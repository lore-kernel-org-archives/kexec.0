Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFE9C79FBB
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=c7OopUXEb/cYzDlfPWlrvtnzMRjL5zmzmrpAgsq/8e4=; b=e+6aWI8D+MVBp/
	a+HReL3SvlyJn1IXyGu4lOrmgcEPsRjuzFhxGJhn4hrzfYGfJwgIkYXghFALsiCHli6KjTuUir8zG
	CZ44Z2Lu2olTXbaIeInpRoktj9v9d4SlEbPaMGpxad35mWAFNL2mD2Pg28TQM6MRu3ZG9cc4oOwqT
	MTIpSztvVo4cmEOBoQh2hgTZHCV+TxXwD0XKIqQK6IQV955dpO4bYuJz81SrhwozXtzbTdIO5AYSc
	Q8dlLwurmsOUhc9gX0FJ1Fy3vi2Q+Z6NlAjvdLKOkgtm8/NpcitdG1An6j8xHL5nZdkWf56tf9olC
	WxUxKbcX3pRm9hhXJEnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oXF-0000000FaCt-0m5o;
	Thu, 10 Sep 2026 23:50:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4oXE-0000000FaCa-27Ng
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 23:50:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BD199601F1;
	Thu, 10 Sep 2026 23:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4762B1F000FF;
	Thu, 10 Sep 2026 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084227;
	bh=c7OopUXEb/cYzDlfPWlrvtnzMRjL5zmzmrpAgsq/8e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=SWvdIX1BHb3G2mc3DqyJOJjeon1cveuDPti+i3UgGtydjKjjIuLAZjugxNUQntTsi
	 k7tFsAfMxEDD74cLH2E2ATVZW0vSV7mAZi8xvAU2u/v2UxvgpL1SiJ9zaZfiPnkOwz
	 FlvYWyzKMnXsILexLoAROHTxfm7tg95B/q1KUSnYjg4TEInmOHalF/wvvi2ASprk1o
	 OXiwI6ZzjvtlQrp+guF0OjE8unAGgEOS6gN2HtwPZSxLM/IE4b+fN5mwOdiAeGLFyH
	 aMCTxt7YV/SH4HFLDZzz6tKLnsRLto5qr9a8Vh1Akv8a3F/OwlToXzlyvB6J85vUbQ
	 CbfiU/LHnbcNQ==
Date: Thu, 10 Sep 2026 18:50:26 -0500
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
Subject: Re: [PATCH v8 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Message-ID: <20260910235026.GA367309@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-5-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:09:58PM +0000, David Matlack wrote:
> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 5ce5f8b36902..0f7a018ddc66 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -71,6 +71,22 @@
>   *
>   *  * The device cannot be a Virtual Function (VF).
>   *  * The device cannot be behind a PCI-to-PCI bridge.
> + *
> + * Driver Binding
> + * ==============
> + *
> + * In the outgoing kernel, it is the driver's responsibility to ensure that it
> + * does not release a device between pci_liveupdate_preserve() and
> + * pci_liveupdate_unpreserve().

Possibly "the driver must ensure" or even "the driver must not
release ..."  Also could apply below.

> + * In the incoming kernel, it is the driver's responsibility to ensure that it
> + * does not release a preserved device between probe() and
> + * pci_liveupdate_finish().
> + *
> + * It is the user's responsibility to ensure that incoming preserved devices are
> + * bound to the correct driver. i.e. The PCI core does not protect against a
> + * device getting preserved by driver A in the outgoing kernel and then getting
> + * bound to driver B in the incoming kernel. This may change in the future.

Same "i.e." nit.

Not sure we need to be reminded that things may change in the future :)

