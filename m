Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA9CCA0EE6
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 03:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IRLfDVwYP4ZCgK56gRuVbf3v6A1tlVDw7Fe7cw3dhoQ=; b=VhV/36oo/b0kpTBaTjzbJFI4u+
	dJEz9wC5ukYXvvySxHxfU+skr4lWNYdD2w9tjDVdLui5OPNuhfoKHutYBYXKujSyw/RNzU9FgyI2o
	FaD0wwA3zQJfxv6uiPTLqE/EvRTbiCVQrsK0DcfJkCSVuNJTQ2zNKB/FaFd6SBzH5mxzPktHgMzW0
	1Z0kB64u0kuTNYiAeDaG10a80+0kjSNWImokFThDSFBcaoFB4JWbVy9PiKe8U4unzaBaGBiOFvgFF
	OoIvw/FiyVx62HVJ+coI4K/UEDjmp1Z+AkvUZlcNDD/YiACfq9NjPbNJlneVhYv6JVb5aff3IoV9k
	vjaP6J3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowBc-0000000Fgz8-2cLt;
	Thu, 21 Aug 2025 03:42:00 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowBY-0000000Fgy0-2sKk
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 03:41:57 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-245f3784edcso4498615ad.1
        for <kexec@lists.infradead.org>; Wed, 20 Aug 2025 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747716; x=1756352516; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRLfDVwYP4ZCgK56gRuVbf3v6A1tlVDw7Fe7cw3dhoQ=;
        b=Y6vrWqgNMrWoBEz2iFhC1jCxzvioBcgL1l0Nf46llyOVI/hAkJXIq0JKjKjTt8VjBP
         jlyoDdB+S4dbHDBSNVm54dQPk89rfBbke0TRiEgt1fWQTCzZu+H1Ak+lNS2OzfOzfpMh
         pI2VoKoyL25kVdq8y62cU8mxxwfNGZCxgCTykHf/SDe0cFMYBRZqicLxWyLflKVKk3PY
         MUTI7arbgX+G2E5NWV2bMr94E8OxBaOdgqQ/4w37z43iDd6ELNX1g5qIGHFacE6QDLom
         OMh85f3DoTM5ncXHPjg2tGCIEeXEFGbi5EbaoTgwCPdAC4H3mPRphnecwH5Um39g8ckV
         iTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747716; x=1756352516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRLfDVwYP4ZCgK56gRuVbf3v6A1tlVDw7Fe7cw3dhoQ=;
        b=mppakNWbjZ5+814yRmc3qwdW4pRk1jqrVboVXzeky8paFXyrmRFpwKtc3k6SJYCicW
         mJ6/NnjPiuYyYqqy6R/vVitpi3udveJhnx1sMiX8xH/F8Dj7mRU+9WjlcCScBJOfGax/
         1UWb+ieQGdY1aCIVPeYX6Ndib9H3Qs1gvVMBWzfEMgy86ckNtTWzyojBhqDazAqZMdw6
         61OHIugGGty6gM4hCmwr/uz+PZK7ent9oZnDRpuUwE/8d4Z+eGfSzeXezxrvjLSdm9H1
         ow1TvKtcfDFDJhfhPdSmncFTs6AAzNIEQ7ZKMxo0kFTfnFDiSHocUzr8jCJ/gCkIkt50
         ehUA==
X-Forwarded-Encrypted: i=1; AJvYcCW9btGMvgciAH9+0qwUfeqzR/y3DyrcxMzvyjYrVM3QFAXajNuTnxLsJuMEfD5CJBVN9GmqTw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJ4T1gHm1/gSpBmLegof8IcdPn7IajyWCJdxd2XXuS3a+dESHv
	1Jph6Zve5TXDO82i3ulB/yXoLAT0huuG9G9D9Q0OcfZC4jjSLINm/sr24r1oeIkX4d5DsKXL
X-Gm-Gg: ASbGncs/ra8NFkQXVq5NbGu1y43dg5bSy2E+zEm6cMRLbDaOwt+9R5RQDr9awIwaG2C
	mKvDqEZ09sV0UejIc6ETl6YtTmemYgikKtSDoBarhm8VEoCw24fYtPwsBFNL+3bThE513vsM5cv
	GHAn7cihUurL5uc5pLZMjU91s9Vr5LX1DMGDjaIRWesjp2Jzg00Knov2Ys6CkkGdO7sLx8AHAnc
	qVKyF/3Er1biiulfScQg5yEa+mbvvKx2qtUfRT0/11z/q4YEthqEjo6iUO/NH7aA71UQRRT/56S
	DTbSl2Rw2jpl6qNwA1ey0CQ/qWQYd8Uu3g8iulLbRaNMc8PR0Fzcte+EQInuk0y7BbuXKq726mh
	4k1JC97qqK9moi8U=
X-Google-Smtp-Source: AGHT+IGHVc1FTNUDeFUsPOjRM4aR3LLXqdfdYwjrp5/bYhy1+SZ1tq+Kh46WSZHKBqSXtdOxVJeNpg==
X-Received: by 2002:a17:902:d54e:b0:240:469d:beb0 with SMTP id d9443c01a7336-245fed7e65amr15261125ad.31.1755747715733;
        Wed, 20 Aug 2025 20:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:6::3058])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51aa14sm40806585ad.145.2025.08.20.20.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 20:41:55 -0700 (PDT)
Message-ID: <3bfd0f8c-cda1-40fb-9642-bd305d3ff98f@gmail.com>
Date: Thu, 21 Aug 2025 11:41:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
 joel.granados@kernel.org, john.ogness@linutronix.de, namcao@linutronix.de,
 sravankumarlpu@gmail.com, kexec@lists.infradead.org
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <aKaHvnxEaXF/fLnW@MiWiFi-R3L-srv>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <aKaHvnxEaXF/fLnW@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_204156_730731_FA87835A 
X-CRM114-Status: GOOD (  19.37  )
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

On 8/21/25 10:43, Baoquan He wrote:
> On 08/20/25 at 05:14pm, Jinchao Wang wrote:
>> crash_kexec() had its own code to exclude
>> parallel execution by setting panic_cpu.
>> This is already handled by panic_try_start().
>>
>> Switch to panic_try_start() to remove the
>> duplication and keep the logic consistent.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> 
> I had to use b4 to grab back the whole patchset, but I can't comment on
> other patches, especially the patch 1.
> 
> Firstly, this series looks interesting. It does enhance code
> readibility. But I am a vim user, I like open code on this one line of
> code wrapping. So leave this to other reviewers to decide if this should
> be accepted.
> 
> Secondly, the lines of your patch log are too short, it's not convenient
> for reading. Can you set your mail writer to change this.
> 
Thanks for the feedback. I will make sure to set my email client to use 
a wider line length for future patches.
> Thirdly, please add people to CC in all patches. I don't know why you
> only CC me in patch 3 if the whole patchset is related to crash and
> panic.
I use git send-email, which automatically adds the To and Cc headers 
based on these two configuration lines:
	tocmd = "scripts/get_maintainer.pl --norolestats --nol"
	ccCmd = "scripts/get_maintainer.pl --norolestats --nom"
It seems this isn't working very well. I'll find another configuration 
for the toCmd/ccCmd.
I would be very grateful if you could share your configuration or commands.

-- 
Best regards,
Jinchao

