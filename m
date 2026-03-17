Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F08FF6E97
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8R08fAS2L/TqkBdbNFXhbiB2wc1JFGzUh5S9wXtuww4=; b=iFWmU0Y48K2QPG5jsEWRAF0OZk
	yh9s9Lfb5j2ulbWSi2lBt3cJMhq0BLu/k8Qx5r8DaCeeGIpQvxCJl61g/aVmMV/wbYqyclP+tmtF0
	qNUF3fCj2tFGvYuQX/gOKEGGo7jcMgzo4k3wX2GKkXzEPQyVbH+02LrThERklm1vs0YrSWirYixPZ
	3qzIAtb4IyNmu7PM3ZqKbXw+ejGaAPsPqe9jIAYjz9elDt+FimDf4s/JVkvHYiwj7JrIIWhKY3KVG
	IqBoPjDc0FVLdD6j6Tfy7PS2+vHc3CbijzAcNJmUriJjbOr0fkngTnyOmUh1pOwnV3DxJ6btY9cD0
	hmmaTkcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dxp-00000007Sqq-3DI2;
	Tue, 17 Mar 2026 23:36:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dxl-00000007SqC-1KPM
	for kexec@bombadil.infradead.org;
	Tue, 17 Mar 2026 23:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8R08fAS2L/TqkBdbNFXhbiB2wc1JFGzUh5S9wXtuww4=; b=mLjd8mersMARlvadC/Uejsywrg
	qVLwNnrop4IZByxodzK+yKBNJueME+WQsSTRzZWd+5t9uMQ9bwRNp5nEYo2qVxs0W400NYZdtj51u
	mIuGJfZ20NMSouQBijzkMWMwjueqB0VnXoiWJX8hrrrvj3//PpH3R0ExXqpbtA7Wir3wTozbTVgYp
	9EUzHBulYSyJ4v8babWkPMifbkL7Ph+7KbQRozRvRI6Ew0zBYFrwPjJe1oNCVEDSfO9NNIICorlOd
	afTqemn9lqFee0XkCBrqIzwsAEQVEkuIkWaaz0EdGJWEV/YMFOP+QFzl8b5RcoB1W0G1xBLZMSG1r
	ZNndk9Jg==;
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2dxa-0000000A9wq-195N
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 23:36:32 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b052ec7176so20955ad.1
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773790583; x=1774395383; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8R08fAS2L/TqkBdbNFXhbiB2wc1JFGzUh5S9wXtuww4=;
        b=MaPmz7Cv9VxwTls5bjnp8A5zVL7UOurgEMFWEc8KiG+0TlzHp55ZkwqpEzQnKkh7vs
         xuCs40FvwLMCkcrasfdbHcaz4mwcPF1DgVeWCyFyVpEz1odPP3+q9/50w0oj+4ttAOOa
         XG//TMcCFlQYJfb3HmQ4fSI2XsKw9BpK4+s6bdcz+QKhXzF6ho3ihl1tY8RIXTfUhQkf
         /TMz84wvWvkZ4POfvP1t3C8NZYElvI/LOCEiLe4FOEncoyVfrLvq8daSiXIJT+eu2lYy
         JD+mmSuHd2sR0HAR1tWdKj575x1qF7NvINAZSTBuTPwf3QnrRIJBNJ7fENQ5IUHDEd0w
         dB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790583; x=1774395383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8R08fAS2L/TqkBdbNFXhbiB2wc1JFGzUh5S9wXtuww4=;
        b=XxPdkOknVN+mU5yCT6hJq2BEkABGIpxBQ4+Zt8nHlZGEr39s3aBHtcSuCVEA+LV3vG
         aXvp9Bc6tlKKUHAVNPNQFMIOrKpPg75bZYtp7X0QsIiHMIVbalBtp3rhRKLPp9/HRuhn
         +BK7NXbqHmvbX2sJ5Eeh2wpQqXpX4yyJm9nFppom1h7JGXL8/3jta8ctJYwQ9ZjEv+/l
         EDVgeE6xABQ7UmI1+U5sgQpC8/azfP2VNk316oVHGdI1ar8+IgMIDyOlGTnXi9jOqvPJ
         8LvhRTCCA7sPUbBxlv7C6LDu2KJavro6IAzgsysqcyvtFPXBICYE6qBGzaOqcFikBfRI
         EcYw==
X-Forwarded-Encrypted: i=1; AJvYcCUgIZn+ZSoYrl5e5AEKTozfygv9loZlwDP6hImrej9EAbQpbyYpaKzWx2mZnGUp+jbZL8/YdA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyYhLg4OkU3U4KQePkAjvje0AY05dq4MDnUuLdb06De5KkD8d3u
	7VGpyh9UTf4n+5NG8kaZojRL7y2bFhbmD5hz2jLo5YdGroiTBEeeidnbJzydFq1r3g==
X-Gm-Gg: ATEYQzw3wDSlotQcWTdb2DaqPRxYt2mVwqUptgen+oNlrGG9gXRH+aOXHLUTkhfomkZ
	RLy4AzG76SY50DJZqyobJWAy/QkJUNVNDk2b7grRcyHXYUG7Z/Ml6yKuz/OSPMkYhm7a6TqMOJu
	55HyGtyZXNDXuhgteBGuxLw/eR7Gas1uJr3oVjBMSKBP/hoeNkGbnEecjE1kVu/E7cXHASXpB72
	WypzPuVbxdg70ViQ7bTERTZ9BZwtNB6VcE3XOgdSPw1z9jS9w9xRtqnmVdXl430XnKuOQRh27uf
	OcVCcMZeFsZzD3GBjY5QWyDdkkmjvH497H/STteNsz40GFtw8hHAbFJWfxcIqWjNcYZYKXukl3p
	rM/aU9mJRji/KaYeP+CjjWUe0nQwHApcTXFExU2a1THJHW0pIn2ci9syw16p5p4OAgRfBmoze1x
	VO+kKdFizDAs5IYonlnpzKi5LLNA7F5tC+C6A74CPhS/iB8lAKnWzuI55PWA==
X-Received: by 2002:a17:903:22c7:b0:2ae:c566:bd99 with SMTP id d9443c01a7336-2b06e88a5f7mr1634235ad.22.1773790582361;
        Tue, 17 Mar 2026 16:36:22 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e629da3sm6015715ad.76.2026.03.17.16.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:36:21 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:36:17 -0700
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
Message-ID: <20260317232431.GA2795773.vipinsh@google.com>
References: <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
 <20260316160759.GA1767448.vipinsh@google.com>
 <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
 <20260316214055.GB1846904.vipinsh@google.com>
 <CALzav=df8K0R0gJyQ=ifoznp_CMRRtyrWchbNvcw2-wpkdaBaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=df8K0R0gJyQ=ifoznp_CMRRtyrWchbNvcw2-wpkdaBaQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_233626_917431_89E553EA 
X-CRM114-Status: GOOD (  47.97  )
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

On Mon, Mar 16, 2026 at 03:14:18PM -0700, David Matlack wrote:
> On Mon, Mar 16, 2026 at 2:49 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Mon, Mar 16, 2026 at 10:18:22AM -0700, David Matlack wrote:
> > > On Mon, Mar 16, 2026 at 9:22 AM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > > > > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > > > > On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:
> > > > >
> > > > > > > Sorry if I don't have the whole model in my head yet, but is exposing
> > > > > > > the restriction to the vfio user of the device sufficient to manage the
> > > > > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > > > > > > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > > > > > > imposes the policy decision to decide what support is sufficient?
> > > > > >
> > > > > > Hm.. good questions. I don't think we want userspace inspecting bits
> > > > > > exposed by the kernel and trying to infer exactly what's being
> > > > > > preserved and whether it's "good enough" to use. And such a UAPI would
> > > > > > become tech debt once we finish development, I suspect.
> > > > > >
> > > > > > A better approach would be to hide this support from userspace until
> > > > > > we decide it is ready for production use-cases.
> > > > > >
> > > > > > To enable development and testing, we can add an opt-in mechanism
> > > > >
> > > > > Here is what I am trending towards sending in v3 as the opt-in mechanism:
> > > > >
> > > > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > > > index 1e82b44bda1a..770231554221 100644
> > > > > --- a/drivers/vfio/pci/Kconfig
> > > > > +++ b/drivers/vfio/pci/Kconfig
> > > > > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> > > > >  config VFIO_PCI_DMABUF
> > > > >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> > > > >
> > > > > +config VFIO_PCI_LIVEUPDATE
> > > > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > > > +       depends on LIVEUPDATE && VFIO_PCI
> > > > > +       help
> > > > > +         Support for preserving devices bound to vfio-pci across a Live
> > > > > +         Update. The eventual goal is that preserved devices can run
> > > > > +         uninterrupted during a Live Update, including DMA to preserved
> > > > > +         memory buffers and P2P. However there are many steps still needed to
> > > > > +         achieve this, including:
> > > > > +
> > > > > +          - Preservation of iommufd files
> > > > > +          - Preservation of IOMMU driver state
> > > > > +          - Preservation of PCI state (BAR resources, device state, ...)
> > > > > +          - Preservation of vfio-pci driver state
> > > > > +
> > > > > +         This option should only be enabled by developers working on
> > > > > +         implementing this support. Once enough support has landed in the
> > > > > +         kernel, this option will no longer be marked EXPERIMENTAL.
> > > > > +
> > > > > +         If you don't know what to do here, say N.
> > > > > +
> > > >
> > > > To use VFIO liveupdate, user has to do at least two things:
> > > > 1. Enable CONFIG_LIVEUPDATE
> > > > 2. Pass VFIO FD to a live update session.
> > > >
> > > > This means someone using it has to know what live update is and
> > > > intentionally pass the VFIO FDs. Isn't act of doing this itself an
> > > > opt-in mechanism?
> > >
> > > If it is, then I can leave this out. Alex?
> > >
> > > My thinking was: Distros are free to enable LIVEUPDATE and use it. The
> > > support it enables today is all fully functional (albeit new).
> > > vfio-cdev, OTOH, is not. A separate Kconfig can help express that
> > > difference.
> > >
> > > Consider that LIVEUPDATE could be enabled by default in a future
> > > release, but vfio-cdev support might not be ready yet at that point.
> >
> > But that also requires point 2 above i.e. userspace explicitly passing
> > VFIO FD to liveupdate. Unless there is a capability mechanism like KVM
> > then userspace cannot know what is exactly supported.
> 
> Yes that is why I propose not exposing the support to userspace at all
> until it is ready, by compiling it out of kernel via new Kconfig. This
> way it does not get accidentally enabled in distros or downstream
> kernels before it is ready.
> 
> > Also, users who
> > are using these APIs will already be advanced users and have to know
> > many details about what liveupdate supports or not.
> 
> VMMs will be the ones preserving VFIO cdev files. I think you are
> suggesting they should know what versions of Linux support what kind
> of preservation? Like QEMU would know that Linux 7.1-7.4 supports
> partial VFIO preservation and 7.5+ supports fully? That does not sound
> like a good situation to be in.

I agree, for VMM its better to just assume it is a complete preservation
feature but it is an experimental code in kernel.

> 
> I think it's much better to hide the support behind Kconfig until its
> ready. That way the PRESERVE_FD ioctl just fails on kernels that do
> not fully support (because VFIO_PCI_LIVEUPDATE is not enabled), and
> succeeds on kernels that do fully support.
> 
> If someone wants to enable and use VFIO_PCI_LIVEUPDATE while it is
> still marked experimental, they're on their own.
> 

Sounds good. Thanks!

