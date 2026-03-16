Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A07F53D72
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qInQBteouiFFrqfiLhXSZXU3zqWyev9a+m0PyBXHRjI=; b=u0ZRA/dL4plkjtXk6h8ohyhcMU
	dYJUNE3F2p5A/m3VnKJnAW4xIAfvxgohufFvS8HN8c7d2uC4AaYZ0puVVMYSgeQRMu1b8epY4E24i
	4hMkNlybfxu8G6c/fARZV9dW4C95BB1pCHHPOebyuiGFGW/ZX08ZarSAto5tclTx7iBkpBgvKXjXL
	HQrKbDdViNM1Tv38qTkQoVDtZ0lyd58UJfkpXArgpCk81PjepkmrLs96w1E3JvvWUpGb7qYoFbErr
	Jy8kOBcNtOXkF+r4ZhpgruPIhU3GgifJ+JywwVskTlsB8uSJw+3dE9fphap1vjEayVq1B8tOHGQG6
	78l1W1+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AiH-00000004Reu-3Yqh;
	Mon, 16 Mar 2026 16:22:41 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2AiF-00000004Rde-0Xcv
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 16:22:40 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so103645ad.0
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773678158; x=1774282958; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qInQBteouiFFrqfiLhXSZXU3zqWyev9a+m0PyBXHRjI=;
        b=N2+m2/gZ8etKs75nNgDimwsNIIV9sqOJeP7rE7HxzblspcONZGIdNMV+PDDwiKmn4Q
         1tWYFpBQqI3lLHF2tz2AS9ssZvIQxhSTToDE6lPPWakfuXn17ZGuCCIH1+AqxxACvXEc
         lDz0SSL6VdEtJDUsi05Ykubi5Sfskms+24PEN/BlB34xthPLaqo4iN6XBdpzM7e7zRmk
         lxeBuxQz2j3257DLPI4LfwVq2zlVn5GlHG+j+IkcF7GVUm4tT5vTkkWisLKfi6/jivv3
         Rz3gLd3Qq8W+nKfhyZpJWAX9pntpTXKgK8flwo2kn6Q41bMytPiCh3TDT+VDX/tRX6ul
         Jcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678158; x=1774282958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qInQBteouiFFrqfiLhXSZXU3zqWyev9a+m0PyBXHRjI=;
        b=FXUdn0+vMUbHbHEnF9bVhflrLHJZilAv6XdSItkiqZ6FHhv5uHxjMdclZpCLFDelkB
         IqDxS2zEnFjBZf03D+6+lX+exFfGDJ9pzPU/VINtGtwMAo2xtdrpPB6OXNzMsH/jTBCQ
         B52c/QmClkXN/ls8BU6X/yzIGrIx8e7JENfKKA6I9eWBdGcJZNDkNyr1PTyKwgOvL9Xr
         aFy+CkeIoyEuWOk/d+a59l2/X+fyJTVtDN40QoB6rAb+bNj26I/Pmae/f0/Oba0skykB
         /b3a3tfis0/iccjE+3uMQhLzvQRnQmps1llSX+VOClAHhyGb3kvQPBoo3w8W5K4b25xu
         DjBA==
X-Forwarded-Encrypted: i=1; AJvYcCXoK90rogpXTCC1F6hsHmY8roWP1bXFhaitWMOCCyW8p+8Q3P+wXNcTO7VcsHQDbExqFMfemw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwElntudAFYKXMzR49GB4/9CowfCHoGKAzoXmXI5kEWhq39uTIJ
	ApJ8Cs6H3WdbuQRiwu4jKrO00kEn/53W4Wy92nYmUYhBqM1CBJd8BPT0TCKJPondVA==
X-Gm-Gg: ATEYQzxp8cOCzn8++c0mP755dGpev2/jrvYUBGgwjwMgOLgzngM8EXI7yYlKFujep4k
	eFTifNxiMIAHQmK8N8Yoyey9sEf5aibKGaiWPHvfBdzYEDQlIPl8rZC55Ja41nJAx/UfwletjeN
	lC0MKvuyN7QbHCkXQal85PKJ3kVoA34aCeELWsifAXAlD5h/rT9GK3NMPApHAySYt1gSjhoXSCk
	E1rEaMT/kyg42I0fkhvWOYUoU6792WOycDyCfaxLwf7GMeE6jBvsM1Bh0vcDrdUAGhpjtJ+MbfW
	PlSxaIXriuIKGVAA6Cwi/VXoRqnuP4LD3NjNz67bUNyXWcOOgzUQsxC9u8pDoU18usQtAcopjbp
	iRcLDHkdHKPGshTKCm8Y9dzRc+RtZ/a6d/GPimtwjF9my3wUHdj7JqLbP92lPeohW4XNGD58QTN
	w7IlO/Igxv2WAWpeCdOiC+Q4ERDNXWatVQmcPABA5nYmevj72yYE7I6V8jpFEg
X-Received: by 2002:a17:902:c94d:b0:2ae:4572:50e8 with SMTP id d9443c01a7336-2b04208841fmr5460915ad.8.1773678157593;
        Mon, 16 Mar 2026 09:22:37 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada43329sm111822a91.6.2026.03.16.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:22:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:22:32 -0700
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
Message-ID: <20260316160759.GA1767448.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abNOwcOTXqxCxNzt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_092239_178402_751370EE 
X-CRM114-Status: GOOD (  29.47  )
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

On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> On 2026-03-09 10:32 AM, David Matlack wrote:
> > On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:
> 
> > > Sorry if I don't have the whole model in my head yet, but is exposing
> > > the restriction to the vfio user of the device sufficient to manage the
> > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > > imposes the policy decision to decide what support is sufficient?
> > 
> > Hm.. good questions. I don't think we want userspace inspecting bits
> > exposed by the kernel and trying to infer exactly what's being
> > preserved and whether it's "good enough" to use. And such a UAPI would
> > become tech debt once we finish development, I suspect.
> > 
> > A better approach would be to hide this support from userspace until
> > we decide it is ready for production use-cases.
> > 
> > To enable development and testing, we can add an opt-in mechanism
> 
> Here is what I am trending towards sending in v3 as the opt-in mechanism:
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 1e82b44bda1a..770231554221 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
>  config VFIO_PCI_DMABUF
>         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> 
> +config VFIO_PCI_LIVEUPDATE
> +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> +       depends on LIVEUPDATE && VFIO_PCI
> +       help
> +         Support for preserving devices bound to vfio-pci across a Live
> +         Update. The eventual goal is that preserved devices can run
> +         uninterrupted during a Live Update, including DMA to preserved
> +         memory buffers and P2P. However there are many steps still needed to
> +         achieve this, including:
> +
> +          - Preservation of iommufd files
> +          - Preservation of IOMMU driver state
> +          - Preservation of PCI state (BAR resources, device state, ...)
> +          - Preservation of vfio-pci driver state
> +
> +         This option should only be enabled by developers working on
> +         implementing this support. Once enough support has landed in the
> +         kernel, this option will no longer be marked EXPERIMENTAL.
> +
> +         If you don't know what to do here, say N.
> +

To use VFIO liveupdate, user has to do at least two things:
1. Enable CONFIG_LIVEUPDATE
2. Pass VFIO FD to a live update session.

This means someone using it has to know what live update is and
intentionally pass the VFIO FDs. Isn't act of doing this itself an
opt-in mechanism?

I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
about how userspace will know that sufficient VFIO support exists. May
be write in liveupdate documentation (PATCH 11 of this series) that
support is experimental?

