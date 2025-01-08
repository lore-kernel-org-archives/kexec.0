Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88334E77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MmS4DYQwur7WJQ24jzp44KxvRMWZaKri3Od2Jv/tigk=; b=Mye/e6f+Xvb7u5fCLKsM0dlSjA
	F/mBjyUm8Y9UHTBv5idaubY2sReHETNdSZ/d3u1364+nPnKRmEvdHP2BKOGKUln1HiMA5PiootV6a
	k7DuvkNXj69xWJ44Szx4BergILZJbR9it5foO2YmG/Mv/UYZ8DYew0r/88kHrrWMgvdKl/l2Byp4R
	/jcDMUrb4Arq22GhBxHLfx3oKEMAw9i/c9gnuJda3GK75T6KzV5OaFENgyPGqq83PWD2Fg1v1vmYc
	MPQBUd+URz8B17BMQOW/Re/wl0l9kk2Qrq3/SLAX6U21VoxYVVbGwBZxvFaeX+yjqWC8xU7uaJfc3
	Gdarx2lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVVY0-00000008VQt-2jfP;
	Wed, 08 Jan 2025 12:52:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUle-00000008LMg-43GR
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 12:02:36 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5083r5IL006929;
	Wed, 8 Jan 2025 12:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MmS4DY
	Qwur7WJQ24jzp44KxvRMWZaKri3Od2Jv/tigk=; b=VoqZT8Tj0d8alM6xU2cNKQ
	6+Gxe/JmeFgyneKS0QlqjLxBNXAwKRZ5zSz8NUTMyaC73b9vv9tk0ewynE23MjNZ
	y3jBpMaDz6A7OPv5FJR8mQj3+Jo0sx5EAtMGq97vW5u5jAUCC7zXxzsU4/+2MYlv
	aYJ28Fqd0HvQaop6cjxWgZo17VedG0koq+1HDvWeVNwwHsoxvst0krqCjvk+If4W
	huu5ytsye8aO7qmxP7PjzUceA41d8KfuG9t4O/jJRxZdmNrHX4ZqgSmgSHig4VzL
	GrN675+xw83dfhExgd612O8gPeLDBrvGjZ8PCfgKGnUtixCeL1pto2D9/Wp115QQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupt2jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:02:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508A2Bfv027997;
	Wed, 8 Jan 2025 12:02:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk7c0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 12:02:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508C2MCH50594104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 12:02:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78F2F20049;
	Wed,  8 Jan 2025 12:02:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A6B2004D;
	Wed,  8 Jan 2025 12:02:20 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 12:02:20 +0000 (GMT)
Message-ID: <622d9d6d-3dfc-4bdb-b251-4abf9299fc6a@linux.ibm.com>
Date: Wed, 8 Jan 2025 17:32:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1 2/5] crash: let arch decide crash memory export
 to iomem_resource
To: Baoquan he <bhe@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-3-sourabhjain@linux.ibm.com>
 <Z35gnO2N/LFt1E7E@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Z35gnO2N/LFt1E7E@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FDF-htNt5foZo1yPQ6u0KJVXvE4WVYwE
X-Proofpoint-GUID: FDF-htNt5foZo1yPQ6u0KJVXvE4WVYwE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=653
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_040235_013707_9FC451DB 
X-CRM114-Status: GOOD (  19.29  )
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

Hello Baoquan

On 08/01/25 16:55, Baoquan he wrote:
> Hi,
>
> On 01/08/25 at 03:44pm, Sourabh Jain wrote:
>> insert_crashkernel_resources() adds crash memory to iomem_resource if
>> generic crashkernel reservation is enabled on an architecture.
>>
>> On PowerPC, system RAM is added to iomem_resource. See commit
>> c40dd2f766440 ("powerpc: Add System RAM to /proc/iomem").
>>
>> Enabling generic crashkernel reservation on PowerPC leads to a conflict
>> when system RAM is added to iomem_resource because a part of the system
>> RAM, the crashkernel memory, has already been added to iomem_resource.
>>
>> The next commit in the series "powerpc/crash: use generic crashkernel
>> reservation" enables generic crashkernel reservation on PowerPC. If the
>> crashkernel is added to iomem_resource, the kernel fails to add
>> system RAM to /proc/iomem and prints the following traces:
>>
>> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc2+
>> snip...
>> NIP [c000000002016b3c] add_system_ram_resources+0xf0/0x15c
>> LR [c000000002016b34] add_system_ram_resources+0xe8/0x15c
>> Call Trace:
>> [c00000000484bbc0] [c000000002016b34] add_system_ram_resources+0xe8/0x15c
>> [c00000000484bc20] [c000000000010a4c] do_one_initcall+0x7c/0x39c
>> [c00000000484bd00] [c000000002005418] do_initcalls+0x144/0x18c
>> [c00000000484bd90] [c000000002005714] kernel_init_freeable+0x21c/0x290
>> [c00000000484bdf0] [c0000000000110f4] kernel_init+0x2c/0x1b8
>> [c00000000484be50] [c00000000000dd3c] ret_from_kernel_user_thread+0x14/0x1c
>>
>> To avoid this, an architecture hook is added in
>> insert_crashkernel_resources(), allowing the architecture to decide
>> whether crashkernel memory should be added to iomem_resource.
> Have you tried defining HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY in ppc to
> add crashkernel region to iomem early?


I didn’t try, but I think even if I do, the kernel will run into the 
same issue
because as soon as crashkernel is added to iomem, there will be a resource
conflict when the PowerPC code tries to add system RAM to iomem. Which
happens during subsys_initcall.

Regardless, I will give it a try.

> Now there are two branches in the
> existing code, adding a hook will make three ways.

I agree. I can try updating powerpc code to not consider crashkernel 
memory as
iomem conflict.

Thanks for the review.

- Sourabh Jain

