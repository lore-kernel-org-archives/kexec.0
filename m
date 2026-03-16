Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FF0F013FA
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 21:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/8z1/dIhYqxHzj3/umwHNkEcO1PtVcvAJP18LcAQq1Y=; b=uvMMysaprWDpdzQrUe1RxTxuEI
	SxwbJc19c9OJZRhfB5IXHhIrO8DmhigLnWJXiXWSX+LFUV/o5bzO4fMqx/aDI35O/DGFxLglrOuAV
	eP4GZbW9GWgSelJQ2z52ZZMDRYGkjNIt+TlMrV88cFdaJsmjyKFIfKw1BU5ApikhnpyKoDtk8Bien
	6lGVKD/ynpgBADcrnWEK3AsawR0WoUU4mwFj5DJmrO8DS3DBXj8sj4femHUlADUgQSfk+RQ/Hsji9
	wyADlHkkLdVA4eFxSNTnf9v/WkW8HbYQG5a1wHWW6rfJpWrBzFWws04VGS/li8DKdr/X0sUdpytGe
	2Gi8Bawg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Fok-00000004xpI-4AKp;
	Mon, 16 Mar 2026 21:49:43 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Foi-00000004xoi-2ycj
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 21:49:41 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so28035ad.0
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773697780; x=1774302580; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8z1/dIhYqxHzj3/umwHNkEcO1PtVcvAJP18LcAQq1Y=;
        b=aurgiCLCz0g+6MEsPyfgu4GPB8/uuVhKJWxMWgZB1gEqra/NvFdt453fnJJ0o+vKIu
         qB9lA1JeRI0ImGP9ljv0QsigIOlOPH4wrbe2Gfxx7pVh3+zpuS8ZH5Vtv7A3Eiozn5p1
         DRYxR+JQror0of9VN0O/TIcpZxo4hSU1nSPi9YAiV/3MsJfhj+8+fQ9Pe1RcNVPsQT+v
         TAduGbJf4eEbbE+LB1q35F9h81q6M8exOsPiqKln4MN+M3gV0VoYW0tRvqfFSOFIFMzr
         hYZNcF2v/N2znAQuof1sPuDurCLBd6/eX4dRn8mUBW7JEpPnNYAXS31jL0USfWBH0YMj
         dPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697780; x=1774302580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8z1/dIhYqxHzj3/umwHNkEcO1PtVcvAJP18LcAQq1Y=;
        b=RjoAbuQG1qhBvVmeRMW7RjfHUMA6kXMSBwcJdXvEwwB8/x6FOKOt2ODD3ArfEzlWXH
         AomF7iGwwjqbYncUANz12yvLDV+uh8gxHQwL1gUzgfEOunpV+KiG45TkynKli8M+rXLD
         SOW+VpX4KsOLH7qqRSKIDlGXKoMtqEye1C59U6veFma+6hIlRb1q5RhDUpjYZFsV0ePB
         K7FKEoXOr193/Y+/qHmG5Nvqju5VdOdT6F+jFZ0TsCVDNvVH3+GKn4bGyrY3AWmUtAEU
         o0LGhby0ie0lSZ5/gESxJxUa+pz+Vf6MNER2c1oCRnwj+yPf+AgL5ng2YfTPIyDVrj/h
         YuNw==
X-Forwarded-Encrypted: i=1; AJvYcCWdUowQBq8YQlotWUgfh4O9TFi95AuMxgeMe03HjBxZtCIaowMN+oU/kCgC+5PoefryTj1bCA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwaIQXhmJMmY7Yx5DAJApzc7oaDz6vartKN+iAEqRNKXimPS2mU
	sDKvDILuHDJrYSe4yHxbhUNEz+iORFSqYfXTPkQ+FGXDyOBoCs8u1gvnmmgzkGbNeA==
X-Gm-Gg: ATEYQzzf0woyS4VNNXjwqFZjljsSvSLSI77r2Ff9FCOETR+6loxSEznSd+xxkCugU0S
	RvWAKLOTSVA5GJaD1u4l7Xzk4jqtHH6gElsti2RUimX5Tf/rjPs4v6oOWIoIobZtklJwBY72Ndc
	UbD9ss2mP64NW49d0tn+uNhm/Q86+w35XfDxKN6u3D3RePiOrqkqI+bAs2hmn79+2Rmv/jaJVTv
	Qew4p3c3nfevjmb4MD5g3hA4rKDtExUEDTZzXETZ6RK9RIGnrVwTMqNq0hBNWgwsxNMFVKmQlO/
	fbxfxZPFcWZ3lrxQVTe5koCoyL7grSOVqBpU0SIhQwcHn0XiwujPgymfV7/jUn1GAWcFs5E/BQo
	qiSEE4qPX1wyLsRcHzMnLW/k57uRD11witKvwn5lw4c4gQf3xfAxXMh+8oMAjIWDyQUoqxdSx4V
	QntRU7MnqIGvJ9OAvLjOcZ1GWMR0ATojp1t8H6qlDvwVSC/rdFWZVwLzZaB/5L
X-Received: by 2002:a17:903:98b:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2b06402f49emr1238925ad.12.1773697779367;
        Mon, 16 Mar 2026 14:49:39 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365b22sm14359627b3a.45.2026.03.16.14.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:49:38 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:49:34 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260316214055.GB1846904.vipinsh@google.com>
References: <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
 <20260316160759.GA1767448.vipinsh@google.com>
 <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_144940_756741_1B91B05F 
X-CRM114-Status: GOOD (  43.82  )
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

On Mon, Mar 16, 2026 at 10:18:22AM -0700, David Matlack wrote:
> On Mon, Mar 16, 2026 at 9:22 AM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > > On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:
> > >
> > > > > Sorry if I don't have the whole model in my head yet, but is exposing
> > > > > the restriction to the vfio user of the device sufficient to manage the
> > > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > > > > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > > > > imposes the policy decision to decide what support is sufficient?
> > > >
> > > > Hm.. good questions. I don't think we want userspace inspecting bits
> > > > exposed by the kernel and trying to infer exactly what's being
> > > > preserved and whether it's "good enough" to use. And such a UAPI would
> > > > become tech debt once we finish development, I suspect.
> > > >
> > > > A better approach would be to hide this support from userspace until
> > > > we decide it is ready for production use-cases.
> > > >
> > > > To enable development and testing, we can add an opt-in mechanism
> > >
> > > Here is what I am trending towards sending in v3 as the opt-in mechanism:
> > >
> > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > index 1e82b44bda1a..770231554221 100644
> > > --- a/drivers/vfio/pci/Kconfig
> > > +++ b/drivers/vfio/pci/Kconfig
> > > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> > >  config VFIO_PCI_DMABUF
> > >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> > >
> > > +config VFIO_PCI_LIVEUPDATE
> > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > +       depends on LIVEUPDATE && VFIO_PCI
> > > +       help
> > > +         Support for preserving devices bound to vfio-pci across a Live
> > > +         Update. The eventual goal is that preserved devices can run
> > > +         uninterrupted during a Live Update, including DMA to preserved
> > > +         memory buffers and P2P. However there are many steps still needed to
> > > +         achieve this, including:
> > > +
> > > +          - Preservation of iommufd files
> > > +          - Preservation of IOMMU driver state
> > > +          - Preservation of PCI state (BAR resources, device state, ...)
> > > +          - Preservation of vfio-pci driver state
> > > +
> > > +         This option should only be enabled by developers working on
> > > +         implementing this support. Once enough support has landed in the
> > > +         kernel, this option will no longer be marked EXPERIMENTAL.
> > > +
> > > +         If you don't know what to do here, say N.
> > > +
> >
> > To use VFIO liveupdate, user has to do at least two things:
> > 1. Enable CONFIG_LIVEUPDATE
> > 2. Pass VFIO FD to a live update session.
> >
> > This means someone using it has to know what live update is and
> > intentionally pass the VFIO FDs. Isn't act of doing this itself an
> > opt-in mechanism?
> 
> If it is, then I can leave this out. Alex?
> 
> My thinking was: Distros are free to enable LIVEUPDATE and use it. The
> support it enables today is all fully functional (albeit new).
> vfio-cdev, OTOH, is not. A separate Kconfig can help express that
> difference.
> 
> Consider that LIVEUPDATE could be enabled by default in a future
> release, but vfio-cdev support might not be ready yet at that point.

But that also requires point 2 above i.e. userspace explicitly passing
VFIO FD to liveupdate. Unless there is a capability mechanism like KVM
then userspace cannot know what is exactly supported. Also, users who
are using these APIs will already be advanced users and have to know
many details about what liveupdate supports or not.

> 
> > I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> > about how userspace will know that sufficient VFIO support exists.
> 
> I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
> default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
> "(EXPERIMENTAL)" from the option title. That would be how distros and
> downstream users of the kernel know that sufficient support exists to
> enable VFIO_PCI_LIVEUPDATE.
> 
> > May be write in liveupdate documentation (PATCH 11 of this series) that
> > support is experimental?
> 
> The documentation in patch 11 includes largely the same text that I
> put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
> "experimental" as well if that's what you're asking.

Yeah, even though documentation do get stale but I think there is no
better way in this scenario.


