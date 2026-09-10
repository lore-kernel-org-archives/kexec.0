Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144AEC79FBB
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=yDpON0CfstrMMVvgyqFjuA8QunpXRg/nhloNK4nTqMA=; b=MfsmCqfEjnciNn
	qYb8B3d6JIa06HoUTuSe+ScarIRsxsumv1NXme9VoM17hss8AbBKOe/kcqs8VqKLldpFiqs0xhqFr
	wduy41QigK6gFH36GxsCvvNrOMPX+W4oqr/n/MHjyqP+H50Lv4jCQ3isTJHR2J/JDOb6YFBMD8R41
	eV67fiZ1/F0hS27wrBt1mqct+gUpOTpU6UdkiImm8cnPnSq4BV4/6HEn75Rsnp2brdhvpRC0EfHx+
	XfSGv45a04L+B4PO2DF++Nf+/HK5QMpT5upaRN3eaXc9PKXMvAOrHkM2hjmXFmy5ns25N1u19rS8P
	S6yE4BhU67zlyMTjqcRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oWm-0000000Fa7d-0Oge;
	Thu, 10 Sep 2026 23:50:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oWk-0000000Fa7U-0cvm
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 23:49:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D2CB6409AA;
	Thu, 10 Sep 2026 23:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC061F000FF;
	Thu, 10 Sep 2026 23:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084197;
	bh=yDpON0CfstrMMVvgyqFjuA8QunpXRg/nhloNK4nTqMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OcVJARaH6Oi1j8XuEcGXhNRaXpqRaKPdDm2jT1O9TnaIFERSfP65WUqSnVo8d7Fsi
	 dh2sMWmgUOA5sg70lpCN5y/sesey3628HvmXS2+yXCP+WzaYrtcsPy2swaFDr1S/ML
	 negKqmBZROzz0wR6IdBYzxXLm6h8Mw4vbquWhDRvx6hT8lpbnlJ+IStE46soZ9vToa
	 EueBn4XirkPG3SkFz5lg6BJroLl6uN4O1kefqRFehAWQEZGV5HVZRKUqBcxYTV3M8j
	 n6JshkcZkGKKcQM9+PwBnjcwWO266P762oW+Up/K12YE2Bp7Gz9q0zJzgTpG5K+UgN
	 UQEwHZB2IgRIw==
Date: Thu, 10 Sep 2026 18:49:56 -0500
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
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <20260910234956.GA367108@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-4-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:09:57PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
> 
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.

> + * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
> + * ``pci_liveupdate_preserve()``. i.e. A PCI device can be **outgoing**
> + * (preserved for next kernel) and **incoming** (preserved by previous kernel)

Thinking about how this will be rendered in the formatted doc, I think
"i.e." is really part of the sentence, so in U.S. usage this would be:

  ``pci_liveupdate_preserve()``, i.e., a PCI device can be ...

I understand British usage generally omits the comma after, so that's
OK too, but IIUC the first part of the sentence shouldn't be
terminated with a period, and the "A" shouldn't be capitalized as if
it's a new sentence.

Similar issue in "PCI: liveupdate: Document driver binding
responsibilities" later:

  bound to the correct driver. i.e. The PCI core does not protect ...

> +static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
> +{
> +	return (unsigned long)domain << 16 | bdf;
> +}

Add blank line.

>  static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
>  {

