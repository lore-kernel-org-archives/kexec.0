Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5E4C982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MH5QEcAdSFYOoMIMiWDV8W/y30UDqiHCwxXnldaYp0E=; b=3dwPhXHbBrxaEu1J+rediqK/ws
	tYHUGv7ru6f4qV2E74Cl69HDqGhLePGSHx1cXJHUJ3DEYeivUSiONGpuHziHTSk1g0vvSejHe222k
	gnj1L7rjN9/Ucfe1InMD5rOyuVOPPQQC0vn67rwId+rCGl6arF2i5JrYZFOx5AU8FmbfVMjJozcbS
	6Vf9IxUxlSoFJB0zYpHIM1LE1oLNSnIY7oYP3GTPJi/a0g3IaSkoXyDKFVL0sjrR0RkehbWBs/e0U
	ogsgzGShIG+6c3Ic1JcbC1FfdT6b9VICIQgwrle4pcZx3yC+5TT4Dj9B1mMGkSEijXUByEUW4jkF5
	hFFY9l7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MmJ-0000000D4MZ-16bk;
	Fri, 18 Sep 2026 00:48:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MmH-0000000D4MB-1wTE
	for kexec@bombadil.infradead.org;
	Fri, 18 Sep 2026 00:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MH5QEcAdSFYOoMIMiWDV8W/y30UDqiHCwxXnldaYp0E=; b=FoDBfKktL7GuCssosNvPJfKPD7
	IYCbsEMg4IIxBALhKDU1gKtPvxxHqX4tMpuuXSpAArDzcyUcpz51F61/V6kU15Qjamnb4y8fneS34
	Cxj4H1y2p/DB5D8BEK/7CNnJ7CcRwrCfoL+ZDjLd3hIvJGe664S47j9/N4OJmAOv8C6id90g1nbKt
	BvytOEXAFlBn1UL90Qpnp8pW9t6XiBAM5ti1BV5nRf1PpTscJdjIMRaSivHBMXxTNE0Ve7oOsaSzy
	STbFVw+MW84UG9R0Yk9Q7EY3ou+ADKcNTWI/pVq5vNM9GqR1ZSokqMfrH2cu94rI2z8l/6cR1hAXT
	EWIm/NUQ==;
Received: from mail-pj2-x12.google.com ([2607:f8b0:4864:39::12])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7MmE-00000009S7y-0tOe
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 00:48:32 +0000
Received: by mail-pj2-x12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so1657475ad.0
        for <kexec@lists.infradead.org>; Thu, 17 Sep 2026 17:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789692508; x=1790297308; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MH5QEcAdSFYOoMIMiWDV8W/y30UDqiHCwxXnldaYp0E=;
        b=n/WpymgHepiw1U+h3LwIppoRx2+p8tkuWC2oQG/I0MxLqvU+ZsuDi8xpxw+dR9keAt
         NUbrLGSGo5xLdbjOwHOQDCqdgwS60PP5Sfbnaj9Rn+wtiu0JEgZRfRrf+IFAZEj9pm2s
         Vx8H8MzbQGku3FIBW+fRIe3DJdx1SCUbbg2gojY9ck3oBC8Szp8WaPWqML4FD73hLLi6
         C3td22M04UyKvYV4qRQk1gw0F0/cEIQtqWLGByhVZrkkpAlWzwuzkd5yu01qpUp7PSxm
         wJICpVGRaHypNMmziiMaBbYrRGpeqaHQcy0iyLZlgpDSaysrw/O3nzIDJdh2ro70y45m
         W3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789692508; x=1790297308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MH5QEcAdSFYOoMIMiWDV8W/y30UDqiHCwxXnldaYp0E=;
        b=hgqWfv+EIhd5St2uUNzrqzrMbat+Tf5a/DE2jzkzH/v1Q72SiUdXoH81QCyToy9S+j
         SNQo6gdgLDs1derLu/26wZoeU7eu2bQBB5p7/uYz57y3YW3WMxd8nN4I6vnFFozKwjob
         NSzxhWDEp0bbnq2OiZNUoZ8nU+eYljvr9HZAtqIFumAzHJ4/OCEIxKIvVbC1TmH5V4zV
         zMZBTvMqZc7l/iOFZLjY5qKD757+0IGP99+6usRPrx3/VGk+Nq1p9t0H8RzWEuzc4lfj
         QWJnoRmEwaHsiINRdZg5NCVxTzW2mxclQ1h/xD0RexJgkRVpRnfQ5kL+qmAlH9W8IxU5
         LJkA==
X-Gm-Message-State: AFuF++mmjBO3fLksuyIlglQvFxoaS4RZi2d6a1kTUcFo8xU5oM2hQTxV
	w1LgKXmFK5U1MpKUczh0HxZ76MmRZXM+W5nMjkhu5YAue6fYWbtxo998jA3F+e+HTQ==
X-Gm-Gg: AYBFou1ec5XRFpaHXM6rpXQqYp3vqMa5pgh1eaTzrMuBp8YrLnB3G1VUw49DSx3/SM2
	2Gx+28Zuerga3bL5oCwcprGadiG2D6h35XxpzJmMhuhUdF2JKiHXKcg3CJ+ndT3iFuhN6GwJWkT
	/+/uOWACTrU0sCkIBRh0eIywb3NmDma+KLL2zRD4V6yDASpT1DDraGivmgPrGpkcnkX8Aj/mM4M
	nl6P8Hmk9TK5x/aAZfQ/psLYtjzkz17khYXc2q2H+a94QCh3ifAJ8inTQ4Ct8pJxn73C1SJ0Rhn
	2794V4LAvhBAFmCzZhUCK8bqRabpKoPC5ibTLMZFw1CMml0g4TX/pGWhv0dyTVHV5aBlmH1UQUf
	75JrQDXZHSiDcN39ot52Xk7FP9V5W4GGyr/AnNndH2Vf/ariIphyCmzsmSFgJI/IU9dKRMlluRr
	JpjZKwkE2rBMoJ5lzsjEBVMzdNtHWlq9iyeBhRhwajKL/j4s16zECWhF+NMNFLby2wxGPE2JD0c
	FiiHimokxXPst6hbiuQvBThK3tdqdGST+CcMrrgcFPIuj74qSg=
X-Received: by 2002:a17:90b:2ecb:b0:39e:4c7f:8b1c with SMTP id 98e67ed59e1d1-39e54d4cb89mr1939357a91.33.1789692507312;
        Thu, 17 Sep 2026 17:48:27 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a0e8ca0sm201754a91.2.2026.09.17.17.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 17:48:26 -0700 (PDT)
Date: Fri, 18 Sep 2026 00:48:22 +0000
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
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aqyKVkIH58DK0EZO@google.com>
References: <aqQv0jJdT4xq6VWu@google.com>
 <20260916235041.GA989143@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916235041.GA989143@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_014830_539656_99CCFA7B 
X-CRM114-Status: GOOD (  66.93  )
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

On 2026-09-16 06:50 PM, Bjorn Helgaas wrote:
> On Fri, Sep 11, 2026 at 04:44:02PM +0000, David Matlack wrote:
> > On 2026-09-10 06:48 PM, Bjorn Helgaas wrote:
> > > On Tue, Jul 28, 2026 at 10:09:55PM +0000, David Matlack wrote:
> > > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > > > it to participate in the preservation of PCI devices across Live Update.
> > > > Essentially, this commit enables the PCI core to allocate a struct
> > > > (struct pci_ser) and preserve it across a Live Update whenever at least
> > > > one device is preserved.
> > > 
> > > I assume pci_ser is the state the PCI core needs to preserve across
> > > kexec so the new kernel's enumeration doesn't interrupt the device
> > > operation.  And that whatever state the endpoint drivers need to
> > > adopt/inherit the device in the new kernel is managed without any help
> > > from the PCI core?
> > 
> > Yes.
> > 
> > > > Preserving PCI devices across Live Update is built on top of the Live
> > > > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > > > expected to expose a file to userspace to represent a single PCI device
> > > > and support preservation of that file. This is intended primarily to
> > > > support preservation of PCI devices bound to VFIO drivers.
> > > 
> > > Where do drivers expose this file?  sysfs?  I guess it's a file per
> > > preserved device?  Thinking like a driver writer, I'm expecting a hint
> > > about how to expose this file (should also be in the file doc somehere
> > > if it's not already).
> > 
> > There is no requirement about how drivers do this from the PCI core
> > perspective. For all intents and purposes, the VFIO PCI variant drivers
> > are the only drivers that are going to be supported in the next 1-2
> > years. They expose a misc character device for each file.
> 
> If this file isn't relevant to the PCI core, maybe we don't need to
> mention it here.  It doesn't seem like it motivates this patch.
> 
> > > > This commit enables drivers to register their liveupdate_file_handler
> > > > with the PCI core so that the PCI core can do its own tracking and
> > > > enforcement of which devices are preserved.
> > > > 
> > > >   pci_liveupdate_register_flb(driver_file_handler);
> > > >   pci_liveupdate_unregister_flb(driver_file_handler);
> > > 
> > > So a driver calls pci_liveupdate_register_flb() once, then
> > > pci_liveupdate_preserve() once for each device it wants preserved?
> > 
> > Yes
> > 
> > > > When the first file (with a handler registered with the PCI core) is
> > > > preserved, the PCI core will be notified to allocate its tracking struct
> > > > (pci_ser).
> > > 
> > > The passive voice here makes the actors a bit obscure.  I guess a
> > > LIVEUPDATE_SESSION_PRESERVE_FD ioctl on some per-device file kicks
> > > this off?
> > 
> > Yes. (And I will reduce the passive voice in the next version.)
> > 
> > > I guess the pci_ser allocation is in
> > > pci_liveupdate_flb_ops.preserve(), i.e., pci_flb_preserve()?
> > 
> > Yes.
> > 
> > > So the PCI core tracker (pci_ser) isn't actually allocated at the time
> > > of pci_liveupdate_register_flb(); it's allocated on the first
> > > LIVEUPDATE_SESSION_PRESERVE_FD ioctl for a driver that has called
> > > pci_liveupdate_register_flb()?
> > 
> > Yes. The first device that gets preserved triggers the allocation of
> > struct pci_ser. And the last device that gets unpreserved (preservation
> > cancelled) triggers the freeing of struct pci_ser.
> > 
> > > IIUC the call tree for that ioctl looks something like this:
> > > 
> > >   <driver>
> > >     pci_liveupdate_register_flb
> > >       liveupdate_register_flb(fh, &pci_liveupdate_flb)
> > > 
> > >   luo_session_ioctl
> > >     op = &luo_session_ioctl_ops[...]
> > >     op->execute                               # eg luo_session_preserve_fd()
> > >       luo_session_preserve_fd
> > >         luo_preserve_file
> > >           luo_flb_file_preserve
> > >             luo_flb_file_preserve_one
> > >               if (outgoing_count == 0)        # only for first FLB device
> > >                 flb->ops->preserve            # eg pci_flb_preserve()
> > >                   pci_flb_preserve
> > >                     ser = kho_alloc_preserve  <-- alloc pci_ser
> > >                 outgoing.count = 1
> > >           fh->ops->preserve                   # something not included here
> 
> So IIUC this part of the path looks like this, which answers my
> question below about ordering of pci_ser and
> pci_liveupdate_preserve():
> 
>               fh->ops->preserve                   # eg vfio_pci_liveupdate_preserve()
>                 vfio_pci_liveupdate_preserve
>                   pci_liveupdate_preserve
>                     pci_liveupdate_preserve_device
>                       dev_ser = pci_flb_alloc_dev_ser  <-- alloc per-dev PCI core serialized state
>                       dev_ser->bdf = pci_dev_id(dev)
> 
> > > Seems like kind of an awkward way to allocate pci_ser.  Couldn't it be
> > > allocated on the first call to pci_liveupdate_register_flb()?  That
> > > would be a lot easier for driver writers to trace through.
> > 
> > I agree the LUO FLB API is a bit awkward, but this is how it works.
> > 
> > If we allocated it during pci_liveupdate_register_flb() we would then
> > need to stash it in a global variable to hand-off the LUO later. Despite
> > the awkwardness of FLBs, it is useful to avoid globals and have LUO
> > management the lifetime.
> 
> It seems like pci_ser is a singleton by design, so a global variable
> doesn't sound like it would be terrible to me.
> 
> > > > When the last file is unpreserved (i.e. preservation
> > > > cancelled) the PCI core will be notified to free struct pci_ser.
> > > 
> > > There's a lot going on behind "PCI core will be notified".  I assume
> > > these refer to the first-time behavior of luo_flb_file_preserve_one()
> > > and last-time behavior of liveupdate_flb_put_outgoing(), which is
> > > honestly kind of hard to suss out.
> 
> Could we say something specific and PCI-related here, to help connect
> the dots?  Most of these paths are outside the PCI core.
> 
> IIUC luo_session essentially has a refcount (outgoing.count)
> incremented by each LIVEUPDATE_SESSION_PRESERVE_FD ioctl, and the 0->1
> transition in luo_flb_file_preserve_one() ends up calling
> pci_flb_preserve(), where pci_ser is allocated.
> 
> And the refcount is decremented by luo_flb_file_unpreserve() (in a
> luo_session .release() function), where the 1->0 transition in
> liveupdate_flb_put_outgoing() calls pci_flb_unpreserve() where pci_ser
> is deallocated.
> 
> That gets into a lot of detail, probably too much for a commit log.
> Maybe mentioning the function names by which the PCI core is notified
> to alloc/free pci_ser would be enough of a bread crumb.
> 
> > > This series doesn't include a caller of pci_liveupdate_preserve() (or
> > > pci_liveupdate_register_flb()), so I can't figure out the ordering.
> > > Obviously pci_liveupdate_register_flb() must be first.
> > 
> > In every version of this patch series I have sent I included a link to
> > the vfio-pci driver changes that build on top of this, rebased that
> > series on top of this one, uploaded it to my GitHub, and included a link
> > in the cover letter. Here is the relevant section from the v8 cover
> > letter:
> > 
> > . This series was tested in conjunction with v5 of the VFIO PCI driver
> > . series:
> > .
> > .   https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
> > .
> > . The full set of patches used for testing can be found on GitHub.
> > .
> > .   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8-with-vfio
> > 
> > 
> > > I first thought pci_liveupdate_preserve() would be called via the
> > > fh->ops->preserve() in the luo_session_preserve_fd() ioctl path, but
> > > it's not.  pci_liveupdate_preserve() is intended for the driver to
> > > call it directly.  But it looks like it has to be called *after* the
> > > ioctl?  Obviously I'm confused :)
> > 
> > It is called by the driver during it's fh->ops->preserve() callback. In
> > other words, it is called during the ioctl by the driver.
> 
> I think the updated call tree above shows the connection?

Yes the call tree you added above is correct. Here is an attempt at the
complete picture that I plan to include in the kernel-doc in v9:

 * Call Flow
 * ---------
 *
 * ::
 *
 *   # Driver initialization
 *   pci_liveupdate_register_flb(fh)
 *
 *   # Userspace: ioctl(LIVEUPDATE_SESSION_PRESERVE_FD, devfd)
 *   luo_preserve_file()
 *     luo_flb_file_preserve()
 *       luo_flb_file_preserve_one()      # first preserved file only
 *         pci_flb_preserve()             # alloc and preserve struct pci_ser
 *     fh->ops->preserve()                # driver callback
 *       pci_liveupdate_preserve(dev)     # record this device in struct pci_ser
 *
 *   # Userspace: preservation cancelled or session torn down
 *   luo_file_unpreserve_files()
 *     luo_flb_file_unpreserve()
 *       liveupdate_flb_put_outgoing()    # last unpreserved file only
 *         pci_flb_unpreserve()           # free struct pci_ser
 *
 *   # ---------------- kexec ----------------
 *
 *   # New kernel: PCI enumeration
 *   pci_setup_device()
 *     pci_liveupdate_setup_device()
 *       liveupdate_flb_get_incoming()
 *         luo_flb_retrieve_one()         # first request only
 *           pci_flb_retrieve()           # previous kernel's struct pci_ser
 *
 *   # Userspace: ioctl(LIVEUPDATE_SESSION_FINISH)
 *   luo_file_finish_one()
 *     fh->ops->finish()                  # driver callback
 *       pci_liveupdate_finish(dev)       # release this device's pci_dev_ser
 *     luo_flb_file_finish()
 *       liveupdate_flb_put_incoming()    # last incoming file only
 *         pci_flb_finish()               # free struct pci_ser
 *

And here is an updated commit message that I hope explains everything more
clearly:

 PCI: liveupdate: Set up FLB handler for the PCI core

 Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
 preserve its own state across a Live Update kexec.

 Preserving a PCI device across kexec requires preserving two independent
 sets of state:

  - Driver state, e.g. everything vfio-pci needs so that userspace can
    keep using the device in the new kernel. The driver preserves this
    itself and the PCI core is not involved.

  - PCI core state, e.g. which devices are preserved, so that the new
    kernel knows not to disturb them while they are still running and
    doing DMA. That is what this commit adds, serialized into struct
    pci_ser.

 Userspace, not the kernel, decides which devices are preserved, and it
 does so through the Live Update Orchestrator's (LUO) support for file
 preservation: a driver exposes a file that represents a single PCI
 device, and userspace preserves that device with
 ioctl(LIVEUPDATE_SESSION_PRESERVE_FD) on that file. Binding preservation
 to a file gives it proper lifecycle management, e.g. the preservation is
 undone if userspace cancels it or goes away. How a driver exposes that
 file is up to the driver and invisible to the PCI core (vfio-pci variant
 drivers, the first intended use-case, use their per-device cdev).

 LUO only knows that a file was preserved; it does not know that the
 represents a PCI device, or which one. Bridging that gap, drivers
 register their liveupdate_file_handler with the PCI core:

   pci_liveupdate_register_flb(driver_file_handler);
   pci_liveupdate_unregister_flb(driver_file_handler);

 LUO then refcounts the PCI core's FLB against the files preserved by
 that handler, and that refcount drives the lifetime of struct pci_ser:

  - On the first preserved file, luo_flb_file_preserve_one() calls
    pci_flb_preserve(), which allocates struct pci_ser and preserves it
    with KHO.

  - On the last unpreserved file (i.e. preservation cancelled),
    liveupdate_flb_put_outgoing() calls pci_flb_unpreserve(), which
    unpreserves and frees struct pci_ser.

  - In the next kernel, pci_flb_retrieve() hands the PCI core the struct
    pci_ser built by the previous kernel, whenever the PCI core asks for
    it (e.g. during enumeration), and pci_flb_finish() frees it once the
    PCI core is done with it.

 So the flow for preserving a device, once a driver has registered, looks
 like this:

   ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)
     luo_session_preserve_fd()
       luo_preserve_file()
         luo_flb_file_preserve()
           luo_flb_file_preserve_one()  # only on the first preserved file
             pci_flb_preserve()         # alloc + KHO-preserve pci_ser
         fh->ops->preserve()            # driver callback, e.g. vfio-pci

 Note that struct pci_ser is deliberately not allocated when a driver
 calls pci_liveupdate_register_flb(). A driver can be loaded for the
 lifetime of the machine without ever preserving a device, and there is
 no reason to allocate memory and hand it to the next kernel in that
 case. Letting LUO own the lifetime also means the PCI core does not have
 to duplicate LUO's refcounting and unwind logic for preservation
 failures, session aborts and fd close, and the incoming side
 (retrieve/finish) comes from the same object rather than requiring a
 separate KHO FDT entry owned by the PCI core.

 Note: This commit only allocates struct pci_ser and preserves it across
 Live Update. A subsequent commit adds pci_liveupdate_preserve(), the API
 drivers call from their fh->ops->preserve() callback to tell the PCI
 core exactly which devices are being preserved.

 Note: There is no reason to check for kho_is_enabled() since it can be
 assumed to return true. If KHO was not enabled then Live Update would
 not be enabled and these routines would never run.

