Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D37606A32C
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YIGr4w6F;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UJlFno/k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6ppas4HZ2NGOZcFcrTWA/+6VjpboNZmJZl+VQIcgy64=; b=YIGr4w6FzZjNKvK0aS/jT1vAqS
	/jVDqqUs4gq26jwlMfnAuVntnm9MKEzetgaKO6QFU4a91nBYris9f7NxEXRyJ5bHMv2P3tk4v+yc6
	2b/IssP2ImGI4rtTPczmlRK0ecHhpvF+NQ/OXU4xvlj9Wa8SxlaQ/w+E8BlqVdMw2FrV1AaNGi2ZG
	2ZOlca7Ua76ry4KUkHQkEIJzS6ozX+UVMHM5C6bMblLdCWVMFEEirYdINLlPxCDzE0jZ9StuDet40
	p529osyEM56lz8D9zWQxsm8GqfaU216eeCv/budYcHjZn+T5DUSMmsZf7GGNBgK2zjp5hrfwHjbCd
	pMevoXdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTRCo-00000007BX6-05Oa;
	Tue, 17 Nov 2026 21:59:10 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTRCk-00000007BWk-3hCG
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 21:59:08 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2e9f6a16afcso6485ad.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 13:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794952745; x=1795557545; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ppas4HZ2NGOZcFcrTWA/+6VjpboNZmJZl+VQIcgy64=;
        b=UJlFno/k8S/0dlt5YuuQ8RsVKOUQON44V/C25iXdGaxOvdGMUjqlia4k6obbRAVAF3
         lr+1kCEN4LOajjAPra3msQhoDjskBf/n52NeuBfaleQhQa+AoU8T+kg7fgOkfzVDEBSt
         MEiNxxJkqqwOf8snYRgJhsECHaCflSm1J8TetpenEvIHaLq8F3phfktRZ0UZag0k8XNd
         ytbpzWRb1acUdW8GKk2pzq5O716Hxt0xHgK5sBPkX5G2fhPN5EQdML7Ow2u12XMhv0fT
         0l2T25RLWZ/4yXp5OmpgjzYCHeNZ1T23jx48Kbzz8AubJOsDA4aZ0yrme0+1CyL6k6FC
         Ujrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794952745; x=1795557545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ppas4HZ2NGOZcFcrTWA/+6VjpboNZmJZl+VQIcgy64=;
        b=bGQtQAWz+h542FR74tUgz5HgswDordKQFOx2p1UaH1MYpNOzrk6/U+73u2sXElzr0T
         HjULJg4RXarTfDmTR9gUdshGnJ4E2Rw79SbFLBQrmtHenUmoH5ZPU1f6rPUzbOaO9KQc
         dyUhtE7clfhaCEIh0ksAeUpyGN6THxENs616tE4T2HVcwAahiW1sE2oSIolHlqrhU4Ja
         dS34WfsgK6Oz5Ic/o1KPjqKUc6uhKd5T9PTUYb/QJQxgrndDq5uolfWO3E8C/dk62Wv1
         4CqOEtGLgqyl7c6IA9fiwMQzTc8M2jBvIwZW95T7HHqaOen2W707DDhQCBd+rYs5dKJG
         IvJA==
X-Gm-Message-State: APuU4Z/3xF3Zt9pLBTv3yJhkgVCuyeMz47BaLqskLWztyrOF2UzWhMnC
	YVdSXkeVw75x5M1WChbEJwFFGf4mqDfxO11ebb7ZAsA1oVftFw5IKbxZBTZ4sVXHcw==
X-Gm-Gg: AZFdTZfabNLKukcoFhGIeWjUhmCfrm/nfOWD3e96rqjwSmpPrVwev1DDGNoYYmCAMb2
	JJM4ZvLL+b/ktU2Rs+d5oR81AS09t+Bcmsg+9w/pwOwsKsH7WoCcsohMRZZ34fPZ97yKVjXBgFZ
	c4jkv9KzbeAbYsZUR/07MQTjllEkmmTXW6J9jijoGSr8tdYRGpkPUQ//y++b37fvuvxlwUh8rgK
	KvUuZhlN0yv+jQVC94g+7kB7T/uWiq/E8WjP5xjsmK5cE9IsCVZcSieM+kHhhX4LYaSEa3Qns3v
	1DVGXy+3gjwyUe0IbY/fMoMgj44CZyADU8m0T7V54ANh4qDKII9o5yAVMH+EquVoh4yDvIR/85P
	KpMKm6pu767nY4IwmNIvs8FNP6RfMob35Zr3M+sy23BS5frqoDmipJEaMruxXvWJFnY/lUV/R4N
	MHgIy7zxXPM94TaIyjKomHnm4mjGmYdRkm6/ZmEGF2DJFCAujY7EY37CIS+kXa9Arb951ZE6Kzd
	Ufc/BB4BNrLHYtYz6c2wMHvFpvyEDS2P2bnqCddRNU6B81XFoibAjFqJ5ZpukSBsBtR20YbPLL7
	0RnaUVwOSdUsUqLz5QCvfxiVRyHdr1lDurBn1uMmH/koF3+eP/frHmHZcEgciFBm1sgWMBOcgIp
	F55AvI/wjNA14
X-Received: by 2002:a17:903:3d0e:b0:2df:96ca:d7c7 with SMTP id d9443c01a7336-2eff98e2025mr646525ad.10.1794952744396;
        Tue, 17 Nov 2026 13:59:04 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff623c4c6sm2756405ad.54.2026.11.17.13.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 13:59:03 -0800 (PST)
Date: Tue, 17 Nov 2026 13:59:00 -0800
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
Message-ID: <20261117003405.GA4153658.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <auzVEUpFEoWltpVg@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auzVEUpFEoWltpVg@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_135906_927296_631CA895 
X-CRM114-Status: GOOD (  42.33  )
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
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 07:12:17PM +0000, David Matlack wrote:
> On 2026-11-02 07:36 AM, Vipin Sharma wrote:
> >  * TOCTOU synchronization: vfio_pci_dev_is_frozen() is checked locklessly
> >    on entry to the ioctl, read/write and mmap paths, and re-checked under
> >    a lock that freeze() holds before any operation that could change the
> >    device or vconfig: under vdev->igate in vfio_pci_ioctl_set_irqs() and
> >    around every config-space write in vfio_pci_config_rw_single(), under
> >    vdev->memory_lock in vfio_pci_runtime_pm_entry(),
> >    vfio_pci_ioctl_reset() and the SR-IOV enable path of
> >    vfio_pci_core_sriov_configure(), and under dev_set->lock in
> >    vfio_pci_dev_set_hot_reset(). A racing operation thus either completes
> >    before freeze() takes its snapshot or fails, while existing BAR mmaps,
> >    ioeventfds and dma-bufs keep working. Serializing config writes on
> >    igate covers the PCI_COMMAND, INTx disable emulation, power state and
> >    FLR paths at one point (the INTx disable emulation now uses the
> >    igate-held __vfio_pci_intx_mask() and __vfio_pci_intx_unmask()
> >    helpers), and also serializes the irq_type and virq_disabled accesses
> >    of config writes with VFIO_DEVICE_SET_IRQS.
> 
> I think there's a simpler way to do this. Checking the frozen flag
> locklessly and then re-checking it under whichever lock covers each
> path spreads the synchronization across igate, memory_lock and
> dev_set->lock. That makes it hard to convince yourself every path that
> can change the device is covered. It also makes every config space
> write take igate, for all vfio-pci users, even when
> CONFIG_VFIO_PCI_LIVEUPDATE=n.
> 
> Instead, I suggest adding a per-device rw_semaphore to struct
> vfio_device in the VFIO core, e.g. liveupdate_rwsem, that protects a
> liveupdate_frozen flag:
> 
>  - vfio_device_fops_unl_ioctl(), vfio_device_fops_read() and
>    vfio_device_fops_write() take liveupdate_rwsem for read and fail
>    with -EIO if the device is frozen. That covers every device ioctl in
>    one place, including the ones handled by the VFIO core
>    (VFIO_DEVICE_FEATURE, VFIO_DEVICE_GET_REGION_INFO and
>    VFIO_DEVICE_{ATTACH,DETACH}_IOMMUFD_PT). This patch doesn't block
>    the last two at all today.
> 
>  - freeze() and unfreeze() take liveupdate_rwsem for write, before any
>    other lock, and flip the flag. preserve() doesn't need it since it
>    only serializes state that doesn't change after the device is
>    opened.
> 
> Putting this in the VFIO core also means other VFIO drivers can reuse
> it if they add Live Update support in the future.
> 
> The lock order then becomes:
> 
>   liveupdate_rwsem -> dev_set->lock -> igate -> memory_lock
> 
> freeze() can still take igate and memory_lock to check irq_type,
> pm_runtime_engaged and sriov_active. But the ioctl, read and write
> paths no longer need to re-check anything under those locks. So you
> can drop the igate change in vfio_pci_config_rw_single(), the
> open-coded vfio_pci_zap_and_down_write_memory_lock() in
> vfio_pci_runtime_pm_entry() and vfio_pci_ioctl_reset(), and the
> smp_load_acquire()/smp_store_release() pair.
> 
> Two paths still need their own handling because they don't go through
> the device's file:
> 
>  - vfio_pci_core_sriov_configure() is reached through sysfs. Take
>    liveupdate_rwsem for read around the frozen check and the
>    sriov_active update.
> 
>  - VFIO_DEVICE_PCI_HOT_RESET issued on one device also resets the other
>    devices in its dev_set. Keep the check in
>    vfio_pci_dev_set_hot_reset() under dev_set->lock. freeze() sets the
>    flag while holding both liveupdate_rwsem and dev_set->lock, so
>    holding either one is enough to read it. Please don't take the other
>    devices' liveupdate_rwsem there, since that would invert the lock
>    order relative to freeze().
> 
> I don't think mmap needs to be blocked at all. Creating a new mapping
> doesn't change the device or any of the state that gets preserved, and
> existing mappings already keep working while the device is frozen.
> Leaving mmap alone also avoids taking liveupdate_rwsem under mmap_lock,
> which could deadlock: the ioctl, read and write paths can fault on user
> memory (taking mmap_lock) while holding liveupdate_rwsem for read, and
> freeze() may be waiting for the write lock. Please update the comment
> in freeze() and the DOC section to match.
> 

Thanks for suggestion, this is indeed simpler.

> > diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> > index 9914f3ac69ae..1f1ac7a798aa 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -644,10 +644,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
> >  
> >  		if (virt_intx_disable && !vdev->virq_disabled) {
> >  			vdev->virq_disabled = true;
> > -			vfio_pci_intx_mask(vdev);
> > +			__vfio_pci_intx_mask(vdev);
> >  		} else if (!virt_intx_disable && vdev->virq_disabled) {
> >  			vdev->virq_disabled = false;
> > -			vfio_pci_intx_unmask(vdev);
> > +			__vfio_pci_intx_unmask(vdev);
> >  		}
> >  	}
> 
> With the rwsem, config writes no longer need igate, so this change
> isn't needed. If config writes and VFIO_DEVICE_SET_IRQS really do race
> on irq_type and virq_disabled today, that's unrelated to Live Update.
> Please send it as a separate fix.
> 

This will go away.

> Lastly, please add the freeze infrastructure and the checks in their
> own commit ahead of this one, e.g. "vfio: Add infrastructure to freeze
> devices for Live Update". Then this patch only has to implement
> freeze() and unfreeze() on top of it, which will make both easier to
> review.

Sounds good. Thanks for the review.

