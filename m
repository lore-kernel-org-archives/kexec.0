Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A13F013FA
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=; b=sSogJdKJJyyPrGtFfhXrSevJmq
	FCnziqmnWV9mCaLkSS38hD1LI1DUQbrBP2arnR+Y9zj1m01bZrZ5oE0bn2v2QYCDHitVihxi8IIrK
	x4KOq4lnUh21x3Lez9LQNRsh5C6hItTEchP5XYerxiJfy/QrB40kBWgIrtFm8SU7LznqEVDe8x7IO
	GyRNQqfgzSBJqWCnaJRQvyQ8Raz1yRHjteWjIunZUhEJgCUXOni7i7BZscKyPHK0p0ugbXxxgkTQH
	dtQcsFh3/GUEopJkXAp+2Y0V+y+NaIprPVpS5kijjL5JtybTZuqC6M4wJ3Myp47L60765BqX7xjH5
	3+AbzGgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GD4-00000004zOv-2Ymc;
	Mon, 16 Mar 2026 22:14:50 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2GD2-00000004zO4-2suJ
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 22:14:49 +0000
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-59e4a04f059so5184976e87.2
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 15:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773699286; cv=none;
        d=google.com; s=arc-20240605;
        b=DdZL5EyCb+LGfS6q5+95A4n0A2n+/MnR0MpJiC8gRAdlvJde1L9iyRtQuP6as5E6nh
         OycfU8rn5XriUjCHLENYRZaCqF/hu5yNIYCQdTQsT52uhlQohLXWx0XU+UGYNv7iD8Dl
         VTpk5Jpy2e7Vm4QP2IYtpRUg1yL8WpTkTvsiNDKXlrIg4ydwBYh5wub1f9FGuAeSZT2A
         dUWbYjPVPeyFF7VItu8MT+v243QP5W7f7hy61OKY1CrMmlm1vo8Ft1EK3idkyOinyKK7
         A1a4AAralpq224//+UW9/0wFBJVy/xfOP94c3IU/Wy927VRDkt0nF0DENoZX21owjWYU
         NCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        fh=/oYXF0HCrylqkm5GiS9tERyBEjQdkFIOQt2cS9qwJ7Y=;
        b=dWOEHyJ+mM03sOvnRlM7238N+Wf/5LBNB/tmKaxdZoYY9gtYfCx1lk8+cqxj+/A1bg
         e2I5p0CyjgtNego0IQSAZ79rOYP/PXhFNVckxFRniq2aIxpMEy1sVvvpvOO7rhbDfPom
         N6i4AdaQ2BbvIuDmdycuiloG6NFvXWlT0zfBiIt84Fp/mLkZYj4Mkos58ZhidbncDR2i
         GRHHiL/dwkwEFc3IXNl8A1siks7oiS4B+7hJweGnFzb22doqB90oZp3ceVOpph6KZWFN
         81EL5Z/mDWAER9GQOQywdidYVqFthEkH9z3pK/dvuXjJEdid3qMXQ+2UcBcoGcCZtIDN
         SSOg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773699286; x=1774304086; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        b=ah78QzVvYbVOB1Eodt80cWzfIQD7z18xqB1raE9z1IyN624lg0AsQleopiPqip6rSf
         1KdMavuZ8JBBORRHB3NV+syh3EtkcuLdOtp6A54YILIkgL62Ra+P5YcGjGdbFHdJ/oCa
         +7kxlutefWe1ORsO6YMdACyiJRoSi2lX0OcQ4C7+BLpczwYakZ+4f/Iogac6B2qNuGJm
         ZYHTJzztkZSEGFRWKxbJdldV2G0xnUNotYTN0nD3rG2Z52kdNlpwNAVjmqux4B97LXpQ
         EjRZ5fdRk6+knz7pKxN7l2R/XmYayOHuy6miisAwQmmnfm7OPCbiAXMK+bhqSDk01atM
         FhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699286; x=1774304086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        b=JvlhbtJ+g9LSwYDDTGiNumMvmXkkbx3r3H8cOxhA8sIFiVf2lFm8zV+I+VpH/Y+6/C
         OPNO8XdccPh9PcamlkCLPjVr4iSxBeBx0q36PhH6fuXTS/VTvKe5E54C18OnJjaTePxX
         UXXW8f+UtDTuFOrP4ncucq+VgclZDXChl8n2cBKf26yzLiIwQjsxip7efh6by9q+8hkR
         Vq5iM4BXJc5hp6crvc9XuS5L+G+MS/hKbQoVCcWmvHd1o7Tgp4OwC9XqnltFeK+k/zC5
         IwOjRFQYH/XzObeYNjWHZwuiKlpAiHmsYchS9yCD8z2uquzrrYgQLzwFoUObt6cV/yV2
         /d/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3DtmrtkP8H5NMxiFyGaLQ5H9uw3zqt2ZI5UtaBMJsz8/YChQNr3tAQChN08lJVOhRdKcxtg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwgP782F0Kt2PkPUo024QpzBwvEiRdla0QhIq/K5pJRnevkgj0A
	iAEcq/VEaLBD18Byn6wG/nfrpCDe9F12taHKvHtoa343nS3Mbpt5LLVrrwTgj6CSckRIn4kFvbJ
	HTqdBYqfVKEMlQ1FDHmzT4bte+lNmhar2a0gcnmYT
X-Gm-Gg: ATEYQzzY0xhoMXtyF85FbUJhpvHKTAq9RDoTfMb14a/RLkW07XzknxedEOSqNX1VxxG
	recXH/qjVxTQQmX1mb1SyeGcpWQ9KoThddgEo9lZmRy+6NP85qHUfrR7Ccb0hakSsJvsFRLyqAm
	lpS+AFc6/T/ASplIvnEhg52vmw++zmJc2lShCzYQ1Z4Rf672G76gaQvLQMEcs7bS8XJ5qcjFvDo
	DBxR8yUMDhedmX0udSRuLnLzAk7SyALx1VMHZhEygO8ahwHko5C+w6gvR4aStzFxSDxLBDTiL6w
	5oS+JDCsbi4zZizkjak=
X-Received: by 2002:a05:6512:208e:b0:5a1:34d2:b6da with SMTP id
 2adb3069b0e04-5a162b0a440mr3032307e87.31.1773699285744; Mon, 16 Mar 2026
 15:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-11-dmatlack@google.com> <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com> <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260316160759.GA1767448.vipinsh@google.com>
 <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com> <20260316214055.GB1846904.vipinsh@google.com>
In-Reply-To: <20260316214055.GB1846904.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 15:14:18 -0700
X-Gm-Features: AaiRm50S3PNCrqX_TvZ1JiMZN8vQiYVbYC7Ez3YpAEpqzQo0lUEJ7c1xPn8zOqk
Message-ID: <CALzav=df8K0R0gJyQ=ifoznp_CMRRtyrWchbNvcw2-wpkdaBaQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
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
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_151448_815948_3B76004D 
X-CRM114-Status: GOOD (  50.71  )
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

On Mon, Mar 16, 2026 at 2:49=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Mon, Mar 16, 2026 at 10:18:22AM -0700, David Matlack wrote:
> > On Mon, Mar 16, 2026 at 9:22=E2=80=AFAM Vipin Sharma <vipinsh@google.co=
m> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > > > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > > > On Fri, Feb 27, 2026 at 9:57=E2=80=AFAM Alex Williamson <alex@sha=
zbot.org> wrote:
> > > >
> > > > > > Sorry if I don't have the whole model in my head yet, but is ex=
posing
> > > > > > the restriction to the vfio user of the device sufficient to ma=
nage the
> > > > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP =
pushes
> > > > > > the knowledge to QEMU... what does QEMU do with that knowledge?=
  Who
> > > > > > imposes the policy decision to decide what support is sufficien=
t?
> > > > >
> > > > > Hm.. good questions. I don't think we want userspace inspecting b=
its
> > > > > exposed by the kernel and trying to infer exactly what's being
> > > > > preserved and whether it's "good enough" to use. And such a UAPI =
would
> > > > > become tech debt once we finish development, I suspect.
> > > > >
> > > > > A better approach would be to hide this support from userspace un=
til
> > > > > we decide it is ready for production use-cases.
> > > > >
> > > > > To enable development and testing, we can add an opt-in mechanism
> > > >
> > > > Here is what I am trending towards sending in v3 as the opt-in mech=
anism:
> > > >
> > > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > > index 1e82b44bda1a..770231554221 100644
> > > > --- a/drivers/vfio/pci/Kconfig
> > > > +++ b/drivers/vfio/pci/Kconfig
> > > > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> > > >  config VFIO_PCI_DMABUF
> > > >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUF=
FER
> > > >
> > > > +config VFIO_PCI_LIVEUPDATE
> > > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > > +       depends on LIVEUPDATE && VFIO_PCI
> > > > +       help
> > > > +         Support for preserving devices bound to vfio-pci across a=
 Live
> > > > +         Update. The eventual goal is that preserved devices can r=
un
> > > > +         uninterrupted during a Live Update, including DMA to pres=
erved
> > > > +         memory buffers and P2P. However there are many steps stil=
l needed to
> > > > +         achieve this, including:
> > > > +
> > > > +          - Preservation of iommufd files
> > > > +          - Preservation of IOMMU driver state
> > > > +          - Preservation of PCI state (BAR resources, device state=
, ...)
> > > > +          - Preservation of vfio-pci driver state
> > > > +
> > > > +         This option should only be enabled by developers working =
on
> > > > +         implementing this support. Once enough support has landed=
 in the
> > > > +         kernel, this option will no longer be marked EXPERIMENTAL=
.
> > > > +
> > > > +         If you don't know what to do here, say N.
> > > > +
> > >
> > > To use VFIO liveupdate, user has to do at least two things:
> > > 1. Enable CONFIG_LIVEUPDATE
> > > 2. Pass VFIO FD to a live update session.
> > >
> > > This means someone using it has to know what live update is and
> > > intentionally pass the VFIO FDs. Isn't act of doing this itself an
> > > opt-in mechanism?
> >
> > If it is, then I can leave this out. Alex?
> >
> > My thinking was: Distros are free to enable LIVEUPDATE and use it. The
> > support it enables today is all fully functional (albeit new).
> > vfio-cdev, OTOH, is not. A separate Kconfig can help express that
> > difference.
> >
> > Consider that LIVEUPDATE could be enabled by default in a future
> > release, but vfio-cdev support might not be ready yet at that point.
>
> But that also requires point 2 above i.e. userspace explicitly passing
> VFIO FD to liveupdate. Unless there is a capability mechanism like KVM
> then userspace cannot know what is exactly supported.

Yes that is why I propose not exposing the support to userspace at all
until it is ready, by compiling it out of kernel via new Kconfig. This
way it does not get accidentally enabled in distros or downstream
kernels before it is ready.

> Also, users who
> are using these APIs will already be advanced users and have to know
> many details about what liveupdate supports or not.

VMMs will be the ones preserving VFIO cdev files. I think you are
suggesting they should know what versions of Linux support what kind
of preservation? Like QEMU would know that Linux 7.1-7.4 supports
partial VFIO preservation and 7.5+ supports fully? That does not sound
like a good situation to be in.

I think it's much better to hide the support behind Kconfig until its
ready. That way the PRESERVE_FD ioctl just fails on kernels that do
not fully support (because VFIO_PCI_LIVEUPDATE is not enabled), and
succeeds on kernels that do fully support.

If someone wants to enable and use VFIO_PCI_LIVEUPDATE while it is
still marked experimental, they're on their own.

> > > I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> > > about how userspace will know that sufficient VFIO support exists.
> >
> > I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
> > default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
> > "(EXPERIMENTAL)" from the option title. That would be how distros and
> > downstream users of the kernel know that sufficient support exists to
> > enable VFIO_PCI_LIVEUPDATE.
> >
> > > May be write in liveupdate documentation (PATCH 11 of this series) th=
at
> > > support is experimental?
> >
> > The documentation in patch 11 includes largely the same text that I
> > put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
> > "experimental" as well if that's what you're asking.
>
> Yeah, even though documentation do get stale but I think there is no
> better way in this scenario.

Ok will do.

