Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D88C7EE2A
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ljNAA4u8ys4B0xu5/evZOBIDbSKYbrZAoXeLzlET9FY=; b=Mo0Od7EsGnUPxg
	5wpkfHe6m3rZIJTyBJh3vsOg3nWzHuyQVG+eUWp1SAabljaHeBMjrZkGE0bIcDL5IrrDUg8+lv6Ue
	gP5VwhJYXULxOpXQlQDri7zNVHOKdDvSmNs31uHFA1DTBmJCC1sirfTtCoXZrPdvizK5CTxVhV49p
	TnKpfZ01keXB42YA9To6lBaPQ0DOVwUparzk186qPUknOq3SvrXqG5AfXvhy6h/S4Vlko/9RmAYVi
	w1xPfboFb8ZMonq17iojDy/HPbEReRX4FPv0voif01oLibDUgOHXE8Aw+wM4caMyvSsYvE3/dvrVy
	RJmrIEFOId1oRfuPwipQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwGdz-002OHR-2Q;
	Tue, 09 May 2023 06:16:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwGdr-002OGl-2n
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 06:16:11 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349672aH007725;
	Tue, 9 May 2023 06:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1z+JN6aLik1a4qvLewqN5aPDkF1XYfLqEv0aqembvSk=;
 b=mcgk3ldLwVdwOHLdSY5zMSHGskEO0YkuVMNQNO7XViCPcKcxafBxyN9bFmAInwUshfyn
 hFZYuuAw1TKnxLTZ1jVoAFqOVlLLkotal02xf/0dO46+MeK46sUlk9P7iQiDhfBxK2x/
 f/N2G3a3cJhjU5pofEAnzKl67/N6KZwoRWbeMBUEvgcKC71uUoPB5s9rPdrvvwJ9IM0b
 7bmoKK3msgaji7cnQglfe/hWswyF9FnNuEHitLDkiPqdMr8hQLAKLQULHK16XWRbWp3y
 WvN7sSbI6m0X5oLWzWSBn8RA6hhVV2lWpyUFRWZSzWZzQpZfd7lR10WSyyw7FmHhKLZK Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfg8p0xpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 May 2023 06:15:56 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34967liJ013249;
	Tue, 9 May 2023 06:15:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfg8p0xmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 May 2023 06:15:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3491a5Nk029062;
	Tue, 9 May 2023 06:15:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qf896r6h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 May 2023 06:15:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3496Fomp44302806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 May 2023 06:15:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3932320043;
	Tue,  9 May 2023 06:15:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1564620040;
	Tue,  9 May 2023 06:15:46 +0000 (GMT)
Received: from [9.43.122.124] (unknown [9.43.122.124])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 May 2023 06:15:45 +0000 (GMT)
Message-ID: <99cb5ee3-da46-392a-e582-e64b479003e4@linux.ibm.com>
Date: Tue, 9 May 2023 11:45:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 6/8] crash: hotplug support for kexec_load()
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-7-eric.devolder@oracle.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230503224145.7405-7-eric.devolder@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n7wlQVMZTzbmFt0UP1qfy-oTwq5q1KBx
X-Proofpoint-ORIG-GUID: UTm9BzqCjRDM-EgwwXFbHJ_P9P1hkrkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_231607_933635_6515CC80 
X-CRM114-Status: GOOD (  56.46  )
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


On 04/05/23 04:11, Eric DeVolder wrote:
> The hotplug support for kexec_load() requires coordination with
> userspace, and therefore a little extra help from the kernel to
> facilitate the coordination.
>
> In the absence of the solution contained within this particular
> patch, if a kdump capture kernel is loaded via kexec_load() syscall,
> then the crash hotplug logic would find the segment containing the
> elfcorehdr, and upon a hotplug event, rewrite the elfcorehdr. While
> generally speaking that is the desired behavior and outcome, a
> problem arises from the fact that if the kdump image includes a
> purgatory that performs a digest checksum, then that check would
> fail (because the elfcorehdr was changed), and the capture kernel
> would fail to boot and no kdump occur.
>
> Therefore, what is needed is for the userspace kexec-tools to
> indicate to the kernel whether or not the supplied kdump image/
> elfcorehdr can be modified (because the kexec-tools excludes the
> elfcorehdr from the digest, and sizes the elfcorehdr memory buffer
> appropriately).
>
> To solve these problems, this patch introduces:
>   - a new kexec flag KEXEC_UPATE_ELFCOREHDR to indicate that it is

Architectures may need to update kexec segment other then elfcorehdr.
How about changing the flag name to KEXEC_UPDATE_SEGMENTS?

- Sourabh

>     safe for the kernel to modify the elfcorehdr (because kexec-tools
>     has excluded the elfcorehdr from the digest).
>   - the /sys/kernel/crash_elfcorehdr_size node to communicate to
>     kexec-tools what the preferred size of the elfcorehdr memory buffer
>     should be in order to accommodate hotplug changes.
>   - The sysfs crash_hotplug nodes (ie.
>     /sys/devices/system/[cpu|memory]/crash_hotplug) are now dynamic in
>     that they examine kexec_file_load() vs kexec_load(), and when
>     kexec_load(), whether or not KEXEC_UPDATE_ELFCOREHDR is in effect.
>     This is critical so that the udev rule processing of crash_hotplug
>     indicates correctly (ie. the userspace unload-then-load of the
>     kdump of the kdump image can be skipped, or not).
>
> With this patch in place, I believe the following statements to be true
> (with local testing to verify):
>
>   - For systems which have these kernel changes in place, but not the
>     corresponding changes to the crash hot plug udev rules and
>     kexec-tools, (ie "older" systems) those systems will continue to
>     unload-then-load the kdump image, as has always been done. The
>     kexec-tools will not set KEXEC_UPDATE_ELFCOREHDR.
>   - For systems which have these kernel changes in place and the proposed
>     udev rule changes in place, but not the kexec-tools changes in place:
>      - the use of kexec_load() will not set KEXEC_UPDATE_ELFCOREHDR and
>        so the unload-then-reload of kdump image will occur (the sysfs
>        crash_hotplug nodes will show 0).
>      - the use of kexec_file_load() will permit sysfs crash_hotplug nodes
>        to show 1, and the kernel will modify the elfcorehdr directly. And
>        with the udev changes in place, the unload-then-load will not occur!
>   - For systems which have these kernel changes as well as the udev and
>     kexec-tools changes in place, then the user/admin has full authority
>     over the enablement and support of crash hotplug support, whether via
>     kexec_file_load() or kexec_load().
>
> Said differently, as kexec_load() was/is widely in use, these changes
> permit it to continue to be used as-is (retaining the current unload-then-
> reload behavior) until such time as the udev and kexec-tools changes can
> be rolled out as well.
>
> I've intentionally kept the changes related to userspace coordination
> for kexec_load() separate as this need was identified late; the
> rest of this series has been generally reviewed and accepted. Once
> this support has been vetted, I can refactor if needed.
>
> Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   arch/x86/include/asm/kexec.h | 11 +++++++----
>   arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
>   include/linux/kexec.h        | 14 ++++++++++++--
>   include/uapi/linux/kexec.h   |  1 +
>   kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
>   kernel/kexec.c               |  3 +++
>   kernel/ksysfs.c              | 15 +++++++++++++++
>   7 files changed, 96 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 9143100ea3ea..3be6a98751f0 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
>   #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>   
>   #ifdef CONFIG_HOTPLUG_CPU
> -static inline int crash_hotplug_cpu_support(void) { return 1; }
> -#define crash_hotplug_cpu_support crash_hotplug_cpu_support
> +int arch_crash_hotplug_cpu_support(void);
> +#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
>   #endif
>   
>   #ifdef CONFIG_MEMORY_HOTPLUG
> -static inline int crash_hotplug_memory_support(void) { return 1; }
> -#define crash_hotplug_memory_support crash_hotplug_memory_support
> +int arch_crash_hotplug_memory_support(void);
> +#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
>   #endif
> +
> +unsigned int arch_crash_get_elfcorehdr_size(void);
> +#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
>   #endif
>   
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 0c9d496cf7ce..8064e65de6c0 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -442,6 +442,33 @@ int crash_load_segments(struct kimage *image)
>   #undef pr_fmt
>   #define pr_fmt(fmt) "crash hp: " fmt
>   
> +/* These functions provide the value for the sysfs crash_hotplug nodes */
> +#ifdef CONFIG_HOTPLUG_CPU
> +int arch_crash_hotplug_cpu_support(void)
> +{
> +	return crash_check_update_elfcorehdr();
> +}
> +#endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int arch_crash_hotplug_memory_support(void)
> +{
> +	return crash_check_update_elfcorehdr();
> +}
> +#endif
> +
> +unsigned int arch_crash_get_elfcorehdr_size(void)
> +{
> +	unsigned int sz;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		sz = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
> +	else
> +		sz += 2 + CONFIG_NR_CPUS_DEFAULT;
> +	sz *= sizeof(Elf64_Phdr);
> +	return sz;
> +}
> +
>   /**
>    * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>    * @image: the active struct kimage
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 6a8a724ac638..050e20066cdb 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -335,6 +335,10 @@ struct kimage {
>   	unsigned int preserve_context : 1;
>   	/* If set, we are using file mode kexec syscall */
>   	unsigned int file_mode:1;
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	/* If set, allow changes to elfcorehdr of kexec_load'd image */
> +	unsigned int update_elfcorehdr:1;
> +#endif
>   
>   #ifdef ARCH_HAS_KIMAGE_ARCH
>   	struct kimage_arch arch;
> @@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
>   
>   /* List of defined/legal kexec flags */
>   #ifndef CONFIG_KEXEC_JUMP
> -#define KEXEC_FLAGS    KEXEC_ON_CRASH
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
>   #else
> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
>   #endif
>   
>   /* List of defined/legal kexec file flags */
> @@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>   static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>   #endif
>   
> +int crash_check_update_elfcorehdr(void);
> +
>   #ifndef crash_hotplug_cpu_support
>   static inline int crash_hotplug_cpu_support(void) { return 0; }
>   #endif
> @@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
>   static inline int crash_hotplug_memory_support(void) { return 0; }
>   #endif
>   
> +#ifndef crash_get_elfcorehdr_size
> +static inline crash_get_elfcorehdr_size(void) { return 0; }
> +#endif
> +
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 981016e05cfa..01766dd839b0 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -12,6 +12,7 @@
>   /* kexec flags for different usage scenarios */
>   #define KEXEC_ON_CRASH		0x00000001
>   #define KEXEC_PRESERVE_CONTEXT	0x00000002
> +#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
>   #define KEXEC_ARCH_MASK		0xffff0000
>   
>   /*
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ef6e91daad56..e05bfdb7eaed 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
>   #ifdef CONFIG_CRASH_HOTPLUG
>   #undef pr_fmt
>   #define pr_fmt(fmt) "crash hp: " fmt
> +
> +/*
> + * This routine utilized when the crash_hotplug sysfs node is read.
> + * It reflects the kernel's ability/permission to update the crash
> + * elfcorehdr directly.
> + */
> +int crash_check_update_elfcorehdr(void)
> +{
> +	int rc = 0;
> +
> +	/* Obtain lock while reading crash information */
> +	if (!kexec_trylock()) {
> +		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		return 0;
> +	}
> +	if (kexec_crash_image) {
> +		if (kexec_crash_image->file_mode)
> +			rc = 1;
> +		else
> +			rc = kexec_crash_image->update_elfcorehdr;
> +	}
> +	/* Release lock now that update complete */
> +	kexec_unlock();
> +
> +	return rc;
> +}
> +
>   /*
>    * To accurately reflect hot un/plug changes of cpu and memory resources
>    * (including onling and offlining of those resources), the elfcorehdr
> @@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   
>   	image = kexec_crash_image;
>   
> +	/* Check that updating elfcorehdr is permitted */
> +	if (!(image->file_mode || image->update_elfcorehdr))
> +		goto out;
> +
>   	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>   		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>   		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 92d301f98776..60de64bd14b9 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -129,6 +129,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>   	if (flags & KEXEC_PRESERVE_CONTEXT)
>   		image->preserve_context = 1;
>   
> +	if (flags & KEXEC_UPDATE_ELFCOREHDR)
> +		image->update_elfcorehdr = 1;
> +
>   	ret = machine_kexec_prepare(image);
>   	if (ret)
>   		goto out;
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index aad7a3bfd846..1d4bc493b2f4 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>   }
>   KERNEL_ATTR_RO(vmcoreinfo);
>   
> +#ifdef CONFIG_CRASH_HOTPLUG
> +static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
> +			       struct kobj_attribute *attr, char *buf)
> +{
> +	unsigned int sz = crash_get_elfcorehdr_size();
> +
> +	return sysfs_emit(buf, "%u\n", sz);
> +}
> +KERNEL_ATTR_RO(crash_elfcorehdr_size);
> +
> +#endif
> +
>   #endif /* CONFIG_CRASH_CORE */
>   
>   /* whether file capabilities are enabled */
> @@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
>   #endif
>   #ifdef CONFIG_CRASH_CORE
>   	&vmcoreinfo_attr.attr,
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	&crash_elfcorehdr_size_attr.attr,
> +#endif
>   #endif
>   #ifndef CONFIG_TINY_RCU
>   	&rcu_expedited_attr.attr,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
