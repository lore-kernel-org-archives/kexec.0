Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3381CC6B0E
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Di8aE6KdoZOnEQFh34NIGAtRDEHWCfZKwuwkHlmj2kM=; b=mNH6hH/p/jCo+P8HvRE/ofr0iC
	/uPmLTGc7QteBPkQ0RXck5SWS1NYQLP/ZJ2ki6RPqKd0JcZEU7o7h6ow+oB872pTh5cWyACEPoLZO
	HdT+TsZj4K1E9qoazWc6OGTmzGZ9zqwYNYjm/jmQLMTyYyuKimiObQPe2sx+ox1BKtyu4s7ipnsGv
	pRQZ3b+9KbqjWSn8xBxkIgI0brlKH/r+jw0IBBNaZ7MGZVhqdlseFYLy8ahh9xSyO18Nyt3G2etiE
	RcztHmqVwUqOwyW7fBuM36C3sXwPEKhzHXKH6mLUrBI6pwqnPKjC1+i49krPbntf1reSOxcFQlHxg
	TrXbPD9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfo4-0000000Dbjq-1ekr;
	Tue, 13 Oct 2026 16:56:52 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfo1-0000000Dbj7-2etg
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:56:50 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2e836252e1dso26134765ad.3
        for <kexec@lists.infradead.org>; Tue, 13 Oct 2026 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791910609; x=1792515409; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Di8aE6KdoZOnEQFh34NIGAtRDEHWCfZKwuwkHlmj2kM=;
        b=n/T3dXY1oxOO2NWmfbi12PsDG4IMkgujfHcN/GNWeHVtKKmhiFuRcQQb6190Orwq5e
         79pq/QdLRIL0JjVKQVcXmxL+IYqbVR7rssixGpKa4RJ23X66xDvySGLCcno35Ygqfy8J
         0obfi50xmHl69D8VYTQsutXnDlMsj84Do6mbrgSiQI4l1qX3jaXnp0Z42ZyNXWZhbZpm
         GbAMmoBzS8s0gUMu0EvqJEto3zfq9t2c7x/27EXrILmmfbG1qo588WQ8Sq/q605IO8+z
         16EzLHA0Y720Dy8AwF5yt7rr4p81AMlPGDaXzo5P1AnhXn4dFwnz+bCKym3EVDznJht2
         Tf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910609; x=1792515409;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Di8aE6KdoZOnEQFh34NIGAtRDEHWCfZKwuwkHlmj2kM=;
        b=H42iISW5PDLClyakrkhueCh78t6+6G8Elvj5H9tBGMK6aDWu2nCl1OFDjFo1WyN9fT
         ZCE7q9ZRHWkqmUrglaUVc0cfYfIwIyik3CPCKEHDyab2Qbo7sGyrFEu/Ua+cuojjN3Qm
         WQGxiVdxbkPfvJAxT2QHuW1KouM1BpqR4blprCEOYZSDOMlikBM+nHRRlb5bBZ+jqSy+
         FMcV7WoNCZYmVCz+96Z2nmg41dsU/J7W/LYHKfu25t6x7AtBNg6zfwM7U9mzUa61fZAx
         qHtZ0+IzHEGbzL3ED8Z/KkpQmi7wLltVGmmOBjMXywSIe7dNCn7TZAP5u8BdaYlfKY5D
         Lg2g==
X-Gm-Message-State: AFq9FYKZyFFl3C85nGBUVIjw21s3eY/MjuLyaFo215LvyP2iDbXxjB1i
	CZyuvk168SSa44AFUZmcUj+O6o3SXWlvMOikpBAcLGycXuwP/OdK+kz8wc1XWSWtPA==
X-Gm-Gg: AYBFou2FGELJX1hn7g0seKjyiwCOUJKyJqMRbkPcbk9FEu1ohR5Lu+65S4w7m4VRvvF
	eztHKpe5CgquRtwFIQc0Cr3UpOg4uvI6LZYfdRlMjQx/w7BMTxhrQxQCayaOf0Q9Tikz41UeA8j
	0+zSruVJ7oCJ9GmFsPai5iu6TanUbjlFkZBxevmDzYIuq48XZH7EYAZZZFtfGIgp3ldb3jp2waK
	POPwomvnszVzg8lXCPgRuefgDd4zm+fs6K4cE/K6A8ZulUSOdXKXgQnFL/TwxQkBd72AojuLTUB
	5ZDxRHkBagN/KL71ulDbrMSlqKN3tX9axxB/G3brS5i4Wsj8bNcYCeb/ePcqLndyDMWX0w/D8QB
	4YfoaBEDXq2cbgTesXSnx04D3YNKNl8mxN90KzIQgoe6UmQYFS/yrw40Q4V2TeN6u2JV5c7kmE9
	6ZZUK+74q4KWFFwwFZNUqwCfKM48xnUBkTPDq46daX5aVlniE7M9+CHASANjxHIR1GKoUaDMWf7
	D9ULW8xq2vejAYx87K8afDFClK3x/hg48U=
X-Received: by 2002:a17:902:f612:b0:2e7:c821:3789 with SMTP id d9443c01a7336-2e842ce1b19mr106967855ad.43.1791910607036;
        Tue, 13 Oct 2026 09:56:47 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a04012sm60860835ad.1.2026.10.13.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:56:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:56:42 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kexec@lists.infradead.org, linux-pci@vger.kernel.org,
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <as5iyt9-8btokzCo@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-4-dmatlack@google.com>
 <sashiko-outbox-170133@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-170133@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_095649_690290_9630160A 
X-CRM114-Status: GOOD (  13.85  )
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

On 2026-10-13 04:40 PM, sashiko-bot@kernel.org wrote:
> > +    if (READ_ONCE(dev->liveupdate.incoming))
> > +        pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
>
> [Severity: High]
> Does this code risk silent memory corruption by only warning instead of
> panicking?
>
> When an incoming preserved device is destroyed, it is dropped from the
> kernel's resource tracking. However, the device may still be live and
> performing DMA if it was handed over by the previous kernel.

The device is not dropped from tracking. Its struct pci_dev_ser stays
in the incoming FLB with a non-zero refcount, so if the device is
enumerated again it is treated as incoming-preserved again, and if it
never finishes, pci_check_all_devices_finished() still catches it. Bus
numbers also cannot be reassigned, since the preserved upstream bridges
keep theirs.

As for MMIO resources such as BAR locations, they are not preserved
today. That will be handled in a future series.

> > +        pci_liveupdate_cleanup_device(dev);
>
> [Severity: High]
> Can an incoming preserved device that fails enumeration here cause a resource
> conflict?

A preserved device coming back with an unknown header type means the
hardware is probably broken. The PCI core cannot manage the device
either way, its state stays in the incoming FLB, and its upstream
bridges keep their bus numbers. I don't think it's necessary to panick
the entire host in this scenario.

