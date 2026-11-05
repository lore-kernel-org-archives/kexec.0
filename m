Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075A606A32D
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bIuQAixJ;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=afm5Fdnb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QH8EWm3WpJvKmm+3SH11RyockHxBeCCGhqou8vP+rPk=; b=bIuQAixJShiHbF7BRPXKs5AyEr
	Qy76ir53tZaKnPRP6f68KXaVDNp8jLr2MOVWpW/WRJ//ZybhtGPSKNItkJUuKhTBoEz8j6E026JZU
	9BiGkPFi8IpcPTo2a0xUM+9h9IGY1qSn5w4HcUEsnwOyip9B0o9eUOG2+OXiDUOP3QIAcor6dUiSO
	/ms5m9PJY37Mqxj6O3+I0UySpy8LWozWXdnHb2JMlqN/DL8XUbn7hiGVdjWHjXMpnHACNnoxzSAD1
	Wz0Y9wvS7L6toU5LfRq49pyNZ35qp62MKvFXNdCMOU9ivI1Uesb25uwyoFq2xvx8YJa3USZcbEI90
	pd/5YG/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2ss-0000000AIVB-432S;
	Thu, 05 Nov 2026 19:12:26 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2sq-0000000AIUn-14n1
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 19:12:25 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso945324a12.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793905942; x=1794510742; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QH8EWm3WpJvKmm+3SH11RyockHxBeCCGhqou8vP+rPk=;
        b=afm5FdnbqudN3Xsc/Qq///VR+bPkL6TmrI0MHy7c6KSGiNphTm1g8Vpj8wOmcGHoxg
         0OWh3HIN/QrHfsT0yfbGEqy59iQu36OB7y7GhWWcGMZbp3WOydahzJUzWH+xffG9uaDf
         BdElF6qky+nLe8x37fPjGn8Gaz1splW/cX7f4T50OKFyDQ/JjWsYKj/ztImL0fkv14/N
         Oo4SSLiccg1j9yN+VarUsWHPf2bD8hIGoZm6ZhAefZciSLnNpemef+H4X1rWpyu2vQRt
         DHqOyAGpyhBzmET+T4wMX9fBXP+iqH3cdh/WdA+cWQ1iC/ukkdYoO3l1Iw/unX7ijSqc
         l2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905942; x=1794510742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QH8EWm3WpJvKmm+3SH11RyockHxBeCCGhqou8vP+rPk=;
        b=FlK9Gb/a/R3YLobUajA3ps+Tkbr0Vq+5qATmIEU4jTvelbHzzPRyAGanBNIkt5YviE
         nS5raewWCfa3aNgQ7z0bn10jVpi4c9to/mg3gz0B2PSKjftpwmoXmJ7s0oMZJgEuNKFu
         TUBWcRpC6A0RdKXf5xrsNWG7RhadFkGbOPrtR1NdUdnnMt2GwcjRNfmcwo+75337a3cz
         WPfnDHhA2SoiXveEndzCxlqJ42uWZ1fha3SUwIEVDmNMgXI7FydvJaQUB4xHDsdAk9ms
         MXBefFzxiWDplJcjvE8tE0EpxXS03euqc3DDzK4E3bXc6IG8mQsSO1nDGLyW4WzNhYK3
         +shw==
X-Gm-Message-State: APuU4Z90LLMOQAam57Wpt5407S2RyqH3BCGfy3iClV0f1S1LA4vIoAkt
	m5pJvkktQGwyBq9muf5JPgFUCjgwAnKCVH5juw/pUkfe05BezKhe6bBUqou9EWcU+g==
X-Gm-Gg: AYBFou3g3Hml9TqD6OoGtP30p9McUgMbsC9ts3d1HHGadOPoOgNO8eR7J54uRWEzb0W
	XCqsXPL6YpGtMGpgm5YfKM56Z4AbHAV3+ugS0egeKYvu9oXT/QO526oYdA5TYJYHON2oCl/JwKQ
	4MmHLJeYrv2VPvHeId8ynhkJeZaLB7nTDScquS/jvj3FCoczvkPTx4sac4R7C1cJ7GTF2OJKg9n
	8MKG/xWpeOkWbTV3+0fERX3XlKU7FAFUOawny8U+4tVx2AuWrqr2niITfhfDUvZDy0liNqqu3JR
	x4O2IfF4oA3+PwpJyBUccoJdMPX3mjAwZlBl+7nRKkF9OwLh9C6BorNeo2MkYCq7vQd7ahEI4nj
	PlID/n9Q8mEmGOP54y+DIfVHLiccoDE45rlZ8SKcLWvU5IINZFwIROqkf6jZYF6aMPr4MKBkhj5
	RO0zvht10sJ4+PmzvdSirTDUNmwBGu5nLifVGToJ2H2TmchalCxGM4XQSycaOSPdduPgEHyC3Kc
	fteCFkrOKPeUxYsZhBUDFqy3XMtQSltijIYu7cGSU7IujvC5Fq14kCEYfPX6X4faQn6BRmsLRNe
	c86q8H9YHN22OdONCBHO6j6+EPGSUjwpnHzZyC2+TRdlTDLY+CWlbui8XHLVpXcP
X-Received: by 2002:a17:90b:268a:b0:3ac:7c52:faeb with SMTP id 98e67ed59e1d1-3ae89769d66mr17879218a91.41.1793905941532;
        Thu, 05 Nov 2026 11:12:21 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm5401592a91.0.2026.11.05.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:12:20 -0800 (PST)
Date: Thu, 5 Nov 2026 19:12:17 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com,
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
	kees@kernel.org, kevin.tian@intel.com, leon@kernel.org,
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com,
	michal.winiarski@intel.com, parav@nvidia.com,
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org,
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com,
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
	schnelle@linux.ibm.com, skhan@linuxfoundation.org,
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com,
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <auzVEUpFEoWltpVg@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-8-vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_111224_342682_A9C63EE7 
X-CRM114-Status: GOOD (  28.25  )
X-Spam-Score: -14.3 (--------------)
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

On 2026-11-02 07:36 AM, Vipin Sharma wrote:
>  * TOCTOU synchronization: vfio_pci_dev_is_frozen() is checked locklessly
>    on entry to the ioctl, read/write and mmap paths, and re-checked under
>    a lock that freeze() holds before any operation that could change the
>    device or vconfig: under vdev->igate in vfio_pci_ioctl_set_irqs() and
>    around every config-space write in vfio_pci_config_rw_single(), under
>    vdev->memory_lock in vfio_pci_runtime_pm_entry(),
>    vfio_pci_ioctl_reset() and the SR-IOV enable path of
>    vfio_pci_core_sriov_configure(), and under dev_set->lock in
>    vfio_pci_dev_set_hot_reset(). A racing operation thus either completes
>    before freeze() takes its snapshot or fails, while existing BAR mmaps,
>    ioeventfds and dma-bufs keep working. Serializing config writes on
>    igate covers the PCI_COMMAND, INTx disable emulation, power state and
>    FLR paths at one point (the INTx disable emulation now uses the
>    igate-held __vfio_pci_intx_mask() and __vfio_pci_intx_unmask()
>    helpers), and also serializes the irq_type and virq_disabled accesses
>    of config writes with VFIO_DEVICE_SET_IRQS.

I think there's a simpler way to do this. Checking the frozen flag
locklessly and then re-checking it under whichever lock covers each
path spreads the synchronization across igate, memory_lock and
dev_set->lock. That makes it hard to convince yourself every path that
can change the device is covered. It also makes every config space
write take igate, for all vfio-pci users, even when
CONFIG_VFIO_PCI_LIVEUPDATE=n.

Instead, I suggest adding a per-device rw_semaphore to struct
vfio_device in the VFIO core, e.g. liveupdate_rwsem, that protects a
liveupdate_frozen flag:

 - vfio_device_fops_unl_ioctl(), vfio_device_fops_read() and
   vfio_device_fops_write() take liveupdate_rwsem for read and fail
   with -EIO if the device is frozen. That covers every device ioctl in
   one place, including the ones handled by the VFIO core
   (VFIO_DEVICE_FEATURE, VFIO_DEVICE_GET_REGION_INFO and
   VFIO_DEVICE_{ATTACH,DETACH}_IOMMUFD_PT). This patch doesn't block
   the last two at all today.

 - freeze() and unfreeze() take liveupdate_rwsem for write, before any
   other lock, and flip the flag. preserve() doesn't need it since it
   only serializes state that doesn't change after the device is
   opened.

Putting this in the VFIO core also means other VFIO drivers can reuse
it if they add Live Update support in the future.

The lock order then becomes:

  liveupdate_rwsem -> dev_set->lock -> igate -> memory_lock

freeze() can still take igate and memory_lock to check irq_type,
pm_runtime_engaged and sriov_active. But the ioctl, read and write
paths no longer need to re-check anything under those locks. So you
can drop the igate change in vfio_pci_config_rw_single(), the
open-coded vfio_pci_zap_and_down_write_memory_lock() in
vfio_pci_runtime_pm_entry() and vfio_pci_ioctl_reset(), and the
smp_load_acquire()/smp_store_release() pair.

Two paths still need their own handling because they don't go through
the device's file:

 - vfio_pci_core_sriov_configure() is reached through sysfs. Take
   liveupdate_rwsem for read around the frozen check and the
   sriov_active update.

 - VFIO_DEVICE_PCI_HOT_RESET issued on one device also resets the other
   devices in its dev_set. Keep the check in
   vfio_pci_dev_set_hot_reset() under dev_set->lock. freeze() sets the
   flag while holding both liveupdate_rwsem and dev_set->lock, so
   holding either one is enough to read it. Please don't take the other
   devices' liveupdate_rwsem there, since that would invert the lock
   order relative to freeze().

I don't think mmap needs to be blocked at all. Creating a new mapping
doesn't change the device or any of the state that gets preserved, and
existing mappings already keep working while the device is frozen.
Leaving mmap alone also avoids taking liveupdate_rwsem under mmap_lock,
which could deadlock: the ioctl, read and write paths can fault on user
memory (taking mmap_lock) while holding liveupdate_rwsem for read, and
freeze() may be waiting for the write lock. Please update the comment
in freeze() and the DOC section to match.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9914f3ac69ae..1f1ac7a798aa 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -644,10 +644,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  
>  		if (virt_intx_disable && !vdev->virq_disabled) {
>  			vdev->virq_disabled = true;
> -			vfio_pci_intx_mask(vdev);
> +			__vfio_pci_intx_mask(vdev);
>  		} else if (!virt_intx_disable && vdev->virq_disabled) {
>  			vdev->virq_disabled = false;
> -			vfio_pci_intx_unmask(vdev);
> +			__vfio_pci_intx_unmask(vdev);
>  		}
>  	}

With the rwsem, config writes no longer need igate, so this change
isn't needed. If config writes and VFIO_DEVICE_SET_IRQS really do race
on irq_type and virq_disabled today, that's unrelated to Live Update.
Please send it as a separate fix.

Lastly, please add the freeze infrastructure and the checks in their
own commit ahead of this one, e.g. "vfio: Add infrastructure to freeze
devices for Live Update". Then this patch only has to implement
freeze() and unfreeze() on top of it, which will make both easier to
review.

