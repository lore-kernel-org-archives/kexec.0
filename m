Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9B0C25B77
	for <kexec@archiver.kernel.org>; Mon, 13 May 2024 02:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K7vEFEjpbIsnU30LxNmcFxJDPd1VDetK+Ql+edNjCAI=; b=eO9fprlFxnA4CM
	IBrBC+Mn6lvRp0HECGZHdPxTv5oygXQW3WXdr8Ku0AJMPMDiVc4Mw8tpUD8uQ2Ga0NeJLyEdCmabk
	LCO3e0Zfa6A99Wgzu2VuqCdUAfjrC5A/QnJ6wT9HQv1AZXcjK73vRPczHdxpazv4+BzOJQJcwust/
	gTGXzXBJTLERCCGl1IbnCU05YY7I9zLVSetYnPrjgrbTe23N76ruNF/5/rrqzm3U6Lwxpuj9oDxrY
	OO2cDcFq0lp2hHuxe1bqg9ak+NIJUXlZqGU8Ukk2MIEOnqfqyAS4QherfZNQ6SVihbtd5/kfxVFd0
	GWa0cNDTsVpDz3MxXUDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6Lt9-0000000BRyB-2R4P;
	Mon, 13 May 2024 02:58:07 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6Lt6-0000000BRwX-3N5S
	for kexec@lists.infradead.org;
	Mon, 13 May 2024 02:58:06 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6f457853950so3241469b3a.0
        for <kexec@lists.infradead.org>; Sun, 12 May 2024 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715569083; x=1716173883; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y/lu5TaLovMBUI69zhtefvoAbFIExvkJe/gVrMPa9Rs=;
        b=d3R5/kNAul4804cuCdvk2Di3wQQuvjX0fvfHnrM2xzxCD3IXHi4n0co0mV6QG1W3J3
         VBl/ZnKk40lQduh2bSYtrpww5gTCYLluXmC/HtO9GBw4c1n3OKFz1e6zg0YP0eX/kTAh
         WIVHUwkFLsyAeSpkB9mX2VLZE9khgZj6v87bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715569083; x=1716173883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/lu5TaLovMBUI69zhtefvoAbFIExvkJe/gVrMPa9Rs=;
        b=KoxjXvEbbQ3DSovS2KWORiCXXlA82IHjd7xzIaLtksZtCtBmjnyxxnrZHYJ/r873ir
         1KNn0lHc1aIn8PqJJG3sdg7blRNEa/krrJjofM+OU6Zzuljb2Xs3J7wf4zeIe5nY8KvC
         1+FeEKC39fGOAFR7tWuCJeP5x4HuPEsB2d4PuS6PkM+FEzqnZ5Sz4GMER5/KOy6ai4LN
         J7wVRHp4WKmf0ZEfWl3lOZGBrJvt4JbazIIYMgNvnS84O2qLHMUmhMTO5sOf7b0YIRiw
         mnyT/nOqQX1Uf5+B5Wee7oa+XLicdLK32cIiddOHr2H0u3cRDZBIyKemg8XtJOtTNS4c
         hyBA==
X-Forwarded-Encrypted: i=1; AJvYcCVREiPX+ABenh1NIun2ESC5yzleUOetHjUR+VpPGBuakBEJ6JiKVmT73OetXmPmcEDnq8MFz73F2FUneQsvUQbmELmPYy6oZ74i
X-Gm-Message-State: AOJu0YzNlazvlySrJwFEsawYAzcOyC2G97xFUalxpSIHrhm1VYW8VmzH
	+uAVGxEuTvDXu0+763o4/vNgdlhfNyjmgKTf+WZcifH3Y+k53mu+SleQrSj4jQ==
X-Google-Smtp-Source: AGHT+IEKZ/LshmwPejdGxanAmq+x/Okf3LXGs+1GNXJLM4QWlBn90rXQR1Oeyq1KkYKRq0CgAkrYow==
X-Received: by 2002:a05:6a21:1505:b0:1ad:7e68:570c with SMTP id adf61e73a8af0-1afde07d801mr12977761637.4.1715569082704;
        Sun, 12 May 2024 19:58:02 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2fa86sm6335827b3a.213.2024.05.12.19.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 19:58:00 -0700 (PDT)
Date: Sun, 12 May 2024 19:57:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <202405121955.BC922680BA@keescook>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
 <202405080959.104A73A914@keescook>
 <CGME20240511095125eucas1p1e6cd077a31c94dcdda88967d4ffc9262@eucas1p1.samsung.com>
 <8d1daa64-3746-46a3-b696-127a70cdf7e7@t-8ch.de>
 <20240512193240.kholmilosdqjb52p@joelS2.panther.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240512193240.kholmilosdqjb52p@joelS2.panther.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240512_195805_029166_E7552CAC 
X-CRM114-Status: GOOD (  32.24  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sun, May 12, 2024 at 09:32:40PM +0200, Joel Granados wrote:
> On Sat, May 11, 2024 at 11:51:18AM +0200, Thomas Wei=DFschuh wrote:
> > Hi Kees,
> > =

> > On 2024-05-08 10:11:35+0000, Kees Cook wrote:
> > > On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> > > > On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Wei=DFschuh wrote:
> > > > > The series was split from my larger series sysctl-const series [0=
].
> > > > > It only focusses on the proc_handlers but is an important step to=
 be
> > > > > able to move all static definitions of ctl_table into .rodata.
> > > > =

> > > > Split this per subsystem, please.
> > > =

> > > I've done a few painful API transitions before, and I don't think the
> > > complexity of these changes needs a per-subsystem constification pass=
. I
> > > think this series is the right approach, but that patch 11 will need
> > > coordination with Linus. We regularly do system-wide prototype changes
> > > like this right at the end of the merge window before -rc1 comes out.
> > =

> > That sounds good.
> > =

> > > The requirements are pretty simple: it needs to be a obvious changes
> > > (this certainly is) and as close to 100% mechanical as possible. I th=
ink
> > > patch 11 easily qualifies. Linus should be able to run the same Cocci=
nelle
> > > script and get nearly the same results, etc. And all the other changes
> > > need to have landed. This change also has no "silent failure" conditi=
ons:
> > > anything mismatched will immediately stand out.
> > =

> > Unfortunately coccinelle alone is not sufficient, as some helpers with
> > different prototypes are called by handlers and themselves are calling
> > handler and therefore need to change in the same commit.
> > But if I add a diff for those on top of the coccinelle script to the
> > changelog it should be obvious.
> Judging by Kees' comment on "100% mechanical", it might be better just
> having the diff and have Linus apply than rather than two step process?
> Have not these types of PRs, so am interested in what folks think.

I tried to soften it a little with my "*close* to 100%" modifier, and
I think that patch basically matched that requirement, and where it had
manual changes it was detailed in the commit log. I only split out the
seccomp part because it could actually stand alone.

So yeah, let's get the last of the subsystem specific stuff landed after
-rc1, and it should be possible to finish it all up for 6.11. Yay! :)

-Kees

-- =

Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
