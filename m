Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6E0C4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 22:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x+FW7gjGvTRciv0cxFm059UtsWgsBlJ1y0vK9lL15gI=; b=bUceLhO9sBGe8Q
	Q5Fg8owQX+9J5qPojjjqI40H9amHA4/k9A/9OSOCnBKUpZEllpFMigfJERCI7acMXkmUrg0TFw/AZ
	FaCybRVjljoRJqydKQ+mC60vzM42VuzKdEVWKDMpXwV7y/WSz/MN+e33UBR/sK5kagSFP6GyICGvO
	3X2pZADDotzsnWoJYqRjMkUWR7lDwVI9dJouEkzP3rtNbb/28vUS6UDM0XJyr24/y71dU6IxK0KaY
	VgO2JDOdyFvlxY+OIcIcb8PdDK2AxpKFFnoxm7aN+D2mxBjmzFQgShPGpqVmM4gnN8SGlxvshfWuz
	AaWErB3N4IkKgUtmuLDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r328d-00GvuU-2K;
	Tue, 14 Nov 2023 22:44:07 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r328a-00GvtV-2S
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 22:44:06 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5430E20B74C2;
	Tue, 14 Nov 2023 14:43:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5430E20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700001839;
	bh=DTc2qI/cZVPNaic5xevm4U4kECb0RQDfzyicQEiAl80=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RxR/755mlILU85NviXtztSvQq2FPqlIPSdWnIQla9CLQQNb7l6/qwSYu406tYDaBj
	 axMesGQipP4CqQSv3Ix5gk5p4FCa6f5K3EktaOrBke2IlGrTBzGRGPjwcmWyN+Fjkq
	 /cbKl794sWl4Zx6FG7wP21MaHMKR+nWxU7lDMJF0=
Message-ID: <57c97b4f-8489-4cac-8014-c16e4af8fcfc@linux.microsoft.com>
Date: Tue, 14 Nov 2023 14:43:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] ima: move ima_dump_measurement_list call from
 kexec load to execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-3-tusharsu@linux.microsoft.com>
 <989af3e9a8621f57643b67b717d9a39fdb2ffe24.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <989af3e9a8621f57643b67b717d9a39fdb2ffe24.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_144404_842634_E2D8B077 
X-CRM114-Status: GOOD (  25.20  )
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



On 10/27/23 06:08, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
>> In the current IMA implementation, ima_dump_measurement_list() is called
>> during the kexec 'load' operation.  This can result in loss of IMA
>> measurements taken between the 'load' and 'execute' phases when the
>> system goes through Kexec soft reboot to a new Kernel.  The call to the
>> function ima_dump_measurement_list() needs to be moved out of the
>> function ima_add_kexec_buffer() and needs to be called during the kexec
>> 'execute' operation.
>>
>> Implement a function ima_update_kexec_buffer() that is called during
>> kexec 'execute', allowing IMA to update the measurement list with the
>> events between kexec 'load' and 'execute'.  Move the
>> ima_dump_measurement_list() call from ima_add_kexec_buffer() to
>> ima_update_kexec_buffer().  Make ima_kexec_buffer and kexec_segment_size
>> variables global, so that they can be accessed during both kexec 'load'
>> and 'execute'.  Add functions ima_measurements_suspend() and
>> ima_measurements_resume() to set and reset the 'suspend_ima_measurements'
>> variable respectively, to suspend/resume IMA measurements.  Use
>> the existing 'ima_extend_list_mutex' to ensure that the operations are
>> thread-safe.  These function calls will help maintaining the integrity
>> of the IMA log while it is being copied to the new Kernel's buffer.
>> Add a reboot notifier_block 'update_buffer_nb' to ensure
>> the function ima_update_kexec_buffer() gets called during kexec
>> soft-reboot.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> The lengthiness and complexity of the patch description is an
> indication that the patch  needs to be broken up.  Please refer to
> Documentation/process/submitting-patches.rst  for further info.
> 
> In addition, this patch moves the function ima_dump_measurement_list()
> to a new function named ima_update_kexec_buffer(), which is never
> called.   The patch set is thus not bisect safe.
>  > [...]
>> +void ima_measurements_suspend(void)
>> +{
>> +	mutex_lock(&ima_extend_list_mutex);
>> +	atomic_set(&suspend_ima_measurements, 1);
>> +	mutex_unlock(&ima_extend_list_mutex);
>> +}
>> +
>> +void ima_measurements_resume(void)
>> +{
>> +	mutex_lock(&ima_extend_list_mutex);
>> +	atomic_set(&suspend_ima_measurements, 0);
>> +	mutex_unlock(&ima_extend_list_mutex);
>> +}
> 
> These function are being defined and called here, but are not enforced
> until a later patch.   It would make more sense to introduce and
> enforce these functions in a single patch with an explanation as to why
> suspend/resume is needed.
> 
> The cover letter describes the problem as "... new IMA measurements are
> added between kexec 'load' and kexec 'execute'".    Please include in
> the patch description the reason for needing suspend/resume, since
> saving the measurement records is done during kexec execute.
> 
Since I am introducing a few new functions in this patch set,
I am having hard time keeping the patches bisect safe and at the same 
time managing the length/complexity of the individual patches in the series.

I will go back and revisit the bisect-safeness of the patches in this 
series again.

Thanks for the feedback, appreciate it.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
