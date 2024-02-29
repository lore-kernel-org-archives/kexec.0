Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8ABDC54798
	for <kexec@archiver.kernel.org>; Thu, 29 Feb 2024 08:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EMJzpLrsAyln14dnmpXjiG9X4tlR5fUSgkz0WtTPbw=; b=MoBkYMwInom5oW
	2YWBZowAuO5kbPnjju6HvCgQ3EgKCztW1KuZM1Fm+dz9QMANvLwjvDXCALCEWAkF08tL/GY10gCDT
	fJp1/9FWeGcPQa4ogdJpzbWnoFIsWP3RYAMDunFvrAZ10vyujdSlIVTAahNYRd0ZGOglbbrcVDZqJ
	4wjb3rUzmL4cbdwYUgmssCAXNoVtE1p8HQpUtvSSzPCpwpVXAnjBk8q2urCAKCUdCGKTxhJzVnAK9
	cfqAdqWEPKLMYorA2OZRJvN/NzO11bNza7dEXt3hB0uQ0O5t+O//qXU52RawBQB51uCRa8LQiDHg9
	NMD002jiEeqwLeKUiu7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbZe-0000000Cby0-3pdy;
	Thu, 29 Feb 2024 08:15:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbZV-0000000Cbtg-1vKT
	for kexec@lists.infradead.org;
	Thu, 29 Feb 2024 08:15:19 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T87kex012725;
	Thu, 29 Feb 2024 08:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=V69A0Qbk5ZIw/6Hpp/ftusIs/MD8/fIBFIUbplK98zc=;
 b=Rds77jYO2AA7Uv6IRch9AvxzsNibS0wZ0mUaGIMSKWPnm+Pd1K4Bwot+1dLbmu/k99OW
 5iSw7DaGev2Kl+ZgPMXrh+vqC8M725HGTty12SMA6WEf4qCoEiAc+xLyau0D9wLsbTuR
 jEC9J8wsqajBxH6T9za6TQmYIaPXAQc3HhWCNC39j48ZApiEtPumRBpr9eEVn2r8E77T
 9XIjkoWDUxuhD9H2dSA73uKmtwmAOac0q+NbtLxz/IYvARV2HcObV2fDFcR5GtGB4LEG
 hmQjfJateHhl5gKF+Pyv9RztRiviixSIQYe2HJmMl6bRovkN7y/k2bE6NLedhthT0ZKW hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjp4t05nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:14:52 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T88EQx015554;
	Thu, 29 Feb 2024 08:14:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjp4t05mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:14:51 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T7kkMP008798;
	Thu, 29 Feb 2024 08:14:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wftstv809-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:14:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41T8EiU043647446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 08:14:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D075220040;
	Thu, 29 Feb 2024 08:14:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 755412004F;
	Thu, 29 Feb 2024 08:14:36 +0000 (GMT)
Received: from [9.43.0.70] (unknown [9.43.0.70])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 08:14:36 +0000 (GMT)
Message-ID: <2a284d3b-87b2-4109-8867-ddef1dc40275@linux.ibm.com>
Date: Thu, 29 Feb 2024 13:44:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/6] crash: add a new kexec flag for hotplug support
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
References: <20240226084118.16310-1-sourabhjain@linux.ibm.com>
 <20240226084118.16310-3-sourabhjain@linux.ibm.com>
 <ZeAyKj5b2HN90ija@MiWiFi-R3L-srv>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZeAyKj5b2HN90ija@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZFsWgXxnJdscoz9M_2M1-uoyo9ziF1ET
X-Proofpoint-ORIG-GUID: gELmKE8JCKESn-8MgR-b556sEXtsKxM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_001517_543569_2ED6E77E 
X-CRM114-Status: GOOD (  19.50  )
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

On 29/02/24 12:58, Baoquan He wrote:
> On 02/26/24 at 02:11pm, Sourabh Jain wrote:
> ......snip...
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 70fa8111a9d6..630c4fd7ea39 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -496,7 +496,7 @@ static DEFINE_MUTEX(__crash_hotplug_lock);
>>    * It reflects the kernel's ability/permission to update the crash
>>    * elfcorehdr directly.
>       ~~~~~~~~~ this should be updated too.

Yes, it should.

Thanks,
Sourabh
>
>>    */
>> -int crash_check_update_elfcorehdr(void)
>> +int crash_check_hotplug_support(void)
>>   {
>>   	int rc = 0;
>>   
>> @@ -508,10 +508,7 @@ int crash_check_update_elfcorehdr(void)
>>   		return 0;
>>   	}
>>   	if (kexec_crash_image) {
>> -		if (kexec_crash_image->file_mode)
>> -			rc = 1;
>> -		else
>> -			rc = kexec_crash_image->update_elfcorehdr;
>> +		rc = kexec_crash_image->hotplug_support;
>>   	}
>>   	/* Release lock now that update complete */
>>   	kexec_unlock();
>> @@ -552,8 +549,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>>   
>>   	image = kexec_crash_image;
>>   
>> -	/* Check that updating elfcorehdr is permitted */
>> -	if (!(image->file_mode || image->update_elfcorehdr))
>> +	/* Check that kexec segments update is permitted */
>> +	if (!image->hotplug_support)
>>   		goto out;
>>   
>>   	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index bab542fc1463..a6b3f96bb50c 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -135,8 +135,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   		image->preserve_context = 1;
>>   
>>   #ifdef CONFIG_CRASH_HOTPLUG
>> -	if (flags & KEXEC_UPDATE_ELFCOREHDR)
>> -		image->update_elfcorehdr = 1;
>> +	if ((flags & KEXEC_ON_CRASH) && arch_crash_hotplug_support(image, flags))
>> +		image->hotplug_support = 1;
>>   #endif
>>   
>>   	ret = machine_kexec_prepare(image);
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 2d1db05fbf04..3d64290d24c9 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -376,6 +376,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>   	if (ret)
>>   		goto out;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	if ((flags & KEXEC_FILE_ON_CRASH) && arch_crash_hotplug_support(image, flags))
>> +		image->hotplug_support = 1;
>> +#endif
>> +
>>   	ret = machine_kexec_prepare(image);
>>   	if (ret)
>>   		goto out;
> Other than the tiny part, the overall looks good to me.
>
> Acked-by: Baoquan He <bhe@redhat.com>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
