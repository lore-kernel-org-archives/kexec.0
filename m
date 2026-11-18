Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3A60A6F5F
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TngyNWSK;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ObchUOsy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dseap2a1tzzPeaoigzCviLoXjiETn3csEuQBuadnT6s=; b=TngyNWSKiXu4SKd01w47prKV2+
	BAxyUHyKxtw6j/JzfVJFlYNZDCQ4e8RTks8b5t1eUCjlBxeHHLuzCG+e6eLUKnivzUEUhcWB1z3vk
	1h4wTcOHuY/r71Wz/vZnh5KOeYGIR9VynIxv2a9yf/Sq8Hdiurnk8DORaKaoJJPbbsevTT2wB1OFK
	maXjagso5ukwJn+m5Yiewu8t93wpd95YIeuMYFLhwSTrLYb+ximAtNEb+hd2fX1kbRMRBcIU1aavF
	I1kbosp6aRteFPi72Sv9Wy10x/62x5Btbj+OANQOymUXl9jd9LAIfrELGmRF5qhu58m1DGkhtff8z
	RqHhgOXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHJ-0000000AQ2a-2IhN;
	Wed, 18 Nov 2026 22:37:21 +0000
Received: from mail-oa1-x45.google.com ([2001:4860:4864:20::45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHD-0000000APt0-1keZ
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:16 +0000
Received: by mail-oa1-x45.google.com with SMTP id 586e51a60fabf-448d51840c4so1082124fac.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041434; x=1795646234; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dseap2a1tzzPeaoigzCviLoXjiETn3csEuQBuadnT6s=;
        b=ObchUOsyqVBZXi7JdbHYNwtUldxosjhfRlilKsM3k2isAztZeZmscpiLXsin8LSBSX
         FbQ608StSNMRdvvKlaaRtzEbd7JF2u3ji1jePGyMJAg9P9m85b0MauQq2brWk0anqfVh
         Pshea0ZYE2J0zOe9vk7N92bC4CUIlvltB5kV7BI7Jebj054VGS/AmsHRhonR01gobQcD
         I13SNMGNqpBJF+QLVSOl45UFeuepxK7HRKH6xDciDTR/kRrKMkCBFJEH8JgNJBzRSfgi
         KTDyfMs7w/l+wpj6nNQlVT3Cn2r11KT67a5kz5mmVq5Vtc8RqA+figeRxULqL4rWJd3l
         zifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041434; x=1795646234;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dseap2a1tzzPeaoigzCviLoXjiETn3csEuQBuadnT6s=;
        b=s/zmPqFyTysQ8CT8j7omLnp5XE3qco4YTHesAGxjc0yZy/iw3mVJquKSJ86ZoIkLtT
         gI+VXQJDCcDy+Qr121g6KfL35Bf4zDV6inZy0P8I54JJ4nucJztdVDKLiOoiUqnGkCXs
         f6R6t2GMczj0fa0uViBkbrR9/j2NsLiG2MPZfLQes7s3MmmSOaEyRo2ym2QKwOUSzv/3
         c1QzOO2pK0ytpvd4Np+N91MlfumkapzVfJeA552Ec2LgUAUzL/nSn3QVyuVD8PHk4Cpq
         IzQPugUScvbb0DHIFjkfIo+JB8rz4S4hfuiUZv1OYx4QX2RNXJHm4SWhBl4SiNElNXLg
         56qQ==
X-Gm-Message-State: APuU4Z9Cw0IjXfG+2hnlYs6MzHb7czC35p3zLXjfTge4JZMwKpjhKiF0
	6ZPX229gH2bKZiJmBE8KqseVXCpQuR2Fm9A8W8bMOlZPZumWBA8sk44t7zjOMgdfP8srNjg1TAO
	97VXwdsF4iyeW82gytULy7Wq9q+t0s/Xpqbm7+HIzDfaBgzJw97nGhze5jk6Bi9fwIaNIpsSkGD
	ScRSR8s4fUAEAylWQpu62hGrq7Jt2sdBSGW3fXPDVffJy0r8R+MVg=
X-Received: from jaan16-n1.prod.google.com ([2002:a05:6638:aad0:10b0:620:20bd:b624])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6809:703:10b0:567:f627:67eb with SMTP id 5614622812f47-5775a1dbdf5mr3136425b6e.25.1795041433518;
 Wed, 18 Nov 2026 14:37:13 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:56 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-6-dmatlack@google.com>
Subject: [PATCH v11 05/13] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_143715_481559_DF14979A 
X-CRM114-Status: GOOD (  27.49  )
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

Automatically preserve every bridge between a preserved device and its
root port when the device is preserved.

Subsequent commits use this to ensure that preserved devices can
continue performing memory transactions without a disruption or change
in routing.

Track the number of preserved devices at or below each bridge with a
reference count in struct pci_dev_ser. A bridge stays preserved until
all of its downstream preserved devices are unpreserved or finish their
participation in the Live Update.

struct pci_ser::nr_devices counts the struct pci_dev_ser entries that are
in use, so it only changes when a device's entry is allocated or
released, i.e. when its reference count goes from 0 to 1 or from 1 to 0,
not on every preserve and unpreserve.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/liveupdate.c | 125 +++++++++++++++++++++++++++++----------
 include/linux/pci.h      |   3 +
 2 files changed, 97 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index d1b4000c3e78..ad2bb73e1d05 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -122,7 +122,6 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
- *  * The device cannot be behind a PCI-to-PCI bridge.
  *
  * Driver Binding
  * ==============
@@ -137,6 +136,18 @@
  * bound to the correct driver. The PCI core does not protect against a device
  * getting preserved by driver A in the outgoing kernel and then getting bound
  * to driver B in the incoming kernel.
+ *
+ * PCI-to-PCI Bridges
+ * ==================
+ *
+ * Any PCI-to-PCI bridges upstream of a preserved device are automatically
+ * preserved when the device is preserved. The PCI core keeps track of the
+ * number of downstream devices that are preserved under a bridge so that the
+ * bridge is only unpreserved once all downstream devices are unpreserved.
+ *
+ * This lets the PCI core keep the bridges above preserved devices forwarding
+ * their memory transactions, without changes in routing, throughout the Live
+ * Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -437,7 +448,8 @@ static struct pci_dev_ser *pci_liveupdate_alloc_dev_ser(
 }
 
 /*
- * Stop preserving @dev by releasing its struct pci_dev_ser.
+ * Stop preserving @dev by releasing its struct pci_dev_ser. The caller must
+ * have dropped the last reference on it.
  */
 static void pci_liveupdate_free_dev_ser(struct pci_flb_outgoing *outgoing,
 					struct pci_dev *dev)
@@ -450,43 +462,71 @@ static void pci_liveupdate_free_dev_ser(struct pci_flb_outgoing *outgoing,
 	dev->liveupdate.outgoing = NULL;
 }
 
-static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
-					     struct pci_dev *dev)
+static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
+					    struct pci_dev *dev)
 {
 	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
 	if (!dev_ser) {
 		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
-		return;
+		return -EINVAL;
 	}
 
+	if (!dev_ser->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
+	}
+
+	if (--dev_ser->refcount)
+		return 0;
+
 	pci_liveupdate_free_dev_ser(outgoing, dev);
+	return 0;
+}
+
+static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
+					   struct pci_dev *dev,
+					   struct pci_dev *end)
+{
+	for_each_pci_dev_in_path(dev) {
+		if (dev == end)
+			break;
+
+		if (pci_liveupdate_unpreserve_device(outgoing, dev))
+			return;
+	}
 }
 
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 					  struct pci_dev *dev)
 {
-	struct pci_dev_ser *dev_ser;
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
 
 	if (dev->is_virtfn) {
 		pci_warn(dev, "Cannot preserve Virtual Functions\n");
 		return -EINVAL;
 	}
 
-	if (dev->liveupdate.outgoing) {
-		pci_warn(dev, "Device is already preserved\n");
-		return -EBUSY;
+	if (dev_ser) {
+		/*
+		 * Endpoint devices can only be preserved once. Bridges are
+		 * preserved once for every preserved device below them.
+		 */
+		if (!dev->subordinate) {
+			pci_warn(dev, "Device is already preserved\n");
+			return -EBUSY;
+		}
+
+		if (!dev_ser->refcount) {
+			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
+		if (IS_ERR(dev_ser))
+			return PTR_ERR(dev_ser);
 	}
 
-	if (!pci_is_root_bus(dev->bus)) {
-		pci_warn(dev, "Cannot preserve devices behind bridges\n");
-		return -EINVAL;
-	}
-
-	dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
-	if (IS_ERR(dev_ser))
-		return PTR_ERR(dev_ser);
-
 	dev_ser->refcount++;
 	return 0;
 }
@@ -500,12 +540,16 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
  * pci_liveupdate_preserve() from their struct liveupdate_file_handler
  * preserve() callback to ensure the outgoing struct pci_ser is already set up.
  *
+ * pci_liveupdate_preserve() automatically preserves all bridges upstream of
+ * @dev.
+ *
  * Return: 0 on success, <0 on failure.
  */
 int pci_liveupdate_preserve(struct pci_dev *dev)
 {
 	struct pci_flb_outgoing *outgoing = NULL;
-	int ret;
+	struct pci_dev *start = dev;
+	int ret = -ENODEV;
 
 	guard(rwsem_write)(&pci_liveupdate.rwsem);
 
@@ -513,7 +557,13 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
 	if (IS_ERR(outgoing))
 		return PTR_ERR(outgoing);
 
-	ret = pci_liveupdate_preserve_device(outgoing, dev);
+	for_each_pci_dev_in_path(dev) {
+		ret = pci_liveupdate_preserve_device(outgoing, dev);
+		if (ret) {
+			pci_liveupdate_unpreserve_path(outgoing, start, dev);
+			break;
+		}
+	}
 
 	pci_liveupdate_flb_put_outgoing();
 	return ret;
@@ -528,6 +578,9 @@ EXPORT_SYMBOL_GPL(pci_liveupdate_preserve);
  * longer be preserved across the next Live Update. Drivers are expected to call
  * pci_liveupdate_unpreserve() from their struct liveupdate_file_handler
  * unpreserve() callback, while the outgoing struct pci_ser still exists.
+ *
+ * pci_liveupdate_unpreserve() drops @dev's reference on each bridge upstream of
+ * @dev, unpreserving bridges that have no other preserved devices below them.
  */
 void pci_liveupdate_unpreserve(struct pci_dev *dev)
 {
@@ -541,7 +594,7 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_unpreserve_device(outgoing, dev);
+	pci_liveupdate_unpreserve_path(outgoing, dev, /*end=*/NULL);
 	pci_liveupdate_flb_put_outgoing();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
@@ -621,28 +674,30 @@ void pci_liveupdate_cleanup_device(struct pci_dev *dev)
 		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
 }
 
-static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
+static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev)
 {
 	if (!dev->liveupdate.incoming) {
 		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
-		return;
+		return -EINVAL;
 	}
 
-	if (dev->liveupdate.incoming->refcount != 1) {
-		pci_WARN(dev, 1, "Preserved device has a corrupted refcount!\n");
-		return;
+	if (!dev->liveupdate.incoming->refcount) {
+		pci_WARN(dev, 1, "Preserved device has a 0 refcount!\n");
+		return -EINVAL;
 	}
 
 	/*
-	 * Drop the refcount so this device does not get treated as an incoming
-	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
-	 * again because the device is hot-plugged.
+	 * Once the refcount reaches 0 the device is no longer treated as
+	 * incoming, e.g. if pci_liveupdate_setup_device() gets called again
+	 * because the device is hot-plugged.
 	 */
-	dev->liveupdate.incoming->refcount = 0;
+	if (--dev->liveupdate.incoming->refcount)
+		return 0;
 
 	pci_info(dev, "Device is finished participating in Live Update\n");
 	dev->liveupdate.incoming = NULL;
 	ser->nr_devices--;
+	return 0;
 }
 
 /**
@@ -654,6 +709,10 @@ static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *de
  * Update. Drivers must call pci_liveupdate_finish() from their struct
  * liveupdate_file_handler finish() callback, while the incoming struct pci_ser
  * is still available.
+ *
+ * pci_liveupdate_finish() drops @dev's reference on each bridge upstream of
+ * @dev, finishing bridges that have no other incoming preserved devices below
+ * them.
  */
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
@@ -667,7 +726,11 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
-	pci_liveupdate_finish_device(incoming->ser, dev);
+	for_each_pci_dev_in_path(dev) {
+		if (pci_liveupdate_finish_device(incoming->ser, dev))
+			break;
+	}
+
 	pci_liveupdate_flb_put_incoming();
 }
 EXPORT_SYMBOL_GPL(pci_liveupdate_finish);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bb500623ca3e..6482549a8417 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -840,6 +840,9 @@ static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 	return dev->bus->self;
 }
 
+#define for_each_pci_dev_in_path(dev) \
+	for (; dev; dev = pci_upstream_bridge(dev))
+
 #ifdef CONFIG_PCI_MSI
 static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev)
 {
-- 
2.56.1.703.gf848ed807c-goog


