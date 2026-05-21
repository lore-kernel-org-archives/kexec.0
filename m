Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F23BCD5BAF
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 18:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=34C8fXNm/YEiBjxD9RvPlzx1E/TAl0M2wZPpOGsYjno=; b=MYFte2fV9aLsUxN0V1OZrQsGNo
	XbnsthICkfLZbam8TEQ4w2+Q6uBwDktIaLkoQ3TcmJjDiNbLDbBHs+2fl3z+n49VlSAjnoIdriphk
	iS8cUFOu6eOQqsYoth53QfoABRm2b0gJ+M/WMfQXYBLhx3pSMg0mAARlScXEKtzM4z+svCTKNRdu0
	nDxIVZJdtvxJODdYEj4O4ZYnKpCjzPUhWejLuP9yj+bwXtzjhvlCR0tqyJXc3I2E8L93BnSzodexV
	hA9ol1l/j++IHyQSdKS9g4fsBwGwGTNW+CzoxiwW05O6I1+ESHr3/6FhZ2QwFlWCEYun7TAv5l08o
	JVjcGBqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7kE-00000008iyr-2RGu;
	Thu, 21 May 2026 18:03:42 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7kB-00000008ixk-3rO7
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 18:03:41 +0000
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-47cacb4ed99so4085875b6e.1
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779386619; x=1779991419; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34C8fXNm/YEiBjxD9RvPlzx1E/TAl0M2wZPpOGsYjno=;
        b=V0JSGQ5t96AXgZ8bGBn2Omy2uJoJZ3nE2NvhI24Ny4UEUBbJVRxDmS/NbiQvEjwZmP
         VXwGkxWB9dijtZRKtCQw2wiV7lbFicIJXiEkLUU2CuZq5HENhsPgSKdj+M+mnKHIpjy0
         CDDbET+yrutcyErPQR9icbIa9W9d4BLlpqGcjlLdDf6LVAZlfg62x5hXdh2bGh7JDmyM
         yADCSucqfXAgVwXGTyEhowVLqh+SySX1Pm4gwllgSM6t/70KpUQzST7G7V8ZLX+4RD9/
         /IGaU6NFwutE+8lKm3DjPCM1wVJDNIJknJRdoE5UZ4uEfjeazzRggwDxFBxNNOHLh0VV
         GyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386619; x=1779991419;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34C8fXNm/YEiBjxD9RvPlzx1E/TAl0M2wZPpOGsYjno=;
        b=gSEyEDAmWxh0muiPPDGA+FAsPgh74D3S0wEjEd3CKNkgi4yjCU1orPkEe/+wGoET5D
         gjH5iUrL7hUs7Oyhc3SFn/Yt5QbUpvE2DKS9rBjSRYh0+bebdfWKT5cRfe2oKU+n7zJL
         tkA3slTkXwb1SvSphn+mDGG9w/7aThABmuL02xub3fGODcRTtpG4zAGS4HwwK3OwhuKW
         qEulHeOU8/S3tORUbZQWXQTJIMt/1v4WKtbst+0ONoyZ1QZbMrg3a9I8g4+K8R+3m93+
         /9TDNlynATtL3O1FuOYos2rlEDTVspnBXOzBbVPjtlWsHbL5u8CV00DGer4YNd68ZZaP
         jG+g==
X-Gm-Message-State: AOJu0YyjrAzuU2Un3o5zHKogn2W/S06QCg28gm+nGna+R/6BFW74GD9d
	l331nmvytP5x4OjMe2KkaYrjuMgRKSNGyR8F5k9J8XelKFvT1TL5b6nTMqAzWBctEwI=
X-Gm-Gg: Acq92OG261/hg2Y+u8GTPL1Z6Xc6Pc8z6w5jtVmPw+lGrwLI5z+CMv9f4lb/oveI0Hz
	tIesFWTk7TZLymWxKpKDSuZsnZsV5l5AN/HsZSrGKz1TZ1OPMrWdnQluvU5k5cBIAbJ7OPRZTkZ
	f2jTC4tVb4j6zyabEGOGf9qkWIOnsqtl4O13fvQB7IZzI8GwzSANF348pv9rwjBPoJxt1ZHd8v1
	JjlXtm7LiV00mZO9Y/J0xvbjggx5Wb+HkKMJpryKkqeY55tVlYpw1cZU+DPH9NBL72OFPEkkSS+
	f+QAFt1LrW6GKCy52J9dz/Vi502l95u9PEFXNH6jKSmZKzRUqY7BA+/2ksPw85Nr9hBYKSt7Aul
	+hPM/az7wCttG0w4VEvqIicilWh86UcHpQ8DrFNA0aX2J4+3EY+b3Z6pA7lOnDUzAc/Y2hHE14f
	lmr9aW7ZpOmUJadXuBx6KnRbhE0VNG5B67FERqaxs6YmKkF9leJrIwj+3A6O96PenZLGGlu0w=
X-Received: by 2002:a05:6808:f8f:b0:45e:84e7:c20b with SMTP id 5614622812f47-4854a3b9b7cmr27003b6e.25.1779386618973;
        Thu, 21 May 2026 11:03:38 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516ccf4c8d2sm12753751cf.29.2026.05.21.11.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 11:03:38 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kexec@lists.infradead.org, luca.boccassi@gmail.com
Cc: linux-mm@kvack.org, pratyush@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260519152957.548119-1-luca.boccassi@gmail.com>
References: <20260519152957.548119-1-luca.boccassi@gmail.com>
Subject: Re: [PATCH] liveupdate: document systemd support
Message-Id: <177938661809.1151612.9365895540077391794.b4-ty@soleen.com>
Date: Thu, 21 May 2026 18:03:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_110340_030244_A4F0AF4B 
X-CRM114-Status: UNSURE (   5.36  )
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


On Tue, 19 May 2026 16:28:39 +0100, luca.boccassi@gmail.com wrote:
> systemd v261 will add native support for LUO via the file descriptor
> store mechanism. Add a brief paragraph in the LUO userspace documentation
> page to inform users.
> 
> 

Applied, thanks!

[1/1] liveupdate: document systemd support
      commit: 1b7ce86f23a430ac91a2ed6cd88046e16751b285

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


