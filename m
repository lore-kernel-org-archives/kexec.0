Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1853C53209
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HkPvk2eUGVnaH519Z4bYiGg7FI/KZRoqTARHHR55Fmw=; b=ukseQZr1h3vLH2IAvOYpWSWsGJ
	r0qA6l5ildQkotqyLebN4z5mUqSXLMD4DkdDcJCGHJ/qEL0y70cV1/cuA/wpPcpCr0ypxKZbk3td+
	+MLNIzN4dG8Et0egarzCtDyA34Gg1QCIUP9pXYDx7xGZo6WLNLoSQ9ZklkVg7pnc8ACjMUU/niC72
	gHKTEX+khJnqNysCArCior+8uNA6I5OpotH6TBTE/yVtYBNLeYEVl+rWhsz/9darFernX8ZTNuq+l
	OZxrMEaanu9ykp+xpr5Qo3qOJRg0TUr5wHIJFW1QFARKoTcbXlWnbtZjj5u5qLdit7ifPZO2dV8m8
	RdaZW2HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPVh-00000003aeG-1OtO;
	Mon, 27 Jul 2026 17:53:05 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woPVf-00000003adW-1MgE
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 17:53:04 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84a2c90e383so148328b3a.0
        for <kexec@lists.infradead.org>; Mon, 27 Jul 2026 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785174782; x=1785779582; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HkPvk2eUGVnaH519Z4bYiGg7FI/KZRoqTARHHR55Fmw=;
        b=Zhn+6+u+bN3crsasg0BnCAw01pC7paoessX0E6ot8FQadTmj2ir4QeuA/AslroJOWV
         kpmYjDk5rqADXAN1zcamhbOQyXl/QYdkhZdotRHGY6c5+on5Ftgplq+8Z0k0xv2PWcdO
         wK7vU7CseM3HY+fPchzCckJf9/S35FGsr65gGjwNgYv849Ty1+lg4odMIhbPFAi2lSBC
         IJNNvB7tjhxZKiM+Lrdj8m13Z+xZqmtW8+flA5cMe/Zxkx3rFFVZzrTXXnvrsenv88UV
         cg4TDZP5rvKRiTSo9qwdBTvgWjbKws562spNoYuohFJCZ8vyLjqqfVyyMf9qK7QIJoGM
         zSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174782; x=1785779582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkPvk2eUGVnaH519Z4bYiGg7FI/KZRoqTARHHR55Fmw=;
        b=h2JWO4sGKUwKnbLe8fpKjzH3rtNgaWrcNHrFhyDCOxYIrSpHaDFTK1SgJoV6O/zgkT
         eauJKacuH8NMGmrlnI92LJdrITfoa2qCx2hrRwDRFa64AJM+B7ZO5vTIinFx4tMkE1kZ
         yRdi7zY06dgAIesj6n2pY8gi7lpI/zrsl7rHultj30ypIoI6M7RNswNM4Z4J0me3fM9D
         WO/VVlFLGRjQ2wDUNmaAV750zDCzsvhIT0F9Pd7EZ9HTDBgA2+DsVP33VYQSqO2p4R32
         FeVbIYJ2I0n813KEQTFHbmnRE7rxcNlsrANOGkDoP1CzXECgh+fE9kRgFZLmBcEwrmyv
         3Izg==
X-Gm-Message-State: AOJu0YyknTlyG/ZvV79KxUkVuVS+9zTynNxNLqvikXCrSA6IR/my9JDN
	mOkFZ7p4xImuVKkCnRu+F5Bi783HjVLy+YuBjb2FFRDBQISdg6ralo4Ck/sqWy+RWnlnTxPVKbt
	LxuN4gA==
X-Gm-Gg: AR+sD13ogKuUDwUT1XZyzGMQ5rFScoJrUJ3QUrhYwtD8X8T3gAkRMdE6Lk7IOkQH+YZ
	MskZ0oTwrONisuPKZwiGZjUJnADf2I3GzVtr4SsUsd0B4M4blyAxQYVnINSUmrRI1l259+iN7q1
	ZEt2BWlFVUVTQ5nMNqWycj22DC0lHCzzOBGcP1VrDd+DEPvdWGrxA1R4WgubwTHh+pxmY/+xffa
	vePIJrSr/wRnJtH6vVqNUGL85+aUTWJLfJiOVWeTpL+3l6MEUyJ6YgZGxOUbqz7xP4YtAoJOIj4
	5UkL0GJJo64uH481cXLFtrMNWSDCJZFWTaqGCwHl81ObvCBLblyWVq13E16Q5UwddthnTQwbbL0
	5qf6oU5XREnDM23j/dXhUtq+U1cw8hAGifYWsNB4lwsT5EiUJD807mjEDfMnY5pv3Fx7NolmE+b
	epCBvIgrnYM/u52z4OwF8+iOXTKdI2SrFpGFOvlxQm
X-Received: by 2002:a05:6a00:aa06:b0:84a:65fd:950a with SMTP id d2e1a72fcca58-84e8d3ab7b9mr351943b3a.29.1785174781958;
        Mon, 27 Jul 2026 10:53:01 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e532590bdsm3400120b3a.3.2026.07.27.10.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:53:01 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:52:57 +0000
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 00/12] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <amea-VLTnrO_WxnW@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_105303_368505_3CE89676 
X-CRM114-Status: GOOD (  20.04  )
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

On 2026-07-10 09:26 PM, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v7
> 
> This series introduces initial support in the PCI core for Live Update,
> enabling drivers to preserve PCI devices across a kexec-based kernel
> update without interrupting the device. This functionality is critical
> for minimizing downtime in environments where PCI devices (e.g., those
> assigned to VMs via VFIO) must continue operating or maintain state
> across a host kernel upgrade.
> 
> Specifically, this series allows preserved PCI devices to perform
> uninterrupted memory transactions (DMA) to/from system memory across a
> Live Update. These devices can be behind a bridge but must not be VFs.
> Support for P2P and VF preservation will be addressed in future series.

> David Matlack (12):
>   PCI: liveupdate: Set up FLB handler for the PCI core
>   PCI: liveupdate: Track outgoing preserved PCI devices
>   PCI: liveupdate: Track incoming preserved PCI devices
>   PCI: liveupdate: Document driver binding responsibilities
>   PCI: liveupdate: Keep bus numbers constant during Live Update
>   PCI: liveupdate: Auto-preserve upstream bridges across Live Update
>   PCI: Refactor matching logic for pci_dev_acs_ops
>   PCI: liveupdate: Inherit ACS flags in incoming preserved devices
>   PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
>   PCI: liveupdate: Freeze preservation status during shutdown
>   PCI: liveupdate: Do not disable bus mastering on preserved devices
>     during kexec
>   Documentation: PCI: Add documentation for Live Update
> 
>  Documentation/PCI/index.rst                   |   1 +
>  Documentation/PCI/liveupdate.rst              |  29 +
>  .../admin-guide/kernel-parameters.txt         |   6 +-
>  Documentation/core-api/liveupdate.rst         |   5 +
>  MAINTAINERS                                   |  15 +
>  drivers/pci/Kconfig                           |  15 +
>  drivers/pci/Makefile                          |   1 +
>  drivers/pci/liveupdate.c                      | 910 ++++++++++++++++++
>  drivers/pci/liveupdate.h                      |  68 ++
>  drivers/pci/pci-driver.c                      |   9 +-
>  drivers/pci/pci.c                             |  14 +-
>  drivers/pci/pci.h                             |   5 +
>  drivers/pci/probe.c                           |  22 +-
>  drivers/pci/quirks.c                          |  58 +-
>  include/linux/kho/abi/pci.h                   |  59 ++
>  include/linux/pci.h                           |   4 +
>  include/linux/pci_liveupdate.h                |  77 ++
>  17 files changed, 1260 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/PCI/liveupdate.rst
>  create mode 100644 drivers/pci/liveupdate.c
>  create mode 100644 drivers/pci/liveupdate.h
>  create mode 100644 include/linux/kho/abi/pci.h
>  create mode 100644 include/linux/pci_liveupdate.h

Bjorn,

Do you have a preference of whether to merge this series through
liveupdate.git or pci.git once it's ready? (Mike Rapoport asked if we
could make a decision on the merge plan.)

I am leaning toward liveupdate.git:

 1. There are some LUO core changes around how FLBs are refcounted in
    the next branch of liveupdate.git that this series depends on.

 2. We had previously agreed that the files covered by the PCI LIVE
    UPDATE maintainer entry would be merged through the liveupdate.git
    tree (which is the majority of this series), so this would be
    following that process.

    PCI LIVE UPDATE
    ...
    T:     git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
    F:     Documentation/PCI/liveupdate.rst
    F:     drivers/pci/liveupdate.c
    F:     drivers/pci/liveupdate.h
    F:     include/linux/kho/abi/pci.h
    F:     include/linux/pci_liveupdate.h

But if you prefer landing the initial series in pci.git I think we can
expose a stable branch in liveupdate.git to handle (1).

What would be your preference?

