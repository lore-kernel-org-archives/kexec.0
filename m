Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C1CD4F3C
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YAmPSe9oMJmb2SDflrLo6XOZ/WBxHlp4jcSg2KpdbhQ=; b=QO9UnkxdpTmO7/M6/zv37L544s
	eFpSdqfwIudXdkL9OVtqH+eA4I2E+gYfqyJ4t6bibZpURYWWVhb/D54+jtgmG+PFOLW++zkgypHGF
	5u7ErQHL67Euj6Uj/re9XK/3ghRGWWnPdnbC69AhunUTZ88/NQe2JPP1WrqrOc3fGL22F9xFG3Duh
	B+H+kEXxMUHYYBPgWhkBPVV4hYI1ojocCQpA8J7W21Rb9Bazs2gsP3lIDRRBi1q04LN1//pfUerxi
	KmSBoamsJ+I18RNbAOSqB/w5ViJngPxZt+IK8ytZkYt0ca4nhSLndBQ054Js5KnXxEhf8GtwXunr4
	GuPRjpPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPL2n-00000001lEL-0bWA;
	Tue, 19 May 2026 14:03:37 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPL2k-00000001lDe-2Scj
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 14:03:35 +0000
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-47cacb4ed99so2299214b6e.1
        for <kexec@lists.infradead.org>; Tue, 19 May 2026 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779199413; x=1779804213; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAmPSe9oMJmb2SDflrLo6XOZ/WBxHlp4jcSg2KpdbhQ=;
        b=UJF9Ppx2Uq4V0ax4woMrne4fyOx4vDJX4tD0Lb8uHXkGFOKrak328uGTUMKOSWI2lT
         wuB6KP01ggaD5vwZbRtPwL76WMGhSXtwsaZ4Yt/lxgz0vkaztPgvOSSuIiXCEcf4KKPR
         YP1lTYUtH4UBwcLDOgf7rfW6NZSmrBWs6ejtVg74lyS34ptebNmreKdL6hYRRNbGytc8
         LkugGopnU22g2Xs0Bf3Cq5Vwu/mlA8H1DbvGpDOGyjLYFwUuxfO4o7y2mTOKREzzmuXX
         0I6ZCS7m+xsig4G5EnijLtkX1gMwVDctmoXwT7+FtmRjBlY29y+1vVY+Xo3rzVaYqLcW
         rsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199413; x=1779804213;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YAmPSe9oMJmb2SDflrLo6XOZ/WBxHlp4jcSg2KpdbhQ=;
        b=pavq/triIpUPpEK71JYtZWuPH3QuwEs6jyWEUTvXkeqPYXF8fBlWHfI2c3puHC2vec
         vh8bSspnj4e4e9IRHczqpcF+4//ErMW94rnVeZLiX6w4B3Zz6bBaReNdoLkE93tMdZjU
         YycPtMxvPOEec6xC1+mhvPpKLg5xFjrONyPDl71cOSnaRU4Y8oJoJbSO+Jqp5fBcyaZH
         Ps3nxn/eqABZb6jQ3SSBPpY/WQ4wrIaSN2vtPo1INGQcf+brOe1cy5YZ9aPaLTiW5dI8
         7jMMB1TO2bj1C+TkKUjErAoJOM9ROXAGLm+C6lwaRRU3S3aNt/W23cht9zO/t7U+TZmJ
         V6uA==
X-Forwarded-Encrypted: i=1; AFNElJ9YEBx0bLt1lsB+Ik4+HawakKGDf1Ej3d/HnTtLwi8qLqffCYCBO6W6GQM9sSP5USZamWWlGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwRrHoeTEwWoR981bwjIRbp6KkVEba1gmVIrg7YmlDVEJrViHQM
	aEnFzxmzH7/qza+P5WO3ez473/2hqthtiw+60OPoDZ5evaHzf3n3OLaydqGlcYUTymA=
X-Gm-Gg: Acq92OFDrkB2DXSVIepMCKSIJCUUTB1/xZTaHLB/oiJj5yonVpMFzsiYg12Iq6VVKaH
	XT/nS5trCvb8f/oYB7GFH4a+qSZ3D7Pv245HthgT/6OUU9pgLd3kSj/QOtAG/ne9SuCqN9c6oLS
	C0sM320djh6Ch0aIL/51MOWnY2kWTM0+ADxxyBB321uCU13/ibFaTkHtxz3Y385uWPqvPlF2nh2
	KztJxfNRssGceeJ04g7XrzkOAohdp5vz0vBYLY5PRuUY699upoaqyB3G84hIk/D/R87eMDMK3Z9
	47xsoSgPVkFyftbLyLlJ86+po1LF2Nd/CmTxzKnHxmNQ2del4vpxPKewBSUF7xXTorCggMCXsod
	llvLQVZu/Ksv8AlB5TnS7gUBTYCI2ICgHAnjQ3bpQDWMAIwCorN17X0/ETiM/Nq56azlydXxOqH
	lCbfmJBMHA1EfvwLUQiGKh7WcyeQnYvwMkJJ3EFQxK+ZJGPOmNxfIpEuIYR04Z
X-Received: by 2002:a05:6808:2f0e:b0:479:d605:64a0 with SMTP id 5614622812f47-482e54e90cfmr13118969b6e.0.1779199413144;
        Tue, 19 May 2026 07:03:33 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164581fdf9sm164071241cf.24.2026.05.19.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:03:32 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-doc@vger.kernel.org
In-Reply-To: <20260519125714.2435640-1-pratyush@kernel.org>
References: <20260519125714.2435640-1-pratyush@kernel.org>
Subject: Re: [PATCH] liveupdate: document liveupdate=on
Message-Id: <177919941198.1116313.3518745939102714040.b4-ty@soleen.com>
Date: Tue, 19 May 2026 14:03:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_070334_636256_6A865130 
X-CRM114-Status: UNSURE (   9.25  )
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


On Tue, 19 May 2026 14:57:06 +0200, Pratyush Yadav wrote:
> While the liveupdate= parameter is documented in kernel-parameters.txt,
> it is not listed in LUO's user facing documentation. This can make it
> hard for users to figure out how to enable the subsystem, since enabling
> just the config isn't enough.
> 
> Note the need for the kernel parameter in LUO core documentation, which
> gets exported to Documentation/core-api/liveupdate.rst.
> 
> [...]

Applied, thanks!

[1/1] liveupdate: document liveupdate=on
      commit: d65d7e28888a6f3a1999908cacadd99f4c14ddd9

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


