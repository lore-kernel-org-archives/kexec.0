Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtgHl-0005H2-Cn
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 11:26:58 +0000
Date: Fri, 02 Oct 2009 19:26:44 +0800 (CST)
Message-Id: <20091002.192644.194424397.caiqian@redhat.com>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
From: CAI Qian <caiqian@redhat.com>
In-Reply-To: <4AC54672.7080201@mxs.nes.nec.co.jp>
References: <20091002.012816.266343564.caiqian@redhat.com>
	<4AC54672.7080201@mxs.nes.nec.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: oomichi@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org, nhorman@redhat.com, anderson@redhat.com, tachibana@mxm.nes.nec.co.jp, caiqian@redhat.com

Cced the crash utility maintainer.

BZ filed -- https://bugzilla.redhat.com/show_bug.cgi?id=526749

> It does make -d 16 works without errors. However, the crash utility
> failed to read it (the log attached), but the full VMCore is working
> fine there.
> 
> crash: page excluded: kernel virtual address: ffffffff819f1764 type:
>        "tss_struct ist array"

Thanks!
CAI Qian

From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
Date: Fri, 02 Oct 2009 09:16:50 +0900

> 
> Hi CAI,
> 
> Thank you for testing and your report.
> 
> CAI Qian wrote:
>> Met 2 issues with 2.6.31 kernel.
>> 
>> (1) makedumpfile needs to be updated to support 2.6.31 kernel. This looks like 
>>     an easy fix. In makedumpfile.h,
>> 
>>     #define LATEST_VERSION          (0x0206001d)    /* linux-2.6.29 */
> 
> The next makedumpfile will support 2.6.31 kernel, and the above will be fixed.
> 
> 
>> (2) makedumpfile -d 16 failed.
>> 
>> # makedumpfile -D -d 16
>>   /var/crash/127.0.0.1-2009-10-01-06\:22\:33/vmcore vmcore
>> 
>> LOAD (0)
>>   phys_start : 1000000
>>   phys_end   : 2683000
>>   virt_start : ffffffff81000000
>>   virt_end   : ffffffff82683000
>> LOAD (1)
>>   phys_start : 0
>>   phys_end   : a0000
>>   virt_start : ffff810000000000
>>   virt_end   : ffff8100000a0000
>> LOAD (2)
>>   phys_start : 100000
>>   phys_end   : 3000000
>>   virt_start : ffff810000100000
>>   virt_end   : ffff810003000000
>> LOAD (3)
>>   phys_start : b000000
>>   phys_end   : 3ff70000
>>   virt_start : ffff81000b000000
>>   virt_end   : ffff81003ff70000
>> Linux kdump
>> page_size    : 4096
>> 
>> max_mapnr    : 3ff70
>> The kernel version is not supported.
>> The created dumpfile may be incomplete.
>> 
>> num of NODEs : 1
>> 
>> 
>> Memory type  : SPARSEMEM
>> 
>> mem_map (0)
>>   mem_map    : ffff880002664000
>>   pfn_start  : 0
>>   pfn_end    : 8000
>> mem_map (1)
>>   mem_map    : 0
>>   pfn_start  : 8000
>>   pfn_end    : 10000
>> mem_map (2)
>>   mem_map    : 0
>>   pfn_start  : 10000
>>   pfn_end    : 18000
>> mem_map (3)
>>   mem_map    : 0
>>   pfn_start  : 18000
>>   pfn_end    : 20000
>> mem_map (4)
>>   mem_map    : 0
>>   pfn_start  : 20000
>>   pfn_end    : 28000
>> mem_map (5)
>>   mem_map    : 0
>>   pfn_start  : 28000
>>   pfn_end    : 30000
>> mem_map (6)
>>   mem_map    : 0
>>   pfn_start  : 30000
>>   pfn_end    : 38000
>> mem_map (7)
>>   mem_map    : 0
>>   pfn_start  : 38000
>>   pfn_end    : 3ff70
>> Excluding unnecessary pages        : [100 %] page_to_pfn: Can't convert
>> the address of page descriptor (ffffea000004e000) to pfn.
>> 
>> create_2nd_bitmap: Can't exclude unnecessary pages.
>> 
>> makedumpfile Failed.
> 
> The cause is that the virtual memory map of x86_64 has been changed to
> the following since linux-2.6.31.
> 
>  15250 --- a/Documentation/x86/x86_64/mm.txt
>  15251 +++ b/Documentation/x86/x86_64/mm.txt
>  15252 @@ -6,10 +6,11 @@ Virtual memory map with 4 level page tables:
>  15253  0000000000000000 - 00007fffffffffff (=47 bits) user space, different per mm
>  15254  hole caused by [48:63] sign extension
>  15255  ffff800000000000 - ffff80ffffffffff (=40 bits) guard hole
>  15256 -ffff880000000000 - ffffc0ffffffffff (=57 TB) direct mapping of all phys. memory
>  15257 -ffffc10000000000 - ffffc1ffffffffff (=40 bits) hole
>  15258 -ffffc20000000000 - ffffe1ffffffffff (=45 bits) vmalloc/ioremap space
>  15259 -ffffe20000000000 - ffffe2ffffffffff (=40 bits) virtual memory map (1TB)
>  15260 +ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
>  15261 +ffffc80000000000 - ffffc8ffffffffff (=40 bits) hole
>  15262 +ffffc90000000000 - ffffe8ffffffffff (=45 bits) vmalloc/ioremap space
>  15263 +ffffe90000000000 - ffffe9ffffffffff (=40 bits) hole
>  15264 +ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)
> 
> I created the patch for catching this change.
> Could you try the attached patch ?
> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> ---
> [PATCH] Add x86_64 linux-2.6.31 support.
> 
> Virtual memory map of x86_64 has been changed to the following
> since linux-2.6.31.
> 
>  15250 --- a/Documentation/x86/x86_64/mm.txt
>  15251 +++ b/Documentation/x86/x86_64/mm.txt
>  15252 @@ -6,10 +6,11 @@ Virtual memory map with 4 level page tables:
>  15253  0000000000000000 - 00007fffffffffff (=47 bits) user space, different per mm
>  15254  hole caused by [48:63] sign extension
>  15255  ffff800000000000 - ffff80ffffffffff (=40 bits) guard hole
>  15256 -ffff880000000000 - ffffc0ffffffffff (=57 TB) direct mapping of all phys. memory
>  15257 -ffffc10000000000 - ffffc1ffffffffff (=40 bits) hole
>  15258 -ffffc20000000000 - ffffe1ffffffffff (=45 bits) vmalloc/ioremap space
>  15259 -ffffe20000000000 - ffffe2ffffffffff (=40 bits) virtual memory map (1TB)
>  15260 +ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
>  15261 +ffffc80000000000 - ffffc8ffffffffff (=40 bits) hole
>  15262 +ffffc90000000000 - ffffe8ffffffffff (=45 bits) vmalloc/ioremap space
>  15263 +ffffe90000000000 - ffffe9ffffffffff (=40 bits) hole
>  15264 +ffffea0000000000 - ffffeaffffffffff (=40 bits) virtual memory map (1TB)
> 
> This patch catches up this change.
> 
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> ---
> diff -rpuN a/makedumpfile.h b/makedumpfile.h
> --- a/makedumpfile.h	2009-04-20 15:26:23.000000000 +0900
> +++ b/makedumpfile.h	2009-10-02 09:44:44.000000000 +0900
> @@ -450,6 +450,7 @@ do { \
>  #define LATEST_VERSION		(0x0206001d)	/* linux-2.6.29 */
>  #define VERSION_LINUX_2_6_26	(0x0206001a)	/* linux-2.6.26 */
>  #define VERSION_LINUX_2_6_27	(0x0206001b)	/* linux-2.6.27 */
> +#define VERSION_LINUX_2_6_31	(0x0206001f)	/* linux-2.6.31 */
>  
>  /*
>   * vmcoreinfo in /proc/vmcore
> @@ -502,6 +503,10 @@ do { \
>   * The value of dependence on machine
>   */
>  #define PAGE_OFFSET		(info->page_offset)
> +#define VMALLOC_START		(info->vmalloc_start)
> +#define VMALLOC_END		(info->vmalloc_end)
> +#define VMEMMAP_START		(info->vmemmap_start)
> +#define VMEMMAP_END		(info->vmemmap_end)
>  
>  #ifdef __x86__
>  #define __PAGE_OFFSET		(0xc0000000)
> @@ -535,12 +540,18 @@ do { \
>  #endif /* x86 */
>  
>  #ifdef __x86_64__
> -#define __PAGE_OFFSET_ORIG	(0xffff810000000000) /* linux-2.6.26, or former */
> -#define __PAGE_OFFSET_2_6_27	(0xffff880000000000) /* linux-2.6.27, or later */
> -#define VMALLOC_START		(0xffffc20000000000)
> -#define VMALLOC_END		(0xffffe1ffffffffff)
> -#define VMEMMAP_START		(0xffffe20000000000)
> -#define VMEMMAP_END		(0xffffe2ffffffffff)
> +#define __PAGE_OFFSET_ORIG	(0xffff810000000000) /* 2.6.26, or former */
> +#define __PAGE_OFFSET_2_6_27	(0xffff880000000000) /* 2.6.27, or later  */
> +
> +#define VMALLOC_START_ORIG	(0xffffc20000000000) /* 2.6.30, or former */
> +#define VMALLOC_START_2_6_31	(0xffffc90000000000) /* 2.6.31, or later  */
> +#define VMALLOC_END_ORIG	(0xffffe1ffffffffff) /* 2.6.30, or former */
> +#define VMALLOC_END_2_6_31	(0xffffe8ffffffffff) /* 2.6.31, or later  */
> +
> +#define VMEMMAP_START_ORIG	(0xffffe20000000000) /* 2.6.30, or former */
> +#define VMEMMAP_START_2_6_31	(0xffffea0000000000) /* 2.6.31, or later  */
> +#define VMEMMAP_END_ORIG	(0xffffe2ffffffffff) /* 2.6.30, or former */
> +#define VMEMMAP_END_2_6_31	(0xffffeaffffffffff) /* 2.6.31, or later  */
>  
>  #define __START_KERNEL_map	(0xffffffff80000000)
>  #define MODULES_VADDR		(0xffffffff88000000)
> @@ -549,6 +560,7 @@ do { \
>  #define _SECTION_SIZE_BITS	(27)
>  #define _MAX_PHYSMEM_BITS_ORIG		(40)
>  #define _MAX_PHYSMEM_BITS_2_6_26	(44)
> +#define _MAX_PHYSMEM_BITS_2_6_31	(46)
>  
>  /*
>   * 4 Levels paging
> @@ -786,6 +798,9 @@ struct DumpInfo {
>  	unsigned long	phys_base;
>  	unsigned long   kernel_start;
>  	unsigned long   vmalloc_start;
> +	unsigned long   vmalloc_end;
> +	unsigned long	vmemmap_start;
> +	unsigned long	vmemmap_end;
>  
>  	/*
>  	 * diskdimp info:
> diff -rpuN a/x86_64.c b/x86_64.c
> --- a/x86_64.c	2008-10-10 10:13:19.000000000 +0900
> +++ b/x86_64.c	2009-10-02 09:45:39.000000000 +0900
> @@ -70,14 +70,28 @@ get_versiondep_info_x86_64(void)
>  	 */
>  	if (info->kernel_version < VERSION_LINUX_2_6_26)
>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
> -	else
> +	else if (info->kernel_version < VERSION_LINUX_2_6_31)
>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
> +	else
> +		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
>  
>  	if (info->kernel_version < VERSION_LINUX_2_6_27)
>  		info->page_offset = __PAGE_OFFSET_ORIG;
>  	else
>  		info->page_offset = __PAGE_OFFSET_2_6_27;
>  
> +	if (info->kernel_version < VERSION_LINUX_2_6_31) {
> +		info->vmalloc_start = VMALLOC_START_ORIG;
> +		info->vmalloc_end   = VMALLOC_END_ORIG;
> +		info->vmemmap_start = VMEMMAP_START_ORIG;
> +		info->vmemmap_end   = VMEMMAP_END_ORIG;
> +	} else {
> +		info->vmalloc_start = VMALLOC_START_2_6_31;
> +		info->vmalloc_end   = VMALLOC_END_2_6_31;
> +		info->vmemmap_start = VMEMMAP_START_2_6_31;
> +		info->vmemmap_end   = VMEMMAP_END_2_6_31;
> +	}
> +
>  	return TRUE;
>  }
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
