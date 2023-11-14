Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35EBC4332F
	for <kexec@archiver.kernel.org>; Tue, 14 Nov 2023 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yi7dbztYCySzriArC+mvo1V0rnqnNfqK8zI4CHDZeBk=; b=PJ9ITWGvnhMqb0
	6CQAzsD1dI48JIdc8rdDXVZtyLHTEGjpwPmG9dgYclEcLF8oJbL4y9zMCahh907R1B01PO7oJhJJH
	zgjBSyLPaOJKYyh8y8mcBnwLmMhIy5VxzTAV/XpfrkPblactrOtLBHX5O/Gs7AF86ae+0psIGQHEf
	3cDTJpoORWLBnuT7fnwYGKWsAQ7sF3xDugYZbNyQajim1cY6WLhS5X0imJ4YKWDGikh02Nd9/WT8x
	GCfjxRtW7ckgUwD+tZu8dBDfJI5OZL0SPSS3sUfSd6FuqllTNC4xQmHMkTnOSfJuDiTC70BE+Nm7P
	sEn0EDmB6RKFXvpxYeTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r32mB-00GyLL-2w;
	Tue, 14 Nov 2023 23:24:59 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r32m9-00GyL2-0M
	for kexec@lists.infradead.org;
	Tue, 14 Nov 2023 23:24:58 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE6F420B74C1;
	Tue, 14 Nov 2023 15:24:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE6F420B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700004295;
	bh=a/ZQT3bhMqeTYxXiFgqx+wGE/tuZrVWf7f5xrC8MgJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=moon6mDbKllcLqtBGGJLJ5iAYmVVJO21o+ne7xpDose2wc4dVPnsr57BeIXRTvH9f
	 gYOxKQHCflYgZqnT3/cVQE0L6HY4xYEYLkeM/gAwj73yHmA7TiyNsCXqiuI7xRlO8e
	 8iFjMJJNYnDW+JI7kuQxFwAIaj/adwce4bNndGLw=
Message-ID: <731f818d-0e48-45f8-b009-91bd6abad704@linux.microsoft.com>
Date: Tue, 14 Nov 2023 15:24:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ima: kexec: measure events between kexec load and
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_152457_428944_D29DC345 
X-CRM114-Status: GOOD (  16.58  )
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



On 10/27/23 08:18, Mimi Zohar wrote:
> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
>> The current Kernel behavior is IMA measurements snapshot is taken at
>> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
>> over to the new Kernel after kexec 'execute'.
>>
>> Some systems can be configured to call kexec 'load' first, and followed
>> by kexec 'execute' after some time.  (as opposed to calling 'load' and
>> 'execute' in one single kexec command).
> 
> Additional measurements may be introduced by the kexec load itself.
> Saving the measurement list as close as possible to the reboot is
> beneficial, whether or not the kexec load and kexec execute are
> executed separately.
> 
True. What I am trying to say here is the longer the window between
'load' and 'execute', greater are the chances of measurements getting
added.
But as long as a single measurement gets added between 'load' and
'execute', it will break the attestation after kexec soft-reboot.

So maybe the above line in the patch description is not necessary.
I will remove.

>> In such scenario, if new IMA
>> measurements are added between kexec 'load' and kexec 'execute', the
>> TPM PCRs are extended with the IMA events between 'load' and 'execute'.
>> But those IMA events are not carried over to the new Kernel after kexec
>> soft reboot.  This results in mismatch between TPM PCR quotes, and the
>> actual IMA measurements list, after the system boots into the new kexec
>> image.  This mismatch results in the remote attestation failing for that
>> system.
>>
>> This patch series proposes a solution to solve this problem by allocating
>> the necessary buffer at kexec 'load' time, and populating the buffer
>> with the IMA measurements at kexec 'execute' time.
> 
> How about beginning the paragraph with "To solve this problem allocate
> ... and populate ..."
> 
Sure. Will do.

~Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
