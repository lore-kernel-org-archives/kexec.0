Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708CDCA5FA2
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nVlRP8UBi3QSgtgc/PjPsjRl9sO+VgQnXuH3S8lXm6s=; b=aTRqjSPdOc6EX2fKzUj2KoqDaV
	7vU9uZpHk7DCzH/GWKB3yw0JrAU+FbBWjDg8xXQdvKzFyCRRy4HwFTXF/GWkBMjg2O3b0WxmxjCN1
	pGr16xOcGnyb/1PurPTQ8o1O+mzwxDXmWylnp4Txunu6G6OerpcazscCCxvzp963j4KtlnFLLEC0c
	ivc5JY0cENNZRRAzAyb5SLjQ7lsBJB4CT7ilgva2j5hLIFoDZwpwlCsmCX4SWEoDETqiSv1jbEpYU
	LkPWDxc5QVXQghX9oPe14cXFOg42crLRfZURuthE0nDJXUCz/iGWwibm9dzzgHHy06kdZSFMlxoiW
	alD4eatA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBEyA-000000017Xz-0nIk;
	Mon, 28 Sep 2026 17:16:50 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBEy8-000000017Xb-0NA1
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:16:49 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2db33db4de9so2745ad.0
        for <kexec@lists.infradead.org>; Mon, 28 Sep 2026 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790615807; x=1791220607; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nVlRP8UBi3QSgtgc/PjPsjRl9sO+VgQnXuH3S8lXm6s=;
        b=VSg96SybHEwkuPpFoGlxZXerMGRwA4vd5dDE5NgInpiBbbE9GD3XUOvmn4Op+u5C6D
         koomV8/Y3xWJ+NKzJKBczzET3yBehJCz65mJvtrqrqPsnFBJnmqsynDranyLFfx8Labv
         P07iMv9vShSTcuZQIAZRiJAp1fI8XDWX5oKP6guGhzmkrG5L37byJL2Pa7eiHq2XOJgC
         XwbhsnBjWOQJzgHbFaRNC8VhaPEEBPrY1Iy8dLDmMspQWrEssdEJUQ01sepomBr3fHz+
         Cfi7HUtu0Bm4+FWTtwtSW9Tz+5k0lPM59qtyrSFgB7XxDvwv7jMiXW3LrDI8dTrEbZ2s
         oqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615807; x=1791220607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nVlRP8UBi3QSgtgc/PjPsjRl9sO+VgQnXuH3S8lXm6s=;
        b=Rrd8X8goDuyZh+zvyS95xOSkO+rHH8kk8BEZsuNdcsE9crhzkDvtnixa2wP+QMNTiL
         YXHaO6QtdJAi+oLLsKWBU005znUTEUUxdR65PXLqesmpt90hmtebpK6tyTpH6PHa+XS0
         79C4/snIE8GrXSZBIpPEGCi0W/MHmHirWKcnKsCNO0kqBjJ6zO8dL1mnLSap+96BuqHi
         kBfuqmdGPGKlmxZFrsfz9bGtjXXvmPFVAlc50O5ZfhI+7Jp5Uv1MIRaPkESa8dM0YznL
         4/n6SsUohJs+f41HLyQtMRbCVcmvgxN1Mk/PI17ZB24VGxJLAYr0RuCbwXZt/MnvEcwT
         D8ig==
X-Gm-Message-State: AFq9FYK4IhLOC7Q6kIihycaocB41flc2hebkbQmFFldSA5exkULfJAXM
	Gm5kvLPKmuNPQvdzyFab+E00N6ZdYc6NOCSBkokjrD1VsFzH2zsz647McqfXXBcf9g==
X-Gm-Gg: AYBFou3aCgG/s86apyz+8dgeAFM/7xoS5m/Xly4no3HOOjGknHBhBUwCrfGEkJEMKgm
	dbJ1HKsTdxPjAJZuR/I8T0syVKAGDGLLsHc4jgrfFYbGqmlKwbsedz3aUpzgyuEhw/u0gzbwglC
	YTHGXwzwh6lNKxpcsKVCbxaN9GsNFE2bIGtdsBEDfkfgrp412kEG7XtMjzI8pUIcByx/uGNzzP4
	iXRm0fMXZ+hPDcwlKaaGo2xWs9LkFqHUhWP7QQJHL5Ty3L+wapZ+i/VneWCSH5jS+4Du8YjXN54
	UJuWg2FDTplbzfco7AOqGBFUSI+dsE+bciRizfxntW2yMtCW0uWxWX8AMt+dGUwmsM78XX5ObhT
	kwQ/30GSqHYI72EGUumfwRSvbpsTjR+D4ipP19WXuAcz4RQ9RWjAkGwk7b4QmcIOAbCO7Q59jz+
	HPH9Qdk0upG9z1QaV4UjmYyUygzWDnjl/eoC35deQGd/YInx/l4l13d5embs/XlMJBZtVcjk1ei
	oHuBzuUAt82v2RNjtk7wQeHYXymNcjhGwPn
X-Received: by 2002:a17:903:b48:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2dfa6194d00mr7813665ad.2.1790615806244;
        Mon, 28 Sep 2026 10:16:46 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497edd76dsm520284a91.7.2026.09.28.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:16:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:16:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
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
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 06/13] PCI: liveupdate: Preserve bus numbers during
 Live Update
Message-ID: <arqg9G8pXKPX8WCe@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-7-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-7-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_101648_137985_AE467554 
X-CRM114-Status: GOOD (  21.87  )
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

On Fri, Sep 18, 2026 at 08:06:32PM +0000, David Matlack wrote:
> Keep the secondary and subordinate bus numbers that the previous kernel
> programmed into bridges, rather than assigning new ones, if the previous
> kernel preserved any device across a Live Update. Do this even on
> architectures that would otherwise always assign bus numbers themselves,
> e.g. when pci=assign-busses is passed.
> 
> Preserved devices must be allowed to continue performing memory
> transactions across a Live Update, so the kernel cannot change the
> fabric topology. Changing the bus numbers of a bridge changes the
> RequesterIDs of the devices below it, which would require disabling and
> flushing any in-flight memory transactions first.
> 
> Apply the policy globally rather than only to the paths that contain
> preserved devices. Bus numbers have to be preserved above a preserved
> device anyway, since an upstream bridge cannot expand its window. A
> global policy matches the scope of pcibios_assign_all_busses(), and
> gives an answer that cannot change part way through the two passes of a
> bridge scan.
> 
> Bridges that do not have bus numbers are still assigned new ones, so
> hot-adding a bridge keeps working, both during and after a Live Update.
> The two-pass bridge scan guarantees such bridges are only assigned bus
> numbers above those already claimed by preserved bridges.
> 
> The exception is a bridge that was preserved but comes up without a
> valid bus number configuration, e.g. because it was reset during kexec.
> Refuse to assign it new bus numbers, since that would silently change
> the BDF of every preserved device in its hierarchy. Also refuse to
> assign bus numbers to the other bridges on the same bus, since the bus
> numbers of the failed bridge can no longer be read from hardware and
> handing them out would let an unrelated device inherit the BDF of a
> preserved device.
> 
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since preserving bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

