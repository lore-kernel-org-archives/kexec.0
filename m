Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7370104891E
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WC3H5DEaZJ5Vspp5jAs+PxKz8E7K+Tp6LHW5IP31g2M=; b=OhmfHStRWSOnObzKzn8CHNNxzj
	AjJAOAmUhuEopOJLuUa6wda0VCq6z2Mq8tqgDWFY9XZJ8kjrpoHFxNrOp+j5y3hyzOqoFLMWhy9mX
	KR2U6L902EUf5nBld9j16Dv3c9YVVWLFr2RH/l86sb9whr1+hOGEk8jo2ib8Mwpko34qLt+yVkrVP
	dg+jE5fUQasD9XvHSFTHq/euJrgA1G3cNvwXYaKLDW4P2UHFUcfFt98zvcIxnXY4bmRH0pKThnIZR
	fXTVf2lIAL0v92k7blumfBMEydk+rO9s8mSDxLxhD/uTtU3unTuwRIxr1t7UwDVZhnnwaNl5n2lrY
	YeZnscfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6C2-00000009DL2-2cmM;
	Fri, 27 Feb 2026 22:20:18 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw6C0-00000009DKc-3rts
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 22:20:18 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-389e87e3452so33782301fa.3
        for <kexec@lists.infradead.org>; Fri, 27 Feb 2026 14:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772230815; cv=none;
        d=google.com; s=arc-20240605;
        b=KDuCDeeAGe3Ox2Jp16QEDVud8k7GqThDQeeBvL0Rfvv2BtORUMwVLJXsqW7fLzZ+Iq
         7P8I8flccpeCp2tKNksI0N1j0pA2QiKipHiRSxT6YYYEKl/77e3L7R5dm+Zz3rzTH57Z
         zOIvoN+i5ZQciyUtsiD2Yi41IGyWharanCPgzjKtx6dE3s/w1ywa8jGcQ5Ed/HBGZs2f
         rCW2RI3Pv2xTcwMRmxzz2hKRXRk4NGbt5Dyp+tD2CoSWxk38Z9PQTuBKjT/d8puhcma/
         G430JwMJ/glwtcwdKUa+wy48cWfFAnQyfoZgHDASzHY+fyLePptg3xXT0zLu5iv7iAPM
         gXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WC3H5DEaZJ5Vspp5jAs+PxKz8E7K+Tp6LHW5IP31g2M=;
        fh=9hO61hEItIRZKhRnczK0josXna3U368Y/j6KGJa46yI=;
        b=j8s+xUlcnQCO9nbnLZEm01kNBsH7ljYrfl4ONnzwhBe3CfXhQ/DfLnfoB6WvjqBEsv
         hlOnszYvuS1SrD5d0zBWuoxf2vy8eCZN1D6OzT3X8qZSy4HXDozPdxsd+VsxaZAYhsTl
         HU4nchGa5B9fsdZfde36uEHf1GI+WagOsPiY80mb9k2Hac9T5Xmr8G0Js/yIm8Hg8gIM
         PU0Wc124J92T7bSpxFFyjpUKiNGGnQodPk0+T8DWA2VKGhVnncBdKoVW11jKojK2wfVk
         +gLkb8xPjD9CrSxru3zoANv+wpHEPXs/6k7hkEmL1P39ZWqrfXj+kaEe/J3kDPYTO2VO
         g8aQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772230815; x=1772835615; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC3H5DEaZJ5Vspp5jAs+PxKz8E7K+Tp6LHW5IP31g2M=;
        b=JsjIY83ma+c876vPze5Pwj+0qPYDKYyl70ytgQwLYKo2WMpLHzhFQNC8tM3nlFCGdv
         916tj4xHBkyUCB0texQrR8BqvWeYRyUR++dl1LmAj56HHJT/JkhTcdgqYEq3aO9mz9Sn
         LsrkWldZzR94DPdNVwHLpAPHR/8YZYYomaaKP4XyqKFF45jD2uyubV5KIECkH85NaFjq
         RcIy3Dwd+5ChZVGD5hOWPvmKl/kfy6T0Q3K0LlN4f7x02zBi2BSee+lMUd0nhPDTofhC
         OCOiz1OElATG+inTlkIz3QNgczzoLbhXvGhMJFvJ6ECB+weHg0Q9qxMujxFF/c5sANqb
         4HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230815; x=1772835615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WC3H5DEaZJ5Vspp5jAs+PxKz8E7K+Tp6LHW5IP31g2M=;
        b=HjyP2c9ZPgTmEWFlufN1euSRjVk44hoNNm5yQ6x7WqrZpxAF76/f/K6kXyKpV4EQ4t
         4mbk7eMgkrI2dhLVCDc+1nbx5zQbpS4y05g1F8I5oUUEk1AQ0gGa/ldqbL+jR8I6OTvc
         vLqdyIiZwXxeD69EBnDe2p1xR47oI1oAQV/83Y3vf2orjSw+TRbmqXgJz027Y+OHtS5z
         A5VaC1GLy+mEJ/UojUqc2P+GdwLBGMVh2OD48jm2P6SrAcjk/xqedVrbwVmPN7ZXDO2G
         2Hab5b+d4fM9wm+i40rTTmhlEwesQMqDXLkDFFcnNy5/m7w5RIx3KX2g4lf30E+E1Zgd
         vazQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsh+XD72JJIgou+vJcVXEnAev1pJEWynWg0SKVOkl0s2lMKfEF7PufICiEWtKjU/65ph9M9g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0z84lS/LuM5d88e6Bqf+GvJ1k2RwCBs6FQLYkMOkHgvzwkybo
	jYjBKI0O/j6i+2RHC3wCTpEIGKr8JRMokvkOAKKR1ZlgVd3/LLu5TviYohSUPqyL1hS4MYQilOi
	PE+H/vAqHVS7fK5N8c9teHOIVormesikBUlyodsik
X-Gm-Gg: ATEYQzyZuZgbsRsAkMa7m7QiaO/YrmRex2SKtlCQSD8Dn8u18dOFAfedUV8Pe5sqcm8
	b/5tqNhcttUcLsdK4rBV89lECzPPUIdHBQ7lXWVULx+0oOP5DqtvrHD26kcGU8f3OilTLrFsHPP
	2HT+wLUcJOtp4cJElphYoMrAYJhtL83+FZe4bW0Jk2AwSW9/o4+0uKOH9QFF5CyDBM07VHxcr5K
	mMfy//XlE/Uq6unto7uuCy857TlVIi9UHIo4zhm6zMPQu2sHrlyEGFYzpIC59zzKvBACC0O4imC
	V133QFRbzVLf/vwn8A==
X-Received: by 2002:a2e:be9b:0:b0:389:fcc6:4923 with SMTP id
 38308e7fff4ca-389ff36c676mr32953561fa.36.1772230814172; Fri, 27 Feb 2026
 14:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
 <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com> <20260227112501.465e2a86@shazbot.org>
In-Reply-To: <20260227112501.465e2a86@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 14:19:45 -0800
X-Gm-Features: AaiRm50CpBktJDVkdNswfpkBixm1XqIc04gAiSgoLOF5-QNcfKrgPA3B04Dkoqw
Message-ID: <CALzav=egQgG-eHjrjpznGnyf-gpdErSUU_L8y82rbp5u=rQ83A@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_142017_030092_495A7F57 
X-CRM114-Status: GOOD (  37.70  )
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

On Fri, Feb 27, 2026 at 10:25=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Fri, 27 Feb 2026 09:19:28 -0800
> David Matlack <dmatlack@google.com> wrote:
>
> > On Fri, Feb 27, 2026 at 8:32=E2=80=AFAM Alex Williamson <alex@shazbot.o=
rg> wrote:
> > >
> > > On Thu, 26 Feb 2026 00:28:28 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> > > > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args *arg=
s)
> > > > > > +{
> > > > > > + struct pci_dev *dev =3D NULL;
> > > > > > + int max_nr_devices =3D 0;
> > > > > > + struct pci_ser *ser;
> > > > > > + unsigned long size;
> > > > > > +
> > > > > > + for_each_pci_dev(dev)
> > > > > > +         max_nr_devices++;
> > > > >
> > > > > How is this protected against hotplug?
> > > >
> > > > Pranjal raised this as well. Here was my reply:
> > > >
> > > > .  Yes, it's possible to run out space to preserve devices if devic=
es are
> > > > .  hot-plugged and then preserved. But I think it's better to defer
> > > > .  handling such a use-case exists (unless you see an obvious simpl=
e
> > > > .  solution). So far I am not seeing preserving hot-plugged devices
> > > > .  across Live Update as a high priority use-case to support.
> > > >
> > > > I am going to add a comment here in the next revision to clarify th=
at.
> > > > I will also add a comment clarifying why this code doesn't bother t=
o
> > > > account for VFs created after this call (preserving VFs are explici=
tly
> > > > disallowed to be preserved in this patch since they require additio=
nal
> > > > support).
> > >
> > > TBH, without SR-IOV support and some examples of in-kernel PF
> > > preservation in support of vfio-pci VFs, it seems like this only
> > > supports a very niche use case.
> >
> > The intent is to start by supporting a simple use-case and expand to
> > more complex scenarios over time, including preserving VFs. Full GPU
> > passthrough is common at cloud providers so even non-VF preservation
> > support is valuable.
> >
> > > I expect the majority of vfio-pci
> > > devices are VFs and I don't think we want to present a solution where
> > > the requirement is to move the PF driver to userspace.
> >
> > JasonG recommended the upstream support for VF preservation be limited
> > to cases where the PF is also bound to VFIO:
> >
> >   https://lore.kernel.org/lkml/20251003120358.GL3195829@ziepe.ca/
> >
> > Within Google we have a way to support in-kernel PF drivers but we are
> > trying to focus on simpler use-cases first upstream.
> >
> > > It's not clear,
> > > for example, how we can have vfio-pci variant drivers relying on
> > > in-kernel channels to PF drivers to support migration in this model.
> >
> > Agree this still needs to be fleshed out and designed. I think the
> > roadmap will be something like:
> >
> >  1. Get non-VF preservation working end-to-end (device fully preserved
> > and doing DMA continuously during Live Update).
> >  2. Extend to support VF preservation where the PF is also bound to vfi=
o-pci.
> >  3. (Maybe) Extend to support in-kernel PF drivers.
> >
> > This series is the first step of #1. I have line of sight to how #2
> > could work since it's all VFIO.
>
> Without 3, does this become a mainstream feature?

I do think there will be enough demand for (3) that it will be worth
doing. But I also think ordering the steps this way makes sense from
an iterative development point of view.

> There's obviously a knee jerk reaction that moving PF drivers into
> userspace is a means to circumvent the GPL that was evident at LPC,
> even if the real reason is "in-kernel is hard".
>
> Related to that, there's also not much difference between a userspace
> driver and an out-of-tree driver when it comes to adding in-kernel code
> for their specific support requirements.  Therefore, unless migration is
> entirely accomplished via a shared dmabuf between PF and VF,
> orchestrated through userspace, I'm not sure how we get to migration,
> making KHO vs migration a binary choice.  I have trouble seeing how
> that's a viable intermediate step.  Thanks,

What do you mean by "migration" in this context?

