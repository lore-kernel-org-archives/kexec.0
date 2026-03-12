Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EED106ACFC
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tuWxuj0biLq2l1xmhqHdX16m/kzH5EhGtvvF3ksAcvQ=; b=UTLNIOB2o9wagPNp+oQ3rIIGEI
	Cc5ItGuTtueARjU/eIo//ijuhrNEQ4NGDXEikLm5SfmNDWHLhx/tY3SwvErIdcjS6xNGvi4JxbPir
	tQmJ2b8sKtCp6zTEkcVcJalSCWsMGq8Xu1z1qpMeow6xmZtqvvxaW7PywWhs/Z991V9FZ3masqUX6
	pvoredraTYb/JZq2rVm7HaRtGHfdvpXC/1AmZxoC/+yKYPOc2yy4uTdiden0p/QGvbMcmgTRRgo7B
	dWvAaHDsntxX0S3qr5VWuh9U40gbnwiTBklgacTax7jbPKnrxk+0lsn3VC46xzOrIUKqjylXuzWff
	14sF1D+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0pdF-0000000Fnz9-0GKp;
	Thu, 12 Mar 2026 23:39:57 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0pdB-0000000FnyJ-46MV
	for kexec@lists.infradead.org;
	Thu, 12 Mar 2026 23:39:55 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1054063a91.1
        for <kexec@lists.infradead.org>; Thu, 12 Mar 2026 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773358792; x=1773963592; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuWxuj0biLq2l1xmhqHdX16m/kzH5EhGtvvF3ksAcvQ=;
        b=AAL+kjukxOVYsaHAhYb/m2R9gpTvFxe3NSuJ7usQani/EqRtZL7mlvALfRisKgEoqP
         ZSNLElrJJ1+/z9pnS3U/nzteMigVYCNGeOg6+x4ocMGGWTkrUbezd8oCGI1IgV3DApqk
         n10YRM96vs/0ItNbTpm3qrUXs08ymd7HrM/vnyK8Xscs4Bzcp/WnpcfmXtpt9hhTJlve
         FjzhD3M76/v83v/bUkGxdsXuoANZn5Ln3CfxRyMpgP7dHJTILIVL1JWEQP1n0bHBP6zP
         XcCCHIqAsO38lyELhYe+bJi8aREXhyfOPyzKmPw+zo5uOPGQcQPXteofXoarIl3+alh6
         IOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773358792; x=1773963592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuWxuj0biLq2l1xmhqHdX16m/kzH5EhGtvvF3ksAcvQ=;
        b=GFYuBNgyfAdPdIXEzRvfxgzjRaI4srvK0ODRSzTb8EYh4SkfW5KnCGLkakTweGsMlW
         Bd7boC6BWe9hKkyKxCaRJd77fLUuCYsu/kslxulxtEYBvNGqcPQFe0rSc6EYYEUPx+t3
         XCnOWWMLlGJlyFkgBZnU2mykIkTobwVnXFExGhyenXePQ7AIHvmePVsyn50pXu5onD6b
         IUJR17b5hRagRIQeLnknG5hWAn5+RFRoi6o7KOfjovF1gq0g6gmTwyAzSfivZDFUcWze
         542dFdiaDZGlnMPyKY4aQhMjq1RrwRMuWii2ie8tiH+GB88gWwKon1cLShX6zyu/f5Ue
         ou/A==
X-Forwarded-Encrypted: i=1; AJvYcCX8yLvu8R0PasGFWbXwAN8RvMdKP1LVBvSpHUNcpWKevnict5AWZEIt1dTyvG8XpCdblLdDYA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwceXN0zZ7g6ka0z3cXn9ZD/avNq4c446papPlxPUpDMHjlwxev
	/zf5VOzTY5UhAsL2b69T3ETzNyzWEng8yTiAZ67uHCZ16mgKH4mBK0JSh44IaS4sXQ==
X-Gm-Gg: ATEYQzxF39dMnf6w3q14gpe5D4CsY9zlKw1sSrP6afdr5GxgqH7Ok+T/+aZD3iY0xbj
	P0tXm878frdOSfkFcg8FIxqH1Hmjm/hTo82P1LIl06vJ6KPm+rZYCFY4R4RgF02+22VAQAlXSXD
	PrmfBCz5X9t7b76PtOqUa0hO1CvMK5in9J+KW8PpX9q0O/4HPRT7xALAP50sjsb/zV76Twnzo1F
	qtxArnoDruVcwxu8IiEHVgotNNVl99D+AwFlwvCziu+/wO7/0EXH1ScanfFumy3qOp5e+VUxB8E
	HbsbnvTY+3tR563dBSGuqkADNAPThteIuwTajBBjJguuGKLGcxEc6aR7T/27XSdgwaeVY565pLJ
	ZTw7pXEBsjxYhu55Z2pR6859hAK3XMZzj/DKAx/r3dLDxH2Xu8oTzVvIBLZEezXexTc5SGbYjzP
	r0tllqzEuLBGOshXVQ1Adh58FDRkKxJN56JwJ6+QT4SOF+MlYmPWyjQsDh36j0YA==
X-Received: by 2002:a17:90b:3d4b:b0:35a:117:9521 with SMTP id 98e67ed59e1d1-35a21fdb67bmr847337a91.10.1773358791623;
        Thu, 12 Mar 2026 16:39:51 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a03034401sm6609677a91.16.2026.03.12.16.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 16:39:49 -0700 (PDT)
Date: Thu, 12 Mar 2026 23:39:45 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <abNOwcOTXqxCxNzt@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_163954_023050_C6FE5FC6 
X-CRM114-Status: GOOD (  21.62  )
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

On 2026-03-09 10:32 AM, David Matlack wrote:
> On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:

> > Sorry if I don't have the whole model in my head yet, but is exposing
> > the restriction to the vfio user of the device sufficient to manage the
> > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > imposes the policy decision to decide what support is sufficient?
> 
> Hm.. good questions. I don't think we want userspace inspecting bits
> exposed by the kernel and trying to infer exactly what's being
> preserved and whether it's "good enough" to use. And such a UAPI would
> become tech debt once we finish development, I suspect.
> 
> A better approach would be to hide this support from userspace until
> we decide it is ready for production use-cases.
> 
> To enable development and testing, we can add an opt-in mechanism

Here is what I am trending towards sending in v3 as the opt-in mechanism:

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 1e82b44bda1a..770231554221 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
 config VFIO_PCI_DMABUF
        def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER

+config VFIO_PCI_LIVEUPDATE
+       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
+       depends on LIVEUPDATE && VFIO_PCI
+       help
+         Support for preserving devices bound to vfio-pci across a Live
+         Update. The eventual goal is that preserved devices can run
+         uninterrupted during a Live Update, including DMA to preserved
+         memory buffers and P2P. However there are many steps still needed to
+         achieve this, including:
+
+          - Preservation of iommufd files
+          - Preservation of IOMMU driver state
+          - Preservation of PCI state (BAR resources, device state, ...)
+          - Preservation of vfio-pci driver state
+
+         This option should only be enabled by developers working on
+         implementing this support. Once enough support has landed in the
+         kernel, this option will no longer be marked EXPERIMENTAL.
+
+         If you don't know what to do here, say N.
+
 source "drivers/vfio/pci/mlx5/Kconfig"

 source "drivers/vfio/pci/hisilicon/Kconfig"


