Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DA8C55174
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXN1kpPZzQWxyZLtIWIq6X9QJe/5QaMTFSKsE0QskIU=; b=M+OMH1ZyBJLhSYyq9IDGWXahD7
	b32qAN/NH6YUKLrCYLppJKKF2XoZxdk2WvyZa7bNdFLr4u7ULluAZuaX126hBBrXJdgnJu4oDtwKU
	i29CYes17aVu4eG6eX/eGARFknZc+jCsiNlJewnWG+oZwsyddHOI1DsnmJYNSCGokcGgkF3MKdiTV
	DvdP0N/MhXjkkByQiuFsoMlrhh2cMzKU3mC0Pw0k4VMGcS/F/pqwuIuG1k7nEgDsALXnyj/i4ybVx
	IF508lpZ/Dle9/W4tEUpt0Tjh4b1QNG2YtElWr94KDtjzma5pOJM2rZTDkE3HUqiPPKKPnYoLI66E
	FyU6NG0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAT-0000000Ddt9-2GEe;
	Fri, 31 Jul 2026 21:53:25 +0000
Received: from mail-pg1-x548.google.com ([2607:f8b0:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAR-0000000Ddr9-0bTs
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 21:53:24 +0000
Received: by mail-pg1-x548.google.com with SMTP id 41be03b00d2f7-cb711c88f2eso749059a12.2
        for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534801; x=1786139601; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXN1kpPZzQWxyZLtIWIq6X9QJe/5QaMTFSKsE0QskIU=;
        b=f24AHWrVCSZby04wQZbk/tS5EUX0hOBONyFPiOTm3QtPfmg/ZAHE17DV4CMlFBWNsC
         O9POtfLnrDu6ZtXHv+e9RoEgJq9F5okQgTMNDXgolLlmH06PcBtEuIFWUj/wAOkThDkT
         XQ1m/cB50UDKa35wN9wL7hhDkQJDs4JZ3w/7aFk2fcVjBfJ7y1605mUbvZItc2OKlBXK
         sS+zJu0y+9u2z1sUmDFP4PwYDWj3aI5Ybu+e221G1iGJ9TR5cRG9/9ha3q+FE4EGWRly
         vtCYsgntAZDry9RJHM5FxymLND8ZvCrAulkPw4qFQ7SbTvCV/h0tnw7Hv4ITWtKLdJ7U
         NN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534801; x=1786139601;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IXN1kpPZzQWxyZLtIWIq6X9QJe/5QaMTFSKsE0QskIU=;
        b=lPodiG94AzbSBGLTqH4cDmCXkh2nzDa7mpNy6IyHOgp1bZB3yAXg7Fm/nCAChXibno
         kAnq/gubBtVkc2SCt5hlIVwr9JqYcxWYUtqjGZEebbNwsGAINYt+x3bd+y9lO2BnS7m+
         ccTcpW3eiXY+oOLMekx+WEpP6iV1EjyyNCtDpF1La412VKio6xfuUZZeIwCGS7nYpTP8
         4Xg8ZpM/iZqD32vklfzvyOtZ1LdsozkhyhfsMa/GkiJNlDc49+rszcMioi/DUqrD5KuN
         T0fHqnM85CeUM0tJUMehyfFDgFM/1iJWn67np5KPUeX+NchOsahBNZ/ohi/Uixly4GeC
         nj/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rql6aExEGIk7Sd5atxyTahANq7gaC+F1talzBpuPoDp7hytAnj5Yw8p4vo9tv5MzV4t55Tr9A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxY7WV/TRTP7b1bs7jqJ2UTPH+o3f3L7LvcuY+VBrA70VRfAZWl
	oF5CCgbvUWB9gfYozUjX4lg9+dkyMJ5DWdUlmxrCjuOG22d5o6SEw9ZOkIvIAZN3hT8CWs1RlGH
	bKiEJAEGsoT5+YT9RqmtC6Q==
X-Received: from dybkz17.prod.google.com ([2002:a05:7301:1a11:b0:313:b255:3ca2])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3393:b0:3b1:a9ce:507e with SMTP id adf61e73a8af0-3c92a60a0f1mr1289190637.32.1785534801433;
 Fri, 31 Jul 2026 14:53:21 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:52:21 -0700
In-Reply-To: <20260731215224.831696-1-loganodell@google.com>
Mime-Version: 1.0
References: <20260731215224.831696-1-loganodell@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731215224.831696-2-loganodell@google.com>
Subject: [RFC PATCH 1/4] kho: Move subtree blob logic to separate function
From: Logan Odell <loganodell@google.com>
To: graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com
Cc: pratyush@kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_145323_189321_831C264F 
X-CRM114-Status: GOOD (  12.10  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Move the logic to set the blob data in a subtree node into a separate
function to allow for re-use. No functional change.

Signed-off-by: Logan Odell <loganodell@google.com>
---
 kernel/liveupdate/kexec_handover.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cc68a3692905..29a05cec2625 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -722,6 +722,21 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
+static int kho_add_subtree_node(const char *name, void *root_fdt, void *fdt, int off)
+{
+	int err;
+	phys_addr_t phys = virt_to_phys(fdt);
+
+	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
+			  &phys, sizeof(phys));
+	if (err)
+		return err;
+
+	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
+
+	return 0;
+}
+
 /**
  * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
  * @name: name of the sub tree.
@@ -739,7 +754,6 @@ static void __init kho_reserve_scratch(void)
  */
 int kho_add_subtree(const char *name, void *fdt)
 {
-	phys_addr_t phys = virt_to_phys(fdt);
 	void *root_fdt = kho_out.fdt;
 	int err = -ENOMEM;
 	int off, fdt_err;
@@ -757,12 +771,7 @@ int kho_add_subtree(const char *name, void *fdt)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
-
-	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
+	err = kho_add_subtree_node(name, root_fdt, fdt, off);
 
 out_pack:
 	fdt_pack(root_fdt);
-- 
2.55.0.508.g3f0d502094-goog


