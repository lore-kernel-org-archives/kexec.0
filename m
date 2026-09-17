Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73822C982CC
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=/I018ClHfzUNPJt0+qMbQoq+P+RBASppZEIurBOx0D0=; b=eagt5jftpZlcNV
	WmUzTK4YM12PQsV6rwi5VjGrIJaIBX+gCN2b3fECj0fTUYbQtAnmxni+WnfRJTqKKRDbkaLxIef8p
	Y9W+kJKuRXpmiyV3Ws3vDdByddSAGAKGSyoaHivfLEY+nCL91Wq3vG9lnAtaQOKDReWbYwPVvKT//
	dT1WcBNoi5/ir0b4UtS43xqQQ5i/3U3ep7XKJ2aDfv5JU0EdOzV8eq29dXSlp8uiE6rpfec7cUj0h
	tQ2I1ZJMJTbN7+FLiB/pPJu7UxBPzB2PvwVlB77PDSXigtZ9fGD05NytbpPz2Rk7ANktuLzuT8afL
	1aozTICssBFUvfkLkz5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6zpz-0000000AJvT-0sGT;
	Thu, 17 Sep 2026 00:18:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6zpx-0000000AJvF-2cO4
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 00:18:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A40440F10;
	Thu, 17 Sep 2026 00:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E5E1F000FF;
	Thu, 17 Sep 2026 00:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604329;
	bh=/I018ClHfzUNPJt0+qMbQoq+P+RBASppZEIurBOx0D0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hTCcc2OpdJ9QTJ/43CxwpgjFBxFkI1cBuFOCVvg+DW5lqQhReL4g6HpYm8MA+Yd+s
	 cEtp/gYcnSUCGp5wIg8UPM53pGwTfoPcpJRGcQQhWUlDWh2mDLElt8OzdzQzRaToHm
	 1WyHFD0e2UTg0HfnN6aX3wx5uL8+aUjuxmypfEz9bjjjRFX4J0v7Hv2ZS0P9OD7CJz
	 i4SQqmEylvwEMl9RubLczb7y5qvyXOJLBmta4HxuXXhlP8A0tpNQL00gzGAIw52HOv
	 UcyiTOvMxjRzAkCubtbbwYMqr6Ras8/HJf6uPvXYP5hDxatNQMRSFkQQG3nbiv4bgz
	 AtstkzNaGBXEA==
Date: Wed, 16 Sep 2026 19:18:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <20260917001847.GA993118@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQzmvgILmU8F4TR@google.com>
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

On Fri, Sep 11, 2026 at 05:00:10PM +0000, David Matlack wrote:
> On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> > > When a PCI device is preserved across a Live Update, all of its upstream
> > > bridges up to the root port must also be preserved. This enables the PCI
> > > core and any drivers bound to the bridges to manage bridges correctly
> > > across a Live Update.
> > > 
> > > Notably, this will be used in subsequent commits to ensure that
> > > preserved devices can continue performing memory transactions without a
> > > disruption or change in routing.
> > > 
> > > To preserve bridges, the PCI core tracks the number of downstream
> > > devices preserved under each bridge using a reference count in struct
> > > pci_dev_ser. This allows a bridge to remain preserved until all its
> > > downstream preserved devices are unpreserved or finish their
> > > participation in the Live Update.
> > 
> > This seems to hint that we're going to allow bridge reconfiguration in
> > some cases, e.g., for hot-adds.  The simplest case is "leave config of
> > all bridges the same", and I thought that was what the previous patch
> > commit log said.
> > 
> > What's the benefit added by this patch?
> 
> It is used in the following patches:
> 
>  PCI: liveupdate: Adopt ACS controls in incoming preserved devices
>  PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
>  PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec
> 
> to preserve certain configuration on bridges that have downstream
> endpoints that are being preserved. To support P2PDMA we will also have
> to preserve bridge memory windows (future series).
> 
> If we are ok with applying those policies to all bridges on the system
> whenever one or more endpoints anywhere on the system are being
> preserved, then I agree we don't need this patch. But I thought it would
> be cleaner to track things per-device.

Yes, I agree tracking it per-device is good.  I was looking for a
traversal upstream to increment refcounts on bridges, and I guess that
happens via for_each_pci_dev_in_path() in pci_liveupdate_preserve().

The actual refcount still confuses me a bit (see
https://lore.kernel.org/all/20260917000723.GA992337@bhelgaas).  Maybe
it would help if pci_liveupdate_preserve_device() alloc the dev_ser
*first* (right after all the bail-out checks)?  I wonder if the
refcount increment could then happen in exactly one place, separated
from the one-time dev_ser housekeeping?  E.g., something like:

  if (!dev->liveupdate.outgoing) {
    dev_ser = pci_flb_alloc_dev_ser(outgoing);
    ...
    dev->liveupdate.outgoing = dev_ser;
  }

  dev->liveupdate.outgoing->refcount++;

