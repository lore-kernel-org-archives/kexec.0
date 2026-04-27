Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EFFFF8867
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4wM+QOtZ9yfNrPXhT14ztNpzNE+UB64YzKseERpnZeo=; b=J7q4hGxm6ip1M+VgbJJGYeBbdI
	rp3Ptmi2r0VRjlC0U1Qr7ZyJ6dx7I0Gpmr9cD5oBEiQBEXIc5bqe+LIBQF85wwiQpO4fZkwKHhEwX
	QWiNDXT+R/gB4XUX4Lwxy96l3FV7HSaA2ejnXWqYHcCRvEqVY6U/vHBt0p0UsWm19jjoY/ZLnQGW2
	r0FqQWT0VBWU9l1bEeohxP6iarz6FZSG5VQNISxLbq7DAnUo6oLxeZwUlbc3gUj1aphn+Wvm30/hL
	7omy3YLMao4sEVNGsv3CrZiaPKJzb3IO6qK39KAtq6lzf7P5RtRkSPlIQyLp6N+KmDld6l/aDZGfX
	pVzTrdFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHSlO-000000008Xm-1QvI;
	Mon, 27 Apr 2026 20:41:06 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHSlL-000000008XD-3zwj
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 20:41:05 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-35691a231a7so7107187a91.3
        for <kexec@lists.infradead.org>; Mon, 27 Apr 2026 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322463; x=1777927263; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wM+QOtZ9yfNrPXhT14ztNpzNE+UB64YzKseERpnZeo=;
        b=azBI2YtcLjyo5ia/qETLqAnetr6VicqXvvNE6vxLI0ditEJWHMDCvaARmc035W/Ed1
         ljpLEcCeOJfBxBynlM8ApNMQyqoaIDBnEOHEsagV2SILUQRcRdkCBBrLYSDGdMzMkH/Q
         Gfo1SE+/1L9oeA9OxY3Xems4cu2idyrQM+fqoorBXtcEBpIbHD+oxCS+o4P4qzuhxMom
         +6b/Whtn0ftsSxctv6iFR+LkIDkrHvc9+zm74eBRxiBAQnsJc2fGz2qxYtt2OXu14DT8
         hcYj+E0IqR6eF12zCPubDpqL/9JX9jDepAbRHFQNT1LblhxOj4EW/FCqhv+j3kKh4/0b
         W2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322463; x=1777927263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wM+QOtZ9yfNrPXhT14ztNpzNE+UB64YzKseERpnZeo=;
        b=ROv4T92bjuyl4tc29fBxVUYiFtz6qkTAgpLmsINcJtlX8JQ6NFNJKJ5buFRSyGAGsE
         H4vQwvtzg/68VQrnynC9ImYjTMorasgCuX9VWbsEnPZEaDpc06kVin/6NVy2nlrA0wtO
         vuEbeb41CvY5Loi8W7qCnYydEezZxzt9zaND+IDl+BHTHWAos6yN8LHGWIn11KlSkoCn
         29JH/MDmkzZ30+M2VngcjwcWATkxDUyOTeDm8pXOML3Vydv20/JH1syiHxIXblJVS0bE
         imKcEWDGXTB1aDwxXFFyVQoodn5ODrAxZ368sBL8s2s69agAkKDsE0Q5NkTyE/vaHwMN
         gVHg==
X-Forwarded-Encrypted: i=1; AFNElJ8psuh5+1zZlKOVy01jtLP+Ct5pevNQjZSTEM86lBlsJXpvwxI9h7JfA10sWQdCNvm5kbdWzA==@lists.infradead.org
X-Gm-Message-State: AOJu0YylnXwv0VQVMBPDtJ0dW407l2hiXwn9iJNd8YxLNNdKY0r/ojyg
	HvXYYuQ37aacMR19hpgIiv2Zy7U72uf2P1H0LNWfu2VVAduFtzwuNWUbXeaNYJ5KtA==
X-Gm-Gg: AeBDievDvnFz89b4UBwPK6IT7ioCItL+TEseUGiWPzgjNgtHV20YxVt0WN7Pxn8iW1x
	K6EAVgWNoYdGeDySqJKe93tU/Eqfv4pEQ2ID0TmH5Czdgjgbpw/Yvaz9GJIt0P9IuG73s/4DhFD
	U+yL/PeEwBLetQ3ZIO33tDAkVEXmY9WI7748k33bPS2QiOfN1xqcNIkafE8KzusINFzKUMI8r2x
	LcjSg8fL4scR56XYNDhhBMEYE+88xq1LkubluxDlaZDKUGD75hmekoIeDMyo3ID/wZ9ea94/mPj
	cmSiNly6XFenQ3OIyPwvbQhNkkKxIxSXcKOn895NvlpEEOLMsrR4opWqYkabrXJLmqstosKqMNN
	uluypueyMTUQvspx7h5AgEPItYmTPyK/ieUOBIjZ4nV3ouJ+MuCKut+WzOVBWp0JvWu72vWkD1A
	XNISA3KpcCcllDWWmPatsN7a/kajf3gki7PggaB3eoOfAmUkZTFZcQhFU4WvW57wXy0INVocVYx
	Q+HBXyRLeTfjtvc
X-Received: by 2002:a17:902:c412:b0:2ae:57e6:616c with SMTP id d9443c01a7336-2b97c3cba0cmr1478985ad.3.1777322462621;
        Mon, 27 Apr 2026 13:41:02 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97ac784c5sm3813795ad.45.2026.04.27.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 13:41:01 -0700 (PDT)
Date: Mon, 27 Apr 2026 20:40:58 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during
 Live Update
Message-ID: <ae_J2pRWFf5qjZXb@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-6-dmatlack@google.com>
 <20260427114745.00000656@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114745.00000656@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_134104_000705_481C2E44 
X-CRM114-Status: GOOD (  24.94  )
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

On 2026-04-27 11:47 AM, Jacob Pan wrote:
> On Thu, 23 Apr 2026 21:23:09 +0000
> David Matlack <dmatlack@google.com> wrote:

> > To keep things simple, inherit the secondary and subordinate bus
> > numbers on all bridges if any PCI devices were preserved (i.e. even
> > bridges without any downstream endpoints that were preserved). This
> > avoids accidentally assigning a bridge a new window that overlaps
> > with a preserved device that is downstream of a different bridge.
> > 
> > If a bridge is enumerated with a broken topology or has no bus numbers
> > set during a Live Update, refuse to assign it new bus numbers and
> > refuse to enumerate devices below it. This is a safety measure to
> > prevent topology conflicts.
> > 
> > Require that CONFIG_CARDBUS is not enabled to enable
> > CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> > bridges requires additional work but is not a priority at the moment.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>

> > +	/*
> > +	 * During a Live Update, preserved devices are allowed to
> > continue
> > +	 * performing memory transactions. The kernel must not
> > change the fabric
> > +	 * topology, including bus numbers, since that would require
> > disabling
> > +	 * and flushing any memory transactions first.
> > +	 *
> > +	 * To keep things simple, inherit the secondary and
> > subordinate bus
> > +	 * numbers on _all_ bridges if _any_ PCI devices were
> > preserved (i.e.
> > +	 * even bridges without any downstream endpoints that were
> > preserved).
> > +	 * This avoids accidentally assigning a bridge a new window
> > that
> > +	 * overlaps with a preserved device that is downstream of a
> > different
> > +	 * bridge.
> > +	 */
> > +	dev->liveupdate_inherit_buses = true;
> > +
> This flag never gets cleared after the incoming kernel boot up, what if
> the user does a manual rescan via sysfs? i.e.
> # echo 1 > /sys/bus/pci/rescan
> pcibios_assign_all_busses() will never gets called for this device, and
> may hit this
> 	if (dev->liveupdate_inherit_buses) {
> 		pci_err(dev, "Cannot reconfigure bridge during
> 		Live Update!\n");
> 
> So, maybe clear it in pci_liveupdate_finish()?

I think we can allo wa rescan to assign new bus numbers once all devices
go through pci_liveupdate_finish() by clearing
dev->liveupdate_inherit_buses on all devices in pci_flb_finish(). We
would need to hold pci_rescan_remove_lock to avoid this racing with such
a rescan.

Now that you bring up /sys/bus/pci/rescan... I think we also need to
set dev->liveupdate_inherit_buses in the outgoing kernel, to avoid bus
numbers changing on outgoing preserved devices. pci_flb_preserve()
should take pci_rescan_remove_lock and set dev->liveupdate_inherit_buses
on all devices, and pci_flb_unpreserve() should do the opposite.

If we did all then then /sys/bus/pci/rescan can work like normal as long
as no devices are preserved (incoming or outgoing). If any devices are
preserved then dev->liveupdate_inherit_buses gets set to prevent bus
numbers from changing during a possible rescan.

