Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BC0C7618E
	for <kexec@archiver.kernel.org>; Mon, 24 Apr 2023 09:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8taTIjkt1voOFGGodv19G1TI5ze5ctHwDaZy4ma39EI=; b=1KAA2OZn4YzpPR
	3s0DdiXBZSmuugI5tKMCZvb9PtycAeengGcLfA/sOoVl6NbxbX4rOl8giOFqYXu1vimLWkP2hIBDz
	c5zMCnNG090YVlEIH6SIpmvvXsn8W87JCHqU1ywfzN7KoaXUF7twH4YPCOuA1Z4SaMS5Qr5sY80aO
	sn2vt4fkJjNg2deBEk4SW/hw7cq6a1XoNH6rUNJiRwrSJ/KtjE9r1HG+omfuMxFlBzLXhcxlWYKOK
	yLlhfkR7mIKb6kk3lM0rku86he+7TMyPqfZ/L9pcSOwxRI66NfeiemMDLEhGyi59Ud6pSw8UH1EpR
	EAghQRv9+0v9VMTIH0Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqszC-00Ftkk-36;
	Mon, 24 Apr 2023 09:59:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqszA-00Ftjz-15
	for kexec@lists.infradead.org;
	Mon, 24 Apr 2023 09:59:54 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O9veiv032458;
	Mon, 24 Apr 2023 09:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GLGqFvr9E46/9Jar4W1DGBJ7Yu3hZiMLFUXGHk9KZdg=;
 b=EZaMumgyt6CbwZ+OAG2woZrGZUwzDmzBw7eNCfb4tCVowNRIw6BsunX1T9vKl+jyqA+z
 Tzj6mDoBe5jHLMrQyaglJP0zR/y7Q/B2ZMGuICQAZmbRdU9bDApsuzGN8wzRb+CCHDWc
 Rr6iKzeo3nNObh3l9XzHuPxQd21aTAjOofgsVRK25wvbmjQTCM6RsWnPYe3Rhvd+xPJP
 LolMkhLZasgdcJykHQatbwsTN8nYDjm5b31/x8iY0rX+w/eTx5RkuTfbW494efdG7LmI
 WEwdae13Sn7JV7l78hecAMY+inGM5fXW29nk7Id1Sb0T0XO8uuMpLEDrSR2LCZWNorQe 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461bx762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 09:59:48 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33O9wmxa004814;
	Mon, 24 Apr 2023 09:59:47 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461bx750-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 09:59:47 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33O6RCYI028813;
	Mon, 24 Apr 2023 09:59:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3q47770v3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Apr 2023 09:59:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33O9xga331195540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Apr 2023 09:59:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B4922004B;
	Mon, 24 Apr 2023 09:59:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E980220043;
	Mon, 24 Apr 2023 09:59:41 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Apr 2023 09:59:41 +0000 (GMT)
Message-ID: <47d7a076-7567-50c8-2cdb-5218375bb299@linux.ibm.com>
Date: Mon, 24 Apr 2023 11:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v10 4/5] crash: forward memory_notify args to arch crash
 hotplug handler
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au
References: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
 <20230423105213.70795-5-sourabhjain@linux.ibm.com>
From: Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20230423105213.70795-5-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: er0EEpVonj0RrAOeZXSrIoK6HzfPckbj
X-Proofpoint-ORIG-GUID: SxKKecY2Ar6lt7yyEjTOAD6jPKbdRhTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_025952_496667_297D4045 
X-CRM114-Status: GOOD (  37.38  )
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
Cc: bhe@redhat.com, kexec@lists.infradead.org, Laurent Dufour <laurent.dufour@fr.ibm.com>, eric.devolder@oracle.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 23/04/2023 12:52:12, Sourabh Jain wrote:
> On PowePC memblock regions are used to prepare elfcorehdr which
> describes the memory regions of the running kernel to the kdump kernel.
> Since the notifier used for the memory hotplug crash handler gets
> initiated before the update of the memblock region happens (as depicted
> below) the newly prepared elfcorehdr still holds the old memory regions.
> If the elfcorehdr is prepared with stale memblock regions then the newly
> prepared elfcorehdr will still be holding stale memory regions. And dump
> collection with stale elfcorehdr will lead to dump collection failure or
> incomplete dump collection.
> 
> The sequence of actions done on PowerPC when an LMB memory hot removed:
> 
>  Initiate memory hot remove
>           |
>           v
>  offline pages
>           |
>           v
>  initiate memory notify call
>  chain for MEM_OFFLINE event  <---> Prepare new elfcorehdr and replace
>  				    it with old one
>           |
>           v
>  update memblock regions
> 
> Such challenges only exist for memory remove case. For the memory add
> case the memory regions are updated first and then memory notify calls
> the arch crash hotplug handler to update the elfcorehdr.
> 
> This patch passes additional information about the hot removed LMB to
> the arch crash hotplug handler in the form of memory_notify object.
> 
> How passing memory_notify to arch crash hotplug handler will help?
> 
> memory_notify holds the start PFN and page count of the hot removed
> memory. With that base address and the size of the hot removed memory
> can be calculated and same can be used to avoid adding hot removed
> memory region to get added in the elfcorehdr.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>

I don't remember sending a review-by on this patch earlier, do you?

> ---
>  arch/powerpc/include/asm/kexec.h |  2 +-
>  arch/powerpc/kexec/core_64.c     |  3 ++-
>  arch/x86/include/asm/kexec.h     |  2 +-
>  arch/x86/kernel/crash.c          |  3 ++-
>  include/linux/kexec.h            |  2 +-
>  kernel/crash_core.c              | 14 +++++++-------
>  6 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index f01ba767af56e..7e811bad5ec92 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -104,7 +104,7 @@ struct crash_mem;
>  int update_cpus_node(void *fdt);
>  int get_crash_memory_ranges(struct crash_mem **mem_ranges);
>  #if defined(CONFIG_CRASH_HOTPLUG)
> -void arch_crash_handle_hotplug_event(struct kimage *image);
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
>  #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>  #endif
>  #endif
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 611b89bcea2be..147ea6288a526 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -551,10 +551,11 @@ int update_cpus_node(void *fdt)
>   * arch_crash_hotplug_handler() - Handle crash CPU/Memory hotplug events to update the
>   *                                necessary kexec segments based on the hotplug event.
>   * @image: the active struct kimage
> + * @arg: struct memory_notify handler for memory add/remove case and NULL for CPU case.
>   *
>   * Update FDT segment to include newly added CPU. No action for CPU remove case.
>   */
> -void arch_crash_handle_hotplug_event(struct kimage *image)
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  {
>  	void *fdt, *ptr;
>  	unsigned long mem;
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 1bc852ce347d4..70c3b23b468b6 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -213,7 +213,7 @@ extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>  extern void kdump_nmi_shootdown_cpus(void);
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
> -void arch_crash_handle_hotplug_event(struct kimage *image);
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
>  #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index ead602636f3e0..b45d13193b579 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -445,11 +445,12 @@ int crash_load_segments(struct kimage *image)
>  /**
>   * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>   * @image: the active struct kimage
> + * @arg: struct memory_notify handler for memory add/remove case and NULL for CPU case.
>   *
>   * The new elfcorehdr is prepared in a kernel buffer, and then it is
>   * written on top of the existing/old elfcorehdr.
>   */
> -void arch_crash_handle_hotplug_event(struct kimage *image)
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>  {
>  	void *elfbuf = NULL, *old_elfcorehdr;
>  	unsigned long nr_mem_ranges;
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0ac41f48de0b1..69765e6a92d0d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -506,7 +506,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>  #endif
>  
>  #ifndef arch_crash_handle_hotplug_event
> -static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
> +static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>  #endif
>  
>  #ifndef crash_hotplug_cpu_support
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 4aa3c7a6b390f..7afe5f60d2bfe 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -718,7 +718,7 @@ subsys_initcall(crash_save_vmcoreinfo_init);
>   * list of segments it checks (since the elfcorehdr changes and thus
>   * would require an update to purgatory itself to update the digest).
>   */
> -static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>  {
>  	struct kimage *image;
>  
> @@ -775,7 +775,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>  	image->hp_action = hp_action;
>  
>  	/* Now invoke arch-specific update handler */
> -	arch_crash_handle_hotplug_event(image);
> +	arch_crash_handle_hotplug_event(image, arg);
>  
>  	/* No longer handling a hotplug event */
>  	image->hp_action = KEXEC_CRASH_HP_NONE;
> @@ -789,17 +789,17 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>  	kexec_unlock();
>  }
>  
> -static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *arg)
>  {
>  	switch (val) {
>  	case MEM_ONLINE:
>  		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> -			KEXEC_CRASH_HP_INVALID_CPU);
> +			KEXEC_CRASH_HP_INVALID_CPU, arg);
>  		break;
>  
>  	case MEM_OFFLINE:
>  		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
> -			KEXEC_CRASH_HP_INVALID_CPU);
> +			KEXEC_CRASH_HP_INVALID_CPU, arg);
>  		break;
>  	}
>  	return NOTIFY_OK;
> @@ -812,13 +812,13 @@ static struct notifier_block crash_memhp_nb = {
>  
>  static int crash_cpuhp_online(unsigned int cpu)
>  {
> -	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu, NULL);
>  	return 0;
>  }
>  
>  static int crash_cpuhp_offline(unsigned int cpu)
>  {
> -	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu, NULL);
>  	return 0;
>  }
>  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
