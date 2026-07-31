Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01C2C55179
	for <kexec@archiver.kernel.org>; Fri, 31 Jul 2026 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=als7b8ug69mz+jjevN//6dwMY7mF0ZGUUEH5Txoyuyo=; b=E96keA6gfsKVPy0/hz2dt/RpMX
	Efo6d1W4YUCA7was3YArRkcaZL/gp2dfDRqWoqgZ3Pnn0nOZc2o/9yg3FUnRo7qUACEZGl/M/RrqR
	pqiHnL45o+Ml0gp5sfqER9OYtyOfryJAB8Lg6yEkO5ZHy8EKPi/0/8/ALkxP8Pqi4nghr4k1+n8YB
	HXrijBMkq/Qn8StqJFfI6Ke+sJ+vFoGYasxWPLT4Ibqf4zBYlOuwG0egU6hcoScfb5OZIV/whxN4Y
	iyWeari86/Ihm7Ao2k8HS5RNQra02ux1OSTtjt8pTrJgiq9unVTdb3ZvY0w2zFjTr9zJJ5a3LAWFx
	PbtUSLOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAV-0000000Ddtx-3TYn;
	Fri, 31 Jul 2026 21:53:27 +0000
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpvAS-0000000Ddrx-3odw
	for kexec@lists.infradead.org;
	Fri, 31 Jul 2026 21:53:26 +0000
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so1946758a91.0
        for <kexec@lists.infradead.org>; Fri, 31 Jul 2026 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785534803; x=1786139603; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=als7b8ug69mz+jjevN//6dwMY7mF0ZGUUEH5Txoyuyo=;
        b=jd4D+C2qfbNwz33qSt/NwHuCdgzzuWtqZprKfK04aqXK5UYFWPDxrJ7iYm3tq0SQZM
         SN3Up9V8oa+s8dxh1EhafykatpMEQmZYTVw/pOTcwd6WJIggXi3vyrwsBvouspxr4Wss
         y41RZCU3o/37R4Ry4MdW02vLQYxkVUNRIq1U7DRJL3OyXIxb8utdgkboBmomm3RKvgGz
         385Vg9tDJ/1oHLWIBjK0flaWHfNymEkhr2Dp+hZuWCszKCG2qHsqWcNGavIBUkp0rGYI
         iPjqOYT6cJ3YiB5Dcasbf5IO5XlRCr34jUsOcsjeg15EzKh6lm3xwrrhLdGgBJ/MXyyd
         JV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534803; x=1786139603;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=als7b8ug69mz+jjevN//6dwMY7mF0ZGUUEH5Txoyuyo=;
        b=cW1Up7HbOUM3mPGgflhSJUyZAOyTewHFHkye3YCoHpjYO64VWU4xE5pcj0rjdk+yun
         77mAHEQhXa86kiGUjUOD6yvgGvOTPg75VJMzr/LyjX+6Kxw4divIHPDFnVcwlOr8U6mJ
         ot7IJtpA8SZmi17IMfyyTlfKDmbugh16dQ/jWk74uqEHogcOWTlKd4g0zbPOvjcYdoC5
         5rv7Ck11anIx1Faa8EC55/CZxOZl5kLcowM0dvwx4pPWHbzIEn5XIarstbhJ1QxDnJcm
         emrOt6ZpzAUGEOoQHFzBI6ZC8Mpvhcs1AU8vEkuHPH2navisC1XB//QLJZUtTQ0NNYc7
         pAxg==
X-Forwarded-Encrypted: i=1; AHgh+RpIOcdBgWQkk7wJ8Xs/cp10CJBwDlzh1lZxAbREPjIB7I2EjgLiSjShwyLscJrzX14lG+0EcA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6c+JctP8qbqDbmOrIeDOGsXpRY4O1U2kGNtatYqD/TfeVs2Fi
	XaVwraIY7O0iz7qVuFEsekSSDiMNcuCaMrVj8BmLbpJ7eat5iJKbncwQt22wsPXYJmoQE5gsLwI
	ubn7k3Rpi2YuELDSyXdFXRQ==
X-Received: from dycmf5.prod.google.com ([2002:a05:693c:2485:b0:30f:42b1:df2b])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2dc7:b0:37f:9ce2:348c with SMTP id 98e67ed59e1d1-38fbc4eead6mr1133723a91.29.1785534803101;
 Fri, 31 Jul 2026 14:53:23 -0700 (PDT)
Date: Fri, 31 Jul 2026 14:52:23 -0700
In-Reply-To: <20260731215224.831696-1-loganodell@google.com>
Mime-Version: 1.0
References: <20260731215224.831696-1-loganodell@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731215224.831696-4-loganodell@google.com>
Subject: [RFC PATCH 3/4] kho: Add support for multiple versions to debugfs
From: Logan Odell <loganodell@google.com>
To: graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com
Cc: pratyush@kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_145324_962176_661C7D0B 
X-CRM114-Status: GOOD (  12.55  )
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

Update kho_in_debugfs_init to search for versioned subnodes
(depth 2) and expose them as name-version in the input debugfs.
This ensures versioned subtrees are visible to userspace for debugging,
matching the behavior of the output side.

Signed-off-by: Logan Odell <loganodell@google.com>
---
 kernel/liveupdate/kexec_handover_debugfs.c | 57 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 2f93939168ab..2ca055219900 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/libfdt.h>
 #include <linux/mm.h>
+#include <linux/unaligned.h>
 #include "kexec_handover_internal.h"
 
 static struct dentry *debugfs_root;
@@ -140,19 +141,49 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 		const u64 *fdt_phys;
 
 		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
-		if (!fdt_phys)
-			continue;
-		if (len != sizeof(*fdt_phys)) {
-			pr_warn("node %s prop fdt has invalid length: %d\n",
-				name, len);
-			continue;
-		}
-		err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
-					    phys_to_virt(*fdt_phys));
-		if (err) {
-			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
-				ERR_PTR(err));
-			continue;
+		if (fdt_phys) {
+			if (len != sizeof(*fdt_phys)) {
+				pr_warn("node %s prop fdt has invalid length: %d\n",
+					name, len);
+				continue;
+			}
+			err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir, name,
+						    phys_to_virt(get_unaligned(fdt_phys)));
+			if (err) {
+				pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
+					ERR_PTR(err));
+			}
+		} else {
+			int grandchild;
+
+			fdt_for_each_subnode(grandchild, fdt, child) {
+				const char *gc_name = fdt_get_name(fdt, grandchild, NULL);
+				const u64 *gc_fdt_phys;
+				char *combined_name;
+
+				gc_fdt_phys = fdt_getprop(fdt, grandchild, "fdt", &len);
+				if (!gc_fdt_phys)
+					continue;
+
+				if (len != sizeof(*gc_fdt_phys)) {
+					pr_warn("node %s/%s prop fdt has invalid length: %d\n",
+						name, gc_name, len);
+					continue;
+				}
+
+				combined_name = kasprintf(GFP_KERNEL, "%s-%s", name, gc_name);
+				if (!combined_name)
+					continue;
+
+				err = __kho_debugfs_fdt_add(&dbg->fdt_list, sub_fdt_dir,
+							combined_name,
+							phys_to_virt(get_unaligned(gc_fdt_phys)));
+				kfree(combined_name);
+				if (err) {
+					pr_warn("failed to add fdt %s-%s to debugfs: %pe\n",
+						name, gc_name, ERR_PTR(err));
+				}
+			}
 		}
 	}
 
-- 
2.55.0.508.g3f0d502094-goog


