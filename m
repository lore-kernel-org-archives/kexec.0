Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D03CF044A
	for <kexec@archiver.kernel.org>; Wed,  9 Oct 2024 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pnz6QmYMBvVPJJ/XjolGYo/EpFkAS+wdQqrX+pDngew=; b=wI6jgnV1D6kKbi
	BYYtgNZYMAdiqJQDFOuPa5DcRhfAON2U6ECSHu2o7q2AhqT9KCHyJ2xHlD1FBHCqdsKHCuNlcWf7q
	GKnL0cZKNCgirBue8kgVGRviyZMeuwsSSPfpcoGroGRlbiJGV9uOZgGr68ZO/hyxGoV25GiVIsh6j
	K+tm3cTyqSxnwxpC+4bjpuawKnlQTQ87cVOREtaI2VG+TSl3zmTZVYmVmybIYjZnlRZKc8ivRp7Rl
	FU0l26rQi14C4Hxtnu7+WDmqvrnGCTwghIck/oA0VKvycjytZrLUdU8Ic8KHU6I2zM/vtKitJNtVa
	uXLi5yHC/NiW9v4cUyaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syUDI-00000008vxV-2hXX;
	Wed, 09 Oct 2024 10:46:40 +0000
Received: from mail-lj1-f177.google.com ([209.85.208.177])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syUDG-00000008vwv-1VK3
	for kexec@lists.infradead.org;
	Wed, 09 Oct 2024 10:46:39 +0000
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso96992221fa.3
        for <kexec@lists.infradead.org>; Wed, 09 Oct 2024 03:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728470796; x=1729075596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNMFGv2yRXisTXc7gWT2h+fzh59yEWTgP+a8tlpKQSw=;
        b=dynGIv4gMSa+nHt/NL1EHmOKQtvArofVYt2GTEYlMMrFmwQM+sB9g+izDHOBzZf31M
         E6+IhdGzC0mlPWuQDmbEHBSuhmi50Bwfg9Bf3WOWtw4hrC+lK1/ieuJDD3JvAYaBv9qh
         9pGqe/Rhqz6X+axZqZBQeHOqG9+GDOvN34grPyNruYA5wFeP+eUMD1UYcp3BVoIVToLB
         avvOOo3Pk+pSAF+LD84TYDyON4ss1j7LfbNiicDaZ2zVKhQAzPopnCqIWMX0cG8RBrBl
         1zcSkK3GT4U0+m8+qjESQP/Ac+ioW/tiNbK+LNXovMygAN1phZ9UIhlwdBDJ+TQGP6WO
         GRCg==
X-Forwarded-Encrypted: i=1; AJvYcCWOYD0zI6fgjwiRdV0Gu9KR8hEGSnq0mPkVacKNgDPlKcjRPRrnIaqSyMPYfIX9Y3gMGFXlOA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCJIVNS6cIitBYUSFEAG12lhiI5KviB2wVa+ehrWbxISRGngMM
	NPotFu/xZWdl0yc1qkXXDe939MWRsBFVE6Md780EkHYTpr2/o1F7
X-Google-Smtp-Source: AGHT+IGBgPyvl5kI21wnDB/KVv5sxzPHbM6/6Kuir7Lxse6lIyMw/Z/TaRG/9tgMZmWq+QJVbcztyQ==
X-Received: by 2002:a05:651c:2126:b0:2fa:d49d:45ae with SMTP id 38308e7fff4ca-2fb1871e4f5mr19755081fa.8.1728470795507;
        Wed, 09 Oct 2024 03:46:35 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99446bd93asm522407566b.82.2024.10.09.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:46:35 -0700 (PDT)
Date: Wed, 9 Oct 2024 03:46:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <20241009-feathered-polar-manul-ea6e33@leitao>
References: <d9df5012cd3306afa2eddd5187e643a3bbdfd866.camel@HansenPartnership.com>
 <20240913-careful-maroon-crab-8a0541@leitao>
 <5c525fe8f33fffebc0d275086cc7484e309dfae0.camel@HansenPartnership.com>
 <87o74n5p05.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXF7EohKai9nyxSnvu32KNdUcNZxxP69Sz-vUZ-6nmvekg@mail.gmail.com>
 <874j6e482p.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXEa4DSY8omHGhoTK0U5isvK2G-PJO9go-QK_Mzny=g6ow@mail.gmail.com>
 <87setx3b8l.fsf@email.froward.int.ebiederm.org>
 <CAMj1kXHtNrsdsHQWMXrq9jAyzxEJnTW0M7-OEA0kpb3KS2cZ=w@mail.gmail.com>
 <ZwZIoQobJrltBpTX@earth.li>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZwZIoQobJrltBpTX@earth.li>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_034638_426451_098D065D 
X-CRM114-Status: GOOD (  39.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Oct 09, 2024 at 10:10:57AM +0100, Jonathan McDowell wrote:
> On Wed, Sep 18, 2024 at 09:36:06AM +0200, Ard Biesheuvel wrote:
> > On Wed, 18 Sept 2024 at 05:14, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > Ard Biesheuvel <ardb@kernel.org> writes:
> > > > On Tue, 17 Sept 2024 at 17:24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > >> Ard Biesheuvel <ardb@kernel.org> writes:
> 
> > > >> This should not be the kexec-on-panic kernel as that runs in memory
> > > >> that is reserved solely for it's own use.  So we are talking something
> > > >> like using kexec as a bootloader.
> > > >
> > > > kexec as a bootloader under TPM based measured boot will need to do a
> > > > lot more than pass the firmware's event log to the next kernel. I'd
> > > > expect a properly engineered kexec to replace this table entirely, and
> > > > include the hashes of the assets it has loaded and measured into the
> > > > respective PCRs.
> > > >
> > > > But let's stick to solving the actual issue here, rather than
> > > > philosophize on how kexec might work in this context.
> > >
> > > I am fine with that.  The complaint I had seen was that the table was
> > > being corrupted and asking how to solve that.  It seems I haven't read
> > > the part of the conversation where it was made clear that no one wants
> > > the tpm_log after kexec.
> > >
> > It was not made clear, that is why I raised the question. I argued
> > that the TPM log has limited utility after a kexec, given that we will
> > be in one of two situations:
> > - the kexec boot chain cares about the TPM and measured boot, and will
> > therefore have extended the TPM's PCRs and the TPM log will be out of
> > sync;
> > - the kexec boot chain does not care, and so there is no point in
> > forwarding the TPM log.
> > 
> > Perhaps there is a third case where kdump wants to inspect the TPM log
> > that the crashed kernel accessed? But this is rather speculative.
> 
> Generally the kernel/host OS and the firmware are touching different
> PCRs in the TPM.
> 
> The firmware eventlog covers what the firmware/bootloader measured;
> itself, option ROMs, secure boot details, bootloader, initial
> kernel/initrd (if we're talking grub as the initial bootloader). These
> details are not changed by a kexec, and provide the anchor of the
> software trust chain.
> 
> A kexec'd kernel will generally not touch the same PCRs. The primary way
> I know to carry kexec measurements / logs over to new kernels is using
> IMA, which will be configured to use one of the later PCRs (default of
> 10).

What about in the case where you don't have Grub, but, use the kernel as
the bootloader, kexecing into the desired kernel?

Will the bootloader-kernel touch the same PCRs as GRUB, or it will only
touch PCRs above 10?

Thanks
--breno

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
