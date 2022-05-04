From: Eric DeVolder <eric.devolder@oracle.com>
Date: Wed, 4 May 2022 13:11:04 -0500
Subject: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
 <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
 <6f3a6cbb-0ac4-f178-fc17-18f9594da319@linux.ibm.com>
 <YmeBjrChOHsIYG3e@MiWiFi-R3L-srv>
 <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
Message-ID: <6af5bf76-065c-9167-a73e-21908f4b5ef3@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/28/22 00:18, Sourabh Jain wrote:
> Hi Baoquan,
> 
> On 26/04/22 10:52, Baoquan He wrote:
>> On 04/26/22 at 09:36am, Sourabh Jain wrote:
>>> On 15/04/22 03:59, Eric DeVolder wrote:
>>>> Hi Baoquan,
>>>> Inline comments below.
>>>> Thanks!
>>>> eric
>>>>
>>>> On 4/13/22 21:45, Baoquan He wrote:
>>>>> On 04/13/22 at 12:42pm, Eric DeVolder wrote:
>>>>>> Upon CPU and memory changes, a generic crash_hotplug_handler()
>>>>>> dispatches the hot plug/unplug event to the architecture specific
>>>>>> arch_crash_hotplug_handler(). During the process, the kexec_mutex
>>>>>> is held.
>>>>>>
>>>>>> To support cpu hotplug, a callback is registered to capture the
>>>>>> CPUHP_AP_ONLINE_DYN online and ofline events via
>>>>>> cpuhp_setup_state_nocalls().
>>>>>>
>>>>>> To support memory hotplug, a notifier is registered to capture the
>>>>>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>>>>>
>>>>>> The cpu callback and memory notifier then call crash_hotplug_handler()
>>>>>> to handle the hot plug/unplug event.
>>>>>>
>>>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>>>> ---
>>>>>> ?? include/linux/kexec.h |? 16 +++++++
>>>>>> ?? kernel/crash_core.c?? | 101
>>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>> ?? 2 files changed, 117 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>>>> index f93f2591fc1e..02daff1f47dd 100644
>>>>>> --- a/include/linux/kexec.h
>>>>>> +++ b/include/linux/kexec.h
>>>>>> @@ -306,6 +306,13 @@ struct kimage {
>>>>>> ?? ????? /* Information for loading purgatory */
>>>>>> ?????? struct purgatory_info purgatory_info;
>>>>>> +
>>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +??? bool hotplug_event;
>>>>>> +??? unsigned int offlinecpu;
>>>>>> +??? bool elfcorehdr_index_valid;
>>>>>> +??? int elfcorehdr_index;
>>>>>> +#endif
>>>>>> ?? #endif
>>>>>> ?? ? #ifdef CONFIG_IMA_KEXEC
>>>>>> @@ -322,6 +329,15 @@ struct kimage {
>>>>>> ?????? unsigned long elf_load_addr;
>>>>>> ?? };
>>>>>> ?? +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>>>>> +??? unsigned int hp_action, unsigned int cpu);
>>>>>> +#define KEXEC_CRASH_HP_REMOVE_CPU?? 0
>>>>>> +#define KEXEC_CRASH_HP_ADD_CPU????? 1
>>>>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>>>>>> +#define KEXEC_CRASH_HP_ADD_MEMORY?? 3
>>>>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>>>>> +
>>>>>> ?? /* kexec interface functions */
>>>>>> ?? extern void machine_kexec(struct kimage *image);
>>>>>> ?? extern int machine_kexec_prepare(struct kimage *image);
>>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>>> index 256cf6db573c..ecf746243ab2 100644
>>>>>> --- a/kernel/crash_core.c
>>>>>> +++ b/kernel/crash_core.c
>>>>>> @@ -9,12 +9,17 @@
>>>>>> ?? #include <linux/init.h>
>>>>>> ?? #include <linux/utsname.h>
>>>>>> ?? #include <linux/vmalloc.h>
>>>>>> +#include <linux/highmem.h>
>>>>>> +#include <linux/memory.h>
>>>>>> +#include <linux/cpuhotplug.h>
>>>>>> ?? ? #include <asm/page.h>
>>>>>> ?? #include <asm/sections.h>
>>>>>> ?? ? #include <crypto/sha1.h>
>>>>>> ?? +#include "kexec_internal.h"
>>>>>> +
>>>>>> ?? /* vmcoreinfo stuff */
>>>>>> ?? unsigned char *vmcoreinfo_data;
>>>>>> ?? size_t vmcoreinfo_size;
>>>>>> @@ -491,3 +496,99 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>>>> ?? }
>>>>>> ?? ? subsys_initcall(crash_save_vmcoreinfo_init);
>>>>>> +
>>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>>>>>> +??? unsigned int hp_action, unsigned int cpu)
>>>>>> +{
>>>>>> +??? pr_warn("crash hp: %s not implemented", __func__);
>>>>>> +}
>>>>>> +
>>>>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>>>>> +??? unsigned int cpu)
>>>>>> +{
>>>>>> +??? /* Obtain lock while changing crash information */
>>>>>> +??? if (!mutex_trylock(&kexec_mutex))
>>>>>> +??????? return;
>>>>>> +
>>>>>> +??? /* Check kdump is loaded */
>>>>>> +??? if (kexec_crash_image) {
>>>>>> +??????? pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>>>>>> +
>>>>>> +??????? /* Needed in order for the segments to be updated */
>>>>>> +??????? arch_kexec_unprotect_crashkres();
>>>>>> +
>>>>>> +??????? /* Flag to differentiate between normal load and hotplug */
>>>>>> +??????? kexec_crash_image->hotplug_event = true;
>>>>>> +
>>>>>> +??????? /* Now invoke arch-specific update handler */
>>>>>> +??????? arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>>>>>> +
>>>>>> +??????? /* No longer handling a hotplug event */
>>>>>> +??????? kexec_crash_image->hotplug_event = false;
>>>>>> +
>>>>>> +??????? /* Change back to read-only */
>>>>>> +??????? arch_kexec_protect_crashkres();
>>>>>> +??? }
>>>>>> +
>>>>>> +??? /* Release lock now that update complete */
>>>>>> +??? mutex_unlock(&kexec_mutex);
>>>>>> +}
>>>>>> +
>>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>>>>> +??? unsigned long val, void *v)
>>>>>> +{
>>>>>> +??? struct memory_notify *mhp = v;
>>>>>> +
>>>>>> +??? switch (val) {
>>>>>> +??? case MEM_ONLINE:
>>>>>> +??????? crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
>>>>> We don't differentiate the memory add/remove, cpu add, except of cpu
>>>>> remove. Means the hp_action only differentiate cpu remove from the other
>>>>> action. Maybe only making two types?
>>>>>
>>>>> #define KEXEC_CRASH_HP_REMOVE_CPU?? 0
>>>>> #define KEXEC_CRASH_HP_UPDATE_OTHER????? 1
>>>>>
>>>> Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and
>>>> ADD_MEMORY.
>>>> Do you still want to consolidate these?
>>> On PowerPC different actions are needed for CPU add and memory add/remove.
>>> For CPU add case only FDT is updated whereas for the memory hotplug we will
>>> be
>>> updating FDT and elfcorehdr.
>> I don't understand. For elfcorehdr updating, we only need regenerate it.
>> Do you update them different for memory add/remove?
> 
> We have different actions for cpu remove, CPU add and memory add/remove case.
> 
> CPU remove: no action
> CPU add: update flattened device tree (FDT)
> memory add/remove: update FDT and regenerate/update elfcorehdr
> 
> Since memory add/remove action is same we can have common hp_action for them.
> 
>>
>> What I saw is the added action for memory hotplug is only for message
>> printing. Is this really needed? And memory hotplug is even not
>> supported. Please correct me if I missed anything.
> 
> I agree that currently memory hp_action is only used for printing warning message but
> eventually we will be handling memory hotplug case as well.

Baoquan,
It appears the straight forward thing to do here is just to keep the 4 cpu/mem add/remove 
combinations. It appears there is value in keeping them as currently defined. However, please 
indicate if you agree or not.
Thanks!
Eric

> 
>> +?????? /* crash update on memory hotplug is not support yet */
>> +?????? if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
>> +?????????????? pr_info_once("crash hp: crash update is not supported with memory hotplug\n");
>> +?????????????? return;
>> +?????? }
> 
> Thanks,
> Sourabh Jain
> 

