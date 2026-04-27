Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BB0FF8864
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=nULIG7ClBBNI/AWIbW76qlekbMCSvE2pfN+/Fn6exkg=; b=n+b1NLPsX8ccaR
	rVtnZ2WZxNKsPaZ9+mKr9BrQC7XPkxgsHlZjKtXShCM0VgqzLWp9v0Bh4GvcnXJ9YdvhgE/yPNx66
	F41uamntV77SC+AommN4gEpV0rahfgqOMrQz5hwcF40oHPkBKkODQ2mQocHVBvplEwfF1SJVazkg6
	uykyHRrO2xRCUrH2Owaz3xsxPkm+Q6JCDE8iWANdTUi5k5SOU+WvA+6HGNopAyybHnqbWqPgRqOir
	CNs8BgILJ4sc/RhCOB25v9CX27UtxfnWRMvbjhfgafOcAQ+rQKubUQFJJQyYmaAwmTPMtMlk5ZdHk
	huLqUPGMkQxz/kRsK9LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTBT-00000000AAG-2a2Y;
	Mon, 27 Apr 2026 21:08:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHTBT-00000000AA8-04XK
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 21:08:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 76E9160139;
	Mon, 27 Apr 2026 21:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010B0C19425;
	Mon, 27 Apr 2026 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777324082;
	bh=HAhIww82BvlkJia3sROkCN1IHhF5mIbxG7w4f+smGgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FGEjjy4FAaFY3A5PuDOdwJ8Xj4EEJiA4g1yL5cIGR7Vn92lO9AV/7gQgs0RIJp88+
	 RSTByY/JniJOtzZ0Blkp+9wjKoA/q3uA/W4Os0CJ2ORUAWPdqd+ACdpKfo/pIUhQ/n
	 Qz/f5MkmYFlb4sXREbt/X0QQc7hmBvgosVjVBeM8qOrO81b8+/BOPDEXGa885+Ix5I
	 avII16tNuOj8GG1TOOxM4oUwXtc8+P8ELkjcrD4GHUMnMVFQWLd8ZhsTj4bKZOsp2d
	 akjmbU2gDr8yaabA9KPzS3D4e/OQNnGX3sOg3vJEwuK7mMSs6wnM/Ur/TEtpTvdF36
	 lF/CQTdsWnCAQ==
Date: Mon, 27 Apr 2026 16:08:01 -0500
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
Subject: Re: [PATCH v4 10/11] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <20260427210801.GA185338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-11-dmatlack@google.com>
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

On Thu, Apr 23, 2026 at 09:23:14PM +0000, David Matlack wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.

> +++ b/drivers/pci/liveupdate.c
> @@ -132,6 +132,10 @@
>   *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
>   *    preserved devices to ensure that all preserved devices on the bridge's
>   *    secondary bus are addressable after the Live Update.
> + *
> + *  * The PCI core does not disable bus mastering on outoing preserved devices
> + *    during kexec. This allows preserved devices to issue memory transactions

s/outoing/outgoing/

