Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7660A2601
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W/i7mocq;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k0uW5KZf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vA8W8np9fXaskA2k2ROSy6+asR0jHvCl6wOsZYrc5lM=; b=W/i7mocq16c4wXaOPoWSGemQOc
	c0lFBBT6Mddp+9DLQS5Zz9+ycldq63izjirc7HG0SSOpxYkTagUJcQeQ29zZuYDc32G3cY/S2QAt+
	VyAnLO2rPH0GsqrYiMqABoYVltHyCnCAtOt+C5Upif2WUQK+GQblzk4tVxCEomBI6Z+loPRnw/96y
	1RcAdqZ5i1VpakG+2pHuuIBZGhGMQXBjyqBtG9sWcj3rencCKnJYSvLMghSfvvo+qrQgPH9UNDih6
	O/VxAwrmSca+y+aHtTjQ1RZlw1rxDr1wtN1dAQ9rF23x/wJAVEhTtTF19ApZjZhLN8Absd9AD8/MD
	cH6pTWIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe0Q-00000002SOe-1M4s;
	Tue, 10 Nov 2026 05:02:50 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe00-00000002RVN-2MCr
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:31 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6b706aec65bso1580514a12.3
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286942; x=1794891742; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vA8W8np9fXaskA2k2ROSy6+asR0jHvCl6wOsZYrc5lM=;
        b=k0uW5KZf6TaWboLBvZF5MDIw7Q9aMf1+v4arH2ZOhAxLWUI/y8DPxOaYtwDrPyC74y
         N49bXqT6ThNsIo3H55D52IoSOWnpLPQBn1bKujWb9Nnord7GgJjlolG9xQuEaPHKro7U
         UpfqaZXsUvhc0DoJ4F33q1uMvm0J+JTFUWS7P1fOka+GGTmiZO8i4t7mAo+v3YTYhTo5
         5WRDKL597g1c26bu9qU2E9vDR4DQ4S/nIwZZ/7uY6YqCiGwgfnOrSw7J/K0P/zztHkiw
         nFE3NjVfvAAyBFQnS/qWbL1kwwkWGFPsM9DT+99/qH6eBBzmfqkKOtWRpuQyo8zhzPFr
         6N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286942; x=1794891742;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA8W8np9fXaskA2k2ROSy6+asR0jHvCl6wOsZYrc5lM=;
        b=Y2GtJSCCdmnH4wlSWVtwT+EjX6/n3DySKo+XPv5SqgNZa/rD+rFNiw2HkRJHi+lHVJ
         TQ8TyIo+C+bX8okQoIdvDtmbRxPCw2pmZVV7uBXNOPURpKNRrEsJqEeKM3y0omECkYUS
         IdHxSDT5IaUAu6jhx1xYPMbauKkc4kb8Jf4ZL/0PPtZ0bKZfBmas42LvTcHiFOsPQeuI
         eWXUtY0N+95y8cc2jmadmGHTeBVEmQxHjTQZcTZpQhr9EzydG1mavEC74IHQBmHTtTrk
         K9OIHg7isEYnI/9fSQRxhyXWgkZvYeYK+kNz2Vbx5rtNuLkTN9tt/RshMOyNxFrY+DUh
         QJ5Q==
X-Forwarded-Encrypted: i=1; AL+hErHsezXdF4tEQ5kBx8cpOn9aPDbhH27yAFgep2+kNKu5mbLS8zG2z3xqwWGwlicZBJjgMyAKDw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9MvqqgU3rOEB9I+WzcIFFNZmwzQjgLzWgO8u5gTMuoZtXYZWq3
	6KALtQFVNxu94M4DPE677jLdDkEn/Pe6+dsD1ZQ8oTjC0w17OqZ6E0zC1Hj19hddx1NfVRuzaxW
	Ui8kcL6tuowJ3SU+Mww==
X-Received: from edty17.prod.google.com ([2002:aa7:ccd1:0:b0:6b5:5ee4:9030])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5516:b0:6b4:87b8:1348 with SMTP id 4fb4d7f45d1cf-6b756ae845cmr1164654a12.27.1794286941928;
 Mon, 09 Nov 2026 21:02:21 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:58 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-16-tarunsahu@google.com>
Subject: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct pci_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_210224_679039_0B6BFDCF 
X-CRM114-Status: GOOD (  31.20  )
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

struct pci_ser currently defines its own PCI-specific required_flags and
optional_flags bitmasks (capped at 64 bits without recorded structure
size) and stores dev_ser_size in the parent structure even though KHO
block headers now record entry_size directly. In addition, struct
pci_ser and struct pci_dev_ser still carry __packed despite having
naturally aligned fields on 64-bit architectures.

Precede struct pci_ser with struct kho_ser_hdr via DECLARE_KHO_SER,
removing required_flags, optional_flags, and
PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
from the KHO block header entry_size. Drop __packed from struct pci_ser
and struct pci_dev_ser, adding an explicit u32 reserved field to struct
pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
pci-v2.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 drivers/pci/liveupdate.c    | 74 +++++++++++++++++--------------------
 include/linux/kho/abi/pci.h | 63 +++++++++++--------------------
 2 files changed, 55 insertions(+), 82 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6f92d4ddca2b..0bda94f4a7e4 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -233,7 +233,7 @@ static struct pci_liveupdate_global pci_liveupdate = {
 
 /**
  * struct pci_flb_outgoing - Outgoing PCI FLB object
- * @ser: Pointer to the preserved struct pci_ser.
+ * @fhdr: Pointer to the serialization feature header.
  * @block_set: The KHO block set holding the outgoing devices.
  *
  * This structure holds the runtime state for the outgoing PCI Live Update
@@ -241,14 +241,14 @@ static struct pci_liveupdate_global pci_liveupdate = {
  * the serialized entries.
  */
 struct pci_flb_outgoing {
-	struct pci_ser *ser;
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
 	struct kho_block_set block_set;
 };
 
 /**
  * struct pci_flb_incoming - Incoming PCI FLB object
- * @ser: The incoming struct pci_ser from the previous kernel.
- * @xa: Xarray used to quickly lookup devices in @ser.
+ * @fhdr: Pointer to the serialization feature header.
+ * @xa: Xarray used to quickly lookup preserved devices.
  * @block_set: The KHO block set holding the incoming devices.
  *
  * This structure holds the runtime state for the incoming PCI Live Update
@@ -256,17 +256,11 @@ struct pci_flb_outgoing {
  * the serialized entries, and an xarray for fast lookups.
  */
 struct pci_flb_incoming {
-	struct pci_ser *ser;
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
 	struct xarray xa;
 	struct kho_block_set block_set;
 };
 
-/*
- * Bits in struct pci_ser::required_flags that this kernel knows how to handle.
- * No flags are currently defined.
- */
-#define PCI_SER_REQUIRED_FLAGS_SUPPORTED	0ULL
-
 /* PCI_LIVEUPDATE depends on 64BIT, so domain and bdf always fit. */
 static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
 {
@@ -276,27 +270,28 @@ static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
 static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 {
 	struct pci_flb_outgoing *outgoing __free(kfree) = NULL;
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr);
 	struct pci_ser *ser;
 
 	outgoing = kzalloc_obj(*outgoing);
 	if (!outgoing)
 		return -ENOMEM;
 
-	ser = kho_alloc_preserve(sizeof(*ser));
-	if (IS_ERR(ser))
-		return PTR_ERR(ser);
+	fhdr = kho_alloc_preserve(kho_ser_size(pci_ser));
+	if (IS_ERR(fhdr))
+		return PTR_ERR(fhdr);
 
-	ser->required_flags = 0;
-	ser->optional_flags = 0;
-	ser->dev_ser_size = sizeof(struct pci_dev_ser);
+	kho_ser_init(fhdr, pci_ser);
+	ser = kho_ser_payload(fhdr, pci_ser);
 	ser->nr_devices = 0;
+	ser->reserved = 0;
 	ser->devices = 0;
 
-	outgoing->ser = ser;
+	outgoing->fhdr = fhdr;
 	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
 
 	args->obj = no_free_ptr(outgoing);
-	args->data = virt_to_phys(ser);
+	args->data = virt_to_phys(fhdr);
 	pr_debug("Preserved struct pci_ser (0x%llx)\n", args->data);
 	return 0;
 }
@@ -307,9 +302,9 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
 
 	pr_debug("Unpreserving struct pci_ser (0x%llx)\n", args->data);
 
-	WARN_ON(outgoing->ser->nr_devices);
+	WARN_ON(kho_ser_payload(outgoing->fhdr, pci_ser)->nr_devices);
 	kho_block_set_destroy(&outgoing->block_set);
-	kho_unpreserve_free(outgoing->ser);
+	kho_unpreserve_free(outgoing->fhdr);
 	kfree(outgoing);
 }
 
@@ -321,35 +316,29 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
  */
 static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
-	struct pci_ser *ser = phys_to_virt(args->data);
+	DECLARE_KHO_SER_HDR(pci_ser, *fhdr) = phys_to_virt(args->data);
 	struct pci_flb_incoming *incoming;
 	struct pci_dev_ser *dev_ser;
 	struct kho_block_set_it it;
+	struct pci_ser *ser;
 	int ret;
 
 	pr_debug("Retrieving struct pci_ser (0x%llx)\n", args->data);
 
-	if (ser->required_flags & ~PCI_SER_REQUIRED_FLAGS_SUPPORTED)
-		panic("Incoming PCI FLB requires unsupported features (0x%llx)\n",
-		      ser->required_flags & ~PCI_SER_REQUIRED_FLAGS_SUPPORTED);
+	ret = kho_ser_validate(fhdr, pci_ser);
+	if (ret)
+		panic("Failed to validate incoming PCI FLB feature header (%d)\n", ret);
 
-	/*
-	 * The previous kernel may have appended fields to struct pci_dev_ser,
-	 * which this kernel ignores, but every entry must be at least the
-	 * minimum size.
-	 */
-	if (ser->dev_ser_size < PCI_DEV_SER_MIN_SIZE)
-		panic("Incoming PCI FLB has unsupported struct pci_dev_ser size (%u)\n",
-		      ser->dev_ser_size);
+	ser = kho_ser_payload(fhdr, pci_ser);
 
 	incoming = kzalloc_obj(*incoming);
 	if (!incoming)
 		panic("Failed to allocate struct pci_flb_incoming\n");
 
-	incoming->ser = ser;
+	incoming->fhdr = fhdr;
 	xa_init(&incoming->xa);
 
-	kho_block_set_init(&incoming->block_set, ser->dev_ser_size);
+	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
 	ret = kho_block_set_restore(&incoming->block_set, ser->devices);
 	if (ret)
 		panic("Failed to restore devices KHO block set (%d)\n", ret);
@@ -393,7 +382,7 @@ static void pci_check_all_devices_finished(struct pci_flb_incoming *incoming)
 	 * This runs once the last reference to the incoming FLB is dropped, so
 	 * there are no finishers left in flight.
 	 */
-	nr_devices = incoming->ser->nr_devices;
+	nr_devices = kho_ser_payload(incoming->fhdr, pci_ser)->nr_devices;
 	if (nr_devices == 0)
 		return;
 
@@ -428,7 +417,7 @@ static void pci_flb_finish(struct liveupdate_flb_op_args *args)
 
 	xa_destroy(&incoming->xa);
 	kho_block_set_destroy(&incoming->block_set);
-	kho_restore_free(incoming->ser);
+	kho_restore_free(incoming->fhdr);
 	kfree(incoming);
 }
 
@@ -522,7 +511,7 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 		return 0;
 
 	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
-	outgoing->ser->nr_devices--;
+	kho_ser_payload(outgoing->fhdr, pci_ser)->nr_devices--;
 	memset(dev_ser, 0, sizeof(*dev_ser));
 	dev->liveupdate.outgoing = NULL;
 	return 0;
@@ -580,6 +569,7 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 	}
 
 	if (!dev->liveupdate.outgoing) {
+		struct pci_ser *ser = kho_ser_payload(outgoing->fhdr, pci_ser);
 		struct pci_dev_ser *dev_ser;
 
 		dev_ser = pci_flb_alloc_dev_ser(outgoing);
@@ -587,8 +577,8 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 			return PTR_ERR(dev_ser);
 
 		pci_info(dev, "Device will be preserved across next Live Update\n");
-		outgoing->ser->nr_devices++;
-		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+		ser->nr_devices++;
+		ser->devices = kho_block_set_head_pa(&outgoing->block_set);
 
 		dev_ser->domain = pci_domain_nr(dev->bus);
 		dev_ser->bdf = pci_dev_id(dev);
@@ -876,6 +866,7 @@ static int pci_liveupdate_finish_device(struct pci_ser *ser, struct pci_dev *dev
 void pci_liveupdate_finish(struct pci_dev *dev)
 {
 	struct pci_flb_incoming *incoming;
+	struct pci_ser *ser;
 
 	guard(rwsem_write)(&pci_liveupdate.rwsem);
 
@@ -885,8 +876,9 @@ void pci_liveupdate_finish(struct pci_dev *dev)
 		return;
 	}
 
+	ser = kho_ser_payload(incoming->fhdr, pci_ser);
 	for_each_pci_dev_in_path(dev) {
-		if (pci_liveupdate_finish_device(incoming->ser, dev))
+		if (pci_liveupdate_finish_device(ser, dev))
 			break;
 	}
 
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index c2e3a5949f73..f53f6350e53d 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -8,9 +8,8 @@
 #ifndef _LINUX_KHO_ABI_PCI_H
 #define _LINUX_KHO_ABI_PCI_H
 
-#include <linux/bug.h>
-#include <linux/compiler.h>
-#include <linux/stddef.h>
+#include <linux/build_bug.h>
+#include <linux/kho/abi/feature.h>
 #include <linux/types.h>
 
 /**
@@ -18,33 +17,20 @@
  *
  * The PCI core preserves its state across kexec as Live Update
  * File-Lifecycle Bound (FLB) data, identified by the compatible string
- * ``"pci"`` and laid out as described by the structs below.
+ * ``"pci-v2"`` and laid out as described by the structs below.
  *
- * This layout is a contract between kernels. Rather than being versioned, it
- * is extended according to the following rules:
+ * struct pci_ser is preceded by &struct kho_ser_hdr, which records the
+ * total size of the serialization and feature flags. See
+ * include/linux/kho/abi/feature.h for the feature header layout, feature
+ * rules, and validation.
  *
- *  * Existing fields must never be moved, resized, removed, or have their
- *    meaning changed. New fields may only be appended to the end of a struct.
- *
- *  * A bit set in ``pci_ser.required_flags`` marks a feature that the next
- *    kernel must understand to safely take over the preserved devices. The
- *    next kernel panics if it finds a bit it does not know how to handle.
- *
- *  * A bit set in ``pci_ser.optional_flags`` marks a feature that the next
- *    kernel can safely ignore if it does not understand it.
- *
- *  * Fields appended to struct pci_ser must be accompanied by a flag that
- *    indicates they are present, since the size of struct pci_ser is not
- *    recorded.
- *
- *  * The size of each struct pci_dev_ser is recorded in
- *    ``pci_ser.dev_ser_size`` and is never smaller than
- *    ``PCI_DEV_SER_MIN_SIZE``. The next kernel ignores any fields beyond the
- *    ones it knows about, and must handle entries that are smaller than its
- *    own struct pci_dev_ser.
+ * Preserved devices are serialized as struct pci_dev_ser entries stored in
+ * a KHO block set. The block header records the entry size, allowing the
+ * next kernel to step through entries using the source kernel's stride
+ * even if fields are added in later versions.
  */
 
-#define PCI_LUO_FLB_COMPATIBLE "pci"
+#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
 
 /**
  * struct pci_dev_ser - Serialized state about a single PCI device.
@@ -61,13 +47,9 @@ struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
 	u16 refcount;
-} __packed;
+};
 
-/*
- * The size of struct pci_dev_ser when this ABI was introduced. Since fields
- * can only be appended, every struct pci_dev_ser is at least this large.
- */
-#define PCI_DEV_SER_MIN_SIZE offsetofend(struct pci_dev_ser, refcount)
+static_assert(sizeof(struct pci_dev_ser) == 8);
 
 /**
  * struct pci_ser - PCI Subsystem Live Update State
@@ -77,20 +59,19 @@ struct pci_dev_ser {
  * core; the state a driver needs to resume its device is preserved separately
  * by that driver.
  *
- * @required_flags: Features that the next kernel must support to take over
- *                  the preserved devices. No flags are currently defined.
- * @optional_flags: Features that the next kernel may ignore if it does not
- *                  support them. No flags are currently defined.
- * @dev_ser_size: The size in bytes of each struct pci_dev_ser in @devices.
+ * Preceded by &struct kho_ser_hdr.
+ *
  * @nr_devices: The number of devices that were preserved.
+ * @reserved: Reserved for alignment.
  * @devices: Physical address of the first KHO block containing pci_dev_ser.
  */
 struct pci_ser {
-	u64 required_flags;
-	u64 optional_flags;
-	u32 dev_ser_size;
 	u32 nr_devices;
+	u32 reserved;
 	u64 devices;
-} __packed;
+};
+
+/* Register pci_ser with KHO serialization accessors */
+DECLARE_KHO_SER(pci_ser, 16, 0, 0);
 
 #endif /* _LINUX_KHO_ABI_PCI_H */
-- 
2.56.0.506.g506a7eabc5-goog


