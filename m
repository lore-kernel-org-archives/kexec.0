Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6C3C48BF6
	for <kexec@archiver.kernel.org>; Thu, 29 Feb 2024 08:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hHS1ZX60LteloPIGsQ5cZE39Y8dkH4BMqjSnhP5DWVs=; b=aKLAusyQZSxqyC
	lfADubUCDPN0rfFi2WVLki9CvwC0io/9D9/qn3txk2ae0ETkkXM+ZFizvntROp2+05f1VfATlZx3X
	MnyuHdsYkLZpne/CyTukU2u3kCztShtWLhpFM3ZChJYeJO4ael12W7NK0A77Gh/LuR7lBmBLSxn30
	RIKVWhlcRUNrV/IINsDO0bgS+tT0SKYXQoyW+gFcsCj2sgBir/KxDMF900JyeeGpV6oZumJGTz+t4
	9mhhxMNBcKJh1rlyQ2lpaeBtAhMUhqHjAeYdIOSXJp1flO2EzrA1k2DYuQKsNcAMWLz/JaZqOYHPY
	L07UBndryWP+NpS1oOIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbdf-0000000CcWU-2T3t;
	Thu, 29 Feb 2024 08:19:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfbdd-0000000CcW5-0cbj
	for kexec@lists.infradead.org;
	Thu, 29 Feb 2024 08:19:34 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T827nF014174;
	Thu, 29 Feb 2024 08:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ElgC3hdscpC8Q6xDACh7uLB0Blr3VI0u7yKwmhTRX/g=;
 b=eKqqNXou6j6F5yb07zs+OIQtmF68VZILUK9N3ePpXFOSZLpSAPc/pvYKmeTSp1PNryqL
 wWwznhI7TDUm/AN/3e1wwl0SDB6MCvSMzxqr+ElKAISUFXKFRhXeqbjJZC66pmN70GQh
 QJkudMwlGDvEXq5SIH2N+S/9nifBdQrxR/ncHO0t7ePdrxFW0BtvI+ode6PLYn6b2Ges
 mLq9bsAhm6/uXLn2uU9JuUSbhUxfNy29oHsXS8OBKbUiHS1w+3stwlHn50eeAaJbD/dx
 O14c8EeL6HiJt7NS/HPt7eMTlqdTSq5ED7QdFWTE/zJdHywV0L+mq5F7erdGHoVjoaYU Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjp2crh5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:19:14 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T82INs014816;
	Thu, 29 Feb 2024 08:19:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjp2crgw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:19:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T83RhS021762;
	Thu, 29 Feb 2024 08:17:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu60c3mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 08:17:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41T8H1Pj34734360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 08:17:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14C02004E;
	Thu, 29 Feb 2024 08:17:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E3D2004B;
	Thu, 29 Feb 2024 08:16:54 +0000 (GMT)
Received: from [9.43.0.70] (unknown [9.43.0.70])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 08:16:53 +0000 (GMT)
Message-ID: <e68df310-6691-45c0-8264-ba36b9e71133@linux.ibm.com>
Date: Thu, 29 Feb 2024 13:46:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 3/6] powerpc/kexec: move *_memory_ranges functions to
 ranges.c
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
 <20240226084118.16310-4-sourabhjain@linux.ibm.com>
 <ZeA8Fl7xVHly4Ma+@MiWiFi-R3L-srv>
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZeA8Fl7xVHly4Ma+@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dn9SrOfzZfMe_dwJDfGA2Vm5LjmBgprJ
X-Proofpoint-GUID: DHp_b4dc7wWj4SDOfSLoxsWL3680WPQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=629 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_001933_202003_D909535D 
X-CRM114-Status: GOOD (  16.24  )
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



On 29/02/24 13:41, Baoquan He wrote:
> On 02/26/24 at 02:11pm, Sourabh Jain wrote:
>> Move the following functions form kexec/{file_load_64.c => ranges.c} and
>> make them public so that components other KEXEC_FILE can also use these
>                                             ^
>                                            'than' missed?

Yes, I will update it.

Thanks,
Sourabh Jain

>> functions.
>> 1. get_exclude_memory_ranges
>> 2. get_reserved_memory_ranges
>> 3. get_crash_memory_ranges
>> 4. get_usable_memory_ranges
>>
>> Later in the series get_crash_memory_ranges function is utilized for
>> in-kernel updates to kdump image during CPU/Memory hotplug or
>> online/offline events for both kexec_load and kexec_file_load syscalls.
>>
>> Since the above functions are moved to ranges.c, some of the helper
>> functions in ranges.c are no longer required to be public. Mark them as
>> static and removed them from kexec_ranges.h header file.
>>
>> Finally, remove the CONFIG_KEXEC_FILE build dependency for range.c
>> because it is required for other config, such as CONFIG_CRASH_DUMP.
>>
>> No functional changes are intended.
> ......snip
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
