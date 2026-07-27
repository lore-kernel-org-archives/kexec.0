Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F1EC53219
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 19:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=sKZJ5OViBbK3ZJT1F6pApbVMnloDUEEXkiEo8E43BZo=; b=aBq6OX3W7XK/R/0TLTxZkZ3DWr
	GNc8N0UPq5rTIESxY3nOJ08+fBsfRx1rVcQPGwh2RfZvUxu9I4LyP07yH30DMuDneF7rjsme8uquR
	YrrkQvMxV0ch2GFRvQcNbUEtlbFfmZ0yT5pItqGFwKtIk2WA6bLeQwGc8Q0d6tCAjLIQItWMXB9tn
	E2iZHjLGxkez6BUKATkgf277zIY0B6PavwW1GBzPuRzEW/bIPnVpCvxDLOpZrzOVNGTqpoHxrJbL+
	UUPuCUpXhHVoC5mJUYNLmLtSHaejZsDi4Y1M6GPAClvazyzQp7OJwO8TWE+1CR0lwf9LNtwivv1ee
	OkQdzuCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woQye-00000003lEx-2TIg;
	Mon, 27 Jul 2026 19:27:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woQyd-00000003lEq-1ixl
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 19:27:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B69A40164;
	Mon, 27 Jul 2026 19:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36551F000E9;
	Mon, 27 Jul 2026 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785180423;
	bh=sKZJ5OViBbK3ZJT1F6pApbVMnloDUEEXkiEo8E43BZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IzYilg/M8OJawVypIyI6yqeauwbZiYHFTE/2k3KHuRHUxMx0FStRiRDIYwLSXuz+j
	 05E1VSdnB8lEC6Dizt4VUGoyC5z/mveyiibWsgRdAlvKKIkj48/ah7F6UT2aCwtI+P
	 M7K/wl4ZU3s2ty47OdvEC9FdpqZZooqnD/YPe5dYLEcIqXgPRe9z+IRv0OGOjxpiCI
	 Jkkv2KqNrNrHHFyKWrUSu4jKNcR9MN7OKjAKqyH6336kbZXEsU0FdJisLbzQ98yFFp
	 BOxeFggnvJIK1ABfQTx2tpoMDd3ziP5gU/FGGW5Hjp9V/egQQBr6nc61xzYH0DhpGX
	 yRf6bic++oydw==
Date: Mon, 27 Jul 2026 14:27:01 -0500
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
Message-ID: <20260727192701.GA1250952@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cRhFW+zNX6xCnhjJXXDHgyhOxuoX26FG2Ve8+wMccypg@mail.gmail.com>
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

On Mon, Jul 27, 2026 at 10:40:52AM -0700, David Matlack wrote:
> On Thu, Jul 23, 2026 at 3:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > > it to participate in the preservation of PCI devices across Live Update.
> > > Essentially, this commit enables the PCI core to allocate a struct
> > > (struct pci_ser) and preserve it across a Live Update whenever at least
> > > one device is preserved.
> > > ...
> >
> > > +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> >
> > Is KBUILD_BASENAME buying us something important here?  Just from
> > code-reading perspective, it's more work because without some digging
> > I don't know what it will end up looking like in a dmesg log.
> >
> > > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > > +{
> > > +     struct pci_flb_outgoing *outgoing = args->obj;
> > > +
> > > +     WARN_ON(outgoing->ser->nr_devices);
> > > +     kho_block_set_destroy(&outgoing->block_set);
> > > +     kho_unpreserve_free(outgoing->ser);
> > > +     kfree(outgoing);
> > > +     pr_debug("Unpreserved struct pci_ser\n");
> >
> > If this pr_debug() is useful, maybe it should include an address and
> > there should be a corresponding pr_debug() on the preserve side so we
> > could find things in a crashdump?
> >
> > > +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> > > +{
> > > +     pr_debug("Registering file handler \"%s\"\n", fh->compatible);
> >
> > Is fh->compatible enough to identify a driver?
> 
> Not necessarily. VFIO could theoretically have one file handler that
> handles all the vfio-pci variant drivers. But I suspect we'll end up
> with 1 fh per driver in practice.
> 
> Are you thinking about how we can ensure devices are bound to
> compatible drivers after Live Update?

No, I don't understand enough to worry about things like that.  I'm
just wondering if there's enough info in the message to be useful,
since fh->compatible is the only text that's variable.  Same reason I
asked about the "Unpreserved struct pci_ser" message above.  E.g., if
a user reports these messages, will we need more information to debug
it, or is the message itself enough?

