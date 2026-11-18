Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50B606A334
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nRCrDqNw;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SNhvGgtF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1gbh0okTI8s6EjfIrwbYjY5j+vGizMFhIhkRj367QiY=; b=nRCrDqNwoBaoaAVuf4UBkXQ6Kt
	ZAWf/qdWFjTDnGNvSNiZNo9NBu3qI33C1fHtAS0lpN136jc+msIOKJSrV+zOX+8kKBzMGWUjpkxBO
	wfVhCltH8cMiah0lzgh8UFPkx7LoIhbsWRsEQswpW3WUaO37zAUF5MHp8XYChEyR4rBxy8ui1I8aL
	JIBLmVnfMtvD30aDB1NB9gaULG4xOWBT8No74ZWBFwwn+c9XY64Z1VGJ0tXlx0s50LYm5dqiAz8J/
	WCVkCQpbM8JHYndR/7VozP/Ian+KKUcR+DyBYbp80wDV5sMt/L/N5Wd3tpiGhaPkwkesB4o54mS1e
	uhpqVJQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZPH-00000007vXS-1CWn;
	Wed, 18 Nov 2026 06:44:35 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZPF-00000007vWl-0ykR
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:44:34 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ee254f6eefso47485ad.0
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794984272; x=1795589072; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1gbh0okTI8s6EjfIrwbYjY5j+vGizMFhIhkRj367QiY=;
        b=SNhvGgtFHKByCM8FJzy9fjQDCkjnaljtSC3ar+i6mrnvFmj0a/TVYIPmt0dyR7//iy
         v+3sCmI4SpSjgA6uCN2VJ6ECT/XgUKU2a6F5kIs8s1bdJ90vGpf7doDHh2Rjo0HwX3HE
         H6WIiP7CSMz2h9MLlOaTUWPu5HTeit0XTPw/j6y9f6+6NiFkKe11LDASj0YJd37EUlw8
         H9al0JPhb8pl39F+SpyUhnfimue5xj8qChd3IFs8xUuMkmpDXVKm1NMyStVite3WgYQi
         U1hmyQyStnKC/5rw+SSSh0527iS4NItgJ7+DzLUv80fkSsG1LprSO4ZCc6w0YrIQfbu6
         8wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984272; x=1795589072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gbh0okTI8s6EjfIrwbYjY5j+vGizMFhIhkRj367QiY=;
        b=16+Rg07UpRduMs2JFVlWgID4zSEyRw+LqECHf1cDB5h1TjUuVnrUGiRu04X3x85Kec
         9ldf/WMwNPr4SvIOBwZb7tSEdZl2dDySlPKAhJDC/siliB5UgFwqLAyUBdQQvYk0IiEZ
         +aALvw9b56ROzT5ujPFuRqXFElVHp/r7Wgz48YhxincAc3B0Bjb1JnvXgZ4UbSYMIO+4
         hERUTymn9Megmgx5MWItutZEJFUMwbCEgerJaDi0KsyUuzG8bGpGX73qk69eLO+v3rUR
         Ql5E7ec3lE4uEzE7QaPzmSxzW40ejVmjsRzyvghMNZKE9ElG/hvMd091ji4Vv+Yi4QnU
         1Gig==
X-Gm-Message-State: APuU4Z//vOxIYO1PYpJ6B8Xc2CBmwXKAn2M0H5xvvwH1WDt4QyzkYE3R
	j7DV53rCe7KhvCRmX4BJ2LRxBVatqys8jczeACMreyYNu73KKYqD6BSvsICYf1bhvQ==
X-Gm-Gg: AZFdTZc4VURWFZ7t1lNv7rnPT5MQweX33gxBcSrzMOdudvCfHquPWs+KbnuJRiUsXB5
	oJMr8qS8TbfKcJRGlciVV6qrBjmf3RF7+4RWTJHtg9RhS4rQWPguf+j4XEO9qQNep+r+ZTrtl50
	ssTNe0ll7xegAf3x3l6tsUh4/TNhozcSDzzSrA5csoaf7L47vjUVdFoBiomXgAffihRE7A25L7i
	O0nLz5HRDi2y3lwUQZemUDKR2gj+S4wKB/dOkD3/+GA8og/QMUAQu61AZpwyR1AYbYyAMlp18dz
	/MoVbQL6wvRWPodH1Ki4LgCU8z8lsNizmeq/n5/xIx55FRdPCDIz1gI8b/kfAlxqgTZLOVllQpY
	HNfQfrUjAs1s8uIucYW3x8ijnSDoo+C3KO0ojDtl16LOmygsHwm/KcpZb97lgzWzqFPolAs2A4x
	bCi98U4ab3USGbyrtndAOvtnjSKjZ4cPyaenryNoco3GzUr+d0B4cO9XLpdVJSiURz+9ZfQFtqJ
	NTPHlEt8naA+ApP2CJ1JpKVOyBmhDxKhlLbr4hSk4tEgarenDAAuGlKKOS7j5JATRPkmC0a/YzY
	br5odjg31Yl9tqsulxWFG0knuIrSn2NdoJr3M0aOUJ/LWnBrLQHmfILhyF4TRCie
X-Received: by 2002:a17:903:1ae8:b0:2e7:e742:8bb5 with SMTP id d9443c01a7336-2eff991431fmr2871605ad.14.1794984271479;
        Tue, 17 Nov 2026 22:44:31 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d187df25sm2719005a91.3.2026.11.17.22.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:44:30 -0800 (PST)
Date: Tue, 17 Nov 2026 22:44:26 -0800
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
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20261117220059.GA2250529.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <auzftbPFO_6XBYVw@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auzftbPFO_6XBYVw@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_224433_289128_F732FFFC 
X-CRM114-Status: GOOD (  60.70  )
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

On Thu, Nov 05, 2026 at 07:57:41PM +0000, David Matlack wrote:
> On 2026-11-02 07:36 AM, Vipin Sharma wrote:
> > + * DMA Memory Ordering Contract
> > + * ============================
> > + *
> > + * Because a preserved noiommu device continues performing DMA using physical
> > + * addresses across kexec, any memory buffer targeted by device DMA must remain
> > + * at the same physical address in both kernels and must not be freed to the
> > + * page allocator while the device can still access it:
> > + *
> > + *  * When using a LUO-preserved ``memfd``, userspace **must** preserve the
> > + *    ``memfd`` in the **same** LUO session as the VFIO device and **before**
> > + *    preserving the VFIO device. LUO finishes files within a session in reverse
> > + *    preservation order (LIFO), guaranteeing that if the device is not taken
> > + *    over in the new kernel, VFIO's ``finish()`` callback stops bus mastering
> > + *    and resets the device before the ``memfd``'s ``finish()`` callback releases
> > + *    its folios. Cross-session ordering is the responsibility of userspace.
> > + *
> > + *  * After retrieving a preserved ``memfd`` in the new kernel, its folios are
> > + *    ordinary unpinned shmem page cache until pinned again; userspace must keep
> > + *    the ``memfd`` alive and re-pin/map it before finishing the session, and
> > + *    must not rely on a ``memfd`` whose ``LIVEUPDATE_SESSION_RETRIEVE_FD`` call
> > + *    failed (failed ``memfd`` retrieval frees its folios immediately).
> 
> Most of this section documents LUO and memfd behavior (finish ordering
> within and across sessions, what happens to memfd folios after
> retrieval), which belongs in the LUO and memfd documentation rather than
> here. The VFIO documentation should just state what VFIO requires of
> userspace and what happens if userspace violates it. Something like:
> 
>   DMA Memory
>   ==========
> 
>   A preserved device keeps performing DMA across kexec to the physical
>   addresses it was programmed with before kexec. VFIO does not know
>   which memory the device accesses and does not preserve it. Userspace
>   must ensure that all memory the device can access stays allocated at
>   the same physical address in both kernels until the device is stopped,
>   either by userspace after taking it over or by VFIO when the session
>   is finished. If userspace violates this, the device can corrupt memory
>   that has been freed and reused by either kernel. VFIO cannot detect
>   this.
> 
> VFIO doesn't stop the device when the session is finished until
> PATCH 11, so either add this section there or drop that clause here and
> add it in PATCH 11.
> 

Sounds good. I will remove memfd from here and mention thing what VFIO
expects.

> > +	cfg_size = pdev->cfg_size;
> > +
> > +	if (cfg_size != PCI_CFG_SPACE_SIZE && cfg_size != PCI_CFG_SPACE_EXP_SIZE)
> > +		return -EINVAL;
> 
> pdev->cfg_size isn't limited to these two values. PCI quirks set other
> sizes, e.g. quirk_citrine() (0xA0) and quirk_nfp6000() (0x600), and
> vfio-pci handles those devices fine since vconfig is just pdev->cfg_size
> bytes. This check only seems to exist to bound the variable-length
> layout of struct vfio_pci_core_device_ser, which goes away with the
> changes suggested below. Please drop it.
> 
> > +	total_size = size_add(sizeof(*ser),
> > +			      size_add(size_mul(2, cfg_size), saved_size));
> > +	if (total_size > U32_MAX)
> > +		return -EOVERFLOW;
> > +
> > +	ser = kho_alloc_preserve(total_size);
> > +	if (IS_ERR(ser))
> > +		return PTR_ERR(ser);
> > +
> > +	if (saved_size) {
> > +		void *dst = ser->data + 2 * (size_t)cfg_size;
> > +
> > +		err = pci_liveupdate_serialize_saved_state(vdev->pci_saved_state,
> > +							   dst, saved_size);
> > +		if (err) {
> > +			kho_unpreserve_free(ser);
> > +			return err;
> > +		}
> > +	}
> 
> Please don't embed struct pci_saved_state_ser in VFIO's serialized
> struct. Variable-length serialized structs should be preserved in their
> own allocation, and VFIO should just store the physical address (0 if
> there is no saved state). That way the PCI core owns the size, flags and
> validation of its own ABI, either struct can grow without changing the
> layout of the other, and the offset math here and in PATCH 11 goes away.
> struct pci_ser already references its devices array the same way.
> 
> I plan to structure the PCI core helpers for serializing and
> deserializing struct pci_saved_state to require this. The PCI core will
> do the allocation and just return a pointer to the serialized saved
> state. But I just wanted to call it out here.
> 

Sounds good, v7 will store physical address returned by new PCI helpers.
I will base my series on top of your PCI saved state series latest
version. Current one is v2 at 
  https://lore.kernel.org/all/20261106004218.604799-1-dmatlack@google.com/

> > +	ser->flags = vdev->reset_works ? VFIO_PCI_SER_RESET_WORKS : 0;
> 
> reset_works shouldn't be serialized. Alex's series replaces
> vdev->reset_works with pci_reset_supported() [1], which only looks at
> pdev->reset_methods. Those are set up at enumeration without resetting
> the device, so the next kernel can answer the question itself. And the
> next kernel's answer is the one that matters, since it's the kernel that
> will reset the device.
> 

Thanks for bringing it up. I will send that specific patch separately as
discussed in
  https://lore.kernel.org/kvm/20261118000511.GC2250529.vipinsh@google.com/

> Please base on that series (or cherry-pick that patch) and drop
> VFIO_PCI_SER_RESET_WORKS, along with the incoming reset_works copy and
> the reset_works argument to vfio_pci_core_liveupdate_reset() in PATCH
> 11, and the copy in vfio_pci_liveupdate_take_over() in PATCH 14. flags
> then has no defined bits, but please keep it (and keep rejecting unknown
> bits) for future features, see below.
> 
> > +	if (!vdev->vconfig || !vdev->pci_config_map ||
> > +	    ser->cfg_size != pdev->cfg_size)
> > +		return -EINVAL;
> 
> ser->cfg_size was set from pdev->cfg_size in preserve(), and
> pdev->cfg_size doesn't change after enumeration, so the cfg_size check
> can't fail.

Yeah, this is redundant.

> 
> > +	memcpy(ser->data, vdev->vconfig, ser->cfg_size);
> > +	memcpy(ser->data + ser->cfg_size, vdev->pci_config_map, ser->cfg_size);
> 
> pci_config_map doesn't need to be preserved. PATCH 14 already rebuilds
> it with vfio_config_init() in the next kernel and only uses the
> preserved copy to check that the two are identical.
> 
> I assume the intent is to detect changes to vfio-pci's config emulation
> between the two kernels, but the map isn't a good proxy for that. It
> changes for differences that don't matter (e.g. hiding a capability or
> learning the length of a new extended capability), which would fail
> take-over and lose the Live Update on exactly the kernel upgrades Live
> Update is meant for. And it doesn't change for differences that do
> matter, like which bits are virtualized or writable within a capability.

I think it does matter because reads and writes of unitialized
capabilities in VFIO PCI config space goes to hardware directly. So, in
the new kernel if pci_config_map changes it from PCI_CAP_ID_INVALID to
others then those reads/writes can go to vconfig which will contain
stale unitialized data from the old kernel's heap.

This also changes behavior under a running user. Writes that reached
hardware before Live Update can be silently dropped or redirected to
vconfig. See the comment above struct perm_bits unassigned_perms{}
in vfio_pci_config.c

I do agree current patch is not protecting against bits virt/write
changes inside a capability, which is also important.

> 
> Preserving vconfig makes vfio-pci's config emulation part of the
> contract between kernels either way. I think changes to the config
> emulation that affect how a preserved vconfig is interpreted need to be
> tied to a userspace opt-in, recorded as a flag in struct
> vfio_pci_core_device_ser. A kernel that doesn't understand the flag then
> rejects the preserved device, and userspace shouldn't opt in while it
> can still roll back to a kernel without the new emulation.

How would a userspace opt-in? New kernel can change a capability visiblity
or virt and write permission of the bits inside a capability. Kernel
cannot know if userspace used the capability or not. Creating a VFIO
device in the new kernel by default results in a opt-in and currently
there is no way for userspace to opt-out unless we add a new
functionality where userspace can disable/enable features something
similar to KVM capabilities.

For now, I think we don't need to worry about it. As this version will
be a base and if any serialized data with flags set received in this
kernel will lead to erroring out restore.

In the next version, I will not preserve pci_config_map. Hopefully,
anyone changing VFIO code doesn't forget to update flags if they change
capability or permission bits (I will write comments at appropriate
places.)

If we want to be very careful, we can do two things in this series:

1. Create a per bit valid mask for the vconfig and compare this between
   new and old kernel during restore. In the new kernel, VFIO then takes
   each bit from the preserved copy only where the mask says it was
   valid, and keeps its own freshly initialized value elsewhere.
2. Create a hash or store virt and writable bits in config space.
   Compare it with the new kernel.

Both of the above combined will safeguard against forgotten flag update
in the code.

We don't have to do it but it safeguards against mistakes. Let me know
what you prefer.

> 
> > +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +	vdev->liveupdate_intx_disabled = !!(cmd & PCI_COMMAND_INTX_DISABLE);
> > +	if (!vdev->liveupdate_intx_disabled)
> > +		pci_intx(pdev, 0);
> 
> This doesn't mask INTx on devices with pdev->broken_intx_masking set,
> either because PCI_COMMAND_INTX_DISABLE isn't writable or because a
> quirk marks INTx masking as broken. vfio-pci normally masks INTx for
> those devices at the interrupt controller, but nothing does that across
> kexec, so the device can still assert INTx in the next kernel before
> anything is ready to handle it. If the line is shared, that can get the
> line disabled as spurious and break the other device.
> 
> Please reject those devices in preserve() if they have an INTx pin and
> !pci_intx_mask_supported(pdev), and add that to the Restrictions in the
> DOC. Check the PCI core flag rather than vdev->pci_2_3, since
> vfio_pci.nointxmask=1 clears pci_2_3 even when INTx masking works.

Agree, I will reject those devices in preserve().
> 
> > +struct vfio_pci_core_device_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 cfg_size;
> > +	u32 size;
> > +	u32 flags;
> > +	u32 saved_state_size;
> > +	u32 reserved;
> > +	u8 data[];
> > +} __packed;
> 
> Once config_map and the saved state are gone, vconfig is the only
> variable-length part left. Please either make it a fixed-length array
> sized for the largest config space (PCI_CFG_SPACE_EXP_SIZE), or preserve
> it in a separate allocation like the saved state. Either way this struct
> becomes fixed-size and data[] goes away.
> 
> cfg_size should stay, to record how much of vconfig is valid. The next
> kernel computes pdev->cfg_size on its own and could come up with a
> different value, so it needs to check that ser->cfg_size matches (and
> fits in the vconfig buffer) before using the preserved vconfig. Doing
> that once in retrieve() should be enough.
> 
> I understand this will waste some memory today, since each KHO
> allocation must be a multiple of a PAGE_SIZE. But that is a KHO problem
> that can be fixed later.
> 

I agree. I will change data to fixed size for vconfig. We will not need
pci_config_map, and pci saved state array.

I am planning to add two flags required and optional similar to your PCI
serialization struct.

Thanks again for the review.

