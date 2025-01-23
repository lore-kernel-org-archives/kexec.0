Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE6DC0218B
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 11:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TYHzT7PsfyUri1Pj5o7+pR3jEob9Vl2tdXjNuTZzJaE=; b=VGakAKEkKuPO8MZU06DQijiXvR
	CTerB2H7zeZWoWZpuc7GQyaOcJ1GIp4OknSZgv58verd+gbJXO28zp2YAoxUPwyXBEzKIIYvPjnqg
	TYuKxU/jTwc5I2XI1j4FkyA8JuIqoYtYBzX171tPIcZSjFGtFStjYVwfumygW628AYyt5kdtdhXKx
	QFpKTCd2Zikn/5hB8kAXcLsPfm1HxssvQR2HflUV8v4se1nnRhl0q6VQIJfmHSuAaARCQiYq2LpYa
	0XiRD6c7mWrJ77whIucr9U50BnlHbRXqZDzOkW61+zLoETJwsfejkbkQOMf61WEzNw6evRaKWD5TM
	gQvAPH4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tavKO-0000000CJpB-1VZr;
	Thu, 23 Jan 2025 11:24:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tavIo-0000000CJZF-3KAF
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 11:23:15 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N5NoBr026361;
	Thu, 23 Jan 2025 11:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TYHzT7
	PsfyUri1Pj5o7+pR3jEob9Vl2tdXjNuTZzJaE=; b=NhZ7/ugnVmpJ0M9krwXvho
	kpKhOABczxzbG7ZZP2x2IlfoCC1cT2oZhwADeHiDqzs+tj0pbiMkKkO5IdQG/555
	6hMUt254PYlZ5Twoj3jD3RSJmOQXEvR+emh51OVlG5wl9i105OE0ov3VT8AxQYqw
	2mHMZdrLRhUtEJcS/gkJJdBx0mIR/B423xP7VomWaSbl3OxXJhCZxWnHmijlmYCz
	gTyifA3RfhNSEir6keRWzuml4F7wGEWseB75VObPLX0EDW1XMf7YeuRH65yGv94n
	4UOh5hvsA2g8vWxeFbIUOcbKp9SNDvqW3nsKjBsrVicWRok5jbkgZayqIk1zIgLQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7skgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 11:23:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N8xHlx021074;
	Thu, 23 Jan 2025 11:23:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1mw32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 11:23:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NBN46964946494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 11:23:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F9020049;
	Thu, 23 Jan 2025 11:23:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E812120040;
	Thu, 23 Jan 2025 11:23:01 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 11:23:01 +0000 (GMT)
Message-ID: <ed578d5e-c2ec-46b8-90fa-7e4f9b727685@linux.ibm.com>
Date: Thu, 23 Jan 2025 16:53:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] kexec: Initialize ELF lowest address to ULONG_MAX
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
 <20250121115442.1278458-2-sourabhjain@linux.ibm.com>
 <7cfe94c9-4ca5-48b1-ab53-bc08fcf8fbc0@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7cfe94c9-4ca5-48b1-ab53-bc08fcf8fbc0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bHomo7JeB_Q0vOgJKpGHSVDIlTTskGB-
X-Proofpoint-ORIG-GUID: bHomo7JeB_Q0vOgJKpGHSVDIlTTskGB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_032314_833793_16454710 
X-CRM114-Status: GOOD (  16.88  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello Hari,


On 23/01/25 15:34, Hari Bathini wrote:
>
>
> On 21/01/25 5:24 pm, Sourabh Jain wrote:
>> kexec_elf_load() loads an ELF executable and sets the address of the
>> lowest PT_LOAD section to the address held by the lowest_load_addr
>> function argument.
>>
>> To determine the lowest PT_LOAD address, a local variable lowest_addr
>> (type unsigned long) is initialized to UINT_MAX. After loading each
>> PT_LOAD, its address is compared to lowest_addr. If a loaded PT_LOAD
>> address is lower, lowest_addr is updated. However, setting lowest_addr
>> to UINT_MAX won't work when the kernel image is loaded above 4G, as the
>> returned lowest PT_LOAD address would be invalid. This is resolved by
>> initializing lowest_addr to ULONG_MAX instead.
>>
>> This issue was discovered while implementing crashkernel high/low
>> reservation on the PowerPC architecture.
>>
>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>


Thanks for the Ack!

- Sourabh Jain


>
>> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: kexec@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Baoquan He <bhe@redhat.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kernel/kexec_elf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
>> index d3689632e8b9..3a5c25b2adc9 100644
>> --- a/kernel/kexec_elf.c
>> +++ b/kernel/kexec_elf.c
>> @@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct 
>> elfhdr *ehdr,
>>                struct kexec_buf *kbuf,
>>                unsigned long *lowest_load_addr)
>>   {
>> -    unsigned long lowest_addr = UINT_MAX;
>> +    unsigned long lowest_addr = ULONG_MAX;
>>       int ret;
>>       size_t i;
>


