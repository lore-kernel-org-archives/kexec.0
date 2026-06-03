Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D3CD6E5D
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 02:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1IZPLWBHqvJvl4gIvSvnZxXOnDR854hRgX/CoDKx5XU=; b=ItXFPJPeVYtRtqjOxzWCfkPAIR
	S3DOijon13UrQwtWra7T8QGPhwgI1Srir/zCQ66AFS7fE+MsXambUtsC85rc1uEVt7t43c2/TeHMe
	7F+pOfSXRTlonx3aQQWLM7RnQNNSCCBT40CePF6rV8yL9RSjpc1wGLa+C1ftD6ObG/2Iv2kF0xnt7
	Zrda8kI2pxOamcwYceeQBy7rzN3qKVhRLsW0cZMMzSkyuQaLppICD2ym2Mk47OQH/QHRl9KZZQll1
	tts/7lHtFVYX0QB+8HeFTA8ZAORoov044yeEXtMz/foIlwICMFt0wRW8BiX6OCVhiRYydo4k75p35
	0k5MkXmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUbh4-0000000E872-2xdn;
	Wed, 03 Jun 2026 02:50:58 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUbh1-0000000E86h-26ot
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 02:50:56 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-91564c3a968so30099685a.1
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 19:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780455054; x=1781059854; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IZPLWBHqvJvl4gIvSvnZxXOnDR854hRgX/CoDKx5XU=;
        b=ic/pKrNi5SMzuS327AzWH3mURW0nl1u6VL6i3mKicSsEH2Gsi2zZPm96vf89RZm3TP
         D5/xgAP25TgJPCkiEuMpexvONK7ia5zNqAYhY91jfL3KjAeHQm71gyzev9JtSBICQK18
         brRE1MUy4MTD/m/VfHCVONb9NBgQWpEY9d6IRZFsREzw8A3zwLA6Zi17e1xlPvmXWZH5
         VI03RyqMvE621duXLz/s/I7jrTEyaWbUpfKqC401Zy4cJoaZeyFOwB4TGFqs2Dxi77Na
         uLskJb/kNezrRPbrnwTzEeMO8wLZ7isVNrDuu6Si478sEZq0RCIYmDEc0JF/rthl0zsx
         dBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455054; x=1781059854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IZPLWBHqvJvl4gIvSvnZxXOnDR854hRgX/CoDKx5XU=;
        b=TRV4Fz7PMpHAyP7++Z5SIe40AJF7IyXvdxmMj6ZNWtJYXMNPQ3DCtI+aeizX8OjuPu
         oe9/FUUTYIhW+2nWX3PQet11JdJMdT1Bj9Yl+BZeqVacNnFHr49JVfMYptDQIdjM6mot
         NthbvopExX3apaCmS0znYJir7+7/pWqgF+u70rcDsJg30HynLCCLm1sdnNxwqMtnKB4Q
         LSshC+mG2Fpo6L0TRAPGPAtDp2fYEE/g50F8C70wpo6paJm0CDpldWZx9R46l7E0Q16c
         OH8LUY9sTVD5L5G9AguxRCsJxY2xb/ybwrpp0CGkL3LTfh+5uu5CFoeVU8O+hh/eR9Mj
         Rt3g==
X-Forwarded-Encrypted: i=1; AFNElJ8m6pkG2SMYa9/HO1+HCjs1HC/mJtqaG8d4+Y+2vUqt0aJ9w+/T94Mmxsx+hg0uQumFjVGDBA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTTDy2hqBnQVyvTZh8jLhpA1oodkZ26uJ5ohP6lCak6B3FrXbW
	3O+6aLuQMjCaYvC3g65nNkIGTZ4dapTSk5X3JFol5np6SSKQGzG9JV46pyJbWbunybo=
X-Gm-Gg: Acq92OFYNWqFXdLHIX0qrCbFCZ4zXnaiJoLZvG1fdWG4fOitUUkJnXQe04sR04gqM7M
	HcG7A7t5TnvZ4MnYTCRK6lU0tOL0Ay0pePhDuCk6+/ghtOybSN8Rzf9DTAZIMHz7qNRUE9z19Un
	nYvmyhlE/+SKHH5v4PFGE3B2niQ4o9nrR/ux+V90NTxbrxUg4wdCFMT27jbFUNXC5kNkWM2Jy9V
	DjVBNrQxibqnKtkcVs53Ba89ZNJDjla6pqeT80APDNEihNNk0BnlHlb1ArxxqmaoN3katGUq89k
	mMrLv68/cAQ92LfapLRJXZvkBf/wOUFNsznwaEcLVuSX8kUScUUYIVG6CpeaJooZmD9jpZyo8dr
	xtscNeU+xOpPkseCqcrHxEkfN90a3nH9rJpsa2UnpHAYhwIdlorKC9OsC/df9r1ts1P9OJ6Z1w9
	mFxVvAKLeAwvAyFVkY0UIXLB76DmSZscpWQG5CzSHJbPYqxRrMQfZ5w0aH/dAXOA==
X-Received: by 2002:a05:620a:a2c5:20b0:915:8f64:6056 with SMTP id af79cd13be357-9158f646703mr47560885a.16.1780455054088;
        Tue, 02 Jun 2026 19:50:54 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fc7dsm8925566d6.5.2026.06.02.19.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:50:53 -0700 (PDT)
Date: Wed, 3 Jun 2026 02:50:52 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 08/13] liveupdate: defer session block allocation and
 PA setting
Message-ID: <ah-Vp6xKSPWkuCyR@plex>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-9-pasha.tatashin@soleen.com>
 <178038801492.119771.3419366349068848854.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178038801492.119771.3419366349068848854.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_195055_568042_13722550 
X-CRM114-Status: UNSURE (   8.30  )
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

On 06-02 11:13, Mike Rapoport wrote:
> On Sat, 30 May 2026 22:19:33 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > Currently, luo_session_setup_outgoing() allocates the session block and
> 
> "liveupdate: defer session block allocation and PA setting"
> 
> PA as "Public Assistance"? ;-)
> 
> Let's spell it out.

Done

> 
> -- 
> Sincerely yours,
> Mike.
> 

