Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F160F0C26
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mg9b0erE;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SrPPYZ+p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Co3UjJyFEnZJpTpwZDKwqCjGC43bvHMJxy07QdLEStk=; b=Mg9b0erEyv9iQ/F+lRViOZS2aE
	7V3fXdbufIJoWqXCFB5RkFxDWMcahONPeqYT4dwqMWcu+jjg3UBr/B2rkVZVgprHxQs+PsDnulZ01
	AWzLp1jdRZK/PbD9wpxyrIsszp7/9iItmmTq2LU9fBkTJrZkr+A4VUGWLHtWPD48P7v+67a6LI+Q3
	1cUm0klu/PbVtOksXIxXDIAagUf6rWRzIckCuS98iZ5rtnojTSJ8pV/gTHc0hp3Ydxy9oTBqFz3ls
	JarMhv+CVhruPupz6Svkna6Hp0/KBnINYRjq/bku1z3kcx4aw9w36LxyJZ3Ko8Xltmu5ES48q80C8
	xRhtVtLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6N-0000000HAAX-1GlR;
	Mon, 02 Nov 2026 15:37:39 +0000
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNu6D-0000000H9uy-1QmV
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 15:37:31 +0000
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so3011696a91.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633845; x=1794238645; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Co3UjJyFEnZJpTpwZDKwqCjGC43bvHMJxy07QdLEStk=;
        b=SrPPYZ+pmOqMR8KuVg0zwNWG0QJAfvqgUgSNMUzW9F0pIQ7sxM2VPJ1X2qqB1nLXRN
         CoLzl18RL7wO0ykD9WTM3QtB6lNUnuwJb3Az/UsiGpQWXPd1pJ2HCNOL9/m+OEx3fuav
         zn5Ylm/jMmLBd+OGP0ICQVBklQYVNsQsbpPBTeRCUhb71WUas8WkQ6Csgs1Efcichx41
         BjaKZoCbhBy8QY+nW0E4EtADTi86eO1kJaKsXjOwXnXiQRzVN3dwKacreqgR9IWb+lD3
         te09ZgWd8w+BoGOeAuzwjC+HAMeJgYaijzU7OS6goGPm06eS/uER83roBpQbv4YISZ49
         Iyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633845; x=1794238645;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Co3UjJyFEnZJpTpwZDKwqCjGC43bvHMJxy07QdLEStk=;
        b=KpDTdI2aHbwGUNfLEy66r0beiwCYcKum5kdTWvTJU+LMZbchGRxO0XGD3KCWnXm+3D
         Yr6xV8Nw9z907iKgcwC8ixFEs3Z2BZCgfQG4mTDPXFODloINGlIPxefvJ/0/0aS1AusY
         MnINyqf2urYWdkNhah4hNthMJcqPLvWt2lS2fEy6O02wqQR2UELf96oe6t0L8zhAy7U/
         cESHdPL7q+tH6a21PplvZoE3dJfNuGRBowpstF6bUti+npIWI4383+gl9ivfPoxOs5/2
         n0TWHTNVocip+F5hqWYh51vgPHCRvZXYXRWFttRtKHxa7rpLSzxW8Hi7SRrG7BYOrIxS
         LZ3g==
X-Gm-Message-State: APuU4Z9DrJauMqxsNswlE+zdq6DSBKBs8nO2QhLITrkGrYk7NkMZqcFr
	ZwWfv9y5CzBB0dc3Bv3z1HncRk0jIvc9+s4s8KNl1PHb1livJWuOD3pEvW/RP1W+MmO16ll0gwV
	J67Mnz/77ZvCznoWs3WiztkCDEWx15cjpVp+q9iptUfRrVddJ5/kshsdwUtwz5TcwWrTIsbGj49
	NnGuP5cEqLn6gUwiZyrZr3oTgGCy3UiGjfY/FDVEFqyp3liA==
X-Received: from pjbir4.prod.google.com ([2002:a17:90b:4684:b0:3a8:74c5:5a5c])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3887:b0:3ac:97e3:73a3
 with SMTP id 98e67ed59e1d1-3ae89574e10mr7137697a91.6.1793633844535; Mon, 02
 Nov 2026 07:37:24 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:52 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-24-vipinsh@google.com>
Subject: [PATCH v6 23/27] vfio: selftests: Add an attach() driver op
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
X-CRM114-CacheID: sfid-20261102_073729_813925_295B3F12 
X-CRM114-Status: GOOD (  20.32  )
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

Add a new attach() op to vfio_pci_driver_ops and a corresponding
vfio_pci_driver_attach() wrapper to adopt a device that was already
initialized (and optionally has memcpy operations in flight) in another
process prior to a Live Update, without resetting or reprogramming the
hardware.

Implement attach() for the igb and dsa selftest drivers: refresh process-
local BAR pointers, verify that the device hardware state and descriptor
rings are still intact as left before kexec, re-enable MSI-X, and set
driver capability limits.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/vfio/lib/drivers/dsa/dsa.c      | 35 +++++++++++++++--
 .../selftests/vfio/lib/drivers/igb/igb.c      | 39 +++++++++++++++++--
 .../lib/include/libvfio/vfio_pci_driver.h     | 17 ++++++++
 .../selftests/vfio/lib/vfio_pci_driver.c      | 22 ++++++++++-
 4 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 19d9630b24c2..2764ed4c67f8 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -215,6 +215,16 @@ static void dsa_register_cache_init(struct vfio_pci_device *device)
 	dsa->max_copies_per_batch = min(dsa->max_copies_per_batch, ARRAY_SIZE(dsa->copy));
 }
 
+static void dsa_set_limits(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+
+	device->driver.max_memcpy_count =
+		dsa->max_batches * dsa->max_copies_per_batch;
+	device->driver.max_memcpy_size = 1UL << dsa->gen_cap.max_xfer_shift;
+	device->driver.msi = MSIX_VECTOR;
+}
+
 static void dsa_init(struct vfio_pci_device *device)
 {
 	struct dsa_state *dsa = to_dsa_state(device);
@@ -236,11 +246,27 @@ static void dsa_init(struct vfio_pci_device *device)
 	dsa_command(device, IDXD_CMD_ENABLE_WQ);
 
 	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+	dsa_set_limits(device);
+}
 
-	device->driver.max_memcpy_count =
-		dsa->max_batches * dsa->max_copies_per_batch;
-	device->driver.max_memcpy_size = 1UL << dsa->gen_cap.max_xfer_shift;
-	device->driver.msi = MSIX_VECTOR;
+static void dsa_attach(struct vfio_pci_device *device)
+{
+	struct dsa_state *dsa = to_dsa_state(device);
+	union gensts_reg gensts;
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*dsa));
+
+	/* The device must still be enabled as dsa_init() left it. */
+	gensts.bits = readl(device->bars[0].vaddr + IDXD_GENSTATS_OFFSET);
+	VFIO_ASSERT_EQ((u32)gensts.state, IDXD_DEVICE_STATE_ENABLED,
+		       "Device was disabled or reset\n");
+	dsa_check_sw_err(device);
+
+	/* BAR0 is mapped at a different address now, refresh the pointers into it. */
+	dsa_register_cache_init(device);
+
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+	dsa_set_limits(device);
 }
 
 static void dsa_remove(struct vfio_pci_device *device)
@@ -420,6 +446,7 @@ const struct vfio_pci_driver_ops dsa_ops = {
 	.name = "dsa",
 	.probe = dsa_probe,
 	.init = dsa_init,
+	.attach = dsa_attach,
 	.remove = dsa_remove,
 	.memcpy_start = dsa_memcpy_start,
 	.memcpy_wait = dsa_memcpy_wait,
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index fd9e05d77ea4..3f9f631a5977 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -224,6 +224,13 @@ static void igb_reset(struct igb *igb)
 	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
 }
 
+static void igb_set_limits(struct vfio_pci_device *device)
+{
+	device->driver.max_memcpy_size = IGB_MAX_CHUNK_SIZE;
+	device->driver.max_memcpy_count = RING_SIZE - 1;
+	device->driver.msi = MSIX_VECTOR;
+}
+
 /*
  * Program the device into a usable state.  Split out of igb_init() so it
  * can be reused after a device reset to re-program the registers that
@@ -372,9 +379,7 @@ static void igb_hw_init(struct vfio_pci_device *device)
 	igb->tx_tail = 0;
 	igb->rx_tail = 0;
 
-	device->driver.max_memcpy_size = IGB_MAX_CHUNK_SIZE;
-	device->driver.max_memcpy_count = RING_SIZE - 1;
-	device->driver.msi = MSIX_VECTOR;
+	igb_set_limits(device);
 }
 
 static void igb_init(struct vfio_pci_device *device)
@@ -400,6 +405,33 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_hw_init(device);
 }
 
+static void igb_attach(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+	u64 iova_tx, iova_rx;
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
+
+	/* BAR0 is mapped at a different address in this process. */
+	igb->bar0 = device->bars[0].vaddr;
+
+	/*
+	 * The device must still use the rings and tails in the driver region,
+	 * i.e. it was not reset and the region is mapped at the same IOVAs.
+	 */
+	iova_tx = to_iova(device, igb->tx_ring);
+	iova_rx = to_iova(device, igb->rx_ring);
+	VFIO_ASSERT_EQ(igb_read32(igb, E1000_TDBAL(0)), (u32)iova_tx);
+	VFIO_ASSERT_EQ(igb_read32(igb, E1000_TDBAH(0)), (u32)(iova_tx >> 32));
+	VFIO_ASSERT_EQ(igb_read32(igb, E1000_RDBAL(0)), (u32)iova_rx);
+	VFIO_ASSERT_EQ(igb_read32(igb, E1000_RDBAH(0)), (u32)(iova_rx >> 32));
+	VFIO_ASSERT_EQ(igb_read32(igb, E1000_TDT(0)), igb->tx_tail);
+	VFIO_ASSERT_EQ(igb_read32(igb, E1000_RDT(0)), igb->rx_tail);
+
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+	igb_set_limits(device);
+}
+
 static void igb_remove(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
@@ -578,6 +610,7 @@ const struct vfio_pci_driver_ops igb_ops = {
 	.name = "igb",
 	.probe = igb_probe,
 	.init = igb_init,
+	.attach = igb_attach,
 	.remove = igb_remove,
 	.memcpy_start = igb_memcpy_start,
 	.memcpy_wait = igb_memcpy_wait,
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
index e5ada209b1d1..09603eacab4d 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
@@ -28,6 +28,21 @@ struct vfio_pci_driver_ops {
 	 */
 	void (*remove)(struct vfio_pci_device *device);
 
+	/**
+	 * attach() - Adopt @device as init() and memcpy_start() left it, e.g.
+	 * in another process before a Live Update, without resetting or
+	 * reprogramming it. Memcpy operations started then keep going and can be
+	 * waited for with memcpy_wait(). Optional.
+	 *
+	 * Only sets up what is specific to the calling process (pointers into the
+	 * BARs kept in the driver state, MSI-X) and the driver limits.
+	 *
+	 * Must be called after device->driver.region, and any memory the device
+	 * was told to DMA to, have been mapped at the same IOVAs as when init()
+	 * and memcpy_start() were called.
+	 */
+	void (*attach)(struct vfio_pci_device *device);
+
 	/**
 	 * memcpy_start() - Kick off @count repeated memcpy operations from
 	 * [@src, @src + @size) to [@dst, @dst + @size).
@@ -85,6 +100,8 @@ struct vfio_pci_driver {
 
 void vfio_pci_driver_probe(struct vfio_pci_device *device);
 void vfio_pci_driver_init(struct vfio_pci_device *device);
+void vfio_pci_driver_attach(struct vfio_pci_device *device,
+			    bool memcpy_in_progress);
 void vfio_pci_driver_remove(struct vfio_pci_device *device);
 int vfio_pci_driver_memcpy(struct vfio_pci_device *device,
 			   iova_t src, iova_t dst, u64 size);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index 5e65434d2318..b4be2070342f 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -40,7 +40,8 @@ static void vfio_check_driver_op(struct vfio_pci_driver *driver, void *op,
 {
 	VFIO_ASSERT_NOT_NULL(driver->ops);
 	VFIO_ASSERT_NOT_NULL(op, "Driver has no %s()\n", op_name);
-	VFIO_ASSERT_EQ(driver->initialized, op != driver->ops->init);
+	VFIO_ASSERT_EQ(driver->initialized,
+		       op != driver->ops->init && op != driver->ops->attach);
 	VFIO_ASSERT_EQ(driver->memcpy_in_progress, op == driver->ops->memcpy_wait);
 }
 
@@ -61,6 +62,25 @@ void vfio_pci_driver_init(struct vfio_pci_device *device)
 	driver->initialized = true;
 }
 
+/*
+ * Take over @device as vfio_pci_driver_init() left it in another process, e.g.
+ * before a Live Update. Pass @memcpy_in_progress if memcpy operations were
+ * started there, to be able to wait for them with vfio_pci_driver_memcpy_wait().
+ */
+void vfio_pci_driver_attach(struct vfio_pci_device *device,
+			    bool memcpy_in_progress)
+{
+	struct vfio_pci_driver *driver = &device->driver;
+
+	VFIO_ASSERT_NOT_NULL(driver->region.vaddr);
+	VFIO_CHECK_DRIVER_OP(driver, attach);
+
+	driver->ops->attach(device);
+
+	driver->initialized = true;
+	driver->memcpy_in_progress = memcpy_in_progress;
+}
+
 void vfio_pci_driver_remove(struct vfio_pci_device *device)
 {
 	struct vfio_pci_driver *driver = &device->driver;
-- 
2.56.0.317.g454f8302e1-goog


