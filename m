Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1393AC47258
	for <kexec@archiver.kernel.org>; Tue, 23 Jan 2024 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HWXkzzBKpiQyFYFUxhcSrQ4oU6enizeeS6XnYyaZCvQ=; b=g+5SXv5iaz4l/N
	maEaUvWaKbRon6fNQOr+U5359HBE+518CBesHzCXAEyya8929t8bNQglotiKF+lovxI8tTw4+MbzY
	2hZjoKDoAcoNvtWnD6UhOuz4W+XuE9LSxHEHvQ1iuSDKHDvHSkl+FdzsuitLu1BsKO9CcPCU0luG6
	+k6MHdU95U65tTC90ETP4etc+DSWrQJU5ssfqZFWy7wBi8uu5NYbvsnRrBmA+xSksxLg65crIhsqu
	t7mEpenGwchLnoe9p6/Ni7ozcTvaEt0qY3iRrIDMvotQPmRpu4S0I/t42NgFb710PgTBjlmx//zlJ
	0+Qyj6EjJ6K3iX22Fb5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDvV-00FuVT-2m;
	Tue, 23 Jan 2024 10:22:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDvS-00FuV4-0Q
	for kexec@lists.infradead.org;
	Tue, 23 Jan 2024 10:22:40 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N9xdQ9016827;
	Tue, 23 Jan 2024 10:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JN/LdTxtpdMPsE4Ij8EG5+aGvCE7Vfmvoi+yLiL2jkQ=;
 b=IlOgYJ0zL2Q3116KniMsk6OY1zADaD8qEPxydVivjPY9966+3Era00s1GK13F0FTXnZr
 W3uvPChCK0Vrz9t0Kt+v0izGlKFi1utmjzXcbf74VpnVKwYU0LYIIgAxZKzq5XFmuY7+
 DIRnG5QaShtiWO/SVURHWSeVNj66D5r6BskfVKeHt0dHHphaYbNMZYPDF4cURndZivW/
 pdiBrPQHRplW3njc3IqTyHwT0LBXxab0Tpyfr1MOfxSa9IQ2WpdVDhekySlMNwOIdJ6s
 d0+sS3ANZgR70+TEdK6Ay0U+xyTzmP3sC7b52RBPqoaJOyNPOc04yLMPzqr1id+rGrCD 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vta3vte2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:22:13 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40NAFxLD028850;
	Tue, 23 Jan 2024 10:22:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vta3vte0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:22:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40N9YBUh022438;
	Tue, 23 Jan 2024 10:22:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0kxbrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:22:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NAM73c22807284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 10:22:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 983E52004D;
	Tue, 23 Jan 2024 10:22:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D42262004B;
	Tue, 23 Jan 2024 10:22:02 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 10:22:02 +0000 (GMT)
Message-ID: <bd82e721-e674-4cfe-b9bf-942aaf7ee52c@linux.ibm.com>
Date: Tue, 23 Jan 2024 15:52:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/5] powerpc: add crash memory hotplug support
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc: David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Valentin Schneider <vschneid@redhat.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Naveen N Rao <naveen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kexec@lists.infradead.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20240111105138.251366-1-sourabhjain@linux.ibm.com>
 <20240111105138.251366-6-sourabhjain@linux.ibm.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240111105138.251366-6-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pxobnZditwlSNy9_aWYVkPNuMASTD4k1
X-Proofpoint-GUID: f6Di-NGm0VzLtYQjeZhyLEIcJaxrOto4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_022238_202287_06C06FE1 
X-CRM114-Status: GOOD (  55.01  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 11/01/24 4:21 pm, Sourabh Jain wrote:
> Extend the arch crash hotplug handler, as introduced by the patch title
> ("powerpc: add crash CPU hotplug support"), to also support memory
> add/remove events.
> 
> Elfcorehdr describes the memory of the crash kernel to capture the
> kernel; hence, it needs to be updated if memory resources change due to
> memory add/remove events. Therefore, arch_crash_handle_hotplug_event()
> is updated to recreate the elfcorehdr and replace it with the previous
> one on memory add/remove events.
> 
> The memblock list is used to prepare the elfcorehdr. In the case of
> memory hot removal, the memblock list is updated after the arch crash
> hotplug handler is triggered, as depicted in Figure 1. Thus, the
> hot-removed memory is explicitly removed from the crash memory ranges
> to ensure that the memory ranges added to elfcorehdr do not include the
> hot-removed memory.
> 
>      Memory remove
>            |
>            v
>      Offline pages
>            |
>            v
>   Initiate memory notify call <----> crash hotplug handler
>   chain for MEM_OFFLINE event
>            |
>            v
>   Update memblock list
> 
>   	Figure 1
> 
> There are two system calls, `kexec_file_load` and `kexec_load`, used to
> load the kdump image. A few changes have been made to ensure that the
> kernel can safely update the elfcorehdr component of the kdump image for
> both system calls.
> 
> For the kexec_file_load syscall, kdump image is prepared in the kernel.
> To support an increasing number of memory regions, the elfcorehdr is
> built with extra buffer space to ensure that it can accommodate
> additional memory ranges in future.
> 
> For the kexec_load syscall, the elfcorehdr is updated only if the
> KEXEC_CRASH_HOTPLUG_SUPPORT kexec flag is passed to the kernel by the
> kexec tool. Passing this flag to the kernel indicates that the
> elfcorehdr is built to accommodate additional memory ranges and the
> elfcorehdr segment is not considered for SHA calculation, making it safe
> to update.
> 
> The changes related to this feature are kept under the CRASH_HOTPLUG
> config, and it is enabled by default.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Akhil Raj <lf32.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: x86@kernel.org
> ---
>   arch/powerpc/include/asm/kexec.h        |   5 +-
>   arch/powerpc/include/asm/kexec_ranges.h |   1 +
>   arch/powerpc/kexec/core_64.c            | 107 +++++++++++++++++++++++-
>   arch/powerpc/kexec/file_load_64.c       |  34 +++++++-
>   arch/powerpc/kexec/ranges.c             |  85 +++++++++++++++++++
>   5 files changed, 225 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 943e58eb9bff..25ff5b7f1a28 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -116,8 +116,11 @@ int get_crash_memory_ranges(struct crash_mem **mem_ranges);
>   #ifdef CONFIG_CRASH_HOTPLUG
>   void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
>   #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
> -#endif /*CONFIG_CRASH_HOTPLUG */
>   
> +unsigned int arch_crash_get_elfcorehdr_size(void);
> +#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
> +
> +#endif /*CONFIG_CRASH_HOTPLUG */
>   #endif /* CONFIG_PPC64 */
>   
>   #ifdef CONFIG_KEXEC_FILE
> diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
> index f83866a19e87..802abf580cf0 100644
> --- a/arch/powerpc/include/asm/kexec_ranges.h
> +++ b/arch/powerpc/include/asm/kexec_ranges.h
> @@ -7,6 +7,7 @@
>   void sort_memory_ranges(struct crash_mem *mrngs, bool merge);
>   struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
>   int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
> +int remove_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
>   int add_tce_mem_ranges(struct crash_mem **mem_ranges);
>   int add_initrd_mem_range(struct crash_mem **mem_ranges);
>   #ifdef CONFIG_PPC_64S_HASH_MMU
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 43fcd78c2102..4673f150f973 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -19,8 +19,11 @@
>   #include <linux/of.h>
>   #include <linux/libfdt.h>
>   #include <linux/memblock.h>
> +#include <linux/memory.h>
>   
>   #include <asm/page.h>
> +#include <asm/drmem.h>
> +#include <asm/mmzone.h>
>   #include <asm/current.h>
>   #include <asm/machdep.h>
>   #include <asm/cacheflush.h>
> @@ -546,6 +549,101 @@ int update_cpus_node(void *fdt)
>   #undef pr_fmt
>   #define pr_fmt(fmt) "crash hp: " fmt
>   
> +/*
> + * Advertise preferred elfcorehdr size to userspace via
> + * /sys/kernel/crash_elfcorehdr_size sysfs interface.
> + */
> +unsigned int arch_crash_get_elfcorehdr_size(void)
> +{
> +	unsigned int sz;
> +	unsigned long elf_phdr_cnt;
> +
> +	/* Program header for CPU notes and vmcoreinfo */
> +	elf_phdr_cnt = 2;
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		/* In the worst case, a Phdr is needed for every other LMB to be
> +		 * represented as an individual crash range.
> +		 */
> +		elf_phdr_cnt += memory_hotplug_max() / (2 * drmem_lmb_size());
> +
> +	/* Do not cross the max limit */
> +	if (elf_phdr_cnt > PN_XNUM)
> +		elf_phdr_cnt = PN_XNUM;
> +
> +	sz = sizeof(struct elfhdr) + (elf_phdr_cnt * sizeof(Elf64_Phdr));
> +	return sz;
> +}
> +
> +/**
> + * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it with old
> + *			       elfcorehdr in the kexec segment array.
> + * @image: the active struct kimage
> + * @mn: struct memory_notify data handler
> + */
> +static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *mn)
> +{
> +	int ret;
> +	struct crash_mem *cmem = NULL;
> +	struct kexec_segment *ksegment;
> +	void *ptr, *mem, *elfbuf = NULL;
> +	unsigned long elfsz, memsz, base_addr, size;
> +
> +	ksegment = &image->segment[image->elfcorehdr_index];
> +	mem = (void *) ksegment->mem;
> +	memsz = ksegment->memsz;
> +
> +	ret = get_crash_memory_ranges(&cmem);
> +	if (ret) {
> +		pr_err("Failed to get crash mem range\n");
> +		return;
> +	}
> +
> +	/*
> +	 * The hot unplugged memory is part of crash memory ranges,
> +	 * remove it here.
> +	 */
> +	if (image->hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY) {
> +		base_addr = PFN_PHYS(mn->start_pfn);
> +		size = mn->nr_pages * PAGE_SIZE;
> +		ret = remove_mem_range(&cmem, base_addr, size);
> +		if (ret) {
> +			pr_err("Failed to remove hot-unplugged from crash memory ranges.\n");
> +			return;
> +		}
> +	}
> +
> +	ret = crash_prepare_elf64_headers(cmem, false, &elfbuf, &elfsz);
> +	if (ret) {
> +		pr_err("Failed to prepare elf header\n");
> +		return;
> +	}
> +



> +	/*
> +	 * It is unlikely that kernel hit this because elfcorehdr kexec
> +	 * segment (memsz) is built with addition space to accommodate growing
> +	 * number of crash memory ranges while loading the kdump kernel. It is
> +	 * Just to avoid any unforeseen case.

nitpick..

s/Just/just/

> +	 */
> +	if (elfsz > memsz) {
> +		pr_err("Updated crash elfcorehdr elfsz %lu > memsz %lu", elfsz, memsz);
> +		goto out;
> +	}
> +
> +	ptr = __va(mem);
> +	if (ptr) {
> +		/* Temporarily invalidate the crash image while it is replaced */
> +		xchg(&kexec_crash_image, NULL);
> +
> +		/* Replace the old elfcorehdr with newly prepared elfcorehdr */
> +		memcpy((void *)ptr, elfbuf, elfsz);
> +
> +		/* The crash image is now valid once again */
> +		xchg(&kexec_crash_image, image);
> +	}
> +out:
> +	vfree(elfbuf);
> +}
> +
>   /**
>    * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
>    *				     necessary kexec segments based on the hotplug event.
> @@ -556,7 +654,7 @@ int update_cpus_node(void *fdt)
>    * CPU addition: Update the FDT segment to include the newly added CPU.
>    * CPU removal: No action is needed, with the assumption that it's okay to have offline CPUs
>    *		as part of the FDT.
> - * Memory addition/removal: No action is taken as this is not yet supported.
> + * Memory addition/removal: Recreate the elfcorehdr segment
>    */
>   void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>   {
> @@ -570,7 +668,6 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>   		return;
>   

>   	} else if (hp_action == KEXEC_CRASH_HP_ADD_CPU) {
> -

>   		void *fdt, *ptr;
>   		unsigned long mem;
>   		int i, fdt_index = -1;
> @@ -605,8 +702,10 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>   

>   	} else if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY ||
>   		   hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {

> -		pr_info_once("Crash update is not supported for memory hotplug\n");
> -		return;
> +		struct memory_notify *mn;
> +
> +		mn = (struct memory_notify *)arg;
> +		update_crash_elfcorehdr(image, mn);
>   	}

Use switch case statement for hotplug actions for better readability..

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
