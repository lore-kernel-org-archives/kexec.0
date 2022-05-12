From: David Hildenbrand <david@redhat.com>
Date: Thu, 12 May 2022 10:52:02 +0200
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <20220505184603.1548-4-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
Message-ID: <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05.05.22 20:45, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
> 
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().
> 
> To support memory hotplug, a notifier is registered to capture the
> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
> 
> The cpu callback and memory notifiers call handle_hotplug_event()
> to handle the hot plug/unplug event. Then handle_hotplug_event()
> dispatches the event to the architecture specific
> arch_crash_handle_hotplug_event(). During the process, the
> kexec_mutex is held.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

[...]

> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
> +							unsigned int hp_action, unsigned int cpu)
> +{
> +	WARN(1, "crash hotplug handler not implemented");


Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
triggering?

> +}
> +
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (!mutex_trylock(&kexec_mutex))
> +		return;

This looks wrong. What if you offline memory but for some reason the mutex
is currently locked? You'd miss updating the vmcore, which would be broken.

Why is this trylock in place? Some workaround for potential locking issues,
or what is the rationale?

> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {
> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Flag to differentiate between normal load and hotplug */
> +		kexec_crash_image->hotplug_event = true;

1. Why is that required? Why can't arch_crash_handle_hotplug_event() forward that
information? I mean, *hotplug* in the anme implies that the function should be
aware what's happening.

2. Why can't the unprotect+reprotect not be done inside
arch_crash_handle_hotplug_event() ? It's all arch specific either way.

IMHO, this code here should be as simple as

if (kexec_crash_image)
	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);

3. Why do we have to forward the CPU for CPU onlining/offlining but not the
memory block id (or similar) when onlining/offlining a memory block?

> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
> +
> +		/* No longer handling a hotplug event */
> +		kexec_crash_image->hotplug_event = false;
> +
> +		/* Change back to read-only */
> +		arch_kexec_protect_crashkres();
> +	}
> +
> +	/* Release lock now that update complete */
> +	mutex_unlock(&kexec_mutex);
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	return 0;
> +}
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		register_memory_notifier(&crash_memhp_nb);
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +									"crash/cpuhp",
> +									crash_cpuhp_online,
> +									crash_cpuhp_offline);

Ehm, this indentation looks very weird.

> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif


-- 
Thanks,

David / dhildenb


