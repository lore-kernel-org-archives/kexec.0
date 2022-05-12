From: Eric DeVolder <eric.devolder@oracle.com>
Date: Thu, 12 May 2022 11:10:28 -0500
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
Message-ID: <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

David,
Great questions! See inline responses below.
eric

On 5/12/22 03:52, David Hildenbrand wrote:
> On 05.05.22 20:45, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> to handle the hot plug/unplug event. Then handle_hotplug_event()
>> dispatches the event to the architecture specific
>> arch_crash_handle_hotplug_event(). During the process, the
>> kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> [...]
> 
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>> +							unsigned int hp_action, unsigned int cpu)
>> +{
>> +	WARN(1, "crash hotplug handler not implemented");
> 
> 
> Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
> I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
> triggering?
> 
You're correct. What about: printk_once(KERN_DEBUG "...") ?

>> +}
>> +
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!mutex_trylock(&kexec_mutex))
>> +		return;
> 
> This looks wrong. What if you offline memory but for some reason the mutex
> is currently locked? You'd miss updating the vmcore, which would be broken.
> 
> Why is this trylock in place? Some workaround for potential locking issues,
> or what is the rationale?

I took this from kernel/kexec.c:do_my_load(), but you are right, this is not
right.

      *
      * KISS: always take the mutex.
      */
     if (!mutex_trylock(&kexec_mutex))
         return -EBUSY;

This should simply be mutex_lock(&kexec_mutex).

> 
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		kexec_crash_image->hotplug_event = true;
> 
> 1. Why is that required? Why can't arch_crash_handle_hotplug_event() forward that
> information? I mean, *hotplug* in the anme implies that the function should be
> aware what's happening.
Member .hotplug_event is needed in crash_prepare_elf64_headers(). To date, it has made
sense (to me) to pass this parameter to crash_prepare_elf64_headers() via the
struct kimage, rather than directly. The patch "crash: prototype change for 
crash_prepare_elf64_headers" changes crash_prepare_elf64_headers() to accept the
struct kimage. If it is so desired, it could just as well be changed to pass just
this one parameter; though struct kimage seems a more useful way to go.

> 
> 2. Why can't the unprotect+reprotect not be done inside
> arch_crash_handle_hotplug_event() ? It's all arch specific either way.
> 
> IMHO, this code here should be as simple as
> 
> if (kexec_crash_image)
> 	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
> 

The intent of this code was to be generic infrastructure. Just invoking the
arch_crash_handle_hotplug_event() would certainly be as generic as it gets.
But there were a series of steps that seemed to be common, so those I hoisted
into this bit of code.

> 3. Why do we have to forward the CPU for CPU onlining/offlining but not the
> memory block id (or similar) when onlining/offlining a memory block?
 From patch "kexec: exclude hot remove cpu from elfcorehdr notes" commit message:

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

If there is a better CPUHP_ to use than _DYN, I'd be all for that!

> 
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>> +
>> +		/* No longer handling a hotplug event */
>> +		kexec_crash_image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +									"crash/cpuhp",
>> +									crash_cpuhp_online,
>> +									crash_cpuhp_offline);
> 
> Ehm, this indentation looks very weird.
> 
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
> 
> 

