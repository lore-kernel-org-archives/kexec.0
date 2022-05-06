From: Baoquan He <bhe@redhat.com>
Date: Fri, 6 May 2022 15:12:50 +0800
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <20220505184603.1548-4-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
Message-ID: <YnTKcvkCoRBxqGSW@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/05/22 at 02:45pm, Eric DeVolder wrote:
......
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..f197af50def6 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -9,12 +9,17 @@
>  #include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/highmem.h>

Wondering where highmem.h is needed. Just curious.

> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  
>  #include <crypto/sha1.h>
>  
> +#include "kexec_internal.h"
> +
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
>  size_t vmcoreinfo_size;
> @@ -491,3 +496,90 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
> +							unsigned int hp_action, unsigned int cpu)
> +{
> +	WARN(1, "crash hotplug handler not implemented");
> +}
> +
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (!mutex_trylock(&kexec_mutex))
> +		return;
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
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> -- 
> 2.27.0
> 


