Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C879C531D0
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=jt33XZg6IakrXoUrAEnJIibUYgZUlDskKhuW4fOU1xM=; b=y9O+FwUTrpPY5d
	EjPP1e8WLNf/eEs8Y1IO5+R16u1v6fHRKaugOhm6CUdAyme2eWf67VSENO/I9GfuY6m8bfit4HTxY
	tUHyjszv4zoshSg+KscIGZpWoICnH/jxWWaI1W7T/+O/NQVojciw/bhy8pFLsvFFC9PuLC6R3BfCN
	ExyjzbTVl09RMHNCOsqiwetK8pMgf7VzQkLJLMnlWfNk40PAEMaz2u5jMAHohsUd29qPCwZhKxO/h
	t8cNq+68gSzZ5+TE8RK6L8nOV+HV/I0PJuIEMrEo+X1998T9GCAZ6//LhwuTUy/gfK/X1XM+uQd4i
	SZPWPkE7Rwn+4YFfT1BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn1mv-0000000FCHT-48x9;
	Thu, 23 Jul 2026 22:21:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn1mu-0000000FCHB-2g7q
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 22:21:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A50043C2D;
	Thu, 23 Jul 2026 22:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CD81F000E9;
	Thu, 23 Jul 2026 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845267;
	bh=jt33XZg6IakrXoUrAEnJIibUYgZUlDskKhuW4fOU1xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=I6oI+1WvIphSqo2SuYZlr+Z760iGzSCqCOqo1O52QXp0AQt4DpnWOjisJa4Dl9+HO
	 JERVpACfEtCncGeO3ANxpi2GaBQ94g9U/b+m2LChVg+v8C7Jj96R4FEHQemOqnV1df
	 gF8XJ3qDVMf4/f1lRpAYBfHrtjAtaYNxjerhzzJQ9O35DZ+nmDJ7bEIxwhEUUJN7Ye
	 Tt6/NS51u9fLd+CCzUdwtSjR+JsoOWluKNMUvl38CPvbY5NrDPcKPsKklnoXAfp0Hc
	 LJ8hgorhXMMGA5x79fdAR7IgtS9Ri1F8IjDr++NQof3NE313yZRqh3C/6dYKWCte5P
	 +i2kBcAGvHzwA==
Date: Thu, 23 Jul 2026 17:21:06 -0500
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
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260723222106.GA867236@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-2-dmatlack@google.com>
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

On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
> ...

> +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt

Is KBUILD_BASENAME buying us something important here?  Just from
code-reading perspective, it's more work because without some digging
I don't know what it will end up looking like in a dmesg log.

> +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> +{
> +	struct pci_flb_outgoing *outgoing = args->obj;
> +
> +	WARN_ON(outgoing->ser->nr_devices);
> +	kho_block_set_destroy(&outgoing->block_set);
> +	kho_unpreserve_free(outgoing->ser);
> +	kfree(outgoing);
> +	pr_debug("Unpreserved struct pci_ser\n");

If this pr_debug() is useful, maybe it should include an address and
there should be a corresponding pr_debug() on the preserve side so we
could find things in a crashdump?

> +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> +{
> +	pr_debug("Registering file handler \"%s\"\n", fh->compatible);

Is fh->compatible enough to identify a driver?

