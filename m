Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CDEC47258
	for <kexec@archiver.kernel.org>; Tue, 23 Jan 2024 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ba3XOM2P5X1SM6hM2YhlLbYYdjWjMD7i27NVo+Oh1Gs=; b=MRzLFx6wAkosQS
	rCGvWsKGWVqsTPWKeJlStyVW2ojgKmFMf4ScKwNUJpt36gjnFZGqjU/8yRFt6GdE0PCMVSHZglBMB
	8EYWIVbc6/rZ2oXlJQp0Cqa8QVG4OqHq0nSVLlO3VdpwrSbjLeLvMuWKjI0JpAWdLgNFGqKYfnUBk
	5h/avqu622L3KC8z+KEolznODaFGiCSWZEE4gB5FUM4yLykqeHKk1JDWWrC74HOikn5impDQ/klMN
	w5F2D1Vjx+VSKIY9uj1y6JxIr1N4bMF0BkmpJCqEWXQquhzj463qXVdZ1NPOfxTRD5abRrkyoJODz
	oG7TT7uKHMwoEcQTXung==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDqN-00Fte3-2n;
	Tue, 23 Jan 2024 10:17:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSDqL-00Ftcz-02
	for kexec@lists.infradead.org;
	Tue, 23 Jan 2024 10:17:23 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NADTd5030774;
	Tue, 23 Jan 2024 10:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eBb9iis8p6GvEcLweaO8orvlF3Kt0YzPVzPZBLO7jFY=;
 b=NKkFOG9/6QzVQLBBKsPGg3dU5IltPDdRJ6OXg4cCLEEzQ64K1AFMDhRXlbN+SrH+bEp4
 dx2AnebCo46YLajQcgMjVkU9gpWF+m2R9dDppQm5VbCij+gDdmVMHFpnbVlP12SHmbPC
 rY330+Xh4ZyGYek/ED89j5eBq8csWLSLwx0PMwu6dJsoB+ywlU3p7a4DiyLNjtP7G7t5
 ai9XVlTlnxdGN8Gsy7pRcyzLBWpKeU465CoxNb3Y9c5+B+tzDzmj831hCDxDC/qG8M9k
 4G26DqHK00bQ2JCZjeJDxznH2e4hM3cnxkwHDeLWAkLENi8LHm9qGlIa3Zb8+k6GkYos 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtbgug2cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:16:51 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40NADcjC030990;
	Tue, 23 Jan 2024 10:16:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtbgug2ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:16:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40N8lXHM025892;
	Tue, 23 Jan 2024 10:16:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgnxf30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 10:16:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NAGk4q8258058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 10:16:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B5A2004E;
	Tue, 23 Jan 2024 10:16:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E828F2004D;
	Tue, 23 Jan 2024 10:16:41 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 10:16:41 +0000 (GMT)
Message-ID: <7d49f9db-d2f8-4cd1-9337-f7b73f5373f0@linux.ibm.com>
Date: Tue, 23 Jan 2024 15:46:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/5] powerpc: add crash CPU hotplug support
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
 <20240111105138.251366-5-sourabhjain@linux.ibm.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240111105138.251366-5-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jdLzW9nGpSS87JW5KslaFwl6HXGNgIzc
X-Proofpoint-GUID: na4ATF74CP8RiaTam9MIUaKlGiA7OY7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_021721_189945_F9B6EE53 
X-CRM114-Status: GOOD (  61.02  )
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
> Due to CPU/Memory hotplug or online/offline events, the elfcorehdr
> (which describes the CPUs and memory of the crashed kernel) and FDT
> (Flattened Device Tree) of kdump image becomes outdated. Consequently,
> attempting dump collection with an outdated elfcorehdr or FDT can lead
> to failed or inaccurate dump collection.
> 
> Going forward, CPU hotplug or online/offline events are referred as
> CPU/Memory add/remove events.
> 
> The current solution to address the above issue involves monitoring the
> CPU/Memory add/remove events in userspace using udev rules and whenever
> there are changes in CPU and memory resources, the entire kdump image
> is loaded again. The kdump image includes kernel, initrd, elfcorehdr,
> FDT, purgatory. Given that only elfcorehdr and FDT get outdated due to
> CPU/Memory add/remove events, reloading the entire kdump image is
> inefficient. More importantly, kdump remains inactive for a substantial
> amount of time until the kdump reload completes.
> 
> To address the aforementioned issue, commit 247262756121 ("crash: add
> generic infrastructure for crash hotplug support") added a generic
> infrastructure that allows architectures to selectively update the kdump
> image component during CPU or memory add/remove events within the kernel
> itself.
> 
> In the event of a CPU or memory add/remove events, the generic crash
> hotplug event handler, `crash_handle_hotplug_event()`, is triggered. It
> then acquires the necessary locks to update the kdump image and invokes
> the architecture-specific crash hotplug handler,
> `arch_crash_handle_hotplug_event()`, to update the required kdump image
> components.
> 
> This patch adds crash hotplug handler for PowerPC and enable support to
> update the kdump image on CPU add/remove events. Support for memory
> add/remove events is added in a subsequent patch with the title
> "powerpc: add crash memory hotplug support"
> 
> As mentioned earlier, only the elfcorehdr and FDT kdump image components
> need to be updated in the event of CPU or memory add/remove events.
> However, on PowerPC architecture crash hotplug handler only updates the
> FDT to enable crash hotplug support for CPU add/remove events. Here's
> why.
> 
> The elfcorehdr on PowerPC is built with possible CPUs, and thus, it does
> not need an update on CPU add/remove events. On the other hand, the FDT
> needs to be updated on CPU add events to include the newly added CPU. If
> the FDT is not updated and the kernel crashes on a newly added CPU, the
> kdump kernel will fail to boot due to the unavailability of the crashing
> CPU in the FDT. During the early boot, it is expected that the boot CPU
> must be a part of the FDT; otherwise, the kernel will raise a BUG and
> fail to boot. For more information, refer to commit 36ae37e3436b0
> ("powerpc: Make boot_cpuid common between 32 and 64-bit"). Since it is
> okay to have an offline CPU in the kdump FDT, no action is taken in case
> of CPU removal.
> 
> There are two system calls, `kexec_file_load` and `kexec_load`, used to
> load the kdump image. Few changes have been made to ensure kernel can
> safely update the FDT of kdump image loaded using both system calls.
> 
> For kexec_file_load syscall the kdump image is prepared in kernel. So to
> support an increasing number of CPUs, the FDT is constructed with extra
> buffer space to ensure it can accommodate a possible number of CPU
> nodes. Additionally, a call to fdt_pack (which trims the unused space
> once the FDT is prepared) is avoided if this feature is enabled.
> 
> For the kexec_load syscall, the FDT is updated only if the
> KEXEC_CRASH_HOTPLUG_SUPPORT kexec flag is passed to the kernel by
> userspace (kexec tools). When userspace passes this flag to the kernel,
> it indicates that the FDT is built to accommodate possible CPUs, and the
> FDT segment is excluded from SHA calculation, making it safe to update.
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
>   arch/powerpc/Kconfig              |  4 ++
>   arch/powerpc/include/asm/kexec.h  |  6 +++
>   arch/powerpc/kexec/core_64.c      | 69 +++++++++++++++++++++++++++++++
>   arch/powerpc/kexec/elf_64.c       | 12 +++++-
>   arch/powerpc/kexec/file_load_64.c | 15 +++++++
>   5 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 414b978b8010..91d7bb0b81ee 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -682,6 +682,10 @@ config RELOCATABLE_TEST
>   config ARCH_SUPPORTS_CRASH_DUMP
>   	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
>   
> +config ARCH_SUPPORTS_CRASH_HOTPLUG
> +	def_bool y
> +	depends on PPC64
> +
>   config ARCH_SELECTS_CRASH_DUMP
>   	def_bool y
>   	depends on CRASH_DUMP
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 562e1bb689da..943e58eb9bff 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -112,6 +112,12 @@ void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
>   struct crash_mem;
>   int update_cpus_node(void *fdt);
>   int get_crash_memory_ranges(struct crash_mem **mem_ranges);
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
> +#endif /*CONFIG_CRASH_HOTPLUG */
> +
>   #endif /* CONFIG_PPC64 */
>   
>   #ifdef CONFIG_KEXEC_FILE
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 48beaadcfb70..43fcd78c2102 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -542,6 +542,75 @@ int update_cpus_node(void *fdt)
>   	return ret;
>   }
>   


> +#ifdef CONFIG_CRASH_HOTPLUG
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +
> +/**
> + * arch_crash_handle_hotplug_event - Handle crash CPU/Memory hotplug events to update the
> + *				     necessary kexec segments based on the hotplug event.
> + * @image: a pointer to kexec_crash_image
> + * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
> + *
> + * Update the kdump image based on the type of hotplug event, represented by image->hp_action.
> + * CPU addition: Update the FDT segment to include the newly added CPU.
> + * CPU removal: No action is needed, with the assumption that it's okay to have offline CPUs
> + *		as part of the FDT.
> + * Memory addition/removal: No action is taken as this is not yet supported.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
> +{
> +	unsigned int hp_action = image->hp_action;
> +
> +	/*
> +	 * Since the hot-unplugged CPU is already part of crash FDT,
> +	 * no action is needed for CPU remove case.
> +	 */
> +	if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU) {
> +		return;
> +
> +	} else if (hp_action == KEXEC_CRASH_HP_ADD_CPU) {
> +
> +		void *fdt, *ptr;
> +		unsigned long mem;
> +		int i, fdt_index = -1;
> +
> +		/* Find the FDT segment index in kexec segment array. */
> +		for (i = 0; i < image->nr_segments; i++) {
> +			mem = image->segment[i].mem;
> +			ptr = __va(mem);
> +
> +			if (ptr && fdt_magic(ptr) == FDT_MAGIC) {
> +				fdt_index = i;
> +				break;
> +			}
> +		}
> +
> +		if (fdt_index < 0) {
> +			pr_err("Unable to locate FDT segment.\n");
> +			return;
> +		}
> +
> +		fdt = __va((void *)image->segment[fdt_index].mem);
> +
> +		/* Temporarily invalidate the crash image while it is replaced */
> +		xchg(&kexec_crash_image, NULL);
> +
> +		/* update FDT to refelect changes in CPU resrouces */
> +		if (update_cpus_node(fdt))
> +			pr_err("Failed to update crash FDT");
> +
> +		/* The crash image is now valid once again */
> +		xchg(&kexec_crash_image, image);
> +
> +	} else if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY ||
> +		   hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
> +		pr_info_once("Crash update is not supported for memory hotplug\n");
> +		return;
> +	}
> +}
> +#endif

Add this code snippet at the end of the file to avoid using this print
format accidentally for code unrelated to hotplug support?

> +
>   #ifdef CONFIG_PPC_64S_HASH_MMU
>   /* Values we need to export to the second kernel via the device tree. */
>   static __be64 htab_base;

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
