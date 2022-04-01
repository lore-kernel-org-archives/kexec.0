From: Eric DeVolder <eric.devolder@oracle.com>
Date: Fri, 1 Apr 2022 13:34:33 -0500
Subject: [PATCH v5 7/8] x86/crash: Add x86 crash hotplug support for
 kexec_file_load
In-Reply-To: <YkWDnzQoR0CI2zc8@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-8-eric.devolder@oracle.com>
 <YkWDnzQoR0CI2zc8@MiWiFi-R3L-srv>
Message-ID: <b9ce1ee1-4ff1-c9bd-2a3f-190e41e2d65e@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 3/31/22 05:34, Baoquan He wrote:
> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and if no errors occur, it is
>> installed over the top of the existing elfcorehdr.
>>
>> In the patch 'crash hp: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
>>
>> With this change, the kexec_file_load syscall (not kexec_load)
>> is supported. When loading the crash kernel via kexec_file_load,
>> the elfcorehdr is identified at load time in crash_load_segments().
> 
> I tune the log a little, please check:
> 
> [PATCH v5 7/8] x86/crash: Add x86 crash hotplug support for kexec_file_load
> 
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
> 
> To update the elfcorehdr for x86_64, a new elfcorehdr need be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, then installed over the top of the
> existing elfcorehdr.
> 
> In the patch 'kexec: exclude elfcorehdr from the segment digest',
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
> 
> With this change, crash hotplug for kexec_file_load syscall
> is supported. When loading kdump kernel via kexec_file_load,
> the elfcorehdr is identified at load time in crash_load_segments().
> 
Updated the commit message.

>>
> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/kernel/crash.c | 120 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 120 insertions(+)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..5da30e2bc780 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
>> +	/* For marking as usable to crash kernel */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	/* Record the index of the elfcorehdr segment */
>> +	image->elf_index = image->nr_segments;
>> +	image->elf_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,112 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +static void *map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	/*
>> +	 * NOTE: The addresses and sizes passed to this routine have
>> +	 * already been fully aligned on page boundaries. There is no
>> +	 * need for massaging the address or size.
>> +	 */
>> +	void *ptr = NULL;
>> +
>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap(page);
>> +	}
>> +
>> +	return ptr;
>> +}
>> +
>> +static void unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +/**
>> + * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @a: first parameter dependent upon hp_action
>> + * @b: first parameter dependent upon hp_action
>> + *
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories. The new
>> + * elfcorehdr is prepared in a kernel buffer, and if no errors,
>                                                   ~~~~~~~~~~~~~~~~~~
>                                                   can be removed.
done

>> + * then it is written on top of the existing/old elfcorehdr.
>> + *
>> + * For hotplug changes to elfcorehdr to work, two conditions are
>> + * needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. See
>> + * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + *
>> + */
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +
>> +	/* Must have valid elfcorehdr index */
>          Redundant code comment can be removed.
done

> 
>> +	if (!image->elf_index_valid) {
>> +		pr_err("crash hp: unable to locate elfcorehdr segment");
>> +		goto out;
>> +	}
>> +
>> +	ksegment = &image->segment[image->elf_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources. The elfcorehdr segment memsz must be
>> +	 * sufficiently large to accommodate increases due to hotplug
>> +	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> +	 */
>          This paragraph could be duplicated with the part in kernel-doc.
>          Considering to drop one?
done

>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ptr = map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/* Temporarily invalidate the crash image while it is replaced */
>> +		xchg(&kexec_crash_image, NULL);
>> +		/* Write the new elfcorehdr into memory */
>                  No need, the code is self explanatory.
done

>> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>> +		/* The crash image is now valid once again */
> 
>                  ditto. Sometime over commenting is not suggested.
done

> 
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 

