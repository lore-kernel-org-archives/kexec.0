Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B805EC88E7F
	for <kexec@archiver.kernel.org>; Wed, 16 Sep 2026 18:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Va42xDUxw3Ha13QgHOlSJnNxTf47U1kOlLIt+P89At4=; b=YyngIaC2fVHXHds2rlA9Ss20fL
	sDmk98+Z0jj7HSLIoUAXFAFYqfrZbsHmg1ytpE+q7Mdj0sR93eV4d0pO4DPKsex9ENAVqA96x5wlB
	xeJsTcVMBXdXfRMhCsrh60i6VXqveuDjth4WJR4cKCJVCepiRavnof2BHnFVe8UHyBmb5J0A0lmmK
	+XiDKR2BYw6SK5tKjc9hy3b5U6kX7HoObVJF8o/bmGL3VZV76lRCFpjGHDGNpZDfq9aPLmIBXUcid
	TZIEj8K+3zL5roe0wGtIjGvXZ0GqFeta2yfCxx2PClRhY5KwJOHHarV+Q3uG6saaSXJutCahT1pIC
	Yg9EFtwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6uJu-00000009xB9-3wfM;
	Wed, 16 Sep 2026 18:25:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6uJt-00000009xAt-3TrA
	for kexec@lists.infradead.org;
	Wed, 16 Sep 2026 18:25:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C4B4F43E53;
	Wed, 16 Sep 2026 18:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE651F000FF;
	Wed, 16 Sep 2026 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583119;
	bh=Va42xDUxw3Ha13QgHOlSJnNxTf47U1kOlLIt+P89At4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P2xA7D7zGPKwhboQgFoFmwpysEtGxI+V2h2GSj6IA/YgBa85bMaQLxzaFxULINGed
	 AEtc+voU6gqXMDlIskNI09FqisQhKRMmOWkHdE/pPbS4SJuP5YF0zkGANb07pGkKVP
	 qqfO/yR7DeItPjTJiYP+hYLH9jbp4YLqDtxavkvkfhVzgCWjsJYlV5//6kBpAC+Imm
	 BzUA36PrUrZwSPeHUiUOhw4Tvq9qAJ+G0AstgyZKggDzIiowzZ/GoYjNGP6iEhFzM4
	 4g4Q2Mc5YTibk/b+yFZDTdx+Uz5RgNDkfi244moTiPV8DsAQ1jLin/jFLYmuX5gUz8
	 OQPGZJUyOVkPg==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,  kexec@lists.infradead.org,
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
 Shrivastava <praan@google.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,  Vipin
 Sharma <vipinsh@google.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
In-Reply-To: <CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
	(David Matlack's message of "Wed, 16 Sep 2026 10:28:52 -0700")
References: <20260728221007.2098560-1-dmatlack@google.com>
	<20260728221007.2098560-4-dmatlack@google.com>
	<e099cbaf-3185-4c39-ae36-7f0e074ebff7@linux.dev>
	<CALzav=eX0gVrbWCnYGwfqPHUkoVxqdr2nw3Tx6Aqze0XOcuwzA@mail.gmail.com>
Date: Wed, 16 Sep 2026 20:25:12 +0200
Message-ID: <2vxzcxud6ol3.fsf@kernel.org>
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

> On Tue, Sep 15, 2026 at 8:31=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev>=
 wrote:
>> =E5=9C=A8 2026/7/28 15:09, David Matlack =E5=86=99=E9=81=93:
>
>> > CONFIG_64BIT is now required to enable CONFIG_PCI_LIVEUPDATE so that t=
he
>> > domain and bdf can be guaranteed to fit in an unsigned long and be used
>> > as the xarray key.
>
>> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> > index 3781e2b5f095..8af20f558086 100644
>> > --- a/drivers/pci/Kconfig
>> > +++ b/drivers/pci/Kconfig
>> > @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
>> >
>> >   config PCI_LIVEUPDATE
>> >       bool "PCI Live Update Support"
>> > -     depends on PCI && LIVEUPDATE
>> > +     depends on PCI && LIVEUPDATE && 64BIT
>>
>> One question about adding 64BIT to the dependency:
>>
>> As I understand it, enabling CONFIG_64BIT essentially means that we are
>> building a 64-bit kernel, and a 32-bit architecture cannot normally
>> enable CONFIG_64BIT.
>>
>> If that is the case, would depends on 64BIT be necessary here? Or is PCI
>> Live Update already inherently restricted to 64-bit architectures by the
>> existing LIVEUPDATE/architecture configuration, so that this dependency
>> would be redundant?
>>
>> If this problem has already discussed, I am very sorry about this.
>
> The necessity is that the PCI core needs to store more than 32-bits in
> the unsigned long xarray key (see the snippet above). The dependency
> on CONFIG_64BIT ensures that unsigned long is big enough. We could
> probably remove the dependency but I would rather wait until someone
> with a 32-bit build has a real use-case for using PCI_LIVEUPDATE
> before putting any effort into it.

KHO or live update themselves don't support 32-bit platforms and there
are no plans to do so either. So I don't think you even need to have a
dependency on 64BIT in PCI_LIVEUPDATE. Only 64 bit architectures define
ARCH_SUPPORTS_KEXEC_HANDOVER, so PCI_LIVEUPDATE and others indirectly
inherit the dependency.

If you'd like to be extra safe, then probably you should add a
dependency to 64BIT in KEXEC_HANDOVER directly. Though I think that can
be a separate patch independent from this series.

--=20
Regards,
Pratyush Yadav

