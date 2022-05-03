From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 3 May 2022 15:57:32 -0300
Subject: [PATCH 16/30] drivers/hv/vmbus, video/hyperv_fb: Untangle and
 refactor Hyper-V panic notifiers
In-Reply-To: <PH0PR21MB3025A46643EEDA6B14AC1ECED7C09@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-17-gpiccoli@igalia.com>
 <PH0PR21MB30250C9246FFF36AFB1DFDECD7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <2787b476-6366-1c83-db80-0393da417497@igalia.com>
 <PH0PR21MB3025A46643EEDA6B14AC1ECED7C09@PH0PR21MB3025.namprd21.prod.outlook.com>
Message-ID: <92dee5a0-f04e-f352-1e22-f990818ca06a@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/05/2022 15:13, Michael Kelley (LINUX) wrote:
> [...]
>> (a) We could forget about this change, and always do the clean-up here,
>> not relying in machine_crash_shutdown().
>> Pro: really simple, behaves the same as it is doing currently.
>> Con: less elegant/concise, doesn't allow arm64 customization.
>>
>> (b) Add a way to allow ARM64 customization of shutdown crash handler.
>> Pro: matches x86, more customizable, improves arm64 arch code.
>> Con: A tad more complex.
>>
>> Also, a question that came-up: if ARM64 has no way of calling special
>> crash shutdown handler, how can you execute hv_stimer_cleanup() and
>> hv_synic_disable_regs() there? Or are they not required in ARM64?
>>
> 
> My suggestion is to do (a) for now.  I suspect (b) could be a more
> extended discussion and I wouldn't want your patch set to get held
> up on that discussion.  I don't know what the sense of the ARM64
> maintainers would be toward (b).  They have tried to avoid picking
> up code warts like have accumulated on the x86/x64 side over the
> years, and I agree with that effort.  But as more and varied
> hypervisors become available for ARM64, it seems like a framework
> for supporting a custom shutdown handler may become necessary.
> But that could take a little time.
> 
> You are right about hv_stimer_cleanup() and hv_synic_disable_regs().
> We are not running these when a panic occurs on ARM64, and we
> should be, though the risk is small.   We will pursue (b) and add
> these additional cleanups as part of that.  But again, I would suggest
> doing (a) for now, and we will switch back to your solution once
> (b) is in place.
> 

Thanks again Michael, I'll stick with (a) for now. I'll check with ARM64
community about that, and I might even try to implement something in
parallel (if you are not already working on that - lemme know please),
so we don't get stuck here. As you said, I feel that this is more and
more relevant as the number of panic/crash/kexec scenarios tend to
increase in ARM64.


>> [...]
>> Some ideas of what we can do here:
>>
>> I) we could change the framebuffer notifier to rely on trylocks, instead
>> of risking a lockup scenario, and with that, we can execute it before
>> the vmbus disconnect in the hypervisor list;
> 
> I think we have to do this approach for now.
> 
>>
>> II) we ignore the hypervisor notifier in case of kdump _by default_, and
>> if the users don't want that, they can always set the panic notifier
>> level to 4 and run all notifiers prior to kdump; would that be terrible
>> you think? Kdump users might don't care about the framebuffer...
>>
>> III) we go with approach (b) above and refactor arm64 code to allow the
>> custom crash handler on kdump time, then [with point (I) above] the
>> logic proposed in this series is still valid - seems more and more the
>> most correct/complete solution.
> 
> But even when/if we get approach (b) implemented, having the
> framebuffer notifier on the pre_reboot list is still too late with the
> default of panic_notifier_level = 2.  The kdump path will reset the
> VMbus connection and then the framebuffer notifier won't work.
> 

OK, perfect! I'll work something along these lines in V2, allowing the
FB notifier to always run in the hypervisor list before the vmbus unload
mechanism.


>> [...]
>>>> +static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned long val,
>>>>  			      void *args)
>>>> +{
>>>> +	if (!kexec_crash_loaded())
>>>
>>> I'm not clear on the purpose of this condition.  I think it means
>>> we will skip the vmbus_initiate_unload() if a panic occurs in the
>>> kdump kernel.  Is there a reason a panic in the kdump kernel
>>> should be treated differently?  Or am I misunderstanding?
>>
>> This is really related with the point discussed in the top of this
>> response - I assumed both ARM64/x86_64 would behave the same and
>> disconnect the vmbus through the custom crash handler when kdump is set,
>> so worth skipping it here in the notifier. But that's not true for ARM64
>> as you pointed, so this guard against kexec is really part of the
>> decision/discussion on what to do with ARM64 heh
> 
> But note that vmbus_initiate_unload() already has a guard built-in.
> If the intent of this test is just as a guard against running twice,
> then it isn't needed.

Since we're going to avoid relying in the custom crash_shutdown(), due
to the lack of ARM64 support for now, this check will be removed in V2.

Its purpose was to skip the notifier *proactively* in case kexec is set,
given that...once kexec happens, the custom crash_shutdown() would run
the same function (wrong assumption for ARM64, my bad).

Postponing that slightly would maybe gain us some time while the
hypervisor finish its work, so we'd delay less in the vmbus unload path
- that was the rationale behind this check.


Cheers!

