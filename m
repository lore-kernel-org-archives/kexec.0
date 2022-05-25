From: Eric DeVolder <eric.devolder@oracle.com>
Date: Wed, 25 May 2022 08:51:55 -0500
Subject: [PATCH v8 6/7] x86/crash: Add x86 crash hotplug support for
 kexec_file_load
In-Reply-To: <60bd09e4-91d6-d81c-3b97-1d5334efe6e7@linux.ibm.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-7-eric.devolder@oracle.com>
 <60bd09e4-91d6-d81c-3b97-1d5334efe6e7@linux.ibm.com>
Message-ID: <526d44b2-0120-2d52-aac3-57155a2bf80b@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 5/25/22 00:25, Sourabh Jain wrote:
> Hello Eric,
> 
> On 06/05/22 00:16, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and then installed over the top of
>> the existing elfcorehdr.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.? As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported. When loading the crash kernel via kexec_file_load,
>> the elfcorehdr is identified at load time in crash_load_segments().
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>> ? arch/x86/Kconfig??????? |? 11 ++++
>> ? arch/x86/kernel/crash.c | 117 ++++++++++++++++++++++++++++++++++++++++
>> ? 2 files changed, 128 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 4bed3abf444d..bf1201fe6981 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2072,6 +2072,17 @@ config CRASH_DUMP
>> ??????? (CONFIG_RELOCATABLE=y).
>> ??????? For more details see Documentation/admin-guide/kdump/kdump.rst
>> +config CRASH_MAX_MEMORY_RANGES
>> +??? depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>> +??? int
>> +??? default 32768
>> +??? help
>> +????? For the kexec_file_load path, specify the maximum number of
>> +????? memory regions, eg. as represented by the 'System RAM' entries
>> +????? in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>> +????? This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>> +????? size to determine the final buffer size.
>> +
>> ? config KEXEC_JUMP
>> ????? bool "kexec jump"
>> ????? depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..951ef365f0a7 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>> ? #include <linux/slab.h>
>> ? #include <linux/vmalloc.h>
>> ? #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>> ? #include <asm/processor.h>
>> ? #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>> ????? image->elf_headers = kbuf.buffer;
>> ????? image->elf_headers_sz = kbuf.bufsz;
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +??? /* Ensure elfcorehdr segment large enough for hotplug changes */
>> +??? kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>> +??? /* For marking as usable to crash kernel */
>> +??? image->elf_headers_sz = kbuf.memsz;
>> +??? /* Record the index of the elfcorehdr segment */
>> +??? image->elfcorehdr_index = image->nr_segments;
>> +??? image->elfcorehdr_index_valid = true;
>> +#else
>> ????? kbuf.memsz = kbuf.bufsz;
>> +#endif
>> ????? kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>> ????? kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> ????? ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,109 @@ int crash_load_segments(struct kimage *image)
>> ????? return ret;
>> ? }
>> ? #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +static void *map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +??? /*
>> +???? * NOTE: The addresses and sizes passed to this routine have
>> +???? * already been fully aligned on page boundaries. There is no
>> +???? * need for massaging the address or size.
>> +???? */
>> +??? void *ptr = NULL;
>> +
>> +??? /* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +??? if (size > 0) {
>> +??????? struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +??????? ptr = kmap(page);
>> +??? }
>> +
>> +??? return ptr;
>> +}
>> +
>> +static void unmap_crash_pages(void **ptr)
>> +{
>> +??? if (ptr) {
>> +??????? if (*ptr)
>> +??????????? kunmap(*ptr);
>> +??????? *ptr = NULL;
>> +??? }
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
>> + *
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories. The new
>> + * elfcorehdr is prepared in a kernel buffer, and then it is
>> + * written on top of the existing/old elfcorehdr.
>> + *
>> + * For hotplug changes to elfcorehdr to work, two conditions are
>> + * needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. See the
>> + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + *
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +??? unsigned int hp_action, unsigned int cpu)
>> +{
>> +??? struct kexec_segment *ksegment;
>> +??? unsigned char *ptr = NULL;
>> +??? unsigned long elfsz = 0;
>> +??? void *elfbuf = NULL;
>> +??? unsigned long mem, memsz;
>> +
>> +??? if (!image->elfcorehdr_index_valid) {
>> +??????? pr_err("crash hp: unable to locate elfcorehdr segment");
>> +??????? goto out;
>> +??? }
>> +
>> +??? ksegment = &image->segment[image->elfcorehdr_index];
>> +??? mem = ksegment->mem;
>> +??? memsz = ksegment->memsz;
>> +
>> +??? /*
>> +???? * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +???? * memory resources.
>> +???? */
>> +??? if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +??????? pr_err("crash hp: unable to prepare elfcore headers");
>> +??????? goto out;
> 
> Prepare_elf_header uses crash_prepare_elf64_headers function to generate elfcorehdr.
> Since crash_prepare_elf64_headers is defined under CONFIG_KEXEC_FILE option we
> will have build issues if CONFIG_KEXEC is enabled and CONFIG_KEXEC_FILE is disabled.
> 
> How about moving crash_prepare_elf64_headers function to kernel/kexec_core.c?

Yes, of course. I originally protected against this scenario with having the
CRASH_HOTPLUG dependent on KEXEC_FILE, but as we eliminated CRASH_HOTPLUG, your
suggestion above is on point.

Thanks!
eric

> 
> Thanks,
> Sourabh Jain
> 

