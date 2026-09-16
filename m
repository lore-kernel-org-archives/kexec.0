Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7348EC88E7F
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lSvr0vCtdCumQova2+QTaGAW1CeluERBIU1FmP9NgV0=; b=z4Mx1gXMdUw8bAzTBSKkIH6GFH
	sWlIUZSWkbuXpHHPfaLbCopbG4kBneD37dIcZ7vOcgik74z0qyjq9FMtU2ExXOLclBPw1vdxMLLpl
	lDiiMCNs5Hh0fLnTPhEj4OqaeZ1G72bNKkyrgH02v1GTwqHd3k/sNDBHTXrrodlAlO3h4Ily2c+L6
	uFCmp/3yDWXS+HA+EsuYrFTId0DKXJooOb9N9Sxjnv5tK+p+4EEy8B0nj0ntQkQhTUPAaRMDaZElZ
	cK1Nuht4t2Rxo5RgbUHU7Thecs9DQiW0PSMb1PeAjNhPS9MN9s5faITyAiJhrJocA1SUFuG9jkmPG
	ONp5BKJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6uqH-00000009zcA-1kkK;
	Wed, 16 Sep 2026 18:58:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6uqF-00000009zc4-3hgl
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 18:58:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D9A1419C5;
	Wed, 16 Sep 2026 18:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575CF1F000FF;
	Wed, 16 Sep 2026 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585127;
	bh=lSvr0vCtdCumQova2+QTaGAW1CeluERBIU1FmP9NgV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dpKfeOdnhJbQOBnw3SyHypTt1bwo3khu9OjlnaFMto0eI+LryvCcytPSjazdhOHUR
	 s4du1cwq3DXECxApHbs7cf/wMeptDnEdlt2Pclae5BtOwLmGVkqOmtMcI0ZzkNUwTL
	 9YWSexTWum8n8WNCqEbnlTR40tO0Qrml0kRiC5M5x+wSbM14AnTazL5yCSRNfjugqy
	 JCXx1cKYMi8Z3Tti0pRbkYFQY0g9nmG5XSSThdECoh5+J5VCB4MTJdVcYvfjECDfap
	 FnkMzxpiuQfqYa0TZAX1sbBJEKIfu8jryKFSikfQZ4dfSWI8Qw0+FhRqLQhSc0p5xy
	 mjrO8itBp9hWg==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Zhu Yanjun
 <yanjun.zhu@linux.dev>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Leon Romanovsky <leonro@nvidia.com>,  Lukas Wunner
 <lukas@wunner.de>,  Mike Rapoport <rppt@kernel.org>,  Parav Pandit
 <parav@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pranjal
 Shrivastava <praan@google.com>,  Saeed Mahameed <saeedm@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Vipin Sharma <vipinsh@google.com>,  William
 Tu <witu@nvidia.com>,  Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
In-Reply-To: <CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
	(David Matlack's message of "Wed, 16 Sep 2026 11:31:17 -0700")
References: <20260728221007.2098560-1-dmatlack@google.com>
	<20260728221007.2098560-4-dmatlack@google.com>
	<e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
	<CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
	<2vxzcxud6ol3.fsf@kernel.org>
	<CALzav=eBXsaZKNv1SNtuT9F6aX_2TS3u5kUtko5WMv2NWt3e+A@mail.gmail.com>
Date: Wed, 16 Sep 2026 20:58:40 +0200
Message-ID: <2vxz5x056n1b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 16 2026, David Matlack wrote:

> On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> On Wed, Sep 16 2026, David Matlack wrote:
>>
>> > On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.d=
ev> wrote:
>> >> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
>> >
>> >> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so tha=
t the
>> >> > domain and bdf can be guaranteed to fit in an unsigned long and be =
used
>> >> > as the xarray key.
>> >
>> >> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> >> > index 3781e2b5f095..8af20f558086 100644
>> >> > --- a/drivers/pci/Kconfig
>> >> > +++ b/drivers/pci/Kconfig
>> >> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
>> >> >
>> >> >   config PCI_LIVEUPDATE
>> >> >       bool "PCI Live Update Support"
>> >> > -     depends on PCI && LIVEUPDATE
>> >> > +     depends on PCI && LIVEUPDATE && 64BIT
>> >>
>> >> One question about adding 64BIT to the dependency:
>> >>
>> >> As I understand it, enabling CONFIG_64BIT essentially means that we a=
re
>> >> building a 64-bit kernel, and a 32-bit architecture cannot normally
>> >> enable CONFIG_64BIT.
>> >>
>> >> If that is the case, would depends on 64BIT be necessary here? Or is =
PCI
>> >> Live Update already inherently restricted to 64-bit architectures by =
the
>> >> existing LIVEUPDATE/architecture configuration, so that this dependen=
cy
>> >> would be redundant?
>> >>
>> >> If this problem has already discussed, I am very sorry about this.
>> >
>> > The necessity is that the PCI core needs to store more than 32-bits in
>> > the unsigned long xarray key (see the snippet above). The dependency
>> > on CONFIG_64BIT ensures that unsigned long is big enough. We could
>> > probably remove the dependency but I would rather wait until someone
>> > with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
>> > before putting any effort into it.
>>
>> KHO or live update themselves don't support 32-bit platforms and there
>> are no plans to do so either. So I don't think you even need to have a
>> dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures define
>> ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
>> inherit the dependency.
>>
>> If you'd like to be extra safe, then probably you should add a
>> dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that can
>> be a separate patch independent from this series.
>
> It should be in both places then. PCI_LIVEUPDATE explicitly requires
> 64BIT for its own use of unsigned long, so it should have an explicit
> dependency. If KEXEC_HANDOVER requires 64-bit for its own specific
> purposes, then it should have an explicit Kconfig dependency as well.
> That way if and when someone wants to add 32-bit support we know
> exactly which configs need to add support.

Well, I don't think we are ever adding 32-bit support. Most 32-bit
support in the kernel is being deprecated or removed, so I really don't
think it makes much sense to extend KHO/live update to 32-bit
architectures.

But anyway, if you'd like to explicitly mark PCI as needing 64-bit, that
sounds fine too in the very very unlikely event we do add 32-bit
support.

--=20
Regards,
Pratyush Yadav

