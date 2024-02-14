Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15497C48BC3
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WiE+R08UiwOvZepHQzk2TRD9OEHLvLhAeUFBMeNPdl4=; b=S/x+oG/Sbk1ENt
	eRvo476CYT8aBDtpdVONwOOu/oYz6YiRjJQXDRwtUO11TrDfKSmjMpy0d6kC5oOGpN8z3DCMmYCJq
	R1oOF90y+IH0Fvg393mcM3MtQJvKl1sQKhnClzphWhNJtZql1lIXkecNhjE59KMZ18ggi4uco15bI
	z8mCR9bJu9VIktrXTPd7t7wTQyohmlSIHpqtQSG8YseG76OGKUVZENxyky0L+ICXwYMgQd+uqjY2D
	/UzAxFBmmYBKVO2wKd40k++nVySRTkYrDLULJP/TYD0jG+OQn/AIXJpWVEu5rzDkWF8c1dm+m4nZy
	DXQDq2L/WIfJUyKAwviA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raFSf-0000000D2iO-0NHu;
	Wed, 14 Feb 2024 13:38:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raFSb-0000000D2hT-301u
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 13:38:02 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ECTscS005701;
	Wed, 14 Feb 2024 13:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=66aKMC+DKM0cDMfo8TE1gVlZfE/wkFZWk8GOx8oR3LQ=;
 b=dBs/97Al7bYKDsf4c/jeuozQgJW+tv3PAouoEUIKVcl8yAxB9MhehT4bRgl5xxITnACS
 qtP8ROINuup8EhGhXu5vJxH2lY6iDUUo45DcoVg5Yo8ypB3q5QXVXExRQDrRoH0vov5S
 HSa3vfSgwWzpMEoyCwPmtANoVGnptPzu4rF1XFvxLNNdfM3558k8iLMeo1mspxPHZ3C0
 6G0KWrJBBwCBp7jSvXaKDQ7yE5vFz+V60MBcM4eDdUKdAHQ4/Li47gf6WMBXI15J5QpQ
 8+Pwzxpt/XRKLUGmcQPyni8z2pwwew14CVDPIjScuajojlyAygMx6JJk451WBrJkHlk1 QA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8rmvs1su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:37:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41ECUKii009479;
	Wed, 14 Feb 2024 13:37:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8rmvs0va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:37:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EC4CU8009741;
	Wed, 14 Feb 2024 13:36:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62wnbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:36:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EDa9hf20906508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 13:36:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46E032004E;
	Wed, 14 Feb 2024 13:36:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDAA120040;
	Wed, 14 Feb 2024 13:35:57 +0000 (GMT)
Received: from [9.61.185.188] (unknown [9.61.185.188])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 13:35:57 +0000 (GMT)
Message-ID: <7c5f8e9a-b6d4-4ebf-9bed-4b9bddb62e25@linux.ibm.com>
Date: Wed, 14 Feb 2024 19:05:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/5] crash: add a new kexec flag for hotplug support
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
References: <20240111105138.251366-1-sourabhjain@linux.ibm.com>
 <20240111105138.251366-3-sourabhjain@linux.ibm.com>
 <ZcBRle7szFrD3cW+@MiWiFi-R3L-srv>
 <cc02538f-9460-4cbb-9ae4-194412b85e36@linux.ibm.com>
 <ZcrgHvTbDGbXc894@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZcrgHvTbDGbXc894@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D6o2onbtUPBmy6b7s_IQOnwLYwQ0Qxpy
X-Proofpoint-ORIG-GUID: dINt9bOkjK9Eq45Z-IOHHG6wDs3eYOmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=610 bulkscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_053801_882859_825F388F 
X-CRM114-Status: GOOD (  26.32  )
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



On 13/02/24 08:51, Baoquan He wrote:
> On 02/12/24 at 07:27pm, Sourabh Jain wrote:
>> Hello Baoquan,
>>
>> On 05/02/24 08:40, Baoquan He wrote:
>>> Hi Sourabh,
>>>
> ......
>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>> index 802052d9c64b..7880d74dc5c4 100644
>>>> --- a/include/linux/kexec.h
>>>> +++ b/include/linux/kexec.h
>>>> @@ -317,8 +317,8 @@ struct kimage {
>>>>    	/* If set, we are using file mode kexec syscall */
>>>>    	unsigned int file_mode:1;
>>>>    #ifdef CONFIG_CRASH_HOTPLUG
>>>> -	/* If set, allow changes to elfcorehdr of kexec_load'd image */
>>>> -	unsigned int update_elfcorehdr:1;
>>>> +	/* If set, allow changes to kexec segments of kexec_load'd image */
>>> The code comment doesn't reflect the usage of the flag.
>> I should have updated the comment to indicate that this flag is for both
>> system calls.
>> More comments below.
>>
>>> You set it too
>>> when it's kexec_file_load. Speaking of this, I do wonder why you need
>>> set it too for kexec_file_load,
>> If we do this one can just access image->hotplug_support to find hotplug
>> support for currently loaded kdump image without bothering about which
>> system call was used to load the kdump image.
>>
>>> and why we have
>>> arch_crash_hotplug_support(), then crash_check_hotplug_support() both of
>>> which have the same effect.
>> arch_crash_hotplug_support(): This function processes the kexec flags and
>> finds the
>> hotplug support for the kdump image. Based on the return value of this
>> function,
>> the image->hotplug_support attribute is set.
>>
>> Now, once the kdump image is loaded, we no longer have access to the kexec
>> flags.
>> Therefore, crash_check_hotplug_support simply returns the value of
>> image->hotplug_support
>> when user space accesses the following sysfs files:
>> /sys/devices/system/[cpu|memory]/crash_hotplug.
>>
>> To keep things simple, I have introduced two functions: One function
>> processes the kexec flags
>> and determines the hotplug support for the image being loaded. And other
>> function simply
>> accesses image->hotplug_support and advertises CPU/Memory hotplug support to
>> userspace.
>  From the function name and their functionality, they seems to be
> duplicated, even though it's different from the internal detail. This
> could bring a little confusion to code understanding. It's fine, we can
> refactor them if needed in the future. So let's keep it as the patch is.
> Thanks.
Ok sure.

- Sourabh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
