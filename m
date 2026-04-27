Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4EBFF8870
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=w/ZY/a428dOMEzZCQMPOjC/dr2v2uct5csHJwh7YqPM=; b=bG0m3+Z8Boso3q
	KdlmidcBsXv1evrbmaqe+EhYhMX5rXbpVIKA7/UITci+XmDH+CD/0YkgRoZgJ4+RXsYJzRfotHT6B
	55cMkpx3cJmpBNWWONvCMDUtaUZrVczJRQwRHRH572ot6bDKXXBLRc8K7RoupWhF4v7iAC+g4iDXZ
	XGEHQahYeSiei+WYFb4QBeepXlxZPNV0E/UoRUImzGiGvebjgnSfzCFKwBdKfGt5Bzz1Migr9kkTo
	PiDq+NQ/pkbyCUph9BL77rPn4w+qJhTxykgXnzUUKlVQ5VbAfuuzQLHbleR3hElTIC7eP7KeZzc4g
	iAlzaShrQ4zuDr3gg1fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTAy-00000000A6X-0zL2;
	Mon, 27 Apr 2026 21:07:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTAw-00000000A66-2y0l
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 21:07:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 28B4F60154;
	Mon, 27 Apr 2026 21:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5968C19425;
	Mon, 27 Apr 2026 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777324049;
	bh=eTCpxLZv7LpMubk8KJGg69LwpKjJ4rCvsaQuqSw9Ybs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YXALoBTZ96HEbK/in8Mcqf+FcEg3cZ5fOQmzXfQw8l37KdDHJKEmdE1SvjbZeiRUV
	 VjQLZPadaTR3oR6VVLBF0kc78fhKbe+XimUyJpt/bNLks1VVxuBNFtwP4Eey0qEitS
	 d5cnToMQIQCGp38txEqfX8AkS3c9uVTSLVP9ETBVw0YALt9UsN8VG7oBDzRgckokRb
	 tVJHOiw5mnG6eLdlPfV7lNskftueKD74BpFt5HaWzYuh4tsk9k1bgjN+gzC9jPc4vn
	 BLwseIuVEzRz0DUfkLvXU9vK1VX7WcRcJJ10fQd2yr6magkpA+cv8wcamZrmJjRPwO
	 QDO5vWHVk853w==
Date: Mon, 27 Apr 2026 16:07:28 -0500
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
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during
 Live Update
Message-ID: <20260427210728.GA186712@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-6-dmatlack@google.com>
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

On Thu, Apr 23, 2026 at 09:23:09PM +0000, David Matlack wrote:
> Inherit bus numbers from the previous kernel during a Live Update when
> one or more PCI devices are being preserved.

> +++ b/drivers/pci/liveupdate.c
> @@ -93,6 +93,19 @@
>   * bound to the correct driver. i.e. The PCI core does not protect against a
>   * device getting preserved by driver A in the outgoing kernel and then getting
>   * bound to driver B in the incoming kernel.
> + *
> + * BDF Stability
> + * =============
> + *
> + * The PCI core guarantees that incoming preserved devices can be identified by
> + * the same bus, device, and function numbers as prior to kexec. To accomplish
> + * this, the PCI core always inherits the secondary and subordinate bus numbers
> + * assigned to bridges during enumeration, rather than assigning new ones (the
> + * PCI core assumes that the previous kernel established a sane topology).
> + *
> + * If a misconfigured or unconfigured bridge is encountered during enumeration
> + * while there are incoming preserved devices, it's secondary and subordinate
> + * bus numbers will be cleared and devices below it will not be enumerated.

s/it's/its/

