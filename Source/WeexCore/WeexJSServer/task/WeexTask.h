//
// Created by Darin on 20/07/2018.
//

#ifndef WEEXV8_WEEXTASK_H
#define WEEXV8_WEEXTASK_H


#include <WeexCore/WeexJSServer/utils/WeexRuntime.h>
#include <WeexCore/WeexJSServer/utils/ThreadLocker.h>

class WeexTask {

public:

    class Future {

    public:

        Future() : has_result_(false) {}

        ~Future() {}

        void setResult(WeexJSResult result);

        WeexJSResult waitResult();

    private:
        bool has_result_ = false;
        WeexJSResult result_;
        ThreadLocker thread_locker_;
    };

    String instanceId;

    explicit WeexTask(const String &instanceId) : future_(nullptr) { this->instanceId = instanceId; };

    virtual ~WeexTask() = default;

    virtual void run(WeexRuntime *runtime) = 0;

    inline void set_future(Future* future) {
        future_ = future;
    }

    inline Future* future() {
        return future_;
    }

private:
    Future* future_;
};


#endif //WEEXV8_WEEXTASK_H
