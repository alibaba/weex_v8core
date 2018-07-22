//
// Created by yxp on 2018/6/15.
//

#include "core_side_in_multi_process.h"
#include "IPC/Buffering/IPCBuffer.h"
#include "IPC/IPCException.h"
#include "IPC/IPCResult.h"
#include "IPC/IPCSender.h"
#include "IPC/IPCType.h"
#include "IPC/Serializing/IPCSerializer.h"
#include "IPCMessageJS.h"
#include "WeexCore/WeexJSServer/ipc/ipc_server.h"
#include "WeexCore/WeexJSServer/utils/LogUtils.h"
#include "WeexCore/WeexJSServer/utils/Utils.h"

namespace weex {
namespace bridge {
namespace js {
CoreSideInMultiProcess::CoreSideInMultiProcess(WeexJSServer *server)
    : server_(server) {}
CoreSideInMultiProcess::CoreSideInMultiProcess() : server_(NULL) {}
CoreSideInMultiProcess::~CoreSideInMultiProcess() {}

void CoreSideInMultiProcess::CallNative(const char *page_id, const char *task,
                                        const char *callback) {
  LOGE("CoreSideInMultiProcess::CallNative");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLNATIVE));
  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // task args[1]
  serializer->add(task, strlen(task));
  // callback args[2]
  serializer->add(callback, strlen(callback));
  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
}

std::unique_ptr<IPCResult> CoreSideInMultiProcess::CallNativeModule(
    const char *page_id, const char *module, const char *method,
    const char *arguments, int arguments_length, const char *options,
    int options_length) {
  LOGE("CoreSideInMultiProcess::CallNativeModule");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLNATIVEMODULE));

  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // module args[1]
  serializer->add(module, strlen(module));
  // method args[2]
  serializer->add(method, strlen(method));
  // arguments args[3]
  serializer->add(arguments, arguments_length);
  // options args[4]
  serializer->add(options, options_length);

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  return sender->send(buffer.get());
}

void CoreSideInMultiProcess::CallNativeComponent(
    const char *page_id, const char *ref, const char *method,
    const char *arguments, int arguments_length, const char *options,
    int options_length) {
  LOGE("CoreSideInMultiProcess::CallNativeComponent");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLNATIVECOMPONENT));

  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // module args[1]
  serializer->add(ref, strlen(ref));
  // method args[2]
  serializer->add(method, strlen(method));
  // arguments args[3]
  serializer->add(arguments, arguments_length);
  // options args[4]
  serializer->add(options, options_length);

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallNativeComponent: unexpected result: %d",
         result->getType());
  }
}

void CoreSideInMultiProcess::AddElement(const char *page_id,
                                        const char *parent_ref,
                                        const char *dom_str, int dom_str_length,
                                        const char *index_str) {
  LOGE("CoreSideInMultiProcess::AddElement");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLADDELEMENT) |
                     MSG_FLAG_ASYNC);

  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // instacneID args[1]
  serializer->add(parent_ref, strlen(parent_ref));
  // dom node args[2]
  serializer->add(dom_str, dom_str_length);
  // index  args[3]
  serializer->add(index_str, strlen(index_str));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
}

void CoreSideInMultiProcess::SetTimeout(const char *callback_id,
                                        const char *time) {
  LOGE("CoreSideInMultiProcess::SetTimeout");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::SETTIMEOUT));
  // callbackId
  serializer->add(callback_id, strlen(callback_id));
  // time
  serializer->add(time, strlen(time));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallNativeComponent: unexpected result: %d",
         result->getType());
  }
}

void CoreSideInMultiProcess::NativeLog(const char *str_array) {
  LOGE("CoreSideInMultiProcess::NativeLog");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();

  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::NATIVELOG) |
                     MSG_FLAG_ASYNC);
  serializer->add(str_array, strlen(str_array));
  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  sender->send(buffer.get());
}

void CoreSideInMultiProcess::CreateBody(const char *page_id,
                                        const char *dom_str,
                                        int dom_str_length) {
  LOGE("CoreSideInMultiProcess::CreateBody");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLCREATEBODY));

  // page id
  serializer->add(page_id, strlen(page_id));
  // dom node args[2]
  serializer->add(dom_str, dom_str_length);

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallNative: unexpected result: %d", result->getType());
  }
}

int CoreSideInMultiProcess::UpdateFinish(const char *page_id, const char *task,
                                         int task_length, const char *callback,
                                         int callback_length) {
  LOGE("CoreSideInMultiProcess::UpdateFinish");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLUPDATEFINISH));
  serializer->add(page_id, strlen(page_id));
  serializer->add(task, task_length);
  serializer->add(callback, callback_length);

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallUpdateFinish: unexpected result: %d", result->getType());
    return 0;
  }
  return result->get<int32_t>();
}

void CoreSideInMultiProcess::CreateFinish(const char *page_id) {
  LOGE("CoreSideInMultiProcess::CreateFinish");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLCREATEFINISH));

  serializer->add(page_id, strlen(page_id));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallCreateFinish: unexpected result: %d", result->getType());
  }
}

int CoreSideInMultiProcess::RefreshFinish(const char *page_id, const char *task,
                                          const char *callback) {
  LOGE("CoreSideInMultiProcess::RefreshFinish");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLREFRESHFINISH));
  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // task args[1]
  serializer->add(task, strlen(task));
  // callback args[2]
  serializer->add(callback, strlen(callback));
  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallRefreshFinish: unexpected result: %d", result->getType());
    return 0;
  }
  return result->get<int32_t>();
}

void CoreSideInMultiProcess::UpdateAttrs(const char *page_id, const char *ref,
                                         const char *data, int data_length) {
  LOGE("CoreSideInMultiProcess::UpdateAttrs");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLUPDATEATTRS));
  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // ref args[1]
  serializer->add(ref, strlen(ref));
  // dom node args[2] TODO
  serializer->add(data, data_length);

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallUpdateAttrs: unexpected result: %d", result->getType());
  }
}

void CoreSideInMultiProcess::UpdateStyle(const char *page_id, const char *ref,
                                         const char *data, int data_length) {
  LOGE("CoreSideInMultiProcess::UpdateStyle");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLUPDATESTYLE));
  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // ref args[1]
  serializer->add(ref, strlen(ref));
  // dom node styles args[2]
  serializer->add(data, data_length);

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallUpdateStyle: unexpected result: %d", result->getType());
  }
}

void CoreSideInMultiProcess::RemoveElement(const char *page_id,
                                           const char *ref) {
  LOGE("CoreSideInMultiProcess::RemoveElement");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLREMOVEELEMENT));
  serializer->add(page_id, strlen(page_id));
  serializer->add(ref, strlen(ref));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallRemoveElement: unexpected result: %d", result->getType());
  }
}

void CoreSideInMultiProcess::MoveElement(const char *page_id, const char *ref,
                                         const char *parent_ref, int index) {
  LOGE("CoreSideInMultiProcess::MoveElement");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLMOVEELEMENT));
  serializer->add(page_id, strlen(page_id));
  serializer->add(ref, strlen(ref));
  serializer->add(parent_ref, strlen(parent_ref));
  // Client need string
  auto temp = std::to_string(index);
  serializer->add(temp.c_str(), temp.size());

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallMoveElement: unexpected result: %d", result->getType());
  }
}

void CoreSideInMultiProcess::AddEvent(const char *page_id, const char *ref,
                                      const char *event) {
  LOGE("CoreSideInMultiProcess::AddEvent");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLADDEVENT));
  serializer->add(page_id, strlen(page_id));
  serializer->add(ref, strlen(ref));
  serializer->add(event, strlen(event));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallAddEvent: unexpected result: %d", result->getType());
  }
}

void CoreSideInMultiProcess::RemoveEvent(const char *page_id, const char *ref,
                                         const char *event) {
  LOGE("CoreSideInMultiProcess::RemoveEvent");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLREMOVEEVENT));
  serializer->add(page_id, strlen(page_id));
  serializer->add(ref, strlen(ref));
  serializer->add(event, strlen(event));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::INT32) {
    LOGE("functionCallRemoveEvent: unexpected result: %d", result->getType());
  }
}

const char *CoreSideInMultiProcess::CallGCanvasLinkNative(
    const char *context_id, int type, const char *arg) {
  LOGE("CoreSideInMultiProcess::CallGCanvasLinkNative");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLGCANVASLINK));

  // contextId args[0]
  serializer->add(context_id, strlen(context_id));
  // type args[1]
  serializer->add(type);
  // arg args[2]
  serializer->add(arg, strlen(arg));

  try {
    std::unique_ptr<IPCBuffer> buffer = serializer->finish();
    std::unique_ptr<IPCResult> result = sender->send(buffer.get());
    // LOGE("weexjsc functionGCanvasLinkNative");
    // if (result->getType() == IPCType::VOID) {
    //     return JSValue::encode(ret);
    // } else if (result->getStringLength() > 0) {
    //     WTF::String retWString = jString2String(result->getStringContent(),
    //     result->getStringLength()); LOGE("weexjsc functionGCanvasLinkNative
    //     result length > 1 retWString:%s", retWString.utf8().data()); ret =
    //     String2JSValue(state, retWString);

    // }
    if (result->getType() != IPCType::VOID) {
      if (result->getStringLength() > 0) {
        return jString2String(result->getStringContent(),
                              result->getStringLength())
            .utf8()
            .data();
      }
    }
  } catch (IPCException &e) {
    LOGE("functionGCanvasLinkNative exception: %s", e.msg());
    _exit(1);
  }
  return NULL;
}

int CoreSideInMultiProcess::SetInterval(const char *page_id,
                                        const char *callback_id,
                                        const char *time) {
  LOGE("CoreSideInMultiProcess::SetInterval");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::SETINTERVAL));
  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // task args[1]
  serializer->add(callback_id, strlen(callback_id));
  // callback args[2]
  serializer->add(time, strlen(time));
  try {
    std::unique_ptr<IPCBuffer> buffer = serializer->finish();
    std::unique_ptr<IPCResult> result = sender->send(buffer.get());
    if (result->getType() != IPCType::INT32) {
      LOGE("functionSetIntervalWeex: unexpected result: %d", result->getType());
      return 0;
    }
    return result->get<int32_t>();
  } catch (IPCException &e) {
    LOGE("functionSetIntervalWeex exception %s", e.msg());
  }
  return 0;
}

void CoreSideInMultiProcess::ClearInterval(const char *page_id,
                                           const char *callback_id) {
  LOGE("CoreSideInMultiProcess::ClearInterval");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CLEARINTERVAL));
  // instacneID args[0]
  serializer->add(page_id, strlen(page_id));
  // task args[1]
  serializer->add(callback_id, strlen(callback_id));
  try {
    std::unique_ptr<IPCBuffer> buffer = serializer->finish();
    std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  } catch (IPCException &e) {
    LOGE("functionClearIntervalWeex exception %s", e.msg());
  }
}

const char *CoreSideInMultiProcess::CallT3DLinkNative(int type,
                                                      const char *arg) {
  LOGE("CoreSideInMultiProcess::CallT3DLinkNative");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::CALLT3DLINK));
  // type args[1]
  serializer->add(type);
  // arg args[2]
  serializer->add(arg, strlen(arg));
  try {
    std::unique_ptr<IPCBuffer> buffer = serializer->finish();
    std::unique_ptr<IPCResult> result = sender->send(buffer.get());
    // LOGE("weexjsc functionT3DLinkNative");
    // if (result->getType() == IPCType::VOID) {
    //     return JSValue::encode(ret);
    // } else if (result->getStringLength() > 0) {
    //     WTF::String retWString = jString2String(result->getStringContent(),
    //     result->getStringLength()); LOGE("weexjsc functionT3DLinkNative
    //     result length > 1 retWString:%s", retWString.utf8().data()); ret =
    //     String2JSValue(state, retWString);

    // }
    if (result->getType() != IPCType::VOID) {
      if (result->getStringLength() > 0) {
        return jString2String(result->getStringContent(),
                              result->getStringLength())
            .utf8()
            .data();
      }
    }
  } catch (IPCException &e) {
    LOGE("functionT3DLinkNative exception: %s", e.msg());
    _exit(1);
  }
  return NULL;
}

void CoreSideInMultiProcess::PostMessage(const char *vim_id, const char *data) {
  LOGE("CoreSideInMultiProcess::PostMessage");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::POSTMESSAGE));
  serializer->add(data, strlen(data));
  serializer->add(vim_id, strlen(vim_id));
  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
}

void CoreSideInMultiProcess::DispatchMessage(const char *client_id,
                                             const char *data,
                                             const char *callback,
                                             const char *vm_id) {
  LOGE("CoreSideInMultiProcess::DispatchMessage");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::DISPATCHMESSAGE));
  // clientid
  serializer->add(client_id, strlen(client_id));
  // data
  serializer->add(data, strlen(data));
  // callback
  serializer->add(callback, strlen(callback));
  serializer->add(vm_id, strlen(vm_id));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
}

void CoreSideInMultiProcess::ReportException(const char *page_id,
                                             const char *func,
                                             const char *exception_string) {
  LOGE("CoreSideInMultiProcess::ReportException");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::REPORTEXCEPTION));
  serializer->add(page_id, strlen(page_id));
  serializer->add(func, strlen(func));
  serializer->add(exception_string, strlen(exception_string));

  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::VOID) {
    LOGE("REPORTEXCEPTION: unexpected result: %d", result->getType());
  }
}
void CoreSideInMultiProcess::SetJSVersion(const char *js_version) {
  LOGE("CoreSideInMultiProcess::SetJSVersion");
  IPCSender *sender = server_->getSender();
  IPCSerializer *serializer = server_->getSerializer();
  serializer->setMsg(static_cast<uint32_t>(IPCProxyMsg::SETJSFVERSION));
  serializer->add(js_version, strlen(js_version));
  std::unique_ptr<IPCBuffer> buffer = serializer->finish();
  std::unique_ptr<IPCResult> result = sender->send(buffer.get());
  if (result->getType() != IPCType::VOID) {
    LOGE("setJSFVersion: unexpected result: %d", result->getType());
  }
}
}  // namespace js
}  // namespace bridge
}  // namespace weex