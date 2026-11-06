Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44364606EEBD
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dyR6pKUt;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kx5KteiF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VfIh1JSY3MeIq0CEtKa0epmsvwLqQj8oYtgMnnQZzbo=; b=dyR6pKUtZ2oCiYVbOMP4yzYUOV
	CN4/W/KtqdRK6oIumn5m9D1Ky9u4vfcCrLODJHJd0BKwij5lIvqGtoTY/WgM3T/pLMWyjuHZtPgc1
	RkTJVd3BcyYYnQnq4qyePs+fFHChmaDC4zLriVTJGGqO6SQi5NZhMqp8nw3O/D61cMeLvRu7jKeVr
	NX59OJqaOD1uFhhBSqShFqTNywr72MujJ14wjOcgeJKSkQm+RvSNLF6MeVoT8xn5bP32boy1vK8ih
	FAiL80nE5zAX0eYo2MCXE5ReNnVAmxOZHafwPcSRGOYFHpq/U+SkTlirRggBzkGGPxdFMI75xKS6M
	OTTcZsNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP832-0000000AvyA-2p9v;
	Fri, 06 Nov 2026 00:43:16 +0000
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP82y-0000000Avps-0GB8
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:14 +0000
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-4b26d8d2498so69495b6e.2
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925791; x=1794530591; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VfIh1JSY3MeIq0CEtKa0epmsvwLqQj8oYtgMnnQZzbo=;
        b=kx5KteiFXuP4a5hrIroEPTLvH4zRPGvGnn6UFqdy1BVAacRk2FukVIhWSQckMn3mGr
         NMQalbAbxrZhWcd6mxltYVlEcDi+O0w8yt99YMVgVb/ct6PRU0Qf4VuawOgtUccZeJyu
         nOknPbEnEX6TYLDgtVnorf3bl5rN4pefphyEC2S+o3czbGyaJHmM6A+54Jd6kcfRGZhZ
         Q0oHjFpSKb72ztANT+/N4tzkzJVV3s+O40oLPFRjTNSOqo/q3UyU1aHLGCy92L6XCfNI
         Yb7nNyTR896X4fwQ07KuPqn0OvBCHd9iO/MFe8WJ/A6vrOB03at1t6pG7hRunKbCX6PU
         iQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925791; x=1794530591;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VfIh1JSY3MeIq0CEtKa0epmsvwLqQj8oYtgMnnQZzbo=;
        b=BItZN48HiYNo4vIAoiX5OIfNZIrX0AtU5ObtLp5Kk92NkBkHe8VwXPawwLFCOkrG+8
         9nsDl3ZaVuZlCqWb/Q8r44J4jG/vM1TbOqONx9xCRjGYGGnO8/7S6wlkmKAKTfz/sgUo
         zAg/QyVLgju1L/jqGMkvmY2b+RbnF/uJKrbzOzoT/I1J9SwotftEVBumMnamGB6h3bLM
         yj06kF3SG34nq/QlwatkpDVPvLue13BJkp7/a4VEkQu2umb95MLikmjvFC8/kU9+Uf9u
         7AYTZJnuuZscGzOahWj6HdGg9l4jud+62dAhCruj4mWJHxqZOsw2h+ewQYK8N3x1H7Ey
         85aQ==
X-Gm-Message-State: APuU4Z/QKfG3LrmeNZ0mO8NRzCEbrlhKDgfSg9L11aJlBXdXp8MU2DLX
	NuuhI9W/JnDAao/uJ+5CXX+pFvprHmJ4CXoxgVfx6aWcEV7negPZfaadzjNtfPr3hPKB7EDK4kx
	1KTugsjvt577D5oie4sbqutlybYYg++a6icArs89Ik/QlvrGQqG9kuAbMDoH/c/wPXYFghj/zss
	Coy1LMgFmoB4DkVsKIU6o4CCgULU1pYOKi0xvXvgVOhjIunuVF7Dk=
X-Received: from ioo11-n1.prod.google.com ([2002:a05:6602:864b:10b0:9e2:221a:fd83])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a21:b0:561:fa43:1b2f with SMTP id 5614622812f47-567e0fc17c3mr657310b6e.20.1793925790093;
 Thu, 05 Nov 2026 16:43:10 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:12 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-12-dmatlack@google.com>
Subject: [PATCH v2 11/17] PCI/DPC: Save DPC state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_164312_134493_519CE7D8 
X-CRM114-Status: GOOD (  14.05  )
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

Save and restore the DPC Control register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Key the save and restore paths off pdev->dpc_cap rather than
pci_is_pcie(). The old code relied on the save buffer existing only when
the capability did, and the store has no per-capability entry to check.

Reserve the register in pci_reserve_dpc_state(), called from
pci_dpc_init().

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pcie/dpc.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index b7f79266f66d..16203e9ef240 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -45,34 +45,18 @@ static const char * const rp_pio_error_string[] = {
 
 void pci_save_dpc_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
-	if (!save_state)
+	if (!dev->dpc_cap)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, cap);
+	pci_save_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
 }
 
 void pci_restore_dpc_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
-	if (!save_state)
+	if (!dev->dpc_cap)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
+	pci_restore_cap_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL);
 }
 
 static DECLARE_WAIT_QUEUE_HEAD(dpc_completed_waitqueue);
@@ -400,6 +384,16 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+static void pci_reserve_dpc_state(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = pci_reserve_saved_cap(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, sizeof(u16));
+	if (rc)
+		pci_err(pdev, "unable to reserve DPC save state (%pe)\n",
+			ERR_PTR(rc));
+}
+
 void pci_dpc_init(struct pci_dev *pdev)
 {
 	u16 cap;
@@ -408,8 +402,7 @@ void pci_dpc_init(struct pci_dev *pdev)
 	if (!pdev->dpc_cap)
 		return;
 
-	if (pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_DPC, sizeof(u16)))
-		pci_err(pdev, "unable to allocate suspend buffer for DPC\n");
+	pci_reserve_dpc_state(pdev);
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
 	if (!(cap & PCI_EXP_DPC_CAP_RP_EXT))
-- 
2.56.0.455.g6c5a503b38-goog


