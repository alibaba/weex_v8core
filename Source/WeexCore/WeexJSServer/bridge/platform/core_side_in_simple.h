//
// Created by yxp on 2018/6/14.
//

#ifndef WEEXV8_SIMPLECORESIDE_H
#define WEEXV8_SIMPLECORESIDE_H

#include "base/common.h"
#include "core/bridge/platform_bridge.h"

namespace weex {
class CoreSideInSimple : public WeexCore::PlatformBridge::CoreSide {
 public:
  CoreSideInSimple() {}
  virtual ~CoreSideInSimple() {}
  void SetDefaultHeightAndWidthIntoRootDom(
      const std::string& instance_id, float default_width, float default_height,
      bool is_width_wrap_content, bool is_height_wrap_content) override;
  void OnInstanceClose(const std::string& instance_id) override;
  void SetStyleWidth(const std::string& instance_id,
                     const std::string& render_ref, float width) override;
  void SetStyleHeight(const std::string& instance_id,
                      const std::string& render_ref, float height) override;
  void SetMargin(const std::string& instance_id, const std::string& render_ref,
                 int edge, float value) override;
  void SetPadding(const std::string& instance_id, const std::string& render_ref,
                  int edge, float value) override;
  void SetPosition(const std::string& instance_id,
                   const std::string& render_ref, int edge,
                   float value) override;
  void MarkDirty(const std::string& instance_id,
                 const std::string& render_ref) override;
  void SetViewPortWidth(const std::string& instance_id, float width) override;
  void ForceLayout(const std::string& instance_id) override;
  bool NotifyLayout(const std::string& instance_id) override;
  std::vector<int64_t> GetFirstScreenRenderTime(
      const std::string& instance_id) override;
  std::vector<int64_t> GetRenderFinishTime(
      const std::string& instance_id) override;
  void SetRenderContainerWrapContent(const std::string& instance_id,
                                     bool wrap) override;
  void BindMeasurementToRenderObject(long ptr) override;
  void RegisterCoreEnv(const std::string& key,
                       const std::string& value) override;

  long GetRenderObject(const std::string& instance_id,
                       const std::string& render_ref) override;
  void UpdateRenderObjectStyle(long render_ptr, const std::string& key,
                               const std::string& value) override;
  void UpdateRenderObjectAttr(long render_ptr, const std::string& key,
                              const std::string& value) override;
  long CopyRenderObject(long render_ptr) override;
  void SetMeasureFunctionAdapter() override;
  void SetPlatform(const std::string& platformName) override;
  void SetDeviceWidthAndHeight(float width, float height) override;
  void AddOption(const std::string& key, const std::string& value) override;

    int InitFramework(const char *script,
                      std::vector<INIT_FRAMEWORK_PARAMS *> params) override;
    int InitAppFramework(const char *instanceId, const char *appFramework,
                         std::vector<INIT_FRAMEWORK_PARAMS *> params) override;
    int CreateAppContext(const char *instanceId, const char *jsBundle) override;
    const char *ExecJSOnAppWithResult(const char *instanceId,
                                      const char *jsBundle) override;
    int CallJSOnAppContext(const char *instanceId, const char *func,
                           std::vector<VALUE_WITH_TYPE *> params) override;
    int DestroyAppContext(const char *instanceId) override;
    int ExecJsService(const char *source) override;
    int ExecTimeCallback(const char *source) override;
    int ExecJS(const char *instanceId, const char *nameSpace, const char *func,
               std::vector<VALUE_WITH_TYPE *> params) override;
    WeexJSResult ExecJSWithResult(const char *instanceId, const char *nameSpace,
                                  const char *func,
                                  std::vector<VALUE_WITH_TYPE *> params) override;
    int CreateInstance(const char *instanceId, const char *func,
                       const char *script, const char *opts, const char *initData,
                       const char *extendsApi) override;
    const char *ExecJSOnInstance(const char *instanceId, const char *script) override;
    int DestroyInstance(const char *instanceId) override;
    int UpdateGlobalConfig(const char *config) override;

 private:
  DISALLOW_COPY_AND_ASSIGN(CoreSideInSimple);
};
}  // namespace weex

#endif  // WEEXV8_SIMPLECORESIDE_H