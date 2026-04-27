Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A129FF8867
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 21:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=NSfP7dnw2gP3DlZMyk6kvLJqbY+uoXgiA8d0A2mseMU=; b=eVl3VhDl/4nlIl
	ZT+ZaTpf6jSLBb7MN0J8ReK6gShDAH2Ykh+o4pMk358nA9pThomNTHozfQ5JCaJy6R6BaM36GKM4H
	zDsEwNvbIfUvEpX3ACVBzF+enrjBtQhkOYsNfsD3z01GKs8ID6FoDTwaf3HX7jIZ4oeMr8gwnfse6
	eYELmMl/qcI5Pf2bwP05rQzYC0lT0mCs9m2jHuRzAt16HZF1/MYGHEWBspqRJxCbhMhnU7gNVSoCu
	vtZVv3oKGlfy5WHju3QBofM5ZzN1B5uyyqnVRrk5xefmimaOFDP7BnVu1mNmoPuh3r3QvMhjZ9t9M
	jrW1mLnW2ZpvoZWr+mzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTAW-00000000A07-2nPX;
	Mon, 27 Apr 2026 21:07:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTAU-000000009zg-2tj2
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 21:07:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B55A40667;
	Mon, 27 Apr 2026 21:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11644C19425;
	Mon, 27 Apr 2026 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777324021;
	bh=Ji6QG+tICOp3jZRjVIPmRNoeZX3XNm+1s3nZGqpXmws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QFGNDaTGW9a6kdfYz+Q7sP5WR3ZkbzEL1ZCMz/x/Se8P+hqKd3UU21B0gzVx4pqBl
	 kykxyVYNOR7VMHGZ+ds/id+OC9sE4OJiDDrLvBJuAtwrEL/oYKUj25SReZiK63RWqV
	 zqLGHgGm4CQzNaDmqo+Ta83Ay0qv+7jcHNQkaY/6E5JQ9nFVjxzjC2iuYoPQaq1/27
	 0XleZbQtLDheHJpPJP0IVRsnCI+hQSiEFIetIZfoCYJn1sRQx3kn2wlhuvPKWYM0G1
	 nI8/zJ/fR1QDFe6OK/JGPNIwx73t5SJiu7g/Tn0MksDCYe357ycHL/XROhv+A4Hhfc
	 cSXQLsRyl3SJw==
Date: Mon, 27 Apr 2026 16:06:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
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
Subject: Re: [PATCH v4 03/11] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <20260427210658.GA186673@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-4-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_140702_749060_85FBA2E7 
X-CRM114-Status: GOOD (  10.94  )
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

On Thu, Apr 23, 2026 at 09:23:07PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.

> +++ b/drivers/pci/liveupdate.c

> +void pci_liveupdate_finish(struct pci_dev *dev)
> +{
> +	if (!dev->liveupdate_incoming) {
> +		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> +		return;
> +	}
> +
> +	pci_info(dev, "Device is finished participating in Live Update\n");
> +
> +	/*
> +	 * Drop the refcount so this device does not get treated as an incoming
> +	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> +	 * again becase the device is hot-plugged.

s/becase/because/

