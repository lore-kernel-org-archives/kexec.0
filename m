Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A12C43334
	for <kexec@archiver.kernel.org>; Mon, 20 Jun 2022 05:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y9PCRGUId+RANCMS25X+kCQlk6x2hrQeBQx9SZv+/+M=; b=2qpktZqw3GPnQf
	TBbbK/5+IBKiH7sSa+mIESs666nM2/AnZIqf09Uuals+ymSyNk5dQFM984YvJ/PrY2yZ2JBn8Bpdd
	JtquP99rHochXrsmbTT12ePKLuCA2gSx+gF/g9mfiFRWSFu5wWU1kPEwtNhY45N5lKzPyfGiMc6T4
	iSeXTwBf7up8To3DfXnShipkcvmNmqqHC2FsLBxtpbHzjkd6xHi8KMHthB1VJF6IVEV5vV+zrCkpK
	LHQLeHKxbw2OGbFujt5H8IPeBtJY2RHuJ4O9AZWYqry767oH9RJKvRRWB+3XhwGPJjq6w/ATyVqTL
	PxPnToUPrzh898Mrh2QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o39dl-00GEHP-FY; Mon, 20 Jun 2022 05:07:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o39df-00GEGN-TB
	for kexec@lists.infradead.org; Mon, 20 Jun 2022 05:07:53 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K1J2wT005028;
	Mon, 20 Jun 2022 05:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VeGCcSFMnB4/3mrtIVnh+AIWhhcrlrtkJ4MQbI1mY3M=;
 b=iCTMkRPq5SEZ5LkY6pyU9+45+GM8fn2sJPmTw6roUfpALmiU7D+x5Vh4n947DPqVrkNp
 8xtnVW9nHnKyVXRA9XtRaR2lnrfqFLpMVS7rLzgd0ANk0alEQMzyI6X04pk0pVPMg6cG
 atnOu/JaY9JTo7x7YxgXL7o7W3V01ctf/D9AtG9ztrbW8sBO4NJuJRa4iLmWpLB4oVY9
 Blho/gBsqQqNnTjAcepZZz/9rNki5jB9jNEtfNo+A6FoThtmhzzDVllK/LPrTHObtyJo
 GW46E8GSbfj1ab2t11XBzwqllPkX7CZwyySCmmSanAYiEn3XY4zp++IanIhHu0jY+FIN pw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr1aekcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 05:07:11 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25K4xDv3008249;
	Mon, 20 Jun 2022 05:07:10 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr1aekby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 05:07:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K55aRE025895;
	Mon, 20 Jun 2022 05:07:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 3gs6b91wpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jun 2022 05:07:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K57AlH25100686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jun 2022 05:07:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C4324203F;
	Mon, 20 Jun 2022 05:07:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 199F442042;
	Mon, 20 Jun 2022 05:07:00 +0000 (GMT)
Received: from [9.43.109.136] (unknown [9.43.109.136])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jun 2022 05:06:59 +0000 (GMT)
Message-ID: <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
Date: Mon, 20 Jun 2022 10:36:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220613224240.79400-8-eric.devolder@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lweh2CGpAORRR1_CaluIPNglXYSMZJeo
X-Proofpoint-GUID: vPrMKaQn4HUBcfwyr-zDRHa1N1ZPJiwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_03,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_220751_976413_60C27D1B 
X-CRM114-Status: GOOD (  36.35  )
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

Hello Eric,

On 14/06/22 04:12, Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
>
> When loading the crash kernel via kexec_load or kexec_file_load,
> the elfcorehdr is identified at run time in
> crash_core:handle_hotplug_event().
>
> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, and then installed over the top of
> the existing elfcorehdr.
>
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
>
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>
> With this change, crash hotplug for kexec_file_load syscall
> is supported. The kexec_load is also supported, but also
> requires a corresponding change to userspace kexec-tools.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   arch/x86/Kconfig        |  11 ++++
>   arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 127 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 762a0b6ab8b6..e9eecff3b97d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2082,6 +2082,17 @@ config CRASH_DUMP
>   	  (CONFIG_RELOCATABLE=y).
>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>   
> +config CRASH_MAX_MEMORY_RANGES
> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	int
> +	default 32768
> +	help
> +	  For the kexec_file_load path, specify the maximum number of
> +	  memory regions, eg. as represented by the 'System RAM' entries
> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
> +	  size to determine the final buffer size.
> +
>   config KEXEC_JUMP
>   	bool "kexec jump"
>   	depends on KEXEC && HIBERNATION
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9db41cce8d97..b9cdf7a0d868 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -25,6 +25,7 @@
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   #include <linux/memblock.h>
> +#include <linux/highmem.h>
>   
>   #include <asm/processor.h>
>   #include <asm/hardirq.h>
> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>   	image->elf_headers = kbuf.buffer;
>   	image->elf_headers_sz = kbuf.bufsz;
>   
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
> +	/* For marking as usable to crash kernel */
> +	image->elf_headers_sz = kbuf.memsz;
> +	/* Record the index of the elfcorehdr segment */
> +	image->elfcorehdr_index = image->nr_segments;
> +	image->elfcorehdr_index_valid = true;
> +#else
>   	kbuf.memsz = kbuf.bufsz;
> +#endif
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>   	ret = kexec_add_buffer(&kbuf);
> @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
>   	return ret;
>   }
>   #endif /* CONFIG_KEXEC_FILE */
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +int crash_hotplug_support(void) { return 1; }
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	/*
> +	 * NOTE: The addresses and sizes passed to this routine have
> +	 * already been fully aligned on page boundaries. There is no
> +	 * need for massaging the address or size.
> +	 */
> +	void *ptr = NULL;
> +
> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
> +	if (size > 0) {
> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +
> +		ptr = kmap(page);
> +	}
> +
> +	return ptr;
> +}
> +
> +void arch_unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap(*ptr);
> +		*ptr = NULL;
> +	}
> +}

Aren't arch will have build issue if arch_[un]map_crash_pages methods 
are not defined?

Thanks,
Sourabh Jain


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
