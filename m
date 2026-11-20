Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B058606A320
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BrED9DGY;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d9O6jCT4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tQwX2YSXjHFZhdcGcul9Os/DsNb3L2Z/dlwRM94y3qk=; b=BrED9DGYYIpPzg
	FTrB5sIv41XCxDPyhcH0O4Lr8UFnYMeFWB7aeKnZ8Tkus4ZCBZ/KrhlG+17oTI5CypN4JO7U8irsj
	arsfosfjdftuKKbZ2ciufh1MUVl88NNKhf2MPQUYiCU6e4jgb8XsSLKTvPnBs4doRfRO8gcEOsz4u
	kWbqO6nFD40eE83GcrXstI1LlAhG1OXPYwO6sKhzAS0PkQ+ezHFom2kgSA5QpX87GvyTze21+7M/Y
	gEilQUfxxWaAfuDluaCXWlf76NWK+rV5RAgGy5O8uo8w+R/IOeJWJSRWvvub/vW191X5tR5sRNsnS
	FGWJFpNaIPhYJLxViXWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUD0K-0000000Dn4c-1eRr;
	Fri, 20 Nov 2026 01:01:28 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUD0G-0000000Dn3z-1tHb
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 01:01:26 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso142985a12.1
        for <kexec@lists.infradead.org>; Thu, 19 Nov 2026 17:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136482; x=1795741282; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tQwX2YSXjHFZhdcGcul9Os/DsNb3L2Z/dlwRM94y3qk=;
        b=d9O6jCT4vUNcs3gM3jdfALmcmmFUP1i4UVp990XwIdqxuF+IvDt1A6je7kesO69cLU
         V5G/YgyTCrv88EzmJ2V/02kR4TdNWioi/jjZPHDgrYCV4t5MPuYPKcdGQGrU+MhZfsrg
         r6y02eWAIk4CsVgVUow52y6bTtel56FDXLuRaEXm1sXxDI/8T0qvuntCdBP32kZTov/k
         5Z1Etv0RWQQAaMmt8hFMBDijZWQae3etlVGMP2z5vO9JChdpTZtcvWNLgWDGzWhfSupL
         3ESqYnK5rGwW7Z0dgHFogTrtGoI+SkZzZiqtL1cWzUtqqWjE9rZKe0txk8oGLkUAIy1Q
         czqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136482; x=1795741282;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQwX2YSXjHFZhdcGcul9Os/DsNb3L2Z/dlwRM94y3qk=;
        b=0odbAiO/oiCAF9JZ786J3SzD3I8ngX6mXQmCe/Dgn5VfrLZf3lo4+BLS4FOJF7ZHNI
         QwY69vwov5nUFSdP0SjJVdp6PAu8jvXnxgfFN1gUaHh5oN+t5AnZieQGVNUxTmdUaZXu
         wZwYF5VUtniiDWnd5ElN0cuU5GIGSSfOJJQX8ZFSP4exB7hzkc5rvfmAS2Fh1l93Z/uA
         MVPUABvC4jaHNdGIlIh80xtrn+OMLYUfwVLMVTFPdFcx1xJIGjoWV+WKrsZRetoMr2Ok
         DgwxMxjGtHfYD9LLTzyQQYSOw/cIw28IYljYEG3hO93tDI1SJS5vmve7Repv3HpJCoI5
         5s1g==
X-Forwarded-Encrypted: i=1; AL+hErHDQ9CBJ1CvBkJjfj1zZTLyJsPtpKy2dOCida8vbOH21nzEmuU1dUdCtfTHChUwTqFwNplNQw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+a98eD8hMINuuJ6SKstsd9WcbJwtFPUTPtNe/9Wpx7aJ/e/oRd
	DY05B55mh9M0RPEkyKJyQK9qUlf40aK9syZR+mRfNDka1kAsP+bF1qr8QsQNTan5Yw==
X-Gm-Gg: AZFdTZfwbUVj5Izxkh88Cvq9z3nWdfpU11/f6ITJBBM5PF9PiGY0IqgxR8H2WIG0mqX
	1GjM/DjEZbGLJ0hUk25oQRz8e3fiM5j9hhF6ezxOAXMQkQ5Vt8VLiECVnT3zSrhdV/uZ56xo8Qv
	3iZBqcBfgh9+Tq8hk21kdVgyywKoMZH2NEpOWh8ApeQXOR8v+QtRJz6Y/G1YGz5NkrTu/EirfRa
	GuWYiSEddZ/Rb4j+eK8MZQ800DUfSK9BCBPdwcyM4IltffI0GUKZwIWwgSbceWNQWGOPyDIpR7b
	/Ume598JpTKG4qQNiZdZWYmlHj0hFARHQcOWZao4SfZj8Asb6d0zUlrJTFAz6XqNBuvCFVNDaZu
	KovvThC45E4Y5utrF1ixKDvXR4xgnQMj+SOe0c/4z8BrObjVlh0tsVNSUwSLluER3EAsOJRhxHS
	cuia0BJW/F20STKds3TkzUQ9CdCnqcNPuiFU6Yepy8XryD9weVpFwQ0MJlEMIZWk2FGMuAdyVEb
	iFSxIdqnvALWgYGDu4V2boU2H2RBOs/T2VAp1cDGwCpfAQoWLnyvcsEBgelsRz3hwdAx0TBIJqC
	cp5oVIIuaLxFIKetxh90HajN+sNaBALg/bdYoDkqbkOcp+AgvH2mEbq8cbJoyWQt
X-Received: by 2002:a17:90b:4b87:b0:3b4:a63:d55c with SMTP id 98e67ed59e1d1-3b41c93b17cmr965473a91.30.1795136481385;
        Thu, 19 Nov 2026 17:01:21 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm4865271a91.10.2026.11.19.17.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 17:01:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 17:01:19 -0800
Message-Id: <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-12-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_170124_534844_72C87CF3 
X-CRM114-Status: GOOD (  39.35  )
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

On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> Enable userspace to retrieve preserved VFIO device files after a Live
> Update by implementing the retrieve() and finish() file handler
> callbacks.
>
> During retrieve():
>  * Validate the handed-over struct vfio_pci_core_device_ser header,
>    sizes, and flags.
> [...]

Please make the commit messages in this series easier to read. They are
mostly long bulleted lists of everything the code does, which is hard to
follow and largely repeats the diff. A commit message should explain, in
prose, what problem the patch solves and why it solves it this way, and
only call out details that a reviewer can't easily get from the code.
This applies to most of the patches in the series (e.g. PATCH 07 and
PATCH 13 too).

> Do not implement can_finish(): closing a retrieved LUO session invokes
> finish, and refusing can_finish() would leak the session and leave
> unclaimed devices running. Instead, finish() always completes:
>  * If the retrieved device was claimed by opening it via
>    VFIO_DEVICE_BIND_IOMMUFD (which consumes vdev->liveupdate_incoming;
>    subsequent patches replace the open-time reset with non-reset
>    take-over, reject opening incoming devices other than via retrieve(),
>    and protect incoming kept-running devices across runtime PM, dev_set
>    resets, and non-noiommu boots), finish() simply completes its PCI
>    Live Update participation.
>  * If the device was not claimed (never retrieved, retrieve() failed, or
>    retrieved but never bound via VFIO_DEVICE_BIND_IOMMUFD),
>    vfio_pci_core_liveupdate_reset() logs one pci_warn() naming the
>    device, clears PCI_COMMAND_MASTER, resets the function, and restores
>    the inherited pci_saved_state just as closing the device would. If
>    the device has a function reset but is not reset, e.g. because
>    pci_dev_trylock() contends with a concurrent driver unbind, latch
>    vdev->liveupdate_reset_pending so vfio_pci_core_unregister_device()
>    completes the function reset and state restoration via
>    vfio_pci_core_liveupdate_reset_locked() under the device lock held by
>    device_release_driver(). Opening the device after finish() resets it
>    like any open, so it drops the latch.
>  * If the device was not retrieved, look it up under pci_dev_lock(),
>    which waits for a vfio-pci probe in progress. If it is bound to
>    vfio-pci, finish it as above. If it has no driver, clear bus
>    mastering and reset it. Otherwise leave it to the bound driver.
>  * Call pci_liveupdate_finish() and kho_restore_free() on every path.

This is a lot of complexity for one commit, and it's hard to review. I'd
like to start with the simplest approach and build from there: implement
can_finish() and have it return false until the device is fully
retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
Then finish() only needs to free the incoming state and call
pci_liveupdate_finish().

That gets rid of vfio_pci_core_liveupdate_reset(),
vfio_pci_core_liveupdate_reset_locked(),
vfio_pci_liveupdate_finish_lookup() and its bridge and device locking,
liveupdate_reset_pending, and most of the finish documentation. If you
want to handle the other scenarios (devices that are never retrieved or
never bound, devices bound to other drivers, unbind racing with finish),
please add them in separate commits on top, each with its own
justification.

As for closing the session leaking it and leaving unclaimed devices
running: that only happens if userspace closes the session without
taking over all of its devices, and leaving the device running with its
memory still preserved is safe. Resetting the device in that case is
something that can be added later.

It also has a nice side effect: LUO calls can_finish() on every file in
a session before finishing any of them, so a memfd in the same session
that the device DMAs into can't be finished before the device has been
taken over.

> +static int
> +vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
> +				    struct vfio_pci_liveupdate_incoming *in)
> +{
> +	guard(mutex)(&vdev->vdev.dev_set->lock);
> +
> +	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
> +	    !pci_liveupdate_is_incoming(vdev->pdev))
> +		return -EBUSY;
> +
> +	vdev->liveupdate_incoming =3D in;
> +	return 0;
> +}

The pci_liveupdate_is_incoming() check here is redundant with the one in
vfio_pci_liveupdate_retrieve(). Nothing can clear it in between, since
only finish() should do that (see below) and LUO holds the session mutex
across both retrieve and finish.

The liveupdate_claimed check is redundant too: LUO only lets a token be
retrieved successfully once, PATCH 12 prevents opening an incoming
device any other way, and the liveupdate_incoming check already prevents
attaching twice.

> +	if (!pci_liveupdate_is_incoming(pdev) ||
> +	    ser->cfg_size !=3D pdev->cfg_size) {
> +		ret =3D -EINVAL;
> +		goto out_put_dev;
> +	}

If the device isn't incoming here, that's a kernel bug. The previous
kernel only preserves the file after pci_liveupdate_preserve()
succeeds, the PCI core marks the device incoming when it's enumerated,
and only VFIO's finish() should clear it. So this should be a
WARN_ON_ONCE().

> +	if (pci_liveupdate_is_incoming(pdev))
> +		pci_liveupdate_finish(pdev);
> +}

Likewise, the device must still be incoming here, so
pci_liveupdate_finish() can be called unconditionally.

> +static inline void
> +vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +
> +	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
> +		/*
> +		 * Complete a reset that finish() could not do, see
> +		 * vfio_pci_liveupdate_finish_vdev().
> +		 */
> +		if (vdev->liveupdate_reset_pending) {
> +			vfio_pci_core_liveupdate_reset_locked(vdev);
> +			vdev->liveupdate_reset_pending =3D false;
> +		}
> +		vfio_pci_liveupdate_free_incoming(vdev);
> +	}
> +
> +	if (pci_liveupdate_is_incoming(pdev))
> +		pci_liveupdate_finish(pdev);
> +}

VFIO should only call pci_liveupdate_finish() from its finish()
callback (see the kernel-doc of pci_liveupdate_finish()).

If vfio-pci is unbound from an incoming device before finish(), it
should just leave the device and its Live Update state alone. That's
fine: if vfio-pci is bound to the device again, the device is still
incoming and can still be retrieved. And once the device has been
retrieved, LUO holds a reference to the device file until finish(), so
vfio_unregister_group_dev() already blocks unbinding it like it does for
any other open device file.

If userspace binds a different driver to the device instead, that's
userspace's problem. The PCI core documentation already says it is the
user's responsibility to ensure that incoming preserved devices are
bound to the correct driver.

So I don't think the unbind path needs any Live Update handling at all.

>  #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
>  	bool			liveupdate_frozen;
>  	bool			liveupdate_intx_disabled;
> +	bool			liveupdate_claimed;
> +	bool			liveupdate_reset_pending;
> +	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
>  #endif

With the simpler finish(), I don't think liveupdate_claimed or
liveupdate_reset_pending are needed.

PATCH 13 later inverts liveupdate_claimed into liveupdate_kept_running
and uses it to block dev_set resets while a preserved device is still
running. That can use pci_liveupdate_is_incoming() instead. It blocks
resets until finish() rather than until take-over, but since finish()
now requires take-over, userspace controls that window. If some flag is
still needed later, please introduce it once with its final name and
meaning instead of adding it here and inverting it in PATCH 13.

