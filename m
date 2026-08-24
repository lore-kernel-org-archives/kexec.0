Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE2CC5DF9C
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 20:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lbrx60MJW7m62aJUfR88Sv9pb7keNNeDEwmAMWLXqMY=; b=Ps5cClEGSkM6YkBkeQrWryWcvx
	ObDeqLduGIhbruazyepwm8EzhFHyCNqsjCJif8vtrDYmjD3pKDZ7yBqN0P4PxRHMvNawjMP2iuNwK
	+30Sl/jPInD1Ay0Q+rOCuEvD+hO5fuXvQLDG7qW5XhVMFKV3fmFDzujFbgROJKFZehoZSON0LJq8Z
	XJKU23Xeq6cMHcp3UTDqrJNAK1X6bK3SVrnyTDq8PIK5AyGeXW2X8i150CV1Qhg6oPEkX2C4m7TTM
	swkyWEUjiYs02BKsRW8yu+jDd6k4DjzKRRklm6ItX3tFmT0DY1jlIDkPc+ha3yNySGkiAtUlROIIn
	2qsmV02Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyb4M-0000000HLeM-0O40;
	Mon, 24 Aug 2026 20:14:58 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyb4I-0000000HLdt-1PDU
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 20:14:55 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2d3b445a84fso4685ad.1
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787602493; x=1788207293; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lbrx60MJW7m62aJUfR88Sv9pb7keNNeDEwmAMWLXqMY=;
        b=O7suQfafwfQMhkAUEmrhMJxAP3T9tOLXGjpVujsCrLhc0wK9AQUctM2vtGk+BnVzfN
         1K3JZAi/+Bsc5ev7pTC8q5oXOvRU4f+5p+7wdZtBT1LE/hsTaGgPePi3OLHru+GxHFA6
         A3WIKnKOc7W0ZY1M57f7tcqJF6L5GiYxbMoE9ch2isg2AmUxDrsWO6FFjE2ZraW12p7g
         HKklTbufaZMFQiisS37UirBvxgRbPBeqWOlp8D1z3fHvIwKjq4AuATsdC2s0uWI51szm
         XT8n2zqlqXk+enDJgzZD9d01p8ZUbxqvzxqEARsuQm8GkChhgR4KP/stp0piYOMZ1JoT
         jFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602493; x=1788207293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lbrx60MJW7m62aJUfR88Sv9pb7keNNeDEwmAMWLXqMY=;
        b=Wh3hp0HdmD0K7VmTs8T2IAKh4ppL89chAA+iVbZ9lgn/n2pE9oixBLaV0L4VvQhusS
         XQnp9hRU/aELRCVYwkOEiIl2BKnsbd97Bg09D+Voy93krUv1naoT372/jji0WpPJnhLE
         ElpREWiCdUImiImerLaYWEOFdeH3dKPagOnZmzbJt40iCwCn+cDDNh2s2ZDRadh1WYgd
         K9R6jY52kAAqs1bGufy0uz7qMNKY9EYflnaCfUWfOHL5wUkQw3M+DHOso7mmMFT8JY1D
         MDeLVFUP5a9jX2TOz34v6mU7g9SWlTQxS2k2MkpwLj1AeqPqREHDiisC8jvuDibxGugP
         rUow==
X-Gm-Message-State: AFuF++mObGtFhR8ESjOgP9xlb2GJ/GtrU/53JJX/iLB1VNhPaboq71qN
	jRjTZSAYCsjRUbWUsEfob9TYMOUnvP9IFRcBY9ePn/G60Crhjzm1ui4lLeyYLSs7HA==
X-Gm-Gg: AR+sD11sRbb//eNVszq2bYE3Tyj3kMtgJZ9nBb4vqDPT3R2AsorFjDvhJyhJPsajE2r
	DrSMPJ9+eulTlvdg+Jhr+Vq6azORE4fUg6czKC9qGyMJ9LrZvJ7ziFq4XfCCcuP2KzuWT8txzXg
	A4geSGWt3LKYA3L3yEy6/aCG1ykfYzvUo8FbU+mgGi3kJb7rWt9ucnu6Ie/3zHMhSu2pQZZY+Al
	AHmlu30nrCJ43vOsiycKqG2A+t5ra2xEnttvr772kJKsthGDrrhuHWD9pGdyQMTwxvwtxkGeBV+
	mRvb6gM6dHhwk0Xox/WmMg/iJmXpFKoIZYGV/p/6RlQE1CAMBBPU81yLTf64NlGU5pfgs49MsUm
	ssb9xMHSdkoeT98IPQpvQEIkmv60oeKxnZnKGwfTFfvunrnAJxiyjSiLa/VdLcmw+rkFO+qRZwT
	fLE8R/8qS8KKvX2b06kc5di33H9ziCXkdr3HSTlN0N4tOO6OR4Vsb2699huGSptFMi7bVyNV/Nx
	J2YxwuZME3IOHLPaUuRTRy0IPtkaUIE+EyHPPdSRbz1IF9ter6BLHDi2UE=
X-Received: by 2002:a17:902:f142:b0:2c0:defb:557e with SMTP id d9443c01a7336-2d6e07f52b9mr751815ad.1.1787602492814;
        Mon, 24 Aug 2026 13:14:52 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b49e76sm811208a91.6.2026.08.24.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:14:52 -0700 (PDT)
Date: Mon, 24 Aug 2026 20:14:49 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <aoymLetUiJPsqrfI@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_131454_376151_88F7B2F7 
X-CRM114-Status: GOOD (  12.28  )
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

On Tue, Jul 28, 2026 at 10:09:56PM +0000, David Matlack wrote:
>Add APIs to allow drivers to notify the PCI core of which devices are
>being preserved across a Live Update for the next kernel, i.e.
>"outgoing" devices.
>
>Drivers must notify the PCI core when devices are preserved so that the
>PCI core can update its FLB data (struct pci_ser) and track the list of
>outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
>device must be preserved across Live Update. pci_liveupdate_unpreserve()
>reverses this (cancels the preservation of the device).
>
>This tracking ensures the PCI core is fully aware of which devices may
>need special handling during shutdown and kexec, and so the list of
>preserved devices can be handed off to the next kernel.
>
>For now, the API only supports preserving non-VF devices on a root bus
>(not behind an PCI-to-PCI bridges).
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> drivers/pci/liveupdate.c       | 210 +++++++++++++++++++++++++++++++++
> drivers/pci/liveupdate.h       |  21 ++++
> drivers/pci/probe.c            |   2 +
> include/linux/pci.h            |   3 +
> include/linux/pci_liveupdate.h |  21 ++++
> 5 files changed, 257 insertions(+)
> create mode 100644 drivers/pci/liveupdate.h
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

