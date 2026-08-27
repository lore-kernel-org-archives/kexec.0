Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24307C61DC4
	for <kexec@archiver.kernel.org>; Thu, 27 Aug 2026 21:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=tviM4X2nvvvLqMpeuQF9l7koJaDMsc88vWcy1La/8as=; b=OpZmvAoUyz5/t4
	Te9zciJD2urw6xLZ20esLvanHIkwv0fFZZkVe2dSYmbF56whHGo5dt11216L85G/95bCYYyOfyrxb
	4iWGe++/9Dh03+7qrkQbiSkDOuuJwsQ4sbuFryw0lXzSlY+g/ah1NGWDA+OEBKDCct+jfs4obEJYM
	VyjnYo3Spg9lHmJgfOcOF7H4ldrOphqvsw4uxyaDxn7nrT4dcTB0ARdUX22f/kaHnvvT9HUVQjX4R
	lwyPqlVoAW74UY55LKu+AoTLCFx2aUK+cY916fnpXdnZm2chYlrQDSxFjeOFQTAz8XQSjWgxedEam
	9oi8VfV9Ra7rVB+FlCIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzhwB-00000004pmI-2p3u;
	Thu, 27 Aug 2026 21:47:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzhw9-00000004pmA-26db
	for kexec@lists.infradead.org;
	Thu, 27 Aug 2026 21:47:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 73D58601EF;
	Thu, 27 Aug 2026 21:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5EB1F000E9;
	Thu, 27 Aug 2026 21:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787867224;
	bh=tviM4X2nvvvLqMpeuQF9l7koJaDMsc88vWcy1La/8as=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OOnm5D+NhalAr8wIMcxMKb6VaxdR7MfXZrVr6waUND5kQ2IBfnaKblstAaUWXsZHe
	 yJ58QN3mCNgHX47Xtk9I7+p8DaT5sTD+VexFUJkz29OKusmhRsdT9Y6VngaWiB8PbT
	 VpiDPdcqlswFHeb5OZtylVmAX7ZxuZ0XmxtgOBj5/zvvfW8SnDc8MfF2A76BSFlQle
	 7Z1/avFAPLYTtPBdj3MZUI7cVEn+IB1SGbyKfXlTbzHSrtPHSPgNLm2y8ENTkPGjnu
	 HGpV8OOhAKSF7sqEjYJ48iGCXGgk7gTdlk80vG0Yi5u6Ioi8YHNuzvyVkKeq9Z3Avi
	 OoCVbShyvHzKg==
Date: Thu, 27 Aug 2026 16:47:02 -0500
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
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260827214702.GA1636952@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-3-dmatlack@google.com>
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
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> 
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
> 
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so the list of
> preserved devices can be handed off to the next kernel.
> 
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind an PCI-to-PCI bridges).

s/an//

> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

