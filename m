Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5248BC5AC80
	for <kexec@archiver.kernel.org>; Sun,  9 Aug 2026 12:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aLspriiK+hAu6Lf/eulXaxhGyFP0ajwhKIXlrZZsNuE=; b=dqHUVmAJbrUKuK5YX432TGuu2/
	6v9P8tlj8B4hBO7tmTncK5kQvafjdRJ0Q55+qkad6Tx5+oHIYR4pgas9TNQwlyTy3ouXQhDRqxEZS
	O8XzMyjvmb2mkP+WlSSQ8/LL+Fw4GKeQdO+i5vPkwvl1eGfXmsokiNt4nEcXvCVv6/t/TNW1/dSof
	adwFSO+FT7S17XOcROZi1Hjk567zn1tjwRX/ICYLHWASBVs1tT8XFR04gc5WdL+CAP0oV1t5Zcp5/
	Q2WD5UBYueDndtKD5N8jagQJGk7b0MvS6rt7HkHIjMUEXCli0rtZnSw5iE7bzcghgCbKTbIAymC9N
	qc32mtVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt2bk-0000000AHxU-1mYG;
	Sun, 09 Aug 2026 12:26:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt2bh-0000000AHwz-28yk
	for kexec@lists.infradead.org;
	Sun, 09 Aug 2026 12:26:26 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C2VNj2821535;
	Sun, 9 Aug 2026 12:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aLspri
	iK+hAu6Lf/eulXaxhGyFP0ajwhKIXlrZZsNuE=; b=FLU1ThvBlmwV/6Gihjw05U
	RHNRzNN9HPGIR6zmHMqUxVr/LLas0DeRe9HjNrxrKZJIucxWB3Uk+SWtMg77avRL
	XSEwOkD3uZk4bqLO6yxIbk7uWJXFaf7nHMin77PbEa4XfyNvjEzhizmirBdxiP0g
	bpKEjKofOcdChd5xmSH1l6sdaXBTgbuPzYQ3BjQEB/aUN5MqnV8k0Zh7+8mRGZLr
	FZVdceN+62caoCmMKvepaqu88laocA/g11sM4gOu8vK1oaeTZA+Exrqsz+hUSsnP
	stzI2wPn40rj2BW2ol2ANSDnj8WJv2euWI8TjaPA4eSFFb1S6vzor87prdUztmxg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2kvya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 12:26:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679CQII7028026;
	Sun, 9 Aug 2026 12:26:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vscn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 12:26:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679CQG8B15598050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 12:26:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88FBD20043;
	Sun,  9 Aug 2026 12:26:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD4B20040;
	Sun,  9 Aug 2026 12:26:13 +0000 (GMT)
Received: from [9.39.25.10] (unknown [9.39.25.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 12:26:13 +0000 (GMT)
Message-ID: <1af9064e-39cd-4701-b50d-3ee44fd87245@linux.ibm.com>
Date: Sun, 9 Aug 2026 17:56:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] crash_dump: Read the number of dm-crypt keys
 from reserved memory
To: Coiby Xu <coiby.xu@gmail.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>,
        Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-5-coiby.xu@gmail.com>
 <cf03f9c1-5970-4d65-9c4f-6b4fb12ccecf@linux.ibm.com> <anQkT6jwznGfzs1R@Rk>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <anQkT6jwznGfzs1R@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7871eb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=yiBT5GQwkFn-ZPne8XYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DeWCih4nW_pkUgN9YHLh5CCY07zj90QZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDEwNiBTYWx0ZWRfX74u9biO4RQZZ
 vnOoRcnWzmkWh25B7ZCYFCo5DL01zLpi2mVRXEtLuWkdX+0xEw6cbhxBhCczzBI8CEaXXvfebWC
 Ogyee667KZ5tD7+XEBNuEFT4F/xKxXOC2+qjIYeZWsMPgUYy4c5RwSmDagcrvHYLCz5buiFRXyS
 r4CkVbRV05aPilUdarRSMBc+d+PjKX5X4U736Dzqe4x6H+pAZI9mrPL+aQAm/Blnevp6vvWkZWg
 SCkLg+Tcpr6daNVVyzqBio3VCMFtav08/zLn7P5XBSkur2IXOVFzH+qs9L6/DIeB5PLGXXHPkLv
 OQOj6gHm84CABpjuNDLxwHfeVw8IzJPC2ChBB7M4+VsCnPeiSWjb+L7FqHgGC7FKPj4qhBBtR9D
 YUvOoWtOuYZnCzNNKi/favojwhHyzzVpV1zzmN5ves61t05s46v5SutoCbl1zpkZQej8OO2rkNE
 n36L0hpN2m/06QJkkUg==
X-Proofpoint-ORIG-GUID: nYCqTAB5s7RgRBTtBcmoHEDm4w3dklUI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDEwNiBTYWx0ZWRfX6ZrX985EuG6o
 4DyN05sJ1hfFTCoGndnbrZ5Hs5ChtGVhaLqP0OWzYbX3tEzcWssjwMWw6QTznXTL4KopMgfKAGz
 hPm6GVvABgkPgl4GuuPjWETmYE7fUoM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_052625_692405_3A003BFE 
X-CRM114-Status: GOOD (  27.56  )
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



On 06/08/26 11:50, Coiby Xu wrote:
> On Wed, Aug 05, 2026 at 04:35:50PM +0530, Sourabh Jain wrote:
>> Hi Coiby,
>
> Hi Sourabh,
>
>>
>> On 29/07/26 09:06, Coiby Xu wrote:
>>> In case user adds/deletes the keys by mistake, it's safer to read the
>>> number of keys from reserved memory.
>>
>> I am not sure how we differentiate between a key being deleted 
>> accidentally and a user
>> intentionally deleting it. However, I have a question about how the 
>> kernel handles key
>> addition and removal.
>>
>> How does the kernel handle key add/remove operations to keep the 
>> kexec segment
>> corresponding to the key header up to date?
>>
>> The reason I am asking is to understand what happens when a user 
>> deletes a key. Does the
>> kexec segment corresponding to that key header still retain 
>> information about the deleted key?
>>
>> If it does, could you explain why? If it does not, could you explain 
>> how the kexec segment gets updated?
>
> Thanks for the questions! When a user delete a key by removing a
> configfs item, the kexec segment still retain information about the
> deleted key. The kexec segment will only be updated when the user tries
> to reload the kdump kernel. Because I think introducing a sync 
> mechanism to
> automatically update the kexec segment when there is a change to
> configfs is unnecessary.

Thanks for the clarification. So, the kexec segment retains the deleted key
information until the kdump kernel is reloaded.

>>
>> Also, for my understanding, could you please point me to what exactly 
>> is stored in the key header's kexec
>> segment? During restore, kernel access the old kernel memory using 
>> the information stored in that kexec
>> segment, so I would like to better understand what data it contains.
>
> What is stored can be known from struct keys_header and dm_crypt_key,
>
> struct dm_crypt_key {
>     unsigned int key_size;
>     char key_desc[KEY_DESC_MAX_LEN];
>     u8 data[KEY_SIZE_MAX];
> };
>
> struct keys_header {
>     unsigned int total_keys;
>     struct dm_crypt_key keys[] __counted_by(total_keys);
> } *keys_header;
>
> [...] 

Thanks for the pointer I will explore this.

- Sourabh Jain


