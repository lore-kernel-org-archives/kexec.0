Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D42E77197
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 04:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b2mjqvTGempTon9Ywa1jbwZqI26Px4SPJHG2UyEKJDU=; b=oyS0lfMcHNsjIw42V2KhQguw9a
	bzRXwTPVXoGKGw1+bY6AhDCDMc+XzwVtHuOwh96tttr6TwpqMCrGVUNPnunGX0N5fvqdwwYbTrQKO
	mPDY85bE/flW2KuZTamq6xC/DLWHxFa1/6TZUZ/CFQArcIgowVVSI0Rb15rIEImBsanTiFlXX4cyc
	eUUrLxq2F8jcre+05rHTeZmIPfZy4PkZqLFA6M5NkauoFnompQnoSHJa4Z8Illt7a9NDhOxVdUmDr
	/sTkRNwGaTqdtmamxqr6jwe3cOUqJYvmRqhr30fYJhgMedYjH7bbYQdhXfBj58gaCKVlpzrjgo/wk
	3yQ493oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjuN-0000000AgeW-0i3c;
	Thu, 09 Jan 2025 04:12:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVjuK-0000000Age3-0h6Z
	for kexec@lists.infradead.org;
	Thu, 09 Jan 2025 04:12:33 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093r3Qi006598;
	Thu, 9 Jan 2025 04:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b2mjqv
	TGempTon9Ywa1jbwZqI26Px4SPJHG2UyEKJDU=; b=AbCf7KV9MtHn9ZFW9MK/FL
	oCHMyrup5GM2mvCK8iJvPXaYrdKlKGHOuRTAUc3BtaD/JX0SyQXHqxpwS+J1fNAE
	N/1TFTuR74wc8CBaUZiQK3Zvxr1kH/QoAEE7mErsiSTR2lmvQxGQZZWg5KAJbnjq
	chF3vsMTwFZClVQQ4hNe6gPs1Gd10xCUjUb3O8v8zRXVbiCBrHPFOUKN9nc3CqhI
	DYvHGUWMeoxHQpXOg3s5gvuaWhqHEUxYzG+9COLkQ8ZHN32c2yiXK5fLpeYCvCOE
	z8bdHZOU99PrBJYzx34rPq6cKxktBvvlbGU3MCiT9Xbf43gUg1Su+xInf2sAlEFA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc82dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 04:12:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50910t6s013698;
	Thu, 9 Jan 2025 04:12:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap39ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 04:12:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5094CJYv18678034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 04:12:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5827E20049;
	Thu,  9 Jan 2025 04:12:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46A4420040;
	Thu,  9 Jan 2025 04:12:16 +0000 (GMT)
Received: from [9.43.18.121] (unknown [9.43.18.121])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 04:12:15 +0000 (GMT)
Message-ID: <ea2d2f5d-5410-4f7e-a3f5-258c432e9be9@linux.ibm.com>
Date: Thu, 9 Jan 2025 09:42:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: Initialize ELF lowest address to ULONG_MAX
To: Baoquan he <bhe@redhat.com>, ebiederm@xmission.com
Cc: Hari Bathini <hbathini@linux.ibm.com>, akpm@linux-foundation.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20241210091314.185785-1-sourabhjain@linux.ibm.com>
 <Z1pQoh7IwtERIWe5@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Z1pQoh7IwtERIWe5@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BBvxfhqmZn0KHJqDL_jyalZewOdicwfn
X-Proofpoint-ORIG-GUID: BBvxfhqmZn0KHJqDL_jyalZewOdicwfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_201232_216133_3AC76DCC 
X-CRM114-Status: GOOD (  18.21  )
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

Hello Baoquan and Eric,


On 12/12/24 08:25, Baoquan he wrote:
> On 12/10/24 at 02:43pm, Sourabh Jain wrote:
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
>> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: kexec@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kernel/kexec_elf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
>> index d3689632e8b9..3a5c25b2adc9 100644
>> --- a/kernel/kexec_elf.c
>> +++ b/kernel/kexec_elf.c
>> @@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>>   			 struct kexec_buf *kbuf,
>>   			 unsigned long *lowest_load_addr)
>>   {
>> -	unsigned long lowest_addr = UINT_MAX;
>> +	unsigned long lowest_addr = ULONG_MAX;
> Great catch.
>
> Acked-by: Baoquan He <bhe@redhat.com>
Thank you for the Ack! The upcoming two patch series, which aim to 
enable generic crashkernel reservation, depends on this fix. One of them 
is already posted for upstream review: 
https://lore.kernel.org/all/20250108101458.406806-1-sourabhjain@linux.ibm.com/ 
I was wondering if you could guide us on how to get this fix pushed to 
the mainline tree.

Thanks,
Sourabh Jain

