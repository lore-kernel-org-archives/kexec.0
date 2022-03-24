From: Baoquan He <bhe@redhat.com>
Date: Thu, 24 Mar 2022 22:33:00 +0800
Subject: [PATCH v5 4/8] crash: generic crash hotplug support infrastructure
In-Reply-To: <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <20220324133856.GC354864@MiWiFi-R3L-srv>
 <20220324134911.GA354791@MiWiFi-R3L-srv>
 <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
Message-ID: <20220324143300.GD354864@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/24/22 at 08:53am, Eric DeVolder wrote:
> Baoquan,
> Thanks, I've offered a minor correction below.
> eric
> 
> On 3/24/22 08:49, Baoquan He wrote:
> > On 03/24/22 at 09:38pm, Baoquan He wrote:
> > > On 03/03/22 at 11:27am, Eric DeVolder wrote:
> > > > This patch introduces a generic crash hot plug/unplug infrastructure
> > > > for CPU and memory changes. Upon CPU and memory changes, a generic
> > > > crash_hotplug_handler() obtains the appropriate lock, does some
> > > > important house keeping and then dispatches the hot plug/unplug event
> > > > to the architecture specific arch_crash_hotplug_handler(), and when
> > > > that handler returns, the lock is released.
> > > > 
> > > > This patch modifies crash_core.c to implement a subsys_initcall()
> > > > function that installs handlers for hot plug/unplug events. If CPU
> > > > hotplug is enabled, then cpuhp_setup_state() is invoked to register a
> > > > handler for CPU changes. Similarly, if memory hotplug is enabled, then
> > > > register_memory_notifier() is invoked to install a handler for memory
> > > > changes. These handlers in turn invoke the common generic handler
> > > > crash_hotplug_handler().
> > > > 
> > > > On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
> > > > CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
> > > > the CPU still shows up in foreach_present_cpu() during the regeneration
> > > > of the new CPU list, thus the need to explicitly check and exclude the
> > > > soon-to-be offlined CPU in crash_prepare_elf64_headers().
> > > > 
> > > > On the memory side, each un/plugged memory block passes through the
> > > > handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
> > > > memory events, one for each 128MiB memblock.
> > > 
> > > I rewrite the log as below with my understanding. Hope it's simpler to
> > > help people get what's going on here. Please consider to take if it's
> > > OK to you or adjust based on this. The code looks good to me.
> > > 
> > Made some tuning:
> > 
> > crash: add generic infrastructure for crash hotplug support
> > 
> > Upon CPU and memory changes, a generic crash_hotplug_handler() is added
> > to dispatch the hot plug/unplug event to the architecture specific
> > arch_crash_hotplug_handler(). During the process, kexec_mutex need be
> > held.
> > 
> > To support cpu hotplug, one callback pair are registered to capture
> > KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
> > cpuhp_setup_state_nocalls().
> s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
> names I've introduced with this patch?

Right.

While checking it, I notice hp_action which you don't use actually.
Can you reconsider that part of design, the hp_action, the a, b
parameter passed to handler?

> 
> > 
> > To support memory hotplug, a notifier crash_memhp_nb is registered to
> > memory_chain to watch MEM_ONLINE and MEM_OFFLINE events.
> > 
> > These callbacks and notifier will call crash_hotplug_handler() to handle
> > captured event when invoked.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > > > ---
> > > >   include/linux/kexec.h |  16 +++++++
> > > >   kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
> > > >   2 files changed, 124 insertions(+)
> > > > 
> > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > index d7b59248441b..b11d75a6b2bc 100644
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > > @@ -300,6 +300,13 @@ struct kimage {
> > > >   	/* Information for loading purgatory */
> > > >   	struct purgatory_info purgatory_info;
> > > > +
> > > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > > +	bool hotplug_event;
> > > > +	int offlinecpu;
> > > > +	bool elf_index_valid;
> > > > +	int elf_index;
> > > > +#endif
> > > >   #endif
> > > >   #ifdef CONFIG_IMA_KEXEC
> > > > @@ -316,6 +323,15 @@ struct kimage {
> > > >   	unsigned long elf_load_addr;
> > > >   };
> > > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > > +void arch_crash_hotplug_handler(struct kimage *image,
> > > > +	unsigned int hp_action, unsigned long a, unsigned long b);
> > > > +#define KEXEC_CRASH_HP_REMOVE_CPU   0
> > > > +#define KEXEC_CRASH_HP_ADD_CPU      1
> > > > +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
> > > > +#define KEXEC_CRASH_HP_ADD_MEMORY   3
> > > > +#endif /* CONFIG_CRASH_HOTPLUG */
> > > > +
> > > >   /* kexec interface functions */
> > > >   extern void machine_kexec(struct kimage *image);
> > > >   extern int machine_kexec_prepare(struct kimage *image);
> > > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > > index 256cf6db573c..76959d440f71 100644
> > > > --- a/kernel/crash_core.c
> > > > +++ b/kernel/crash_core.c
> > > > @@ -9,12 +9,17 @@
> > > >   #include <linux/init.h>
> > > >   #include <linux/utsname.h>
> > > >   #include <linux/vmalloc.h>
> > > > +#include <linux/highmem.h>
> > > > +#include <linux/memory.h>
> > > > +#include <linux/cpuhotplug.h>
> > > >   #include <asm/page.h>
> > > >   #include <asm/sections.h>
> > > >   #include <crypto/sha1.h>
> > > > +#include "kexec_internal.h"
> > > > +
> > > >   /* vmcoreinfo stuff */
> > > >   unsigned char *vmcoreinfo_data;
> > > >   size_t vmcoreinfo_size;
> > > > @@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
> > > >   }
> > > >   subsys_initcall(crash_save_vmcoreinfo_init);
> > > > +
> > > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > > +void __weak arch_crash_hotplug_handler(struct kimage *image,
> > > > +	unsigned int hp_action, unsigned long a, unsigned long b)
> > > > +{
> > > > +	pr_warn("crash hp: %s not implemented", __func__);
> > > > +}
> > > > +
> > > > +static void crash_hotplug_handler(unsigned int hp_action,
> > > > +	unsigned long a, unsigned long b)
> > > > +{
> > > > +	/* Obtain lock while changing crash information */
> > > > +	if (!mutex_trylock(&kexec_mutex))
> > > > +		return;
> > > > +
> > > > +	/* Check kdump is loaded */
> > > > +	if (kexec_crash_image) {
> > > > +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
> > > > +			a, b);
> > > > +
> > > > +		/* Needed in order for the segments to be updated */
> > > > +		arch_kexec_unprotect_crashkres();
> > > > +
> > > > +		/* Flag to differentiate between normal load and hotplug */
> > > > +		kexec_crash_image->hotplug_event = true;
> > > > +
> > > > +		/* Now invoke arch-specific update handler */
> > > > +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
> > > > +
> > > > +		/* No longer handling a hotplug event */
> > > > +		kexec_crash_image->hotplug_event = false;
> > > > +
> > > > +		/* Change back to read-only */
> > > > +		arch_kexec_protect_crashkres();
> > > > +	}
> > > > +
> > > > +	/* Release lock now that update complete */
> > > > +	mutex_unlock(&kexec_mutex);
> > > > +}
> > > > +
> > > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > > +static int crash_memhp_notifier(struct notifier_block *nb,
> > > > +	unsigned long val, void *v)
> > > > +{
> > > > +	struct memory_notify *mhp = v;
> > > > +	unsigned long start, end;
> > > > +
> > > > +	start = mhp->start_pfn << PAGE_SHIFT;
> > > > +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
> > > > +
> > > > +	switch (val) {
> > > > +	case MEM_ONLINE:
> > > > +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
> > > > +			start, end-start);
> > > > +		break;
> > > > +
> > > > +	case MEM_OFFLINE:
> > > > +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
> > > > +			start, end-start);
> > > > +		break;
> > > > +	}
> > > > +	return NOTIFY_OK;
> > > > +}
> > > > +
> > > > +static struct notifier_block crash_memhp_nb = {
> > > > +	.notifier_call = crash_memhp_notifier,
> > > > +	.priority = 0
> > > > +};
> > > > +#endif
> > > > +
> > > > +#if defined(CONFIG_HOTPLUG_CPU)
> > > > +static int crash_cpuhp_online(unsigned int cpu)
> > > > +{
> > > > +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int crash_cpuhp_offline(unsigned int cpu)
> > > > +{
> > > > +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
> > > > +	return 0;
> > > > +}
> > > > +#endif
> > > > +
> > > > +static int __init crash_hotplug_init(void)
> > > > +{
> > > > +	int result = 0;
> > > > +
> > > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > > +	register_memory_notifier(&crash_memhp_nb);
> > > > +#endif
> > > > +
> > > > +#if defined(CONFIG_HOTPLUG_CPU)
> > > > +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > > > +				"crash/cpuhp",
> > > > +				crash_cpuhp_online, crash_cpuhp_offline);
> > > > +#endif
> > > > +
> > > > +	return result;
> > > > +}
> > > > +
> > > > +subsys_initcall(crash_hotplug_init);
> > > > +#endif /* CONFIG_CRASH_HOTPLUG */
> > > > -- 
> > > > 2.27.0
> > > > 
> > > 
> > 
> 


