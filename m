Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E65606A321
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NWQkteHe;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pZ65kEu8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=V6MeppHP57XkB6Vcbi1NjLSOrXOHPekCDqlyRxgTdoY=; b=NWQkteHez/4QgWI11eX2dmOzAi
	j1t1E1SgU099iW/SWqSvGxCQCO1iF6RmetTjiGRCr1mfPozXhntW2O/f4U3Hk8+uYEHWGpq4lHuEj
	hZtpy5Yjlci6n5SzdRWOvnASywxaTU47CsFpejH9f/H4wuuzVBS+64hMf6/SZRUPFnmlGizhb8Phx
	CvcK4AsdnZPkUvMG40pPSGN61ca4Kbylv/rBs1Bon1jhfZn1IzubfUyRAROCuWGtrc9R+eD7Fnse9
	mMLn9qDIfR6SZIMLlM/KMNElXcgbNyUBUWN/hrqDbKAOsV4W1Y6NI7KxqsU+A/xT85RlGC8n5kBve
	TJCdVSRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTM6-00000001N6u-3Zel;
	Mon, 09 Nov 2026 17:40:30 +0000
Received: from mail-oa1-x45.google.com ([2001:4860:4864:20::45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQTLw-00000001N57-222y
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 17:40:29 +0000
Received: by mail-oa1-x45.google.com with SMTP id 586e51a60fabf-49e379ab077so1201516fac.3
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 09:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794246012; x=1794850812; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6MeppHP57XkB6Vcbi1NjLSOrXOHPekCDqlyRxgTdoY=;
        b=pZ65kEu8y99cfsIz2hJ5zywXExcgfvcVGmqtjzMCgsS+C0bJNf7UQRdebzA7XtIqFJ
         pyosisqBcPRdNbWGGS5CrMInnIL0OR2kKTPIrW1n8AOSAir7yU9cvI/Sv4o7xTODMwKg
         79GwJwLXk0dlcIEwlJITvCv7GUTcNigfKfJOCfMLQRZqraXscLfjzqJnkO2n2D928sF+
         eiK/349Cu3Rh+b+1ykMKwwP3W3wdBrxUj6LHBfHLL7DM3/DNQLZgfJlBThmniJY53HeT
         ivLcw8tbA4VI4dFlCOQBS42otaSvnS27qMc3OIp6lBejs93X4LuylNE+z8cb6htlAB9I
         jkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794246012; x=1794850812;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6MeppHP57XkB6Vcbi1NjLSOrXOHPekCDqlyRxgTdoY=;
        b=M6yF48lRJKZan7CbHEab5mmHlLhhUOz6756W9WuWdv7VBo4NILR2mgPWu/BQw+0V8W
         5NOhGr6G+nLhu1iDwc5zJkcUvryqzTAMQbBMAxDohQ8QxI5p9Pp6XNQnxcIR5eEL7oHv
         78C0tv+kq+gfsN2A/GjqbU3JrjJKUY1r7mR8Hiv8gh4Rzq89P1IefTtaEZgI9Usd3QV7
         af7Cqwz7R997NHvRxN0gyD8hjV3wpxrXdPv6z+ribKt5BKmqE6cCAqt/Xis+FotPzyVf
         BzTg0Nf4uWdt03YMNBrE5AvgsIJ3W8rR7XjtecbhtbPE1HmtL0d/6+pMlnh15/PHbGV+
         z3zA==
X-Gm-Message-State: APuU4Z+jsimL4N2789rTGLPw7i5lC6DblQCKzYSLpryq48PAGfdc2QeO
	Wi2QA5ZlIM1qNV1ePZrA+5jR8c24nECnps6ShCFQollGAY8N7HGhVfjnOqfeR5myzSDgajWZl7e
	WlsggN4vF89MBnVTXUvJKkf8NABF0Wy+Fl1a/X6asStZYh/D10XFOwzs1WrRHUxGigolGWJwB5+
	ERnzfcgEf3jRSLu/fgu2fd0tnrP+pe+m+eQmz6dA6ZbcHGMUH/65w=
X-Received: from iofm3-n1.prod.google.com ([2002:a05:6602:83c3:10b0:9c7:7259:cd7e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c126:b0:4d6:9113:25ad with SMTP id 5614622812f47-5683ce779b1mr275284b6e.48.1794246011548;
 Mon, 09 Nov 2026 09:40:11 -0800 (PST)
Date: Mon,  9 Nov 2026 17:40:09 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261109174009.735309-1-dmatlack@google.com>
Subject: [PATCH] PCI: liveupdate: Factor out pci_dev_ser allocation and release
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_094020_562671_8461DFC2 
X-CRM114-Status: GOOD (  19.72  )
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

Move the code that starts and stops preserving a device into
pci_liveupdate_alloc_dev_ser() and pci_liveupdate_free_dev_ser(), and
split pci_liveupdate_preserve_device() into separate paths for devices
that are already preserved and devices being preserved for the first
time. Leave a single refcount increment shared by both paths.

Since upstream bridges are preserved once for every preserved device
below them, nr_devices is only incremented when a device's struct
pci_dev_ser is allocated and only decremented when it is released, not
on every preserve and unpreserve. Keeping that accounting in a pair of
helpers makes the relationship explicit.

A side-effect of the refactor to pci_liveupdate_preserve_device() is
that preserving an already-preserved endpoint after it is frozen now
fails with -EINVAL instead of -EBUSY, since the frozen check now happens
first.

Link: https://lore.kernel.org/linux-pci/20261106173427.GA1633106@bhelgaas/
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 88 ++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 6f92d4ddca2b..3a18a7e2d81f 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -498,6 +498,44 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 	return dev_ser;
 }
 
+/*
+ * Start preserving @dev by allocating its struct pci_dev_ser. The caller is
+ * responsible for taking a reference on it.
+ */
+static struct pci_dev_ser *pci_liveupdate_alloc_dev_ser(
+		struct pci_flb_outgoing *outgoing, struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser;
+
+	dev_ser = pci_flb_alloc_dev_ser(outgoing);
+	if (IS_ERR(dev_ser))
+		return dev_ser;
+
+	pci_info(dev, "Device will be preserved across next Live Update\n");
+	outgoing->ser->nr_devices++;
+	outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
+
+	dev_ser->domain = pci_domain_nr(dev->bus);
+	dev_ser->bdf = pci_dev_id(dev);
+	dev->liveupdate.outgoing = dev_ser;
+	return dev_ser;
+}
+
+/*
+ * Stop preserving @dev by releasing its struct pci_dev_ser. The caller must
+ * have dropped the last reference on it.
+ */
+static void pci_liveupdate_free_dev_ser(struct pci_flb_outgoing *outgoing,
+					struct pci_dev *dev)
+{
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
+	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
+	outgoing->ser->nr_devices--;
+	memset(dev_ser, 0, sizeof(*dev_ser));
+	dev->liveupdate.outgoing = NULL;
+}
+
 static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 					    struct pci_dev *dev)
 {
@@ -521,10 +559,7 @@ static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
 	if (--dev_ser->refcount)
 		return 0;
 
-	pci_info(dev, "Device will no longer be preserved across next Live Update\n");
-	outgoing->ser->nr_devices--;
-	memset(dev_ser, 0, sizeof(*dev_ser));
-	dev->liveupdate.outgoing = NULL;
+	pci_liveupdate_free_dev_ser(outgoing, dev);
 	return 0;
 }
 
@@ -544,6 +579,8 @@ static void pci_liveupdate_unpreserve_path(struct pci_flb_outgoing *outgoing,
 static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 					  struct pci_dev *dev)
 {
+	struct pci_dev_ser *dev_ser = dev->liveupdate.outgoing;
+
 	if (dev->is_virtfn) {
 		pci_warn(dev, "Cannot preserve Virtual Functions\n");
 		return -EINVAL;
@@ -559,43 +596,32 @@ static int pci_liveupdate_preserve_device(struct pci_flb_outgoing *outgoing,
 		return -EINVAL;
 	}
 
-	/*
-	 * Endpoint devices should not be preserved more than once.
-	 * Bridges are preserved once for every downstream device that
-	 * is preserved.
-	 */
-	if (dev->liveupdate.outgoing && !dev->subordinate) {
-		pci_warn(dev, "Device is already preserved\n");
-		return -EBUSY;
-	}
-
-	if (dev->liveupdate.outgoing && !dev->liveupdate.outgoing->refcount) {
-		pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
-		return -EINVAL;
-	}
-
 	if (dev->liveupdate.frozen) {
 		pci_warn(dev, "Cannot preserve device after it is frozen!\n");
 		return -EINVAL;
 	}
 
-	if (!dev->liveupdate.outgoing) {
-		struct pci_dev_ser *dev_ser;
+	if (dev_ser) {
+		/*
+		 * Endpoint devices can only be preserved once. Bridges are
+		 * preserved once for every preserved device below them.
+		 */
+		if (!dev->subordinate) {
+			pci_warn(dev, "Device is already preserved\n");
+			return -EBUSY;
+		}
 
-		dev_ser = pci_flb_alloc_dev_ser(outgoing);
+		if (!dev_ser->refcount) {
+			pci_WARN(dev, 1, "Preserved device with 0 refcount!\n");
+			return -EINVAL;
+		}
+	} else {
+		dev_ser = pci_liveupdate_alloc_dev_ser(outgoing, dev);
 		if (IS_ERR(dev_ser))
 			return PTR_ERR(dev_ser);
-
-		pci_info(dev, "Device will be preserved across next Live Update\n");
-		outgoing->ser->nr_devices++;
-		outgoing->ser->devices = kho_block_set_head_pa(&outgoing->block_set);
-
-		dev_ser->domain = pci_domain_nr(dev->bus);
-		dev_ser->bdf = pci_dev_id(dev);
-		dev->liveupdate.outgoing = dev_ser;
 	}
 
-	dev->liveupdate.outgoing->refcount++;
+	dev_ser->refcount++;
 	return 0;
 }
 

base-commit: 7e966191f7a235c2f29d5450090b3bd9106c5f99
-- 
2.56.0.506.g506a7eabc5-goog


