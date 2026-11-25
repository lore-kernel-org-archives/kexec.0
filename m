Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C769606A329
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rywYC2eE;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ES/xLP3t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=; b=rywYC2eEOgKe3vP1iGhhM8cxWn
	atDZL2iqfRcodc7mwN/1yyPkoGzjcd3pukKiMmU8v6kkXRoJaAdC0r0s3KBWNvF3d4MebkZeMmE/h
	aAl/bZvLZDwHut/KyzC2xOk5IWIyhx25CP7NBqhs3zWQPZxh3ygVYpNNdLu6rMC+at7ZJahFqxDyT
	j+fH+OJuAAo0Z5g75i7/lDKGgoBu8W7ZEEEZTbiQMcrWy+H7D4KU6J5rS3Oa/b0B/K5jKe+xkkH2f
	hC1lBJTSxyIZv0cQK/6G3n50/LEU9DLTbFa4JowFsJotP1iHmt7R6yB4Lo6asFanrk1KEYNsW6z2f
	maxB+9mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6ul-00000008l2t-3z17;
	Wed, 25 Nov 2026 06:55:35 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW6uj-00000008l2W-2l4x
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 06:55:35 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2f0afdb97abso177375ad.1
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 22:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795589732; x=1796194532; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
        b=ES/xLP3tjrWzRGzsptQ5UqF+ED0GV1H+7tb6A6KAivlPHXGjOFwUgvVppSXOhk3ick
         q+raY23ku+vjTSsikrjR3CWl1jXNtl1ey7eV5iRG5S7LUA1uIUEBzborq3Ad1av4ClOV
         C+zzyZA1gXc35ILAaQLNo5iVp0TF+ca6RL2vw0nX6sEKAnDQaUNY3v5T15Htl83wK60G
         OtYabW5fX2RIANfwTse6cWh02y7YdBEjTev8vxgmrJ+CL0Ng3KsLewImnDpucd18aJOg
         FbbiqO7WJqqMT83kdfizaQQW3kIODcW1g6M0h8mu9P6b5zSbzAxjMF4z573tDqBOJ3bn
         f7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589732; x=1796194532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
        b=nd+YjWXaGctOWE0WahGpHf2XTXGFFnj/sQN5nRT5VMBYMf3nk33hOz2intIlA2L//b
         juIgXSp7afumQnNtYKmTxhD89V2MVHGiydvA9/InyOlJNnSFli4RZreymzQBt4zxg/Wi
         Zlh293eBGdbpQF6ljMBSnvISThPUdRmrIrpybwZ/HQV9rc/fGEi+LSFyn6UZBCuYoZ5f
         jOzhT0Nyc3TFYeO2lOTvMJV/QrTkNhMewzkj6maxPE0OptYT6V+EHQOudwfCxJIrScHt
         WdmarZ0Q0EZqPgLXsi/92sqhNqhvrqonRFoxH+7YlYT0IA0O7cl496T5wvhQjwCd9nec
         d8Zw==
X-Gm-Message-State: APuU4Z8U1JBUiGrCGO1nFKlbEYgWfIeGph01g3LVYvhDddZtiKx71Id3
	KmYREfm95UNhRzXTYdSxLSzV3mk5OAxB5Qtine0s8uqEWPcknF6ZGXUUGrh/+HArig==
X-Gm-Gg: AZFdTZeJDAGxDDUomh7nBJXJGlBMui6eOC5X50n+jEbh4DyW3uGdAouB9H5cUrNTpW2
	VLcEKi30zwpRlu/8og86x5sG+t2a2Q0RTaCEUmzCPKR8fMoiCYA3MLHOHXvMHAE470sfU9Rzscm
	5dHeJbEUXMw05ZlfBpzESFbCf7IBorLx913MKagpmZfBJZXdkvOmX7kuP+LjeV6uFJohpee8oH7
	oXY5OygYym4QkjqCH7G1c+bQXzB3llO/d5gQtoT0X2DZDf5xgEyRCSb2vh1BejATu2gtPk+Ln6/
	XI/TBwoYaX5C5pg8VgHJO4BG539aAP2O9LvFq/NNeIG+7NSjCx2E4OO1O5Y5+PzA8tnOgRHNCUF
	IYUUsqSUTxcBbKZlOvf5tqIWlVFJQiofHunSHQVknTZ7NamMmqYCCwcifJzcMdxhYRsgx/VeDfl
	99M8/6ULGc1VPChXnuwCP/Ue8rIVDzmdvFHDRUikjx1BPc6LBUo6esWe9KNYqIerJC1e3ESax9a
	Oo3r8utmNrRQQu5Bc5OG3r6+0TpX1GUfW3qG9Nv3HgKhAdtC+x0n3duBGIHIxc6GWKH9iJU8FNy
	IpD5HNGhtOT8mpk8CGt8pu458nXI4lVg2th38euit7xsnuzOE3Jwd/SZZzgaScWDFRQ=
X-Received: by 2002:a17:903:298c:b0:2e6:1013:ad57 with SMTP id d9443c01a7336-2f0666c0739mr15428995ad.12.1795589731845;
        Tue, 24 Nov 2026 22:55:31 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm8167972a12.13.2026.11.24.22.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:55:30 -0800 (PST)
Date: Tue, 24 Nov 2026 22:55:27 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <20261125003759.GD3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_225533_714480_2308C5C2 
X-CRM114-Status: GOOD (  59.61  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 05:01:19PM -0800, David Matlack wrote:
> On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> > Enable userspace to retrieve preserved VFIO device files after a Live
> > Update by implementing the retrieve() and finish() file handler
> > callbacks.
> >
> > During retrieve():
> >  * Validate the handed-over struct vfio_pci_core_device_ser header,
> >    sizes, and flags.
> > [...]
> 
> Please make the commit messages in this series easier to read. They are
> mostly long bulleted lists of everything the code does, which is hard to
> follow and largely repeats the diff. A commit message should explain, in
> prose, what problem the patch solves and why it solves it this way, and
> only call out details that a reviewer can't easily get from the code.
> This applies to most of the patches in the series (e.g. PATCH 07 and
> PATCH 13 too).
> 

 I will do a better a job in the next version.

> > Do not implement can_finish(): closing a retrieved LUO session invokes
> > finish, and refusing can_finish() would leak the session and leave
> > unclaimed devices running. Instead, finish() always completes:
> >  * If the retrieved device was claimed by opening it via
> >    VFIO_DEVICE_BIND_IOMMUFD (which consumes vdev->liveupdate_incoming;
> >    subsequent patches replace the open-time reset with non-reset
> >    take-over, reject opening incoming devices other than via retrieve(),
> >    and protect incoming kept-running devices across runtime PM, dev_set
> >    resets, and non-noiommu boots), finish() simply completes its PCI
> >    Live Update participation.
> >  * If the device was not claimed (never retrieved, retrieve() failed, or
> >    retrieved but never bound via VFIO_DEVICE_BIND_IOMMUFD),
> >    vfio_pci_core_liveupdate_reset() logs one pci_warn() naming the
> >    device, clears PCI_COMMAND_MASTER, resets the function, and restores
> >    the inherited pci_saved_state just as closing the device would. If
> >    the device has a function reset but is not reset, e.g. because
> >    pci_dev_trylock() contends with a concurrent driver unbind, latch
> >    vdev->liveupdate_reset_pending so vfio_pci_core_unregister_device()
> >    completes the function reset and state restoration via
> >    vfio_pci_core_liveupdate_reset_locked() under the device lock held by
> >    device_release_driver(). Opening the device after finish() resets it
> >    like any open, so it drops the latch.
> >  * If the device was not retrieved, look it up under pci_dev_lock(),
> >    which waits for a vfio-pci probe in progress. If it is bound to
> >    vfio-pci, finish it as above. If it has no driver, clear bus
> >    mastering and reset it. Otherwise leave it to the bound driver.
> >  * Call pci_liveupdate_finish() and kho_restore_free() on every path.
> 
> This is a lot of complexity for one commit, and it's hard to review. I'd
> like to start with the simplest approach and build from there: implement
> can_finish() and have it return false until the device is fully
> retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
> Then finish() only needs to free the incoming state and call
> pci_liveupdate_finish().

Closing session FD is not retriable. If it returns an error then
userspace won't be able to retry. So, only option will remain to reboot
the host.

VFIO doesn't need to impose this restriction. We discussed in LPC to not
block finish() as this call can only be tried one time in LU if
session is leaked.

> 
> That gets rid of vfio_pci_core_liveupdate_reset(),
> vfio_pci_core_liveupdate_reset_locked(),
> vfio_pci_liveupdate_finish_lookup() and its bridge and device locking,
> liveupdate_reset_pending, and most of the finish documentation. If you
> want to handle the other scenarios (devices that are never retrieved or
> never bound, devices bound to other drivers, unbind racing with finish),
> please add them in separate commits on top, each with its own
> justification.
> 
> As for closing the session leaking it and leaving unclaimed devices
> running: that only happens if userspace closes the session without
> taking over all of its devices, and leaving the device running with its
> memory still preserved is safe. Resetting the device in that case is
> something that can be added later.
> 
> It also has a nice side effect: LUO calls can_finish() on every file in
> a session before finishing any of them, so a memfd in the same session
> that the device DMAs into can't be finished before the device has been
> taken over.

If userspace has two session, memfd in one and vfio in another, we will
still have risk, where memfd is retrieved correctly and may be
closed/released due to a process crash but VFIO device still acessing memory
by continuing its DMA and potentially corrupting memory.

I am still inclined to let finish proceed without blocking via
can_finish(). I can try splitting patches.
> 
> > +static int
> > +vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
> > +				    struct vfio_pci_liveupdate_incoming *in)
> > +{
> > +	guard(mutex)(&vdev->vdev.dev_set->lock);
> > +
> > +	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
> > +	    !pci_liveupdate_is_incoming(vdev->pdev))
> > +		return -EBUSY;
> > +
> > +	vdev->liveupdate_incoming = in;
> > +	return 0;
> > +}
> 
> The pci_liveupdate_is_incoming() check here is redundant with the one in
> vfio_pci_liveupdate_retrieve(). Nothing can clear it in between, since
> only finish() should do that (see below) and LUO holds the session mutex
> across both retrieve and finish.
> 
> The liveupdate_claimed check is redundant too: LUO only lets a token be
> retrieved successfully once, PATCH 12 prevents opening an incoming
> device any other way, and the liveupdate_incoming check already prevents
> attaching twice.

I will remove it.

> 
> > +	if (!pci_liveupdate_is_incoming(pdev) ||
> > +	    ser->cfg_size != pdev->cfg_size) {
> > +		ret = -EINVAL;
> > +		goto out_put_dev;
> > +	}
> 
> If the device isn't incoming here, that's a kernel bug. The previous
> kernel only preserves the file after pci_liveupdate_preserve()
> succeeds, the PCI core marks the device incoming when it's enumerated,
> and only VFIO's finish() should clear it. So this should be a
> WARN_ON_ONCE().

I will add a WARN_ON_ONCE().

> 
> > +	if (pci_liveupdate_is_incoming(pdev))
> > +		pci_liveupdate_finish(pdev);
> > +}
> 
> Likewise, the device must still be incoming here, so
> pci_liveupdate_finish() can be called unconditionally.
> 

Yes, I will remove it.

> > +static inline void
> > +vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
> > +{
> > +	struct pci_dev *pdev = vdev->pdev;
> > +
> > +	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
> > +		/*
> > +		 * Complete a reset that finish() could not do, see
> > +		 * vfio_pci_liveupdate_finish_vdev().
> > +		 */
> > +		if (vdev->liveupdate_reset_pending) {
> > +			vfio_pci_core_liveupdate_reset_locked(vdev);
> > +			vdev->liveupdate_reset_pending = false;
> > +		}
> > +		vfio_pci_liveupdate_free_incoming(vdev);
> > +	}
> > +
> > +	if (pci_liveupdate_is_incoming(pdev))
> > +		pci_liveupdate_finish(pdev);
> > +}
> 
> VFIO should only call pci_liveupdate_finish() from its finish()
> callback (see the kernel-doc of pci_liveupdate_finish()).
> 
> If vfio-pci is unbound from an incoming device before finish(), it
> should just leave the device and its Live Update state alone. That's
> fine: if vfio-pci is bound to the device again, the device is still
> incoming and can still be retrieved. And once the device has been
> retrieved, LUO holds a reference to the device file until finish(), so
> vfio_unregister_group_dev() already blocks unbinding it like it does for
> any other open device file.
> 
> If userspace binds a different driver to the device instead, that's
> userspace's problem. The PCI core documentation already says it is the
> user's responsibility to ensure that incoming preserved devices are
> bound to the correct driver.
> 
> So I don't think the unbind path needs any Live Update handling at all.

I think this should be doable.

> 
> >  #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> >  	bool			liveupdate_frozen;
> >  	bool			liveupdate_intx_disabled;
> > +	bool			liveupdate_claimed;
> > +	bool			liveupdate_reset_pending;
> > +	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
> >  #endif
> 
> With the simpler finish(), I don't think liveupdate_claimed or
> liveupdate_reset_pending are needed.
> 
> PATCH 13 later inverts liveupdate_claimed into liveupdate_kept_running
> and uses it to block dev_set resets while a preserved device is still
> running. That can use pci_liveupdate_is_incoming() instead. It blocks
> resets until finish() rather than until take-over, but since finish()
> now requires take-over, userspace controls that window. If some flag is
> still needed later, please introduce it once with its final name and
> meaning instead of adding it here and inverting it in PATCH 13.

