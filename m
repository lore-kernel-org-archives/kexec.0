Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7405C4829B
	for <kexec@archiver.kernel.org>; Mon, 12 Feb 2024 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bh2q5M6qUoWWgkqoILiEHUKBv4cY2b5ionq5NNQfGz4=; b=G8fDUWZ/0PlqPa
	FdTF9cf97dBRP+Qt0tLF67BsdXWYowVmnili6zIQCAfERZZbGpk7UVZZFFw0d/F3PGEK9j+ZHq8Rj
	XF4OsD3VlbnOjYQns1OVDR5DlPeoDr0yXwcvkwo9ihfa3SgNjEPMFCbJvlRlYWsGAjS7dwxHOuFY6
	5TXPaOhXIp2iKZf9H9F+Zpv5IjFIpputsn80BOcq+8g6ioGqSXj/oG+tZMpn/GhKBKfdyxrOqwP+i
	oUNgTWDxY9K5TqS5ioenSDwEfmd9HGOeCAJoT4YTlTRcUXSvTK8jYHYQoaIbj6s+6awNRI9s0zcgv
	sU/sHYlZRVOA37j/yZNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZUxP-000000059lV-26xb;
	Mon, 12 Feb 2024 11:58:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZUxN-000000059kd-0fAc
	for kexec@lists.infradead.org;
	Mon, 12 Feb 2024 11:58:42 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBuMsg027069;
	Mon, 12 Feb 2024 11:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fjgm4EVcv42uFuuYVFwe4hjzuCWEw3kmWX6V7EkIpkM=;
 b=dJ6omRxgBKiAISLjTrCaoc40P6qRsGeAfveK+gLUIJNfaJOQQjDhJmWqdxUzFWwhCRbC
 dMYKGyhOVCjgeyQCbHaTgbe+qITmDhiypJiBKAHq50nJwRj+NAbvNMPWP/LM61aSJGEa
 OW7tgAOlETuFFeT3CME68mMieARW3S0fpYi2WNKXrNIAqLarbOLJg7369teojwfwSRL2
 rcINYxUadb5hC3/mAk+3w9rO3tRTE6s7arBvqfMyaiq+p7mEYpkEfUjkNJ+N5SW2xyXy
 KzPBgt4jcCbysiBrPFLbOQrfvggsVDhvP2WK7peNZS16PyRJwfCzNHZ0S9XC+LU2ZV2R gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jw8r2j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:58:09 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CBuctl028176;
	Mon, 12 Feb 2024 11:58:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jw8r2fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:58:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBYXhF010063;
	Mon, 12 Feb 2024 11:58:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkg0x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:58:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CBw2bU2687620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 11:58:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD9B20043;
	Mon, 12 Feb 2024 11:58:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08DC520040;
	Mon, 12 Feb 2024 11:57:51 +0000 (GMT)
Received: from [9.61.8.5] (unknown [9.61.8.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 11:57:50 +0000 (GMT)
Message-ID: <0bfaf88a-4ffc-4401-9673-ec4a125a04b9@linux.ibm.com>
Date: Mon, 12 Feb 2024 17:27:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 1/5] crash: forward memory_notify arg to arch crash
 hotplug handler
To: Baoquan He <bhe@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
References: <20240111105138.251366-1-sourabhjain@linux.ibm.com>
 <20240111105138.251366-2-sourabhjain@linux.ibm.com>
 <ZcBR8Q+/WL3luZnP@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZcBR8Q+/WL3luZnP@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OLYrLvp5aRXBuf99ow6AA4bwTs9giQSt
X-Proofpoint-ORIG-GUID: -nNR88___-ZZP6OuTmNrURUYx8etNA1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 mlxlogscore=968 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_035841_352517_B63D07B8 
X-CRM114-Status: GOOD (  24.25  )
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



On 05/02/24 08:41, Baoquan He wrote:
> On 01/11/24 at 04:21pm, Sourabh Jain wrote:
>> In the event of memory hotplug or online/offline events, the crash
>> memory hotplug notifier `crash_memhp_notifier()` receives a
>> `memory_notify` object but doesn't forward that object to the
>> generic and architecture-specific crash hotplug handler.
>>
>> The `memory_notify` object contains the starting PFN (Page Frame Number)
>> and the number of pages in the hot-removed memory. This information is
>> necessary for architectures like PowerPC to update/recreate the kdump
>> image, specifically `elfcorehdr`.
>>
>> So update the function signature of `crash_handle_hotplug_event()` and
>> `arch_crash_handle_hotplug_event()` to accept the `memory_notify` object
>> as an argument from crash memory hotplug notifier.
>>
>> Since no such object is available in the case of CPU hotplug event, the
>> crash CPU hotplug notifier `crash_cpuhp_online()` passes NULL to the
>> crash hotplug handler.
>>
> ......
>> ---
>>   arch/x86/include/asm/kexec.h |  2 +-
>>   arch/x86/kernel/crash.c      |  3 ++-
>>   include/linux/kexec.h        |  2 +-
>>   kernel/crash_core.c          | 14 +++++++-------
>>   4 files changed, 11 insertions(+), 10 deletions(-)
> LGTM,
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks Baoquan He

- Sourabh

>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index c9f6a6c5de3c..9bb6607e864e 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -208,7 +208,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
>>   extern void kdump_nmi_shootdown_cpus(void);
>>   
>>   #ifdef CONFIG_CRASH_HOTPLUG
>> -void arch_crash_handle_hotplug_event(struct kimage *image);
>> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
>>   #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>>   
>>   #ifdef CONFIG_HOTPLUG_CPU
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index b6b044356f1b..44744e9c68ec 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -428,10 +428,11 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>>   /**
>>    * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>>    * @image: a pointer to kexec_crash_image
>> + * @arg: struct memory_notify handler for memory hotplug case and NULL for CPU hotplug case.
>>    *
>>    * Prepare the new elfcorehdr and replace the existing elfcorehdr.
>>    */
>> -void arch_crash_handle_hotplug_event(struct kimage *image)
>> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>>   {
>>   	void *elfbuf = NULL, *old_elfcorehdr;
>>   	unsigned long nr_mem_ranges;
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 400cb6c02176..802052d9c64b 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -483,7 +483,7 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>>   #endif
>>   
>>   #ifndef arch_crash_handle_hotplug_event
>> -static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>>   #endif
>>   
>>   int crash_check_update_elfcorehdr(void);
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index d48315667752..ab1c8e79759d 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -914,7 +914,7 @@ int crash_check_update_elfcorehdr(void)
>>    * list of segments it checks (since the elfcorehdr changes and thus
>>    * would require an update to purgatory itself to update the digest).
>>    */
>> -static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>>   {
>>   	struct kimage *image;
>>   
>> @@ -976,7 +976,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>>   	image->hp_action = hp_action;
>>   
>>   	/* Now invoke arch-specific update handler */
>> -	arch_crash_handle_hotplug_event(image);
>> +	arch_crash_handle_hotplug_event(image, arg);
>>   
>>   	/* No longer handling a hotplug event */
>>   	image->hp_action = KEXEC_CRASH_HP_NONE;
>> @@ -992,17 +992,17 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>>   	crash_hotplug_unlock();
>>   }
>>   
>> -static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *arg)
>>   {
>>   	switch (val) {
>>   	case MEM_ONLINE:
>>   		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
>> -			KEXEC_CRASH_HP_INVALID_CPU);
>> +			KEXEC_CRASH_HP_INVALID_CPU, arg);
>>   		break;
>>   
>>   	case MEM_OFFLINE:
>>   		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> -			KEXEC_CRASH_HP_INVALID_CPU);
>> +			KEXEC_CRASH_HP_INVALID_CPU, arg);
>>   		break;
>>   	}
>>   	return NOTIFY_OK;
>> @@ -1015,13 +1015,13 @@ static struct notifier_block crash_memhp_nb = {
>>   
>>   static int crash_cpuhp_online(unsigned int cpu)
>>   {
>> -	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu, NULL);
>>   	return 0;
>>   }
>>   
>>   static int crash_cpuhp_offline(unsigned int cpu)
>>   {
>> -	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu, NULL);
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.41.0
>>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
