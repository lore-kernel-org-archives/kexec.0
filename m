From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Fri, 25 Mar 2022 17:02:05 +0530
Subject: [RFC v3 PATCH 4/5] powerpc/crash hp: add crash hotplug support
 for kexec_file_load
In-Reply-To: <a8b58549-1fee-24d5-4fcb-b12cf8851ca4@oracle.com>
References: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
 <20220321080422.56255-5-sourabhjain@linux.ibm.com>
 <a8b58549-1fee-24d5-4fcb-b12cf8851ca4@oracle.com>
Message-ID: <37be240d-b083-7501-7552-cb7aefbce7eb@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello Eric,

On 24/03/22 00:02, Eric DeVolder wrote:
> Notes below.
> eric
>
> On 3/21/22 03:04, Sourabh Jain wrote:
>> Two major changes are done to enable the crash CPU hotplug handler.
>> Firstly, updated the kexec_load path to prepare kimage for hotplug
>> changes and secondly, implemented the crash hotplug handler itself.
>>
>> On the kexec load path, memsz allocation of crash FDT segment is
>> updated to ensure that it has sufficient buffer space to accommodate
>> future hot add CPUs. Initialized the kimage members to track the FDT
>> segment.
>>
>> The crash hotplug handler updates the cpus node of crash FDT. While
>> we update crash FDT the kexec_crash_image is marked invalid and restored
>> after FDT update to avoid race.
>>
>> Since memory crash hotplug support is not there yet the crash hotplug
>> handler simply warn the user and return.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>> ? arch/powerpc/kexec/core_64.c | 46 ++++++++++++++++++++++++++++++++++++
>> ? arch/powerpc/kexec/elf_64.c? | 40 +++++++++++++++++++++++++++++++
>> ? 2 files changed, 86 insertions(+)
>>
>> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
>> index 249d2632526d..a470fe6904e3 100644
>> --- a/arch/powerpc/kexec/core_64.c
>> +++ b/arch/powerpc/kexec/core_64.c
>> @@ -466,6 +466,52 @@ int update_cpus_node(void *fdt)
>> ????? return ret;
>> ? }
>> ? +#ifdef CONFIG_CRASH_HOTPLUG
>> +/**
>> + * arch_crash_hotplug_handler() - Handle hotplug FDT changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @a: first parameter dependent upon hp_action
>> + * @b: first parameter dependent upon hp_action
>> + *
>> + * To accurately reflect CPU hot un/plug changes, the FDT
>> + * must be updated with the new list of CPUs and memories.
>> + */
>> +void arch_crash_hotplug_handler(struct kimage *image, unsigned int 
>> hp_action,
>> +??????????????? unsigned long a, unsigned long b)
>> +{
>> +??? void *fdt;
>> +
>> +??? /* No action needed for CPU hot-unplug */
>> +??? if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +??????? return;
> Just curious why no action is needed on cpu remove?


Since CPU note addresses are already available for all possible CPUs 
(regardless they are online or not) the
PHDR is allocated for all possible CPUs during elfcorehdr creation. At 
least for the kexec_load system call.

Now on the crash path, the crashing CPU initiates an IPI call to update 
the CPU data of all online CPUs and
jumps to the purgatory. Hence no action is needed for the remove case.

With the above logic, we shouldn't be taking any action for the CPU add 
case too, right? But on PowerPC early
boot path there is validation that checks the boot CPU is part of the 
Flattened Device Tree (FDT) or not. If the
boot CPU is not found in FDT the boot fails. Hence FDT needs to be 
updated for every new CPU added to the
system.

>
>> +
>> +??? /* crash update on memory hotplug is not support yet */
>> +??? if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == 
>> KEXEC_CRASH_HP_ADD_MEMORY) {
>> +??????? pr_err("crash hp: crash update is not supported with memory 
>> hotplug\n");
>> +??????? return;
>> +??? }
>> +
>> +??? /* Must have valid FDT index */
>> +??? if (!image->arch.fdt_index_valid) {
>> +??????? pr_err("crash hp: unable to locate FDT segment");
>> +??????? return;
>> +??? }
>> +
>> +??? fdt = __va((void *)image->segment[image->arch.fdt_index].mem);
>> +
>> +??? /* Temporarily invalidate the crash image while it is replaced */
>> +??? xchg(&kexec_crash_image, NULL);
>> +
>> +??? /* update FDT to refelect changes to CPU resrouces */
>> +??? if (update_cpus_node(fdt))
>> +??????? pr_err("crash hp: failed to update crash FDT");
>> +
>> +??? /* The crash image is now valid once again */
>> +??? xchg(&kexec_crash_image, image);
>> +}
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> +
>> ? #ifdef CONFIG_PPC_64S_HASH_MMU
>> ? /* Values we need to export to the second kernel via the device 
>> tree. */
>> ? static unsigned long htab_base;
>> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>> index eeb258002d1e..2ffe6d69e186 100644
>> --- a/arch/powerpc/kexec/elf_64.c
>> +++ b/arch/powerpc/kexec/elf_64.c
>> @@ -24,6 +24,33 @@
>> ? #include <linux/slab.h>
>> ? #include <linux/types.h>
>> ? +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +#define MAX_CORE 256
> Is there a better config option to tie this value too?

The above #defines are just placeholders. Eventually, we will replace 
the MAX_CORE with possible CPUs to calculate the FDT size. Maybe in the 
next version, the above #define will be removed.

>> +#define PER_CORE_NODE_SIZE 1500
>> +
>>

Thanks for the review Eric.

- Sourabh Jain


