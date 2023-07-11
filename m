Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A0FEB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=em0piBRecJ6wZWDoVK2NEB4w5F69jxVuQlbYaiUbm2A=; b=ku0XJjd9AfOiXh
	cohJ0Rj4RIoETmuHxQfK7f6QgwXMGCMPospj/pTvJcoRI16jwfqfMXSKme/wZil584ztzr7UGd05R
	0KsFb3cX+4bxYGF7NC2kozyITRVskENCsoP9a0Gaw2Almw+JuHrKMk60GV1VdD9oJDdBnXrUbA5Ds
	ut2x3sapZ581bKWtL4euoK9GA41kGqDmRYk3b2qBPeru0W663SwhTjIdM2WT+a3IDA3WmTvbe6/Fc
	pWdw5H+9mAu6OqwLTR7+ZWK3ooo2i9k3FsBI4Jp/G8Jcq0DcnhzNlVOtZ0olfGbacLntxsWD4vEny
	oJLL7fjzBGZkZLpnKakQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJHXg-00FamK-0z;
	Tue, 11 Jul 2023 17:52:52 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJHXd-00FalV-21
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 17:52:51 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 89C1721C3A93;
	Tue, 11 Jul 2023 10:52:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89C1721C3A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689097968;
	bh=bOmcrci2HPoHYlVwUho2VMxL4ObRHZgvgIPwuP8X0us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AW3iqNSdPgtLp+qzLHJHsXJj4x5wJL1wmLc6wLQ7/znIVB9pjRy5pXLjwj2WQDyBC
	 ayNfYd/ArcxsQv7XfRee5CVQ5y8D3WZPoYIHN5sdzX+kx6SY4hRVtbbpGKLgljCQ3x
	 THVEHs4xiXnJnlRpCBU+rlpCDh2J8tVbcOATq1h8=
Message-ID: <565e0301-3a8b-0543-5ace-22a1484b67a4@linux.microsoft.com>
Date: Tue, 11 Jul 2023 10:52:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/10] ima: measure events between kexec load and execute
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>
Cc: zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
 code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
 Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <CALu+AoSyhnw0Cz06Mmqh+7FcLUF1q0txY1qbWLxkHO8OD5---Q@mail.gmail.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CALu+AoSyhnw0Cz06Mmqh+7FcLUF1q0txY1qbWLxkHO8OD5---Q@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_105249_717090_CB5EE35F 
X-CRM114-Status: GOOD (  24.45  )
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

Thanks Dave for taking a look at this.

I will keep Eric looped in on the next versions of this
patch series.

~Tushar

On 7/7/23 01:18, Dave Young wrote:
> [Add Eric in cc]
>
> On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
>> The current Kernel behavior is IMA measurements snapshot is taken at
>> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
>> over to the new Kernel after kexec 'execute'.
>>
>> Some devices can be configured to call kexec 'load' first, and followed
>> by kexec 'execute' after some time. (as opposed to calling 'load' and
>> 'execute' in one single kexec command).  In such scenario, if new IMA
>> measurements are added between kexec 'load' and kexec 'execute', the
>> TPM PCRs are extended with the IMA events between 'load' and 'execute';
>> but those IMA events are not carried over to the new kernel after kexec
>> soft reboot.  This results in mismatch between TPM PCR quotes and the
>> actual IMA measurements list after the device boots into the new kexec
>> image.  This mismatch results in the remote attestation failing for that
>> device.
>>
>> This patch series proposes a solution to solve this problem by allocating
>> the necessary buffer at kexec 'load' time, and populating the buffer
>> with the IMA measurements at kexec 'execute' time.
>>
>> The solution includes:
>>   - addition of new functionality to allocate a buffer to hold IMA
>>     measurements at kexec 'load',
>>
>>   - ima functionality to suspend and resume measurements as needed during
>>     buffer copy at kexec 'execute',
>>
>>   - ima functionality for mapping the measurement list from the current
>>     Kernel to the subsequent one,
>>
>>   - necessary changes to the kexec_file_load syscall, enabling it to call
>>     the ima functions
>>
>>   - registering a reboot notifier which gets called during kexec 'execute',
>>
>>   - and removal of deprecated functions.
>>
>> The modifications proposed in this series ensure the integrity of the ima
>> measurements is preserved across kexec soft reboots, thus significantly
>> improving the security of the Kernel post kexec soft reboots.
>>
>> There were previous attempts to fix this issue [1], [2], [3].  But they
>> were not merged into the mainline Kernel.
>>
>> We took inspiration from the past work [1] and [2] while working on this
>> patch series.
>>
>> References:
>> -----------
>>
>> [1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
>> https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/
>>
>> [2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
>> https://lkml.org/lkml/2016/8/16/577
>>
>> [3] [PATCH 1/6] kexec_file: Add buffer hand-over support
>> https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/
>>
>> Tushar Sugandhi (10):
>>    ima: implement function to allocate buffer at kexec load
>>    ima: implement function to populate buffer at kexec execute
>>    ima: allocate buffer at kexec load to hold ima measurements
>>    ima: implement functions to suspend and resume measurements
>>    kexec: implement functions to map and unmap segment to kimage
>>    ima: update buffer at kexec execute with ima measurements
>>    ima: remove function ima_dump_measurement_list
>>    ima: implement and register a reboot notifier function to update kexec
>>      buffer
>>    ima: suspend measurements while the kexec buffer is being copied
>>    kexec: update kexec_file_load syscall to call ima_kexec_post_load
>>
>>   include/linux/ima.h                |   3 +
>>   include/linux/kexec.h              |  13 ++
>>   kernel/kexec_core.c                |  72 +++++++++-
>>   kernel/kexec_file.c                |   7 +
>>   kernel/kexec_internal.h            |   1 +
>>   security/integrity/ima/ima.h       |   4 +
>>   security/integrity/ima/ima_kexec.c | 211 +++++++++++++++++++++++------
>>   security/integrity/ima/ima_queue.c |  32 +++++
>>   8 files changed, 295 insertions(+), 48 deletions(-)
>>
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
