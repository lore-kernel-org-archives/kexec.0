Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255F4C83013
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 05:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6UcbTwK4257SwHHBAuXRQcRjKDb/vf2EzrtIm5ni9jc=; b=bluvEnv+eiY+ZYo0javlxDMN4j
	jpH1RFeqsBnPKFi6MvkzNCTSIyBLpUxCrYaF4wiaTwwfv2HGAiEPP+TUJo7EjKiaggFBgcCOcQIPD
	swK2mSUJUGBv+Vpo7wDXXB42ThPf2cABjS55Tb7/J6Fv4HuLuGNTmjGpXjhFOE0OjE/xA1hNmvb31
	Eyb3HdPMrxb4ox0LZYk7T2s1gashnG6rEC2TjXcSBElrtlw5RAo0SF7cEvb+fGA4SrWGa2h7jYNBn
	kFEUztQ3b20Wz2Aou+o4fC6umcYiVm/b6So2bPbdQJ1Y8R3bPzS7cRYzw8iWUs5nYWVr25yxKedh+
	mQI0aPsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpdg-00000007EMi-3kQ0;
	Wed, 02 Jul 2025 05:04:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWpde-00000007EM1-1G28
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 05:04:07 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561MvMVX031002;
	Wed, 2 Jul 2025 05:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6UcbTw
	K4257SwHHBAuXRQcRjKDb/vf2EzrtIm5ni9jc=; b=hjFpsOy50zM5QP8jbkp7Eq
	HtwJGX2HbC7/3V/ig4fvrgNbZiXY9wZeAGf5mscsV8Uc7vgJTwp8dpJu0vD5kdpu
	tl+NSr+k8TNkE6+NlJ453O+t1sf2Spmbezdqe5+QIIwLt3TGEkovzA5luMnfbRE8
	TVqdInVCfMQIYFHJF3TtbsOiBEQe9bB0x83EIxuackxOpJULGLWd9/noj0x6pyhn
	u8qstFmJHCZV7H1et0v4OzRDKYWOl0ycM8qWLbUStuR9QIyrhhWZZfBBeJ4gqVqg
	sWxNbIdCo0uCwi79K21f3jspGd+cZDqeDKN9uKIbkjZi9St7mN0jUC5TMpvuspyA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1u673-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 05:04:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5620xwuW011802;
	Wed, 2 Jul 2025 05:04:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7mwvvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 05:04:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5625414p50069926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 05:04:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 933D320049;
	Wed,  2 Jul 2025 05:04:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8177D20040;
	Wed,  2 Jul 2025 05:04:00 +0000 (GMT)
Received: from [9.87.141.64] (unknown [9.87.141.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 05:04:00 +0000 (GMT)
Message-ID: <32246350-8a68-4d46-9103-9a633d3cfa97@linux.ibm.com>
Date: Wed, 2 Jul 2025 10:33:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?=
 <k-hagio-ab@nec.com>,
        Tao Liu <ltao@redhat.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?=
 <yamazaki-msmt@nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
References: <20250625022343.57529-2-ltao@redhat.com>
 <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
 <CAO7dBbXpkshxguPbHDA2YFZeYsDAbyswBCQ7x0UKY__4H1K2jQ@mail.gmail.com>
 <5c425f4e-4e89-4500-993e-e4dfec50a4fb@nec.com>
 <CAO7dBbXweDPUpsEDYhFZqf-eAALGrFOBJh-=bQAYMUsj2ioNpw@mail.gmail.com>
 <e78c8c33-5718-4218-89a3-ea4d7e3a6c64@nec.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <e78c8c33-5718-4218-89a3-ea4d7e3a6c64@nec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wx8EiRb9skPcWsUGvUSISXKae0OFRlC6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDAzNSBTYWx0ZWRfXxpSd1fFHEBKK IqHbz4ARrfPYX19RnrC6PDPBbrmNP6xwe3+ma3tbi5V9y+YcDhCv3PTftOej7ITQR10oHG1iQAy EMfq+7811RO5qKKdgnAKBrT+NPWICjfcO7guhA2nAJNUTm5PoL2rhI09BE0T52EIsUshQB6eEhZ
 sN3EH7EoHlcNfDZGKuCMOksWdN99ZvNidO2t1i1tIHFq+V3pZr3rXEgNPi64TmqU6YktUJpGrbH DZrWVZNQ6LO/p6V//RFMN6z7cLoxoaPfhm+htD0Dv7KOtR14dwEjO/4dtTSnl2VXS0cq6S77/Se 6mH1vAibaY44SaLl87RXtOfOtB7f3GAaNnNqCCj44XGnnK2ncazbP/O3gA2nme9oCF4bvdUR3GP
 cJADYTpNIT9SDWjjnxqtcsmIo2fXr0V5hK5nwvSOiPS1EijhFFMWVlQ0DrYRNpVWkyTdWfIP
X-Proofpoint-GUID: wx8EiRb9skPcWsUGvUSISXKae0OFRlC6
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6864bdc4 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=nrACCIEEAAAA:8 a=Ihltw4Q5nZl3D2hFa3wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_220406_464570_F9B63ACC 
X-CRM114-Status: GOOD (  26.97  )
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

Hello Kazu,

On 02/07/25 10:22, HAGIO KAZUHITO(萩尾 一仁) wrote:
> Hi Tao,
>
> On 2025/07/02 13:36, Tao Liu wrote:
>> Hi Kazu,
>>
>> On Wed, Jul 2, 2025 at 12:13 PM HAGIO KAZUHITO(萩尾　一仁)
>> <k-hagio-ab@nec.com> wrote:
>>> On 2025/07/01 16:59, Tao Liu wrote:
>>>> Hi Kazu,
>>>>
>>>> Thanks for your comments!
>>>>
>>>> On Tue, Jul 1, 2025 at 7:38 PM HAGIO KAZUHITO(萩尾　一仁) <k-hagio-ab@nec.com> wrote:
>>>>> Hi Tao,
>>>>>
>>>>> thank you for the patch.
>>>>>
>>>>> On 2025/06/25 11:23, Tao Liu wrote:
>>>>>> A vmcore corrupt issue has been noticed in powerpc arch [1]. It can be
>>>>>> reproduced with upstream makedumpfile.
>>>>>>
>>>>>> When analyzing the corrupt vmcore using crash, the following error
>>>>>> message will output:
>>>>>>
>>>>>>         crash: compressed kdump: uncompress failed: 0
>>>>>>         crash: read error: kernel virtual address: c0001e2d2fe48000  type:
>>>>>>         "hardirq thread_union"
>>>>>>         crash: cannot read hardirq_ctx[930] at c0001e2d2fe48000
>>>>>>         crash: compressed kdump: uncompress failed: 0
>>>>>>
>>>>>> If the vmcore is generated without num-threads option, then no such
>>>>>> errors are noticed.
>>>>>>
>>>>>> With --num-threads=N enabled, there will be N sub-threads created. All
>>>>>> sub-threads are producers which responsible for mm page processing, e.g.
>>>>>> compression. The main thread is the consumer which responsible for
>>>>>> writing the compressed data into file. page_flag_buf->ready is used to
>>>>>> sync main and sub-threads. When a sub-thread finishes page processing,
>>>>>> it will set ready flag to be FLAG_READY. In the meantime, main thread
>>>>>> looply check all threads of the ready flags, and break the loop when
>>>>>> find FLAG_READY.
>>>>> I've tried to reproduce the issue, but I couldn't on x86_64.
>>>> Yes, I cannot reproduce it on x86_64 either, but the issue is very
>>>> easily reproduced on ppc64 arch, which is where our QE reported.
>>>> Recently we have enabled --num-threads=N in rhel by default. N ==
>>>> nr_cpus in 2nd kernel, so QE noticed the issue.
>>> I see, thank you for the information.
>>>
>>>>> Do you have any possible scenario that breaks a vmcore?  I could not
>>>>> think of it only by looking at the code.
>>>> I guess the issue only been observed on ppc might be due to ppc's
>>>> memory model, multi-thread scheduling algorithm etc. I'm not an expert
>>>> on those. So I cannot give a clear explanation, sorry...
>>> ok, I also don't think of how to debug this well..
>>>
>>>> The page_flag_buf->ready is an integer that r/w by main and sub
>>>> threads simultaneously. And the assignment operation, like
>>>> page_flag_buf->ready = 1, might be composed of several assembly
>>>> instructions. Without atomic r/w (memory) protection, there might be
>>>> racing r/w just within the few instructions, which caused the data
>>>> inconsistency. Frankly the ppc assembly consists of more instructions
>>>> than x86_64 for the same c code, which enlarged the possibility of
>>>> data racing.
>>>>
>>>> We can observe the issue without the help of crash, just compare the
>>>> binary output of vmcore generated from the same core file, and
>>>> compress it with or without --num-threads option. Then compare it with
>>>> "cmp vmcore1 vmcore2" cmdline, and cmp will output bytes differ for
>>>> the 2 vmcores, and this is unexpected.
>>>>
>>>>> and this is just out of curiosity, is the issue reproduced with
>>>>> makedumpfile compiled with -O0 too?
>>>> Sorry, I haven't done the -O0 experiment, I can do it tomorrow and
>>>> share my findings...
>>> Thanks, we have to fix this anyway, I want a clue to think about a
>>> possible scenario..
>> 1) Compiled with -O2 flag:
>>
>> [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /tmp/out1
>> Copying data                                      : [100.0 %] /
>>      eta: 0s
>>
>> The dumpfile is saved to /tmp/out1.
>>
>> makedumpfile Completed.
>> [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=2 -d
>> 31 -l ~/vmcore /tmp/out2
>> Copying data                                      : [100.0 %] |
>>      eta: 0s
>> Copying data                                      : [100.0 %] \
>>      eta: 0s
>>
>> The dumpfile is saved to /tmp/out2.
>>
>> makedumpfile Completed.
>> [root@ibm-p10-01-lp45 makedumpfile]# cd /tmp
>> [root@ibm-p10-01-lp45 tmp]# cmp out1 out2
>> out1 out2 differ: byte 20786414, line 108064
>>
>> 2) Compiled with -O0 flag:
>>
>> [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /tmp/out3
>> Copying data                                      : [100.0 %] /
>>      eta: 0s
>>
>> The dumpfile is saved to /tmp/out3.
>>
>> makedumpfile Completed.
>> [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=2 -d
>> 31 -l ~/vmcore /tmp/out4
>> Copying data                                      : [100.0 %] |
>>      eta: 0s
>> Copying data                                      : [100.0 %] \
>>      eta: 0s
>>
>> The dumpfile is saved to /tmp/out4.
>>
>> makedumpfile Completed.
>> [root@ibm-p10-01-lp45 makedumpfile]# cd /tmp
>> [root@ibm-p10-01-lp45 tmp]# cmp out3 out4
>> out3 out4 differ: byte 23948282, line 151739
>>
>> Looks to me the O0/O2 have no difference for this case. If no problem,
>> the /tmp/outX generated from both single/multi thread should be
>> exactly the same, however the cmp reports there are differences. With
>> the v2 patch applied, there is no such difference:
>>
>> [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile -d 31 -l ~/vmcore /tmp/out5
>> Copying data                                      : [100.0 %] /
>>      eta: 0s
>>
>> The dumpfile is saved to /tmp/out5.
>>
>> makedumpfile Completed.
>> [root@ibm-p10-01-lp45 makedumpfile]# ./makedumpfile --num-threads=2 -d
>> 31 -l ~/vmcore /tmp/out6
>> Copying data                                      : [100.0 %] |
>>      eta: 0s
>> Copying data                                      : [100.0 %] \
>>      eta: 0s
>>
>> The dumpfile is saved to /tmp/out6.
>>
>> makedumpfile Completed.
>> [root@ibm-p10-01-lp45 makedumpfile]# cmp /tmp/out5 /tmp/out6
>> [root@ibm-p10-01-lp45 makedumpfile]#
> thank you for testing!  sorry one more thing,
> does --num-threads=1 break the vmcore?

I was able to reproduce this issue with --num-threads=1. The reason is 
that when --num-threads is specified,
makedumpfile uses one producer and one consumer thread. So even with 
--num-threads=1, multithreading
is still in effect.

Thanks,
Sourabh Jain

