From: Eric DeVolder <eric.devolder@oracle.com>
Date: Fri, 21 Jan 2022 08:06:50 -0600
Subject: [PATCH v3 6/6] crash hp: Add x86 crash hotplug support
In-Reply-To: <20220119102323.GB6349@MiWiFi-R3L-srv>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-7-eric.devolder@oracle.com>
 <20220119102323.GB6349@MiWiFi-R3L-srv>
Message-ID: <280485c9-4612-892c-0e3e-9e8b09e60cf9@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Baoquan,
Thanks for the feedback, inline responses below!
eric


On 1/19/22 04:23, Baoquan He wrote:
> On 01/10/22 at 02:57pm, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and if no errors occur, it is
>> installed over the top of the existing elfcorehdr.
>>
>> In the patch 'crash hp: kexec_file changes for crash hotplug support'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
>>
>> NOTE that this supports both kexec_load and kexec_file_load. Support
>> for kexec_load is made possible by identifying the elfcorehdr segment
>> at load time and updating it as previously described. However, it is
>> the responsibility of the userspace kexec utility to ensure that:
>>   - the elfcorehdr segment is sufficiently large enough to accommodate
>>     hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
>>   - provides a purgatory that excludes the elfcorehdr from its list of
>>     run-time segments to check.
>> These changes to the userspace kexec utility are not yet available.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/kernel/crash.c | 138 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 137 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9730c88530fc..d185137b33d4 100644
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
>> @@ -265,7 +266,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>>   		goto out;
>>   
>>   	/* By default prepare 64bit headers */
>> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
>> +	ret =  crash_prepare_elf64_headers(image, cmem,
>> +				IS_ENABLED(CONFIG_X86_64), addr, sz);
>>   
>>   out:
>>   	vfree(cmem);
>> @@ -397,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
> 
> I would define a default value for the size, meantime provide a Kconfig
> option to allow user to customize.

In patch 2/6 of this series, "crash hp: Introduce CRASH_HOTPLUG configuration options", I provide 
the following:

+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+   depends on CRASH_HOTPLUG
+   int
+   default 131072
+   help
+     Specify the maximum size of the elfcorehdr buffer/segment.

which defines a default value of 128KiB, and can be overriden at configure time.

Are you asking for a different technique?

> 
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
>> @@ -412,3 +424,127 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
> 
> These two helper function should be carved out into a separate patch as
> a preparatory one. I am considering how to rearrange and split the
> patches, will reply to cover letter.

OK, I look forward to that insight!

> 
>> +void *map_crash_pages(unsigned long paddr, unsigned long size)
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
>> +void unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>> +{
>> +	/*
>> +	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> +	 * is passed to the crash kernel via the elfcorehdr= parameter)
>> +	 * must be updated with the new list of CPUs and memories. The new
>> +	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
>> +	 * then it is written on top of the existing/old elfcorehdr.
>> +	 *
>> +	 * Due to the change to the elfcorehdr, purgatory must explicitly
>> +	 * exclude the elfcorehdr from the list of segments it checks.
>> +	 */
> 
> Please move this code comment to above function as kernel-doc if you
> this it benefits the entire function. Otherwise should move them above
> the code block they are explaining. For this place, I think moving them
> to above arch_crash_hotplug_handler() is better.

ok, I will do that!

> 
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +	unsigned int n;
>> +
>> +	/*
>> +	 * When the struct kimage is alloced, it is wiped to zero, so
>> +	 * the elf_index_valid defaults to false. It is set on the
>> +	 * kexec_file_load path, or here for kexec_load.
>> +	 */
> 
> I think this kexec loading part should be taken out and post after this
> whole patchset being accepted. At least, it's worth to put them in a
> separate patch.

This little bit of code that identifies the incoming elfcorehdr is all that is needed to support 
kexec_load (and the userspace changes of course). I'm happy to split as a separate patch, but I 
would think that be maintaining it with this series, then when it is accepted, both the kexec_load 
and kexec_file_load paths would be supported? Your call.

> 
>> +	if (!image->elf_index_valid) {
>> +		for (n = 0; n < image->nr_segments; n++) {
>> +			mem = image->segment[n].mem;
>> +			memsz = image->segment[n].memsz;
>> +			ptr = map_crash_pages(mem, memsz);
>> +			if (ptr) {
>> +				/* The segment containing elfcorehdr */
>> +				if ((ptr[0] == 0x7F) &&
>> +					(ptr[1] == 'E') &&
>> +					(ptr[2] == 'L') &&
>> +					(ptr[3] == 'F')) {
> 
>                                        Is this for safety checking later?
No, this code is here to support the kexec_load path; the incoming elfcorehdr has to be identified 
in order to make changes to it later.
> 
>> +					image->elf_index = (int)n;
>> +					image->elf_index_valid = true;
>> +				}
>> +			}
>> +			unmap_crash_pages((void **)&ptr);
>> +		}
>> +	}
>> +
>> +	/* Must have valid elfcorehdr index */
>> +	if (!image->elf_index_valid) {
>> +		pr_err("crash hp: unable to locate elfcorehdr segment");
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources. The elfcorehdr segment memsz must be
>> +	 * sufficiently large to accommodate increases due to hotplug
>> +	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	ksegment = &image->segment[image->elf_index];
>> +	memsz = ksegment->memsz;
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
>> +	ksegment = &image->segment[image->elf_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
> 
> The ksegment and memsz have repeated assignment.

Ah, good catch! I will correct.

> 
>> +	ptr = map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/* Temporarily invalidate the crash image while it is replaced */
>> +		xchg(&kexec_crash_image, NULL);
>> +		/* Write the new elfcorehdr into memory */
>> +		memcpy((void *)ptr, elfbuf, elfsz);
>> +		/* The crash image is now valid once again */
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +//FIX??? somekind of cache flush perhaps?
> 
> You might mean memcpy_flushcache() on x86.

Thanks, I'll look into this and hopefully use it above.

> 
> 
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

