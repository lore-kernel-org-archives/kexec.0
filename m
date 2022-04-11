From: Eric DeVolder <eric.devolder@oracle.com>
Date: Mon, 11 Apr 2022 08:54:22 -0500
Subject: [PATCH v6 4/8] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-5-eric.devolder@oracle.com>
 <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
Message-ID: <821b3c62-eedf-c1a3-4aba-671c90d83288@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/11/22 04:20, Baoquan He wrote:
> Hi Eric,
> 
> On 04/01/22 at 02:30pm, Eric DeVolder wrote:
> ... ...
> 
>> +static void crash_hotplug_handler(unsigned int hp_action,
>> +	unsigned long a, unsigned long b)
> 
> I am still struggling to consider if these unused parameters should be
> kept or removed. Do you foresee or feel on which ARCH they could be used?
> 
> Considering our elfcorehdr updating method, once memory or cpu changed,
> we will update elfcorehdr and cpu notes to reflect all existing memory
> regions and cpu in the current system. We could end up with having them
> but never being used. Then we may finally need to clean them up.
> 
> If you have investigated and foresee or feel they could be used on a
> certain architecture, we can keep them for the time being.

So 'hp_action' and 'a' are used within the existing patch series.
In crash_core.c, there is this bit of code:

+       kexec_crash_image->offlinecpu =
+           (hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+               (unsigned int)a : ~0U;

which is referencing both 'hp_action' and using 'a' from the cpu notifier handler.
I looked into removing 'a' and setting offlinecpu directly, but I thought
it better that offlinecpu be set within the safety of the kexec_mutex.
Also, Sourabh Jain's work with PowerPC utilizing this framework directly
references hp_action in the arch-specific handler.

The cpu and memory notifier handlers set hp_action accordingly. For cpu handler,
the 'a' is set with the impacted cpu. For memory handler, 'a' and 'b' form the
impacted memory range. I agree it looks like the memory range is currently
not useful.

Let me know what you think.
eric

> 
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!mutex_trylock(&kexec_mutex))
>> +		return;
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
>> +			a, b);
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		kexec_crash_image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
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
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +static int crash_memhp_notifier(struct notifier_block *nb,
>> +	unsigned long val, void *v)
>> +{
>> +	struct memory_notify *mhp = v;
>> +	unsigned long start, end;
>> +
>> +	start = mhp->start_pfn << PAGE_SHIFT;
>> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>> +
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			start, end-start);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			start, end-start);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +	register_memory_notifier(&crash_memhp_nb);
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +				"crash/cpuhp",
>> +				crash_cpuhp_online, crash_cpuhp_offline);
>> +#endif
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 

