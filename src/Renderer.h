#pragma once

#include "Device.h"
#include "SwapChain.h"
#include "Scene.h"
#include "Camera.h"
#include <functional>

struct NoLeak {
    std::vector<std::function<void()>> jobs;
    ~NoLeak() {
        while (!jobs.empty()) {
            jobs.back()();
            jobs.pop_back();
        }
    }
    NoLeak() = default;
    NoLeak(NoLeak const&) = delete;
    NoLeak(NoLeak&&) = delete;
    template<typename T>
    void Push(T func) {
        jobs.emplace_back(func);
    }
    template<typename T, typename... Ts>
    void Push(T func, Ts... funcs) {
        Push(func); Push(funcs...);
    }
private:
    template<typename T>
    void Push() {}
};

struct ProfilingStats {
    ProfilingStats() : totalTime(0), curTime(0), numSamples(1) { }
    double totalTime, curTime;
    unsigned long long numSamples;

    template<typename RealType, typename = std::enable_if_t<std::is_floating_point_v<RealType>>>
	void Add(RealType time) {
        curTime = static_cast<double>(time);
        totalTime += curTime;
        ++numSamples;
    }
    double Ave() const {
        return numSamples ? totalTime / static_cast<double>(numSamples) : 0;
    }
    double Cur() const {
        return curTime;
    }
};

class Renderer {
public:
    Renderer() = delete;
    Renderer(Device* device, SwapChain* swapChain, Scene* scene, Camera* camera);
    ~Renderer();

    void CreateCommandPools();
    void CreateRenderPass();

    void CreateCameraDescriptorSetLayout();
    void CreateModelDescriptorSetLayout();
    void CreateTimeDescriptorSetLayout();
    void CreateComputeDescriptorSetLayout();
    void CreateComputeNoiseDescriptorSetLayout();

    void CreateDescriptorPool();

    void CreateCameraDescriptorSet();
    void CreateModelDescriptorSets();
    void CreateGrassDescriptorSets();
    void CreateTimeDescriptorSet();
    void CreateComputeDescriptorSets();
    void CreateComputeNoiseTexDescriptorSet();

    void CreateGraphicsPipeline();
    void CreateGrassPipeline();
    void CreateComputePipeline();

    void CreateFrameResources();
    void DestroyFrameResources();
    void RecreateFrameResources();

    void RecordCommandBuffers();
    void RecordComputeCommandBuffer();

    void Frame();

    ProfilingStats const& GetProfilingStats() const { return profileStats; }

private:
    void InitProfiling();
    void BeginProfiling(size_t cmdBufferIdx) const;
    void EndProfiling(size_t cmdBufferIdx) const;
    void GetProfilingResults();

    Device* device;
    VkDevice logicalDevice;
    SwapChain* swapChain;
    Scene* scene;
    Camera* camera;

    NoLeak noLeak;
    ProfilingStats profileStats;
    VkQueryPool queryPool;
    bool profileReady;

    VkCommandPool graphicsCommandPool;
    VkCommandPool computeCommandPool;

    VkRenderPass renderPass;

    VkDescriptorSetLayout cameraDescriptorSetLayout;
    VkDescriptorSetLayout modelDescriptorSetLayout;
    VkDescriptorSetLayout bladeDescriptorSetLayout;
    VkDescriptorSetLayout computeDescriptorSetLayout;
    VkDescriptorSetLayout timeDescriptorSetLayout;
    VkDescriptorSetLayout computeNoiseTexSetLayout;
    
    VkDescriptorPool descriptorPool;

    VkDescriptorSet cameraDescriptorSet;
    std::vector<VkDescriptorSet> modelDescriptorSets;
    std::vector<VkDescriptorSet> bladeDescriptorSets;
    std::vector<VkDescriptorSet> computeDescriptorSets;
    VkDescriptorSet computeNoiseTexDescriptorSet;
    VkDescriptorSet timeDescriptorSet;

    VkPipelineLayout graphicsPipelineLayout;
    VkPipelineLayout grassPipelineLayout;
    VkPipelineLayout computePipelineLayout;

    VkPipeline graphicsPipeline;
    VkPipeline grassPipeline;
    VkPipeline computePipeline;

    std::vector<VkImageView> imageViews;
    VkImage depthImage;
    VkDeviceMemory depthImageMemory;
    VkImageView depthImageView;
    std::vector<VkFramebuffer> framebuffers;

    std::vector<VkCommandBuffer> commandBuffers;
    VkCommandBuffer computeCommandBuffer;
};
