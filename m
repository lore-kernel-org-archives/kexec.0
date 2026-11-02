Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E260EFB46
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=spI+gnAO;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=CYj+eQb0;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XM5Fi/w/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Vbe7YkQSNXb/9uNAV7c/nc8RXxVT9Eq1KsmaqI9CwRI=; b=spI+gnAORey4Xu0UGvVGP4GZzs
	/XtWALmd/qZHYUROd2NolVu/a2S1yqAry6gbbpHVXVgEs5HQMDgRuvcCVBSaA7CfaHILE7mM7Os5V
	5AF5DUEYLQrAASihAG6c98eFH3ku9SIhCtk2Lq3BLhwbF8YarLZwaaCJnJAVmenAny7WuNzHUhj5k
	r3n7WYCCnLGHC7Q3lqdbA5qsEdQ6xk7qP1rrLksdL521XYyfic73iQdE2HIg1hKTZnCwykU1BE3wt
	Ig6Ka9LzjPLfF58afHg2txBWrZnn3psT3NcpmBr2HnOTH8riX6mgZ3w7VuMd9u9aQuape+ZklCwGl
	aoLSgvlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6E-0000000HA1K-47ha;
	Mon, 02 Nov 2026 15:37:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu66-0000000H9qp-1Kj5
	for kexec@bombadil.infradead.org;
	Mon, 02 Nov 2026 15:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vbe7YkQSNXb/9uNAV7c/nc8RXxVT9Eq1KsmaqI9CwRI=; b=CYj+eQb05nIfjMtCFE9ilE/wUG
	hD8YDjcuXuTHle+2NUEoJbhswoORkuS77mGbxKZx469NmGpY3rjEH8R759Nhfw3oyUNuiomrRo84E
	7hT++cwoUdp5hcGL+4FSNFsx09bwW40q+/SFhJz0eIlzw+KkxqHJVzxpZgAon6VZIXjz2mpEWw8Ee
	+8YkJsdheRldG2pATJUJeOg8AVfNi5H/NHIDDG5uWCQdfp6m8pOhXL4it5mO62GC0e08dFKkN4Ki3
	FTT62Xz1sH88p5c1vyiZ73ibF+WwtcJ7VNUia/vu/YPSytNCkF1JIjwK3aUfSjSr+fMnSBFKb6D+d
	EFy9x2XA==;
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu61-00000003Z8F-0cQ2
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:21 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2ea71803effso33720145ad.3
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633834; x=1794238634; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vbe7YkQSNXb/9uNAV7c/nc8RXxVT9Eq1KsmaqI9CwRI=;
        b=XM5Fi/w/tc+d0UTU9rlMUf3a6PKqpHd0np9nIx8gU3i+RAYsEVLh2TEBTwXiASkBmW
         wxniKVT4MPZKMOeg2e0e4/hQKEjoZtw+Nki0TbrCISkwfwepTWcjiIRcqAMk4SdpgEu0
         lkPoQeqMpUrZA+ftNsaEqtQRvDCcPUXHCWstU+KzlampaD+4zjpR1Xt9JnuaZmT/qc9F
         UTIuHj+eb10bsDi3vDy+vzMRGh1ZF86LtcEgfUa03aIcto3hq4dmHQ+ZSl3yELscEdCO
         6JMJiZXHrNo5qo+HjcuuWOezvpe7sXqB3vL7jDEN9qiJagBcZmEt6LatpqfBpXw+fCX8
         kdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633834; x=1794238634;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vbe7YkQSNXb/9uNAV7c/nc8RXxVT9Eq1KsmaqI9CwRI=;
        b=iFKFFBDXaOJM6YhPID6dFD5AccNeJSc8JsTjoh7ZuOFcpRVtkcC30HpMRBzEF/OBYR
         8XJRDBjKKrQg8QiPdlyCDiOejkJDJQtZu1WSnUHl6OuNevw7HPQ1K5M7Dt3sr6Etp/ul
         zBIk0y9SuVfGUaxKOmuXoBjlBuv+VIU8PN4HMr7uA3IO72Nx43NLDRalvgLCt/JlJIjC
         d1OZOc6i8f5m2Fc6jIyKTV7Xhlfwvy1xgedfPvmIaas5Ku8FevJhKMmgtasBqPO+hbbv
         7Bv+3PjqvuD6Zo88GhmyuYCDy6yDN98IM/T3HFTS5dEoJwgVOgh3ZUEYzeoW8TrYG0b6
         DhGw==
X-Gm-Message-State: APuU4Z+bA3dfgB0fz0Sm+pXHezzclVpzRU9tqPrK6TeK4qrYGHgP5y9e
	JEWGioJ5Pozv64Xc36gZ7xmvJ5NjjkZTBqYKNFeN+2q4AjnGuflQbuWiWlmH9OPODNVYzEw4Pfr
	b2LOC81ps4FkkRbtU6HdDZrptPXNN8INNzzeNIvMrnfRwUZHUU3vStB/biieoybLOFywhnRR2kQ
	OZoy16NJlvG5bOMO9A7ZfaP7JpFQQGoTiAcLMlE4u35zIcLg==
X-Received: from plkg13.prod.google.com ([2002:a17:903:19cd:b0:2e8:1f84:7c18])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:2e9:4bf3:37a1
 with SMTP id d9443c01a7336-2eb36506822mr91361225ad.63.1793633833691; Mon, 02
 Nov 2026 07:37:13 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:42 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-14-vipinsh@google.com>
Subject: [PATCH v6 13/27] vfio/pci: Protect incoming preserved devices until
 they finish Live Update
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
X-CRM114-CacheID: sfid-20261102_153717_301401_E1B7C3C3 
X-CRM114-Status: GOOD (  21.07  )
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

Protect incoming preserved devices that were kept running across kexec
from being disturbed before userspace either claims them or finishes the
Live Update session:

 * Runtime PM idle D3: In vfio_pci_init_dev(), when
   pci_liveupdate_is_incoming(pdev) is true, latch
   vdev->disable_idle_d3 = true and vdev->liveupdate_kept_running = true.
   Without this, vfio_pci_core_register_device() drops the runtime PM
   reference and allows the PCI runtime PM core to transition an idle
   incoming device into D3hot, stopping bus mastering and potentially
   triggering an internal reset on NoSoftRst- devices.

 * Non-noiommu boot fallback: In vfio_pci_core_register_device(), after
   vfio_register_group_dev() determines whether the device is in noiommu
   mode, if an incoming kept-running device is not in noiommu mode in
   this kernel, log a pci_warn(), clear PCI_COMMAND_MASTER immediately to
   stop untranslated DMA, and record liveupdate_stopped_early so
   finish() resets it without printing a duplicate warning.

 * Bus/slot reset guards: Refuse vfio_pci_dev_set_needs_reset() and
   vfio_pci_dev_set_hot_reset() (-EBUSY) while any device in the dev_set
   has liveupdate_kept_running set, preventing another device in the same
   dev_set from resetting an unclaimed kept-running device. When an
   unclaimed device finishes Live Update and no device in its dev_set is
   open, invoke vfio_pci_dev_set_try_reset() after clearing
   liveupdate_kept_running so devices without function-level reset still
   receive a bus/slot reset.

 * Unbind before finish: In vfio_pci_core_unregister_device(), if a
   still-unclaimed incoming device is unbound from vfio-pci before the
   session finishes (or if a concurrent finish() deferred its function
   reset via liveupdate_reset_pending), clear bus mastering, reset the
   function and restore config state via
   vfio_pci_core_liveupdate_reset_locked() under the device lock already
   held by remove(), and call pci_liveupdate_finish().

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci.c            |  1 +
 drivers/vfio/pci/vfio_pci_core.c       | 19 +++++++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 16 +++++--
 drivers/vfio/pci/vfio_pci_priv.h       | 62 ++++++++++++++++++++++++--
 include/linux/vfio_pci_core.h          |  3 +-
 5 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 9d48b250a5e8..d01b5cc9d4d2 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -139,6 +139,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 	 */
 	vdev->nointxmask = nointxmask;
 	vdev->disable_idle_d3 = disable_idle_d3;
+	vfio_pci_liveupdate_init_dev(vdev);
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 60ada3bbb6ff..828d620cf836 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -768,6 +768,15 @@ bool vfio_pci_core_liveupdate_reset(struct vfio_pci_core_device *vdev,
 	vdev->reset_works = reset_works;
 	vfio_pci_core_try_reset(vdev);
 
+	/*
+	 * Like vfio_pci_core_disable(), try a bus or slot reset for the devices
+	 * in the set that still need one, e.g. this device if it has no usable
+	 * function reset, or others whose reset was deferred while this device
+	 * was kept running. This device is not open, so none in the set may be.
+	 */
+	if (!vfio_device_set_open_count(vdev->vdev.dev_set))
+		vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
+
 	return !vdev->needs_reset;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_liveupdate_reset);
@@ -2399,6 +2408,8 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
+	vfio_pci_liveupdate_check_noiommu(vdev);
+
 	vfio_pci_core_debugfs_init(vdev);
 
 	return 0;
@@ -2642,7 +2653,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
 		bool owned;
 
-		if (vfio_pci_dev_is_frozen(vdev)) {
+		if (vfio_pci_dev_is_frozen(vdev) ||
+		    vfio_pci_dev_is_kept_running(vdev)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -2744,8 +2756,11 @@ static bool vfio_pci_dev_set_needs_reset(struct vfio_device_set *dev_set)
 	if (vfio_device_set_open_count(dev_set) > 1)
 		return false;
 
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
+	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
+		if (vfio_pci_dev_is_kept_running(cur))
+			return false;
 		needs_reset |= cur->needs_reset;
+	}
 	return needs_reset;
 }
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 64810010f983..ad757acac400 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -457,7 +457,7 @@ vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
 {
 	guard(mutex)(&vdev->vdev.dev_set->lock);
 
-	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
+	if (vdev->liveupdate_incoming || !vdev->liveupdate_kept_running ||
 	    !pci_liveupdate_is_incoming(vdev->pdev))
 		return -EBUSY;
 
@@ -558,8 +558,7 @@ static void vfio_pci_liveupdate_finish_vdev(struct vfio_pci_core_device *vdev,
 	bool was_reset;
 
 	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
-		if (!vdev->liveupdate_claimed &&
-		    pci_liveupdate_is_incoming(pdev)) {
+		if (vdev->liveupdate_kept_running) {
 			if (vdev->liveupdate_incoming) {
 				saved_state = vdev->liveupdate_incoming->saved_state;
 				vdev->liveupdate_incoming->saved_state = NULL;
@@ -572,6 +571,17 @@ static void vfio_pci_liveupdate_finish_vdev(struct vfio_pci_core_device *vdev,
 					saved_state = NULL;
 			}
 
+			/*
+			 * The device is stopped below, so stop shielding it from
+			 * the dev_set resets, including the fallback done by
+			 * vfio_pci_core_liveupdate_reset().
+			 */
+			vdev->liveupdate_kept_running = false;
+
+			/* A device stopped early was logged when it was stopped. */
+			if (vdev->liveupdate_stopped_early)
+				reason = NULL;
+
 			/*
 			 * An unbind of the device waits for the reference held
 			 * by finish() with the device lock held, so the reset
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index d8670dc51bb4..39ea26402312 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -169,6 +169,40 @@ static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
 	return smp_load_acquire(&vdev->liveupdate_frozen);
 }
 
+static inline bool vfio_pci_dev_is_kept_running(struct vfio_pci_core_device *vdev)
+{
+	return vdev->liveupdate_kept_running;
+}
+
+static inline void vfio_pci_liveupdate_init_dev(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = to_pci_dev(vdev->vdev.dev);
+
+	if (pci_liveupdate_is_incoming(pdev)) {
+		vdev->disable_idle_d3 = true;
+		vdev->liveupdate_kept_running = true;
+	}
+}
+
+/*
+ * Called by probe once the device is registered, with the device lock held.
+ * retrieve() and finish() look the device up with that lock held, see
+ * vfio_pci_liveupdate_find_probed(), so they see the result of this check.
+ */
+static inline void
+vfio_pci_liveupdate_check_noiommu(struct vfio_pci_core_device *vdev)
+{
+	guard(mutex)(&vdev->vdev.dev_set->lock);
+
+	if (vdev->liveupdate_kept_running &&
+	    !vfio_device_is_noiommu(&vdev->vdev)) {
+		pci_warn(vdev->pdev,
+			 "Stopping device kept running across Live Update: not in noiommu mode\n");
+		pci_clear_master(vdev->pdev);
+		vdev->liveupdate_stopped_early = true;
+	}
+}
+
 static inline void
 vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
 {
@@ -196,7 +230,7 @@ vfio_pci_liveupdate_claim_incoming(struct vfio_pci_core_device *vdev)
 		return;
 
 	vfio_pci_liveupdate_free_incoming(vdev);
-	vdev->liveupdate_claimed = true;
+	vdev->liveupdate_kept_running = false;
 }
 
 static inline void
@@ -206,11 +240,17 @@ vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
 
 	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
 		/*
-		 * Complete a reset that finish() could not do, see
-		 * vfio_pci_liveupdate_finish_vdev().
+		 * Reset a device unbound before finish(), or whose reset
+		 * finish() could not do, see vfio_pci_liveupdate_finish_vdev().
 		 */
-		if (vdev->liveupdate_reset_pending) {
+		if (vdev->liveupdate_kept_running ||
+		    vdev->liveupdate_reset_pending) {
+			if (vdev->liveupdate_kept_running &&
+			    !vdev->liveupdate_stopped_early)
+				pci_warn(pdev,
+					 "Resetting device not taken over after Live Update (vfio-pci unbound)\n");
 			vfio_pci_core_liveupdate_reset_locked(vdev);
+			vdev->liveupdate_kept_running = false;
 			vdev->liveupdate_reset_pending = false;
 		}
 		vfio_pci_liveupdate_free_incoming(vdev);
@@ -234,6 +274,20 @@ static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
 	return false;
 }
 
+static inline bool vfio_pci_dev_is_kept_running(struct vfio_pci_core_device *vdev)
+{
+	return false;
+}
+
+static inline void vfio_pci_liveupdate_init_dev(struct vfio_pci_core_device *vdev)
+{
+}
+
+static inline void
+vfio_pci_liveupdate_check_noiommu(struct vfio_pci_core_device *vdev)
+{
+}
+
 static inline void
 vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
 {
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index f5c279d0df1e..9bdbc8099bda 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -152,7 +152,8 @@ struct vfio_pci_core_device {
 #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
 	bool			liveupdate_frozen;
 	bool			liveupdate_intx_disabled;
-	bool			liveupdate_claimed;
+	bool			liveupdate_kept_running;
+	bool			liveupdate_stopped_early;
 	bool			liveupdate_reset_pending;
 	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
 #endif
-- 
2.56.0.317.g454f8302e1-goog


