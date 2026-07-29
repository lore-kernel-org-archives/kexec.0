Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A809FC54F51
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=An3JzZeshZc1Fa35pmrkEuoUxcWgUoTFrN6jXuA4oC4=; b=45c0LD8anfqAJc9jmy6Obr9fJS
	yTpnLR62en19zz71NgZwgrkIVzCIalovflu2DGH10/TbZxg8VGCZ/gRljOO6/t7OL1m1duqldCwAt
	wx9mRmW3GdFSXAX8sKkhYbu+Ipw3JcSJIjYvEE9A8oj5qJ68iF8xG+4TMano2s67ntOm35jx524Al
	Zuuto0wYu7EiD175n+UkzWeiFI9h7QGzWw9Ut8sYU9bTQOuEtk5aJJ9xxWA3fs4bp2BBfGSG/oNco
	vckJkp6nZPx+bji0Er5MC+b+Z4DogkGIaGbEeC5rjK29/Xkn+I371NWtrOfshlfahQD1yyh7roplR
	J2D9WWdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpC3h-000000091Gf-0jO7;
	Wed, 29 Jul 2026 21:43:25 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpC3d-000000091G9-3pPf
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 21:43:23 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-848595b338cso1807705b3a.0
        for <kexec@lists.infradead.org>; Wed, 29 Jul 2026 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785361401; x=1785966201; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=An3JzZeshZc1Fa35pmrkEuoUxcWgUoTFrN6jXuA4oC4=;
        b=EaGs2dGbGOl2wkHKdAEYcS1fjIwxnmqy3Z+Wk6D/5bmAsLiu+JEmFuA1nrk93CwCT2
         dDkVMEODngVn/VcGpv98wSIZB9RfNxs0xSkzbhtkEphuSkHO4iyZQNaGFxVOoUVfL6K9
         XxiGpU3J8X6ffJBimKmY9OwnMEU2jJWSXz9ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361401; x=1785966201;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=An3JzZeshZc1Fa35pmrkEuoUxcWgUoTFrN6jXuA4oC4=;
        b=VsegQVkNcrdXBOKhjtxVNHsOECPQNDsZGKeL6bsdG9gjOHYpSr4xLRa5iBGeWiDtu6
         KJNADxp8BDp3W/CraWeI9VZD3mrYz0YVdwgi3YPwZZn+rWRKY4MVvXsKR/QOfYnHf8OI
         qvAn9qucdFFz4++O8rgGMmIzH/EDTB0Wn79+jzuQHSxdd582ua3aeepj72IBL+uzD9EG
         DLeCqBAdTRU9n33sWJu3LbgiUc9CRBMuvxhUU+eXHfZT4cHaVF71/7nz5GOnI3NLwi6J
         4NrMrEAbXgMxEgkcfp4mGRNxOAa+ypYwahqAPRnksdid1W6ZHUkQoA+MekUSvd9qNwxS
         24Hg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6VxJvwbFtra76SSYzdAVuWyg+RmCvHiKdlhUqflRg6pHBmzSPt2C0TgGnuAU2blsRLlaRYQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywjv+ZelcIBsGohjeqxwr1b3REfaVF3x4cqneni4y/C+JOA4In7
	0rpNiv5jK9ui6I4wjJtY/u2fTttN+2387r71Y0/2mEXK7lHLEYh8jIYzU16uYbUT/zugdZFaAl0
	0BRBCOw==
X-Gm-Gg: AR+sD10LU+0Ya0ZEuuypSrMmTq6pkTwMkkBeTknJ7iwXZkK+28ZS3muKplHWZFYqcD+
	GxHXhUu5QqfqyuwxLIaNy8co++GYGIKMZPRLDjHp0IeZ8nFO9P6vuDX/9bX1o92/tAfx45feus3
	zu8kAsJtlbsw4fx3Y1IePuCc44RXp/co0Dozjh4MVRIr1hEjHDUCn573yZEEsNo/YrsrNr3bOJ8
	jH3oA9U2qiUmYb8dR+d8ukyPEa6UNvRntwW6uZosDnGgotK3vO/djdsYg/2ksl9DNG6I5aWZjtF
	wpq+ndwiUQ2vQc+kDOHwiIPlAFN6Hi6ldqUYfweqOV/88sSfAn0+8mKYKi9ev2dXGqrfW0fXmAw
	LMJfBqmQHto/QS+BJRoMbV7ZjWW6q5PG06JXYbc27xBrwizSeRCxEepq6u4CCXvwkFy5UlVIN+t
	B9ZcpOA8Kh5PNuFHZcR6FIZPJfzXpDOLqCZQBHoVR9fK3yTjE1PGtCdv/c6d6R16O4QEuKwGqAm
	aWx5+y272VjWHWuTv0j62Vx3hFZQOUQ
X-Received: by 2002:a05:6a00:b4e:b0:848:48c6:480c with SMTP id d2e1a72fcca58-84ebc233407mr47053b3a.24.1785361400769;
        Wed, 29 Jul 2026 14:43:20 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba929728sm1314120a12.29.2026.07.29.14.43.18
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 14:43:20 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf27856f9cso15752085ad.2
        for <kexec@lists.infradead.org>; Wed, 29 Jul 2026 14:43:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RptwkG4K6ls8H0XuwcCdY4tQKOn2cvrCM/u9fhDwyj+6EluZZYU6skiW7T8MAOBtVzHAb3/BA==@lists.infradead.org
X-Received: by 2002:a05:6214:194e:b0:8ea:10f8:ae87 with SMTP id
 6a1803df08f44-908301652admr8189126d6.11.1785361068683; Wed, 29 Jul 2026
 14:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1782744912.git.kas@kernel.org> <ak_IRHwd02EjWMf8@thinkstation>
 <amYR5VWHWC1WdFXc@willie-the-truck> <amZRtS2Lu1epc0S4@thinkstation>
 <amiDoZdszC1pB6Z2@willie-the-truck> <amiayYZA2kBSTzFB@thinkstation>
In-Reply-To: <amiayYZA2kBSTzFB@thinkstation>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Jul 2026 14:37:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UN8+Yydm1G-afbaAfh2ZF7MzEE27UXoDOG0HFB0cwyXg@mail.gmail.com>
X-Gm-Features: AUfX_mxQN96FUqkYM85HsMzl_ulE8Md6LA-9M6sqY7EHnB4PXM5UtB67IbHenI0
Message-ID: <CAD=FV=UN8+Yydm1G-afbaAfh2ZF7MzEE27UXoDOG0HFB0cwyXg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] arm64: cross-CPU NMI via SDEI
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_144321_979915_261CE2E3 
X-CRM114-Status: GOOD (  11.34  )
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

Hi,

On Tue, Jul 28, 2026 at 5:18=E2=80=AFAM Kiryl Shutsemau <kas@kernel.org> wr=
ote:
>
> The piece that isn't boot-time yet is the hardlockup detector that drives
> all this. perf and buddy are mutually exclusive at compile time. We want
> to use perf watchdog for FEAT_NMI while SDEI needs buddy.

FWIW: can I ask why? You're worried about the "all CPUs lock up at the
same time" problem? I am aware of some work towards solving that (even
with buddy) by letting the hardware watchdog driver's "bark" interrupt
run at NMI-level (or pseudo-NMI-level). With that change, I'm not
aware of any benefits of the "perf" detector over the buddy one. The
buddy one should generally be more efficient (fewer interrupts to
process) and less resource intensive (doesn't reserve a perf counter
for the whole boot).


> But it is solvable.

Yeah, someone posted proof-of-concept patches that made both
selectable at boot time. Nobody was really interested in shepherding
those patches all the way through.

-Doug

