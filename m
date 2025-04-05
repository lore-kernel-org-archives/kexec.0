Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF0AC36010
	for <kexec@archiver.kernel.org>; Sat,  5 Apr 2025 05:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cYhB80NQAEOdELsTajiPWw1wUNFuHRaAVe3BXK9EaeI=; b=n5aYDUEYQBYQCaiZE63mfRYdT3
	Qk7bnLelPADA9vdfG69soZrwN8rQmvLE2hteX2NloTSvZEsUg41QJG5yhCIHggwON+Re1n61VdJ2O
	XNAllm3yO8ME632WxdXvVaR+t6eXaxSFhdEjtZLSDIgwUWljesGFGrg3g/CH9Q9o7nszIhLgCGrAm
	zAbrJRJMj7xkCqH4mhECBeHdvwpswptBU4XU9a6kneUeiLvW0gW96BuVb+XJdFoB5s+xF6Cg/bhDJ
	mvpAGfoSh1ihrfZP08mznqeQmfK645OK1AOGqbpOEyDPtrVrdZju3JEx9dXQG/ZvWrdXQQ3jCgORa
	OzfzOWMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0vsW-0000000DV4a-1CNe;
	Sat, 05 Apr 2025 05:15:36 +0000
Received: from s1.g1.infrastructure.qtmlabs.xyz ([107.172.1.117])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0vsT-0000000DV49-2hr1
	for kexec@lists.infradead.org;
	Sat, 05 Apr 2025 05:15:35 +0000
Message-ID: <b09aab52-8fba-49c4-8dc7-9d5cca0f5b98@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743830128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYhB80NQAEOdELsTajiPWw1wUNFuHRaAVe3BXK9EaeI=;
	b=WC/Jj2uSSBgrctke8lvLcxJfUYYOWf5ktSNDeGd2JRF9/8K3BMadYBjX7si/0FkQpYEozs
	TAT2hjGjSnQ99oP5s6oaIgNx0KhAMZ4PDoj+CoOczq6IQEdwBATSwrBt2GpxFDiMGYHfhE
	eJW4rsq1R+xMMJaBoMo8Ro2uA9MHL7GidG3yZmW6mgZsydLvf3tQQEsr04495XHTC0B3I1
	DLz5b8IEvjFYDnNrATl4uR546D6zy792Ub3hVgqXgs3BXqdqSfDAEb7woCbjelDFX6AcdZ
	qFbWJROMbvUQle+DkdGsHLZLh5yYvKxLSjn9vIsSWkQR4d9mmQO3Qf4wCoj41Q==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=msizanoen@qtmlabs.xyz
Date: Sat, 5 Apr 2025 12:15:20 +0700
MIME-Version: 1.0
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
From: msizanoen <msizanoen@qtmlabs.xyz>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
 ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 akpm@linux-foundation.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Z4WFjBVHpndct7br@desktop0a> <Z4WGSMdF6seQm9GV@desktop0a>
 <b9f6ed5a-74b9-47c0-b073-9922dbe6119b@qtmlabs.xyz>
 <Z-8E-LLs1dFWfn6J@desktop0a>
 <691be719-7d4c-4cb1-87d6-cca7834547fe@qtmlabs.xyz>
 <004d85e4-d23d-43af-87ca-8d037abba51d@qtmlabs.xyz>
 <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
Content-Language: en-US
In-Reply-To: <4081fbd9-0a5f-49d6-9553-4f964bf5ef27@qtmlabs.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_221533_854652_456520BA 
X-CRM114-Status: UNSURE (   7.53  )
X-CRM114-Notice: Please train this message.
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

Submitted for review: 
https://lore.kernel.org/stable/20250405-fix-e820-nosave-v1-1-162633199548@qtmlabs.xyz/

On 4/4/25 12:50, msizanoen wrote:
> Here's an updated version of the patch that better handles 
> pathological e820 tables.
>
> On 4/4/25 11:56, msizanoen wrote:
>> Also, can you reproduce this issue with a target kernel (the kernel 
>> being kexec-ed) that has one of the patches attached (select the 
>> correct one according to your kernel version) applied, with either 
>> kexec_load or kexec_file_load?
>>
>> On 4/4/25 09:54, msizanoen wrote:
>>> Can you send the dmesg logs for this case (6.13 + mentioned patch 
>>> series backported as target kernel, using kexec_load)?
>>>
>>> On 4/4/25 05:00, Roberto Ricci wrote:
>>>> On 2025-04-01 19:59 +0700, msizanoen wrote:
>>>>> [snip]
>>>>> It seems like `e820__register_nosave_regions` is erroneously 
>>>>> marking some
>>>>> kernel memory as nosave in the presence of sub-page e820 regions. 
>>>>> In theory
>>>>> backporting
>>>>> https://lore.kernel.org/all/20250214090651.3331663-1-rppt@kernel.org/ 
>>>>> should
>>>>> be sufficient to avoid this but a fix for the actual root cause is
>>>>> preferred.
>>>> When using kexec_file_load, this patch series fixes the issue not only
>>>> in theory but also in practice.
>>>> But the issue with kexec_load (see
>>>> https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
>>>> ), which might be related, is not fixed.

