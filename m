Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2C3C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZBO/ZTS7dnKuk5yTCrY9zKxxMchuFN1Q3Zkrs1YTSa0=; b=VoDRt3Oodx2ShB
	7zgaR4xwxWm9nGSI2k5Z9cvqubcifsJI3KiDSoRgXZvVbE+p/ccY1yq0IgqoLKnwDXjfEJkK/7/LT
	wQEzNBLNYC/+UfXbusIhxAFR+KmYUTQnnrWlJCj2Pb4A1iAWT2Te02DbWaBeDwvVp4LvsPOunpdTW
	2W/ZcqsIknjKM1fkO9827YnInjVza0L76vle0Es60VpJn35IKi1D/R5KZRfxpl6ggJ6TIDX1xEZ42
	Fr2qv9sn8SsEJzKZGysufxuk/0MbcpqREP88sK4VBJxj+x8UPP+0gLU0oRQWs2kH3XBviIShPc0u8
	lNJEV+PIKoCUsMZWUXPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGCDS-001nX5-0O;
	Thu, 21 Dec 2023 06:07:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGCDP-001nWg-1b
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 06:07:29 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL5gsvW027919;
	Thu, 21 Dec 2023 06:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mlEzLMSbgwKYiXuGSUXtjot5hxjG7NAbIvPHyReafCo=;
 b=iiO6RTKgSw32eTP6fhTUZw0M1vL8KoRKLZVAubqn192u8IT8c5MQDymAB1IPgeyMp+ao
 3drJApUXoWbRc5Em44b8lZKPv9Z5iY0K9J0yQUoB00h1tRzMx6+FUk12y4V5qDyOvT4b
 W0xBdBPwOgQz4X5H3AkkP1KHmCdmVaok+tyezLzePyPhZlA9Z7AjTfV2qWXh8HjIEW8x
 aE9ptMXNzJkjfr4VJDALIi2yzs5v9rGn/DxkxywDg0UvvLdoT5Sqs8vsamowY4SZl+Y4
 MpJmi5qoZg8DY5yU20Ugf3qO6eTSzwKn27jyw3Cs5aHypCxqiDU5vw0HUhdjq+zXDFaA kw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4fey8ruk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 06:06:52 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BL66pXU003864;
	Thu, 21 Dec 2023 06:06:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4fey8ru7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 06:06:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL5oJBT004797;
	Thu, 21 Dec 2023 06:06:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1pm03ba9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 06:06:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BL66jK319071494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 06:06:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D97F42004E;
	Thu, 21 Dec 2023 06:06:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 807152004B;
	Thu, 21 Dec 2023 06:06:40 +0000 (GMT)
Received: from [9.195.35.103] (unknown [9.195.35.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Dec 2023 06:06:40 +0000 (GMT)
Message-ID: <cdde877b-e620-45db-ae28-4b691c1ae5b6@linux.ibm.com>
Date: Thu, 21 Dec 2023 11:36:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/6] crash: add a new kexec flag for FDT update
Content-Language: en-US
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
        Eric DeVolder <eric.devolder@oracle.com>,
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
References: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
 <20231211083056.340404-4-sourabhjain@linux.ibm.com>
 <ZXu55ZXVSMeQDE/e@MiWiFi-R3L-srv>
 <7fe7b62f-d3fc-4035-96fe-1ab0e3e743c0@linux.ibm.com>
 <ZX1wwVlE85FcTxmV@MiWiFi-R3L-srv>
 <67cadf74-6ae6-4f37-8645-af1833b13196@linux.ibm.com>
 <ZX5H+X9Urz8kuiSG@MiWiFi-R3L-srv>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZX5H+X9Urz8kuiSG@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k5lfgCxIBfLmT59O_Qno0leysUmwS1Ik
X-Proofpoint-ORIG-GUID: 4bcOEpxyibbmTSwJ2B9qVbi9bSP48_H1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_02,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_220727_673071_D2B8EEF2 
X-CRM114-Status: GOOD (  44.08  )
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

Hello Baoquan,

While replying to this email earlier, I mistakenly pressed "Reply to List"
instead of "Reply to All." Consequently, my response was sent only to 
powerpc
mailing list.

On 17/12/23 06:29, Baoquan He wrote:
> On 12/17/23 at 12:27am, Sourabh Jain wrote:
>> On 16/12/23 15:11, Baoquan He wrote:
>>> On 12/15/23 at 12:17pm, Sourabh Jain wrote:
>>> ......
>>>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>>>> index 0f6ea35879ee..bcedb7625b1f 100644
>>>>>> --- a/include/linux/kexec.h
>>>>>> +++ b/include/linux/kexec.h
>>>>>> @@ -319,6 +319,7 @@ struct kimage {
>>>>>>     #ifdef CONFIG_CRASH_HOTPLUG
>>>>>>     	/* If set, allow changes to elfcorehdr of kexec_load'd image */
>>>>>>     	unsigned int update_elfcorehdr:1;
>>>>>> +	unsigned int update_fdt:1;
>>>>> Can we unify this to one flag, e.g hotplug_update?
>>>>>
>>>>> With this, on x86_64, we will skip the sha calculation for elfcorehdr.
>>>>> On ppc, we will skip the sha calculation for elfcorehdr and fdt.
>>>> Yeah, that's what I suggested to Eric. I can do that, but I see one
>>>> problem with powerpc or other platforms that need to skip SHA
>>>> for more kexec segments in addition to elfcorehdr.
>>>>
>>>> `update_elfcorehdr` is set when the kexec tool sends the
>>>> `KEXEC_UPDATE_ELFCOREHDR`
>>>> flag to the kernel for the `kexec_load` system call.
>>>>
>>>> Given that the kexec tool has already been updated to send the
>>>> `KEXEC_UPDATE_ELFCOREHDR` flag only when elfcorehdr is skipped from
>>>> SHA verification in generic code, now it would be tricky for architectures
>>>> to
>>>> determine whether kexec has skipped SHA verification for just elfcorehdr
>>>> or all segments needed on the platform with the same flag.
>>> In kexec-tools, it's judged by do_hotplug to skip the elfcorehdr
>>> segment. I am wondering how you skip the fdt segment when calculating
>>> and verifying sha, only saw the update_fdt mark.
>> In the kexec tool where we loop through all the kexec segments to calculate
>> the SHA, there will be a arch call made to determine whether the segment
>> needs
>> to be excluded from SHA or not.
> OK, a arch call will be added to exclude segments in the ARCH. And the
> elfcorehdr segment need be excluded in x86 ARCH in case other ARCH later
> may not want to exclude elfcorehdr.

Yes, Arch can choose which segment to exclude.


>> Now in the arch function if decide a specific segment needs to excluded then
>> corresponding flag is also set by arch function to communicate same with the
>> kernel.
> But I don't see how you exclude elfcorehdr and fdt in kernel for
> kexec_file codes. It's not happening in kexec-tools.

On PowerPC, SHA verification is NOT performed for the kexec_file_load 
case; hence, you
won't find any code changes in my patch series to exclude FDT in the 
kernel code.

However, let's consider a scenario where it gets added in the future, or 
other architectures
need to skip the kexec segment, in addition to elfcorehdr. In that case, 
we can use the
same setup as you suggested below. For each kexec segment, there should 
be an
architecture-specific function call to decide whether the segment needs 
to be excluded or not.

>>> About the existing KEXEC_UPDATE_ELFCOREHDR, we only rename the macro,
>>> but still use the same value, could you think of what problem could be
>>> caused between kernel and kexec-tools utility, the old and new version
>>> compatibility?
>> Just changing the macro name will NOT help because the current kexec tool
>> enables the KEXEC_UPDATE_ELFCOREHDR = 0x00000004 kexec flag bit
>> if
>> the command argument --hotplug is passed to the kexec
>> and
>> the /sys/kernel/crash_elfcorehdr_size file exists in the system.
> As we have discussed, excluding will be done in each ARCH's function
> when doing sha calculation in kexec-tools, isn't it?
>
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index b5393e3b20aa..0095aeec988a 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -701,10 +701,10 @@ static void update_purgatory(struct kexec_info *info)
>   			continue;
>   		}
>   
> -		/* Don't include elfcorehdr in the checksum, if hotplug
> +		/* Don't include unwanted segments in the checksum, if hotplug
>   		 * support enabled.
> -		 */
> -		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
> +		if (do_hotplug)
> +			arch_exclude_segments(info, &i)
>   			continue;
>   		}

Yes, something like the above should work.
>> Now, let's say an architecture enables this feature in the kernel with the
>> assumption
>> that the 0x00000004 kexec flag bit is passed from the kexec tool when all
>> the required
>> kexec segments are skipped from SHA calculation. In this case, the current
>> kexec tool,
>> which passes the 0x00000004 kexec flag bit only when the elfcorehdr is
>> skipped, will
>> cause issues for architectures.
>>
>>> If it's about the new header files installed on older kernel, we can
>>> change it like below? Fortunately only one release, 6.6 passed.
>>>
>>> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
>>> index 3d5b3d757bed..df6a6505e267 100644
>>> --- a/include/uapi/linux/kexec.h
>>> +++ b/include/uapi/linux/kexec.h
>>> @@ -13,7 +13,7 @@
>>>    #define KEXEC_ON_CRASH         0x00000001
>>>    #define KEXEC_PRESERVE_CONTEXT 0x00000002
>>> -#define KEXEC_UPDATE_FDT       0x00000008
>>> +#define KEXEC_CRASH_HOTPLUG_UPDATE 0x00000004
>>>    #define KEXEC_UPDATE_ELFCOREHDR        0x00000004
>>>    #define KEXEC_ARCH_MASK                0xffff0000
>>>    /*
>>>
>>> With my understanding, the kexec flag should be indicating the action,
>>> the mem/cpu hotplug, but not relating to any detail. Imagine later
>>> another segment need be skipped on one ARCH again, then another flag
>>> need be added, this sounds not reasonable.
>> I strongly agree with you. The KEXEC_CRASH_HOTPLUG_UPDATE kexec flag
>> should be sufficient to inform the kernel that the kexec tool has been
>> updated
>> to support CPU/Memory hotplug for the kexec_load system call. Unfortunately,
>> we cannot use the 0x00000004 kexec flags bit for KEXEC_CRASH_HOTPLUG_UPDATE
>> at the moment.
> I am fine with 0x00000008 and a new flag, it has the same effect as
> #define KEXEC_CRASH_HOTPLUG_UPDATE 0x00000004
>
> I am worried about the header file incompatiblity.

If we are OK to have KEXEC_CRASH_HOTPLUG_UPDATE 0x00000008 as new bit
to introduce CPU/Memory hotplug feature for kexec_load syscall, we will 
not have
compatibility issue.

Let me write next version for this patch with KEXEC_CRASH_HOTPLUG_UPDATE 
0x00000008
as new flag bit and show how it will be handled. I will also share kexec 
code for clarity.

Thanks,
Sourabh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
