Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817786082BF7
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QxHH73Nw;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N9I2h8X0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=; b=QxHH73NwkWk8ij47wrxG8VvQHx
	gpNtfXjdVVo5KmUca2knxGnRxxrwe9707Sz95+r+Hl39krKY5D8T5DGdqkzjo1X6v00Qz99Cxvj5D
	9qnVlBDH0WL3+bTNypuwRHrxDzhAMxI2W+JL9xYJncJLVDwEoWX8PQnw4fAgE0DUifzCR8ZSjwQ5i
	KgPm+5PoK2oSMSYmBSimxBCzfNxZT84aJBmb5mwpHRLvF0GrqsW1fTWGvqis32G8HF4bI2UgRBeCY
	G9MXgYL/LDjbbInlptH7tf+oImfJm9Fm0HL3gGTcA++V5ccWh6h+X6Ir9no33QDxKDIpNdc6TXr5A
	Z5TvLWvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP83A-0000000Aw8G-0peU;
	Fri, 06 Nov 2026 00:43:24 +0000
Received: from mail-oi1-x248.google.com ([2607:f8b0:4864:20::248])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP830-0000000Avti-3wyX
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 00:43:20 +0000
Received: by mail-oi1-x248.google.com with SMTP id 5614622812f47-5640a2d9708so91759b6e.1
        for <kexec@lists.infradead.org>; Thu, 05 Nov 2026 16:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925793; x=1794530593; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
        b=N9I2h8X0tKM4SqzC5OhMItSGkbUtU7/Vu8wWNeOIEZTb9S8F79B48n+JccPxp4HO+Z
         0ND+Xq0KiJI4uKKeOY47tE8181MP25bZPNieEOfjHUXBQfJC4hl8OaD4dbgJv5MtR8it
         4qw1zaBt6D0uuI6+EnX7EllN5vb8SDla9A8wBnLHI5Zx/VblAUkz6fFqUc5A0LkV6A5c
         4/PWNiuWOrzlgC/BQ46/Njb7+1Nuq3R1yN2MeiIPUGYSWsk5+Bb2PDj2GMqoTXybeXsJ
         6XZf8qbzwu0McQovwiw3L/pRaglrp8IPaA7FiJpfHMpQ1Ua06Dq6PxZVy8tS1yxxgAN2
         dJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925793; x=1794530593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ko9lBiZy6mSuKQIVTlOLgBpFZr5J5ifQKI8Or80My08=;
        b=scAfydJ5OTN83KmDua/5cIYWqPvHoBHRDoC53rAiawo5KSKUVxP7GbMzcOfRo1UV/o
         PvjdzAqjh+5QwQFDHGZE6N5fcIYaz2td8LsHFt6F/hhew8G1X0hOgHvgPH4zSNajsIxb
         CpN7Faieny3CxBRInZVBY40BaBQfYYSC8r4w4FvcltihyfTLUupyxiJAIsTsHFmTuqop
         +W550ST4Sz2frZuvaTywI5IFARtMlLxTnLObfdogWHXg/AoLb4Ex5F/tQ0pLhk++995v
         E4ksdwBCwNiaFkTA73LxeORHunwX4TWEVwp96Aviax2I0kyHwYXbYhSU/h88ZDPqlvfi
         E14g==
X-Gm-Message-State: APuU4Z+md6Ap5wB8bGurGTvF30bOvZ+f9vBOjfa1XpUUsYmnemvFqq8c
	z7PJFjVQ4XGWf6ychBPbrGCWNVtWe6S78C18YS79AdsPV+RbtWQ4V7tqJAB4/r+43iTrYHEVurn
	KgSmXm3rrRDPeIA9YD0qn/Av9u8/QbDY6+apgXb5V09FDOuTvkD6c1BMfZpIwMbwEY4qAv6j5/d
	XJmLM6MIJMA4a1O60hYojWzuHMAvFl9mmBctMEvBJqtZHySVIRRNw=
X-Received: from iobgs6.prod.google.com ([2002:a05:6602:4fc6:b0:9c7:69c7:3d52])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5087:b0:4f4:857c:98ae with SMTP id 5614622812f47-567e0faea86mr686749b6e.11.1793925792669;
 Thu, 05 Nov 2026 16:43:12 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:14 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-14-dmatlack@google.com>
Subject: [PATCH v2 13/17] PCI/VC: Split the VC Resource Control restore into a helper
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
X-CRM114-CacheID: sfid-20261105_164315_032931_EF6CA767 
X-CRM114-Status: GOOD (  14.69  )
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

Move the restore of the VC Resource Control register out of
pci_vc_do_save_buffer() and into pci_vc_restore_res_ctrl().

Restoring this register is more involved than the rest of the walk: the
enable bit has to be preserved across the write, the port arbitration
table may have to be reloaded, and the VC may have to be re-enabled
afterwards. Inlined in the middle of a loop that is already sizing,
saving and restoring three kinds of register, it is hard to see where
that sequence begins and ends.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/vc.c | 51 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index a4ff7f5f66dd..5b507207d56d 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -168,6 +168,37 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 		pci_err(link, "VC%d negotiation stuck pending\n", id);
 }
 
+/**
+ * pci_vc_restore_res_ctrl - Restore a VC Resource Control Register
+ * @dev: device
+ * @pos: starting position of VC capability (VC/VC9/MFVC)
+ * @res: VC resource number, ie. VCn (0-7)
+ * @ctrl: saved VC Resource Control Register
+ */
+static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res,
+				    u32 ctrl)
+{
+	int ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
+	u32 tmp;
+
+	/*
+	 * For an FLR case, the VC config may remain.  Preserve enable bit,
+	 * restore the rest.
+	 */
+	pci_read_config_dword(dev, ctrl_pos, &tmp);
+	tmp &= PCI_VC_RES_CTRL_ENABLE;
+	tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
+	pci_write_config_dword(dev, ctrl_pos, tmp);
+
+	/* Load port arbitration table if used */
+	if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
+		pci_vc_load_port_arb_table(dev, pos, res);
+
+	/* Re-enable if needed */
+	if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
+		pci_vc_enable(dev, pos, res);
+}
+
 /**
  * pci_vc_do_save_buffer - Size, save, or restore VC state
  * @dev: device
@@ -311,23 +342,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 			if (save)
 				pci_read_config_dword(dev, ctrl_pos,
 						      (u32 *)buf);
-			else {
-				u32 tmp, ctrl = *(u32 *)buf;
-				/*
-				 * For an FLR case, the VC config may remain.
-				 * Preserve enable bit, restore the rest.
-				 */
-				pci_read_config_dword(dev, ctrl_pos, &tmp);
-				tmp &= PCI_VC_RES_CTRL_ENABLE;
-				tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
-				pci_write_config_dword(dev, ctrl_pos, tmp);
-				/* Load port arbitration table if used */
-				if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
-					pci_vc_load_port_arb_table(dev, pos, i);
-				/* Re-enable if needed */
-				if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
-					pci_vc_enable(dev, pos, i);
-			}
+			else
+				pci_vc_restore_res_ctrl(dev, pos, i,
+							*(u32 *)buf);
 			buf += 4;
 		}
 		len += 4;
-- 
2.56.0.455.g6c5a503b38-goog


