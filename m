Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A87AC88E56
	for <kexec@archiver.kernel.org>; Sat, 12 Sep 2026 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pBslPyab51IM3cN1q+WywRAJYOzHWq5eKWBrdVKUM1w=; b=y0vM0lgONgcmfJtTAZxsqVGDbq
	LE/sFHQIzPtxPlTeCuwNzqPgF6+szbIu1uTpwo0+B2txloDdxmQdKlzZZY1B2aRQUh6Eq+C/UjSyO
	mU5UX0sSw7ltihYexFM3+iF8hVFfXUjtCboBV6XOB9vSRQ9gyEJyOHi0fXkNpPAlH2Mefwk789Xv9
	Jh/glP31JGHDDIOv8XFFxSCYl7W46YhTqjzdWiH3Qp+rdAJ//Eu22atTX18FJiKWyov0FFcqrmZ0h
	C188c++pisHnG/gpaaLZCSCDJbGiRJxh9AoTvnmSbND5B/syj8dEn3MYpc2wUfgCE+SRmsjOAQQds
	1JeUsz5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5RaD-000000012hf-4C3Z;
	Sat, 12 Sep 2026 17:32:10 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5RaA-000000012h8-3yGp
	for kexec@lists.infradead.org;
	Sat, 12 Sep 2026 17:32:08 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747ee1f38so9756155ad.2
        for <kexec@lists.infradead.org>; Sat, 12 Sep 2026 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789234325; x=1789839125; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBslPyab51IM3cN1q+WywRAJYOzHWq5eKWBrdVKUM1w=;
        b=aWzZUxV41RkCuEfDQjRzp+MCRrQFybw9YriXzXn8KVO4m6UzQ5tPSD/iyorwcwa1Jv
         gWrpFPzzuAxUshqzWeCJBCRmBymbBVm5itNyJatg1vLUSsFwqeN4EbbWPbiKn2s9UV0n
         MgQK8i/wCev3rUh1ifb3ZJD91CLNBJAXmotokoiXdLV4Tfe43r8T490WsrqHITGaCIx1
         p7lhzicZ87RD39Hn0bf+myEg5iQ4Z02+11vLC0ixMG73TQqy3VGTDZWYgos+1jf2R4WN
         zsR/aWt3SeTWvxL3kJ8DAJ6x6u/FCLfoxA1foC4K5tmNrHaenGMJLjwNvXdw2u+YAlUw
         FV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789234325; x=1789839125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBslPyab51IM3cN1q+WywRAJYOzHWq5eKWBrdVKUM1w=;
        b=otH15iceT1nMBNj+Z1TziQz6LUmrfLnwWf/oFU1E7bKq+2zMPYTf2G0N8stYg/NsON
         MmU+OJzyIdpuvXE+pDUEPIwQRRxKCHorx+TNEBwcyyt35FD6c6XvtioOYVtGSr74o04T
         xugKzgoAtF/T+dLoBOvtottraKZxm+kCJZeaqyxTdfUXqv4fADiodtHxa4LEETmeFQPI
         XTdCnR4S0yJT5QRqf93er2tSyklrNlq/n1gnoLNIyXoFfrb2WYJMCJqo49PUPicE+Jd9
         /mdN7isfgx7Oq6V3t+lExq3Eu54OU/KNvWLn7mwnH9CfgkpIF4Rq+/bAP/HzbRZrMqts
         ZJ6Q==
X-Gm-Message-State: AFuF++l3z3/PiCiLDfS1d9diNEhTMBGeTz/4tQdHnip3i4D04+j2rO64
	EURG4GGia7vQBFtElm40ayQCiSmtaPJIFxE+YuAq1lY5rlSkh0SqWWrwH1hDpFEH6g==
X-Gm-Gg: AYBFou3ey3s4Dw+AfaLUtYS1/eWnd2FDNABFGCT/m0tvq74Doa77vUdWqzagK2y+C0C
	MqlwRWcA9XI1qw6W0VmZMciGykM3iUE0zvebpIRNeq7hcB/f93eaxfP+mMsSQns/kNJXtJD3n5v
	/sM+JSnpr3TioP0TXvraQIK9VVs2/PUR+OWco59dXh5W+eNPdZgQXoHN5Ga+BPwgGKRmLli+SvB
	cAouFQy4ZAY9T44ufFxpfCUioCPyMW3k1Xxb1QlNFXFlGCW3ibGsPOeSEqb6uO8BSAVmaQiGQzC
	fAHuEHRQNKoQgcmte8VxUi4pXsjU06TaCY9xta91aNTVOXs3N5cIbRIQOzblA5HIDzg4S0KJRAS
	E4i9FUCpO16PQytAqiuH7Ts2qNgAbgCwpCJcJ3QSXuHVANgpxluhH2v98n/66UeO849Fy455950
	62bUoPA9w/+dpBKNgxgAtVv+dfQxIFK1TBLcu3wlJIQRwIaHI4N3v+FhLRq2eyPt0FVsrK0WCbK
	Hzdg5hBqyzdRkIUjDKhqTT0kzX3relAZ3MIhGYQ
X-Received: by 2002:a17:902:e881:b0:2d8:d4cc:be64 with SMTP id d9443c01a7336-2dd2a35a58cmr165076475ad.17.1789234324159;
        Sat, 12 Sep 2026 10:32:04 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc5c7bsm25731245ad.51.2026.09.12.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 10:32:02 -0700 (PDT)
Date: Sat, 12 Sep 2026 17:31:58 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v8 05/12] PCI: liveupdate: Preserve bus numbers during
 Live Update
Message-ID: <aqWMjrea2MMMZHxr@google.com>
References: <20260728221007.2098560-6-dmatlack@google.com>
 <20260910235104.GA367522@bhelgaas>
 <aqRIJs1SdJwoV_cf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqRIJs1SdJwoV_cf@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_103207_022382_6E1FAEA0 
X-CRM114-Status: GOOD (  36.30  )
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

On 2026-09-11 06:30 PM, David Matlack wrote:
> On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2026 at 10:09:59PM +0000, David Matlack wrote:

> > > +bool pci_liveupdate_preserve_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
> > > +{
> > > +	struct pci_dev *parent = bus->self;
> > > +
> > > +	if (dev->liveupdate.preserve_bus_numbers)
> > > +		return true;
> > > +
> > > +	if (parent && parent->liveupdate.preserve_bus_numbers) {
> > > +		/*
> > > +		 * Preserve bus numbers if the parent bridge is required to
> > > +		 * preserve bus numbers. Otherwise the PCI core could expand
> > > +		 * this bridge's reservation beyond its parent (which cannot
> > > +		 * expand).
> > > +		 */
> > > +		dev->liveupdate.preserve_bus_numbers = true;
> > > +	} else {
> > > +		/*
> > > +		 * Otherwise preserve bus numbers if there are any incoming
> > > +		 * preserved devices. This ensures that the PCI core does not
> > > +		 * allocate a bus number to a non-preserved device that
> > > +		 * conflicts with the bus number already assigned to a preserved
> > > +		 * device.
> > > +		 *
> > > +		 * This is slightly more restrictive than it needs to be. For
> > > +		 * example, each host bridges have their own range of bus
> > > +		 * numbers that won't conflict with other host bridges. But the
> > > +		 * previous kernel should have assigned a sane bus topology and
> > > +		 * it is simpler to just adopt that entire topology.
> > > +		 */
> > > +		dev->liveupdate.preserve_bus_numbers =
> > > +			pci_has_incoming_preserved_devices();
> > > +	}
> > > +
> > > +	return dev->liveupdate.preserve_bus_numbers;
> > 
> > I'm not sure why you don't just return
> > pci_has_incoming_preserved_devices() in all cases, which is what the
> > commit log suggests this patch does.  What's gained by all the logic
> > here?  It's not like devices will be hot-added during the kexec.
> 
> To protect against pci_has_incoming_preserved_devices() flipping from
> true to false while the PCI core is in the middle of a scan. It is not
> likely to ever happen given most host bridge scanning should happen
> during early boot, but theoretically possible with the way the PCI core
> code is structured. I did not see way to structurally ensure these 2
> things cannot race. A lot of the host bridge scanning happens without
> taking the rescan lock, for example.

After working on this more, I do see a way to simplify the logic in
pci_liveupdate_preserve_bus_numbers().

pci_liveupdate_preserve_bus_numbers() is used in 2 places during
scanning. First to decide if the PCI core should preserve bus numbers or
is free to allocate new ones, and second to decide if the PCI core is
allowed to assign bus numbers to bridges that are missing bus numbers.

The latter case should never happen during initial scanning unless a
bridge was somehow reset during the kexec, but could legitimately happen
if a bridge is later hot-plugged and I did not want Live Update to
unnecessarily break that scenario. But then that creates this problem
where pci_has_incoming_preserved_devices() can suddenly flip from true
to false at any time and I needed all the complex logic to keep it
consistent for a given scan.

Instead we can split the handling of these cases:

 1. When the PCI core needs to decide if it should preserve bus numbers
    due to Live Update, pci_liveupdate_preserve_bus_numbers() can return
    true forever if any device was preserved by the previous kernel,
    which simplifies the logic.

 2. Then to handle the case of a bridge is enumerated that does not have
    bus numbers assigned, we can handle that separately. If we reorder this
    with the next commit so the PCI core knows exactly which bridges have
    preserved downstream endpoints, then it is possible to determine if it
    is safe for the PCI core to allow bus numbers to be assigned to an
    unconfigured bridge.

After re-ordering, we can end up with something like this:

  bool pci_liveupdate_preserve_bus_numbers(void)
  {
  	return pci_liveupdate.had_incoming;
  }

  bool pci_liveupdate_refuse_bus_numbers(struct pci_bus *bus, struct pci_dev *dev)
  {
  	struct pci_dev *bridge;

  	for_each_pci_bridge(bridge, bus) {
  		if (!bridge->liveupdate.was_incoming || bridge->subordinate)
  			continue;

  		pci_err(dev, "Not assigning bus numbers, preserved bridge %s lost its bus number configuration\n",
  			pci_name(bridge));
  		return true;
  	}

  	return false;
  }

The net effect on pci_scan_bridge_extend() is:

  bool preserve_bus_numbers = !pcibios_assign_all_busses() ||
  			    pci_liveupdate_preserve_bus_numbers();
  ...
  	if (pci_liveupdate_refuse_bus_numbers(bus, dev))
  		goto out;

We could further scope pci_liveupdate_preserve_bus_numbers() to only
return true for host bridges with preserved endpoints downstream, but
that doesn't seem worth the extra complexity. It also seems nice to keep
the pci_liveupdate_preserve_bus_numbers() policy global to match how the
existing pcibios_assign_all_busses() policy is global.

Does that look reasonable?

