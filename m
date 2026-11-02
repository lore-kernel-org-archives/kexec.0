Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8467260E7ECF
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a9omcrwW;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PyeOuUfo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pFxb2pGGK5d/5u3ztQ0HXWgDjFCUjhybBWe4UV79dXc=; b=a9omcrwWQiYvQnb+INd2ZSK2vg
	JAQZZO61DmNaMilfcPrPEWOkT9BJevL0fs8MBIDlutUT5AtyKNyODMvKTv4Ufl9wFDuGitQ0voqPr
	9Skb5jNFbLofxPtTfHTE9BmcopB8fEM1dzhgrzi5dPLugWeYkvlqAy0zcYRK2H2oYlF7K5cXMBy1/
	H7PY57oQDEoXsM6EnfPQ6mw/X2w96ORBgpiZa2kx68h6xuD+M0ZNfecOsowQYk/V/05z5Mbp/IPSH
	yQcz4+CAuGPWoDO4a/6JKy+z02psPatZLyakZbg5f1WIHF3nQdp4zUf1KFeKbsXptQ3wnMFG+cdjF
	YwjUW6ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5z-0000000H9dz-0Oql;
	Mon, 02 Nov 2026 15:37:15 +0000
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu5t-0000000H9Ud-0esT
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:11 +0000
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso3322092a12.1
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633828; x=1794238628; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFxb2pGGK5d/5u3ztQ0HXWgDjFCUjhybBWe4UV79dXc=;
        b=PyeOuUfoJ62ex4mNwvSir/BUzKLN+5XwmOedj6Vwrs+xGe/Cvb66SLBKUmrLedKm7S
         vZyyTlOWWWi1oW/ILk0sn6dxnqnBCcAcaD+5Rp1HjizDlTuJp1oeJnuqFt2oBT5++tT5
         1BOa76lqlAMS3mSmjcHorIhjF6ZlD2UVMVrObiDnb/KkJZElsHcKNVGlv4kf4IH54OTC
         16u987mBeWDmS6XrBrX/AT+DGjJhpDBF5hOeCyOa0g0RIuMKOH/ZG2ZUDSye59IJq1SZ
         VE+twdsRdwdwiLIaMKtD8D2aey0tPCuPwjpdmB+Oig9xpytcrnLRpz6wFQXYlM21CQc8
         H8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633828; x=1794238628;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFxb2pGGK5d/5u3ztQ0HXWgDjFCUjhybBWe4UV79dXc=;
        b=PiLwS3h5bRKuutB8bspDQABpyaN7C1l73NnOOMcY2MgCnGDhQ0Xf2Jgs303QTGXa47
         dz4B8gye0zOTYO21chdEo7mIvwAGV6lYJvuAfJMfhomibTcR5Py9UENU13ZzP2AuLzEw
         8No9xuiovewFZP+Yr/NKkiVzqCi0pfoKW0YHigjIlYNCPZE9FqTGo48grjfXDRcOObdV
         bH/9qIJtGIMcqsGN0DPuKqUpwwYMAJUAjHg8qdEnCa4cSnkTBLnlM7gaUICujUCwigsE
         5QaYlzphZ/DC5TcdvxavIXlusjfpI1qssS6rjsRG0G3+0t2wcK1rL3nEQGvADKZnM6oV
         Fkvg==
X-Gm-Message-State: AFq9FYJuN0IKzFYNdmAV3LmJq9ovRZqD4zb6tdclLV7kZGGx9jQmHAi1
	DF0ays3yGWvbstOuDiDyvbhBipDrOBuaAk+m/dyIZXlKnCjS4eqShrMt2oz3ptk9ipqIdCv94VO
	uoxcMvrkFRH+A0DK/GJOnpd2hK3I5RCQOd2dTsqMJZnBia4xHBQL5du5zoB8w/Ffq12KguT05NT
	30lR4kitFx1Q5LvtVG3ZhMtwQ5HnmyOgQm2kvQB34smxR6iA==
X-Received: from pgig3.prod.google.com ([2002:a63:f403:0:b0:cd8:b9f1:e118])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3b44:b0:3e2:9f41:9f63
 with SMTP id adf61e73a8af0-3e92873ca2emr7733836637.1.1793633827224; Mon, 02
 Nov 2026 07:37:07 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:36 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-8-vipinsh@google.com>
Subject: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across Live Update
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_073709_298830_982CC94C 
X-CRM114-Status: GOOD (  29.87  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the Live Update file handler callbacks to preserve a vfio-pci
device in noiommu mode across a Live Update while keeping it running
across kexec. Subsequent commits will enable userspace to retrieve and
take over this file after the Live Update.

State about each device is serialized into struct vfio_pci_core_device_ser
using Kexec-Handover (KHO) to preserve the pages holding the struct and
the Live Update Orchestrator (LUO) to preserve the physical address of
the struct.

Key design notes and constraints:

 * Noiommu-only policy and bound cdev requirement: can_preserve() verifies
   that the preserved file is a bound vfio-pci cdev file descriptor via
   vfio_file_is_bound_cdev(), and preserve() requires the device to be in
   noiommu mode via vfio_device_is_noiommu() (returning -EOPNOTSUPP
   otherwise). CONFIG_VFIO_PCI_LIVEUPDATE now depends on
   CONFIG_VFIO_DEVICE_CDEV and CONFIG_VFIO_NOIOMMU.

 * Serialized state: During preserve(), serialize the PCI domain, BDF,
   config space size, reset_works flag, and the initial pci_saved_state
   captured when the device was first opened. During freeze(), snapshot
   the virtualized PCI config space (vconfig) and capability map
   (pci_config_map).

 * Keep-running freeze and unfreeze: Do not reset the device, clear
   PCI_COMMAND_MASTER, zap BAR mappings, or revoke dma-bufs during
   freeze(). Validate that VFIO interrupts are disabled, that the device
   is in PCI_D0 (and not in VFIO runtime PM low-power mode), and that
   SR-IOV is not enabled, as VFs are not preserved and the next kernel
   disables SR-IOV on the running device. Then mask physical INTx
   (recording the prior state) and mark the device frozen. If the
   Live Update is aborted after freeze(), unfreeze() restores the physical
   INTx state and clears liveupdate_frozen so the existing FD remains
   usable.

 * TOCTOU synchronization: vfio_pci_dev_is_frozen() is checked locklessly
   on entry to the ioctl, read/write and mmap paths, and re-checked under
   a lock that freeze() holds before any operation that could change the
   device or vconfig: under vdev->igate in vfio_pci_ioctl_set_irqs() and
   around every config-space write in vfio_pci_config_rw_single(), under
   vdev->memory_lock in vfio_pci_runtime_pm_entry(),
   vfio_pci_ioctl_reset() and the SR-IOV enable path of
   vfio_pci_core_sriov_configure(), and under dev_set->lock in
   vfio_pci_dev_set_hot_reset(). A racing operation thus either completes
   before freeze() takes its snapshot or fails, while existing BAR mmaps,
   ioeventfds and dma-bufs keep working. Serializing config writes on
   igate covers the PCI_COMMAND, INTx disable emulation, power state and
   FLR paths at one point (the INTx disable emulation now uses the
   igate-held __vfio_pci_intx_mask() and __vfio_pci_intx_unmask()
   helpers), and also serializes the irq_type and virq_disabled accesses
   of config writes with VFIO_DEVICE_SET_IRQS.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/Kconfig               |   2 +-
 drivers/vfio/pci/vfio_pci_config.c     |  19 +-
 drivers/vfio/pci/vfio_pci_core.c       |  49 +++-
 drivers/vfio/pci/vfio_pci_intrs.c      |   4 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 303 ++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h       |  13 ++
 include/linux/kho/abi/vfio_pci.h       |  52 ++++-
 include/linux/vfio_pci_core.h          |   4 +
 8 files changed, 434 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index e8285ad93a69..71289d8908f6 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -45,7 +45,7 @@ config VFIO_PCI_IGD
 
 config VFIO_PCI_LIVEUPDATE
 	bool "VFIO PCI support for Live Update in no-iommu mode"
-	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU
+	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU && VFIO_DEVICE_CDEV
 	help
 	  Support for preserving devices bound to vfio-pci in no-iommu mode
 	  across a Live Update. It enables a device to continue working (DMA)
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..1f1ac7a798aa 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -644,10 +644,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 
 		if (virt_intx_disable && !vdev->virq_disabled) {
 			vdev->virq_disabled = true;
-			vfio_pci_intx_mask(vdev);
+			__vfio_pci_intx_mask(vdev);
 		} else if (!virt_intx_disable && vdev->virq_disabled) {
 			vdev->virq_disabled = false;
-			vfio_pci_intx_unmask(vdev);
+			__vfio_pci_intx_unmask(vdev);
 		}
 	}
 
@@ -1957,7 +1957,20 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 		if (copy_from_user(&val, buf, count))
 			return -EFAULT;
 
-		ret = perm->writefn(vdev, *ppos, count, perm, offset, val);
+		/*
+		 * Serialize with Live Update freeze(), which holds igate, so a
+		 * write that passed the lockless frozen check in vfio_pci_rw()
+		 * cannot change the device or vconfig after freeze() has
+		 * snapshotted vconfig and masked INTx.  The INTx disable
+		 * emulation in vfio_basic_config_write() relies on igate too.
+		 */
+		mutex_lock(&vdev->igate);
+		if (vfio_pci_dev_is_frozen(vdev))
+			ret = -EIO;
+		else
+			ret = perm->writefn(vdev, *ppos, count, perm, offset,
+					    val);
+		mutex_unlock(&vdev->igate);
 	} else {
 		if (perm->readfn) {
 			ret = perm->readfn(vdev, *ppos, count,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7b003c3e5a3a..5f8c882d5778 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -369,6 +369,8 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	return ret;
 }
 
+static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev);
+
 static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 				     struct eventfd_ctx *efdctx)
 {
@@ -376,7 +378,12 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 	 * The vdev power related flags are protected with 'memory_lock'
 	 * semaphore.
 	 */
-	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	down_write(&vdev->memory_lock);
+	if (vfio_pci_dev_is_frozen(vdev)) {
+		up_write(&vdev->memory_lock);
+		return -EIO;
+	}
+	vfio_pci_zap_bars(vdev);
 	vfio_pci_dma_buf_move(vdev, true);
 
 	if (vdev->pm_runtime_engaged) {
@@ -1142,6 +1149,9 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 	struct pci_dev *pdev = vdev->pdev;
 	int i, ret;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	switch (info->index) {
 	case VFIO_PCI_CONFIG_REGION_INDEX:
 		info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
@@ -1309,9 +1319,15 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
 
 	mutex_lock(&vdev->igate);
 
+	if (vfio_pci_dev_is_frozen(vdev)) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+
 	ret = vfio_pci_set_irqs_ioctl(vdev, hdr.flags, hdr.index, hdr.start,
 				      hdr.count, data);
 
+out_unlock:
 	mutex_unlock(&vdev->igate);
 	kfree(data);
 
@@ -1326,7 +1342,12 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	if (!vdev->reset_works)
 		return -EINVAL;
 
-	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	down_write(&vdev->memory_lock);
+	if (vfio_pci_dev_is_frozen(vdev)) {
+		up_write(&vdev->memory_lock);
+		return -EIO;
+	}
+	vfio_pci_zap_bars(vdev);
 
 	/*
 	 * This function can be invoked while the power state is non-D0. If
@@ -1565,6 +1586,9 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 	void __user *uarg = (void __user *)arg;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	switch (cmd) {
 	case VFIO_DEVICE_GET_INFO:
 		return vfio_pci_ioctl_get_info(vdev, uarg);
@@ -1619,6 +1643,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 	struct vfio_pci_core_device *vdev =
 		container_of(device, struct vfio_pci_core_device, vdev);
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
 	case VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY:
 		return vfio_pci_core_pm_entry(vdev, flags, arg, argsz);
@@ -1645,6 +1672,9 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 	int ret;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 		return -EINVAL;
 
@@ -1828,6 +1858,9 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	u64 phys_len, req_len, pgoff, req_start;
 	void __iomem *bar_io;
 
+	if (vfio_pci_dev_is_frozen(vdev))
+		return -EIO;
+
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
@@ -2393,6 +2426,13 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 			goto out_del;
 
 		down_write(&vdev->memory_lock);
+		/* A device frozen for Live Update must not change. */
+		if (vfio_pci_dev_is_frozen(vdev)) {
+			up_write(&vdev->memory_lock);
+			pm_runtime_put(&pdev->dev);
+			ret = -EBUSY;
+			goto out_del;
+		}
 		vfio_pci_set_power_state(vdev, PCI_D0);
 		vdev->sriov_active = true;
 		up_write(&vdev->memory_lock);
@@ -2537,6 +2577,11 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
 		bool owned;
 
+		if (vfio_pci_dev_is_frozen(vdev)) {
+			ret = -EBUSY;
+			break;
+		}
+
 		/*
 		 * Test whether all the affected devices can be reset by the
 		 * user.
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 64f80f64ff57..07ae0caec44b 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -99,7 +99,7 @@ static void vfio_send_intx_eventfd(void *opaque, void *data)
 }
 
 /* Returns true if the INTx vfio_pci_irq_ctx.masked value is changed. */
-static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
+bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
@@ -203,7 +203,7 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 	return ret;
 }
 
-static void __vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
+void __vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_pci_irq_ctx *ctx = vfio_irq_ctx_get(vdev, 0);
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 8fd5af4f4b83..ac77241ffb1e 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -6,28 +6,325 @@
  * David Matlack <dmatlack@google.com>
  */
 
+/**
+ * DOC: VFIO PCI Preservation via LUO
+ *
+ * VFIO PCI devices in noiommu mode can be preserved over a kexec using the Live
+ * Update Orchestrator (LUO) file preservation while keeping the device running
+ * and performing DMA across the kexec transition. This allows userspace (such
+ * as a VMM or userspace driver) to transfer an in-use device to the next kernel
+ * without resetting it.
+ *
+ * .. note::
+ *    This support is enabled by ``CONFIG_VFIO_PCI_LIVEUPDATE`` and is limited
+ *    to devices in noiommu mode (see Restrictions below).
+ *
+ * Usage Example
+ * =============
+ *
+ * VFIO PCI devices can be preserved across a kexec by preserving the bound
+ * character device file associated with the device in a LUO session::
+ *
+ *   device_fd = open("/dev/vfio/devices/noiommu-vfioX", O_RDWR);
+ *   ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+ *   ...
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, { ..., device_fd, ...});
+ *
+ * .. note::
+ *    LUO will hold an extra reference to the device file for as long as it is
+ *    preserved, so there is no way for the file to be destroyed or the device
+ *    to be unbound from the vfio-pci driver while it is preserved.
+ *
+ * Retrieving the file after kexec is not yet supported.
+ *
+ * Restrictions
+ * ============
+ *
+ * The kernel imposes the following restrictions when preserving VFIO devices:
+ *
+ *  * The device must be bound to the ``vfio-pci`` driver (not a variant driver)
+ *    and registered in **noiommu** mode (``vfio.enable_unsafe_noiommu_mode=1``
+ *    with no IOMMU group attached to the device). Attempting to preserve an
+ *    IOMMU-backed device fails with ``-EOPNOTSUPP``.
+ *
+ *  * The device file descriptor must be obtained by opening the VFIO character
+ *    device (``/dev/vfio/devices/noiommu-vfioX``) and not via
+ *    ``VFIO_GROUP_GET_DEVICE_FD``, and ``VFIO_DEVICE_BIND_IOMMUFD`` must have
+ *    completed on that file descriptor before it is preserved.
+ *
+ *  * ``CONFIG_VFIO_PCI_ZDEV_KVM`` must not be enabled. This may be relaxed in
+ *    the future.
+ *
+ *  * The device must not be an Intel display device or SR-IOV Virtual Function
+ *    (VF). This may be relaxed in the future.
+ *
+ *  * The device must meet the following conditions prior to kexec, without
+ *    which the ``reboot(LINUX_REBOOT_CMD_KEXEC)`` syscall (to initiate the
+ *    kexec) will fail with ``-EINVAL`` and abort the Live Update:
+ *
+ *    - All VFIO interrupts on the device must be disabled.
+ *    - The device must be in the ``PCI_D0`` power state and not in VFIO
+ *      low-power mode (``VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY``).
+ *    - SR-IOV must not be enabled on the device.
+ *
+ * In addition, the device must meet all of the restrictions imposed by the
+ * core PCI layer documented at :doc:`/PCI/liveupdate`.
+ *
+ * Preservation Behavior
+ * =====================
+ *
+ * During ``LIVEUPDATE_SESSION_PRESERVE_FD``, VFIO serializes the device's PCI
+ * domain and BDF, its ``reset_works`` capability flag, and the initial
+ * ``struct pci_saved_state`` captured when the device was first opened.
+ *
+ * During the ``reboot(LINUX_REBOOT_CMD_KEXEC)`` freeze phase, VFIO validates
+ * that interrupts are disabled and the device is in ``PCI_D0``, snapshots the
+ * virtualized PCI configuration space (``vconfig``) and capability map
+ * (``pci_config_map``), masks physical INTx (`PCI_COMMAND_INTX_DISABLE`), and
+ * marks the device frozen so subsequent userspace accesses return ``-EIO``.
+ *
+ * VFIO ioctls and config-space writes that race with the freeze phase are
+ * serialized with it: those that could change the device or ``vconfig``
+ * either complete before the snapshot is taken or fail with ``-EIO``
+ * (``-EBUSY`` for ``VFIO_DEVICE_PCI_HOT_RESET``). Userspace should still
+ * quiesce them before invoking ``reboot(LINUX_REBOOT_CMD_KEXEC)``. Existing
+ * BAR mmaps, ioeventfds and dma-bufs keep working while the device is frozen
+ * because the device keeps running.
+ *
+ * The device is **not** reset and ``PCI_COMMAND_MASTER`` is left untouched so
+ * the device continues running and performing DMA across kexec. If the Live
+ * Update is aborted after freeze (for example, if a later file fails to freeze),
+ * the ``unfreeze()`` callback restores the physical INTx mask and clears the
+ * frozen state, leaving the existing file descriptor immediately usable again.
+ *
+ * DMA Memory Ordering Contract
+ * ============================
+ *
+ * Because a preserved noiommu device continues performing DMA using physical
+ * addresses across kexec, any memory buffer targeted by device DMA must remain
+ * at the same physical address in both kernels and must not be freed to the
+ * page allocator while the device can still access it:
+ *
+ *  * When using a LUO-preserved ``memfd``, userspace **must** preserve the
+ *    ``memfd`` in the **same** LUO session as the VFIO device and **before**
+ *    preserving the VFIO device. LUO finishes files within a session in reverse
+ *    preservation order (LIFO), guaranteeing that if the device is not taken
+ *    over in the new kernel, VFIO's ``finish()`` callback stops bus mastering
+ *    and resets the device before the ``memfd``'s ``finish()`` callback releases
+ *    its folios. Cross-session ordering is the responsibility of userspace.
+ *
+ *  * After retrieving a preserved ``memfd`` in the new kernel, its folios are
+ *    ordinary unpinned shmem page cache until pinned again; userspace must keep
+ *    the ``memfd`` alive and re-pin/map it before finishing the session, and
+ *    must not rely on a ``memfd`` whose ``LIVEUPDATE_SESSION_RETRIEVE_FD`` call
+ *    failed (failed ``memfd`` retrieval frees its folios immediately).
+ */
+
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/errno.h>
+#include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/pci.h>
+#include <linux/pci_liveupdate.h>
+#include <linux/string.h>
+#include <linux/vfio.h>
 
 #include "vfio_pci_priv.h"
 
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
-	return false;
+	struct vfio_device *device = vfio_device_from_file(file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+
+	if (!device)
+		return false;
+
+	if (device->ops != &vfio_pci_ops)
+		return false;
+
+	guard(mutex)(&device->dev_set->lock);
+
+	/* Live Update support is limited to bound cdev files. */
+	if (!vfio_file_is_bound_cdev(file))
+		return false;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	/*
+	 * Don't support specialized vfio-pci devices for now since they haven't
+	 * been tested.
+	 */
+	if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV_KVM) || vfio_pci_is_intel_display(pdev))
+		return false;
+
+	/* Only non-VFs are supported for now. */
+	if (pdev->is_virtfn)
+		return false;
+
+	return true;
 }
 
 static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
+	size_t saved_size = 0, total_size;
+	struct pci_dev *pdev;
+	u16 cfg_size;
+	int err;
+
+	if (!vfio_device_is_noiommu(device))
+		return -EOPNOTSUPP;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+	cfg_size = pdev->cfg_size;
+
+	if (cfg_size != PCI_CFG_SPACE_SIZE && cfg_size != PCI_CFG_SPACE_EXP_SIZE)
+		return -EINVAL;
+
+	guard(mutex)(&device->dev_set->lock);
+
+	if (!vfio_file_is_bound_cdev(args->file))
+		return -EINVAL;
+
+	if (vdev->pci_saved_state) {
+		saved_size = pci_liveupdate_saved_state_ser_size(vdev->pci_saved_state);
+		if (!saved_size)
+			return -EINVAL;
+	}
+
+	total_size = size_add(sizeof(*ser),
+			      size_add(size_mul(2, cfg_size), saved_size));
+	if (total_size > U32_MAX)
+		return -EOVERFLOW;
+
+	ser = kho_alloc_preserve(total_size);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	if (saved_size) {
+		void *dst = ser->data + 2 * (size_t)cfg_size;
+
+		err = pci_liveupdate_serialize_saved_state(vdev->pci_saved_state,
+							   dst, saved_size);
+		if (err) {
+			kho_unpreserve_free(ser);
+			return err;
+		}
+	}
+
+	err = pci_liveupdate_preserve(pdev);
+	if (err) {
+		kho_unpreserve_free(ser);
+		return err;
+	}
+
+	ser->domain = pci_domain_nr(pdev->bus);
+	ser->bdf = pci_dev_id(pdev);
+	ser->cfg_size = cfg_size;
+	ser->size = total_size;
+	ser->flags = vdev->reset_works ? VFIO_PCI_SER_RESET_WORKS : 0;
+	ser->saved_state_size = saved_size;
+	ser->reserved = 0;
+
+	args->serialized_data = virt_to_phys(ser);
+	return 0;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct vfio_device *device = vfio_device_from_file(args->file);
+
+	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
+}
+
+static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
+{
+	struct vfio_pci_core_device_ser *ser = phys_to_virt(args->serialized_data);
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device *vdev;
+	struct pci_dev *pdev;
+	u16 cmd;
+
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	pdev = vdev->pdev;
+
+	guard(mutex)(&device->dev_set->lock);
+	guard(mutex)(&vdev->igate);
+	guard(rwsem_write)(&vdev->memory_lock);
+
+	if (!vdev->vconfig || !vdev->pci_config_map ||
+	    ser->cfg_size != pdev->cfg_size)
+		return -EINVAL;
+
+	/*
+	 * Userspace must disable interrupts on the device prior to freeze so
+	 * that the device does not send any interrupts until new interrupt
+	 * handlers have been established by the next kernel.
+	 */
+	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
+		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
+		return -EINVAL;
+	}
+
+	if (pdev->current_state != PCI_D0 || vdev->pm_runtime_engaged) {
+		pci_err(pdev, "Freeze failed! Device not in D0 state.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * VFs are not preserved, and the next kernel disables SR-IOV on the
+	 * device while it keeps running. vfio_pci_core_sriov_configure() sets
+	 * sriov_active under memory_lock, and does not enable SR-IOV once the
+	 * device is frozen.
+	 */
+	if (vdev->sriov_active) {
+		pci_err(pdev, "Freeze failed! SR-IOV is enabled.\n");
+		return -EINVAL;
+	}
+
+	memcpy(ser->data, vdev->vconfig, ser->cfg_size);
+	memcpy(ser->data + ser->cfg_size, vdev->pci_config_map, ser->cfg_size);
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	vdev->liveupdate_intx_disabled = !!(cmd & PCI_COMMAND_INTX_DISABLE);
+	if (!vdev->liveupdate_intx_disabled)
+		pci_intx(pdev, 0);
+
+	/*
+	 * Disable ioctl, read, write and mmap access to the device while it is
+	 * frozen. If the Live Update is aborted, unfreeze() re-enables access.
+	 */
+	smp_store_release(&vdev->liveupdate_frozen, true);
+	return 0;
+}
+
+static void vfio_pci_liveupdate_unfreeze(struct liveupdate_file_op_args *args)
+{
+	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device *vdev =
+		container_of(device, struct vfio_pci_core_device, vdev);
+
+	guard(mutex)(&device->dev_set->lock);
+	guard(mutex)(&vdev->igate);
+	guard(rwsem_write)(&vdev->memory_lock);
+
+	if (!vdev->liveupdate_intx_disabled)
+		pci_intx(vdev->pdev, 1);
+
+	/* Pairs with smp_load_acquire() in vfio_pci_dev_is_frozen(). */
+	smp_store_release(&vdev->liveupdate_frozen, false);
 }
 
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
@@ -43,6 +340,8 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.can_preserve = vfio_pci_liveupdate_can_preserve,
 	.preserve = vfio_pci_liveupdate_preserve,
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
+	.freeze = vfio_pci_liveupdate_freeze,
+	.unfreeze = vfio_pci_liveupdate_unfreeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 872b01bcb5a3..2c732cb1c189 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -25,7 +25,9 @@ struct vfio_pci_ioeventfd {
 	bool			test_mem;
 };
 
+bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
+void __vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
 void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
 
 int vfio_pci_eventfd_replace_locked(struct vfio_pci_core_device *vdev,
@@ -151,6 +153,12 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
 #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
 int __init vfio_pci_liveupdate_init(void);
 void vfio_pci_liveupdate_cleanup(void);
+
+static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
+{
+	/* Written in VFIO PCI Liveupdate during freeze()/unfreeze() */
+	return smp_load_acquire(&vdev->liveupdate_frozen);
+}
 #else
 static inline int vfio_pci_liveupdate_init(void)
 {
@@ -160,6 +168,11 @@ static inline int vfio_pci_liveupdate_init(void)
 static inline void vfio_pci_liveupdate_cleanup(void)
 {
 }
+
+static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
+{
+	return false;
+}
 #endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
 
 #endif
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 67e8199eec59..725043a44b55 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -9,14 +9,19 @@
 #ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 #define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
 
+#include <linux/bits.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
 /**
  * DOC: VFIO PCI Live Update ABI
  *
  * VFIO uses the ABI defined below for preserving device files across a kexec
  * reboot using LUO.
  *
- * Device metadata is serialized into memory which is then handed to the next
- * kernel via KHO.
+ * Device metadata, virtualized PCI configuration space, VFIO's capability map,
+ * and the initial PCI saved state captured when the device was first opened are
+ * serialized into memory which is then handed to the next kernel via KHO.
  *
  * This interface is a contract. Any modification to any of the serialization
  * structs defined here constitutes a breaking change. Such changes require
@@ -25,4 +30,47 @@
 
 #define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
 
+/**
+ * define VFIO_PCI_SER_RESET_WORKS - Device supports function reset.
+ *
+ * Set in &vfio_pci_core_device_ser.flags when the preserved device had
+ * ``vdev->reset_works == true`` prior to kexec.
+ */
+#define VFIO_PCI_SER_RESET_WORKS	BIT(0)
+
+#define VFIO_PCI_SER_KNOWN_FLAGS	VFIO_PCI_SER_RESET_WORKS
+
+/**
+ * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
+ * device.
+ *
+ * @domain: The device's PCI domain number (segment).
+ * @bdf: The device's PCI bus, device, and function number.
+ * @cfg_size: Size in bytes of the device's PCI configuration space
+ *            (``PCI_CFG_SPACE_SIZE`` or ``PCI_CFG_SPACE_EXP_SIZE``).
+ * @size: Total size in bytes of this serialized buffer, equal to
+ *        ``sizeof(struct vfio_pci_core_device_ser) + 2 * @cfg_size + @saved_state_size``.
+ * @flags: Bitmask of ``VFIO_PCI_SER_*`` flags; unknown bits are rejected.
+ * @saved_state_size: Size in bytes of the serialized &struct pci_saved_state_ser
+ *                    blob stored in @data after ``config_map``, or 0 if none.
+ * @reserved: Reserved for future use; must be 0.
+ * @data: Variable-length payload containing, in order:
+ *        1. ``u8 vconfig[@cfg_size]`` - VFIO virtualized config space snapshot
+ *           captured during ``freeze()``.
+ *        2. ``u8 config_map[@cfg_size]`` - VFIO capability map snapshot
+ *           captured during ``freeze()``.
+ *        3. ``u8 saved_state[@saved_state_size]`` - serialized
+ *           &struct pci_saved_state_ser captured during ``preserve()``.
+ */
+struct vfio_pci_core_device_ser {
+	u32 domain;
+	u16 bdf;
+	u16 cfg_size;
+	u32 size;
+	u32 flags;
+	u32 saved_state_size;
+	u32 reserved;
+	u8 data[];
+} __packed;
+
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..6bae7581f4f4 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -149,6 +149,10 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+	bool			liveupdate_frozen;
+	bool			liveupdate_intx_disabled;
+#endif
 };
 
 enum vfio_pci_io_width {
-- 
2.56.0.317.g454f8302e1-goog


