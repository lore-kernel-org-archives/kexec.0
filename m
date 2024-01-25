Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02DCC47422
	for <kexec@archiver.kernel.org>; Thu, 25 Jan 2024 19:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X3OV5UfjoQGslPmmLmSEnkBCCPYCIazOYP2J3XofIMk=; b=lVR820XFYnasSL
	7UrVPdjN+2Xi3XFuypRpZ6bBjkspBCWoKkSZ8LvioovcZXVXb4rnixjIxWfs6ANU0Hkdbw3wJlCjw
	H49CHq8elTjtiHjj0qqOk7VMLwHYLehleMCGLDNaJRM/NdrMpSBBHel5zuLIJOLldG0ZX/s/hqWrA
	ScDCZ+Z2MoGt5i3a6XNLyPAgi4jqCUxVr0juh3DntjAW8Lf46nuHA9cHO1q4uh++Dzc1SVLK27nTv
	PlSyccMPQ2aOoAI2MWRzgBwzJtNO9m4tfu9kl2ZdnmkUjhNMEtvTfVLDwe4UuDqQbdUTljWb5X1Op
	VbwypkmjZKrYBJ1G8oZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT5Cz-00000001VDi-13Dm;
	Thu, 25 Jan 2024 19:16:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT5Cw-00000001VCj-1zne
	for kexec@lists.infradead.org;
	Thu, 25 Jan 2024 19:16:15 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7BAEB20E56B9;
	Thu, 25 Jan 2024 11:16:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BAEB20E56B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706210173;
	bh=UHZMJ2OsiH095u2y17xITV2zIyr9WMiYCpVsdJpGjxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WwCnL77IIycm5PRY6u8vhvG3M64aiRKiWFRK4GSsx0ZdQ7/RTq4np3+Nqnvf6tsa4
	 dFta17N882f5c6fouOfQdAIrh6m/ZN9UdzsyKtiJIjmX52MgrAXSYieU1Wi5SQlOuX
	 g/KoZjK4CNsVoOzFsRHsMUkCyWCcFk2gHaEey5Ec=
Message-ID: <c8760b44-e742-49c2-809d-2120d4f93850@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:16:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-8-tusharsu@linux.microsoft.com>
 <494fc3a82053e71a33bccca3fe6683c59b78b6cf.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <494fc3a82053e71a33bccca3fe6683c59b78b6cf.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_111614_694975_6C30EA1B 
X-CRM114-Status: GOOD (  14.61  )
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



On 1/24/24 06:35, Mimi Zohar wrote:
> On Mon, 2024-01-22 at 10:38 -0800, Tushar Sugandhi wrote:
> 
> The problem statement could be written as:
> 
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  The
> indeterminate interval between kexec 'load' and 'execute' could exacerbate this
> problem.
> 
> Mimi
> 
Thank you again for taking efforts to write one more example for me.
Appreciate it.

Will do.

~Tushar

>> There could be a potential mismatch between IMA measurements and TPM PCR
>> quotes caused by the indeterminate interval between kexec 'load' and
>> 'execute'.  The extra memory allocated at kexec 'load' for IMA log buffer
>> may run out.  It can lead to missing events in the IMA log after a soft
>> reboot to the new Kernel, resulting in TPM PCR quotes mismatch and remote
>> attestation failures.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
