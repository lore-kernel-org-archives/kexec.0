Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A83FF512E
	for <kexec@archiver.kernel.org>; Tue,  7 Apr 2026 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RU9CUTBlQTV9unvZiW1Jd4pICbElcO0miIF1kiEWLp4=; b=TOlufX2zFya0r6Fpb07MESs3l5
	fxjYWradsbEqYewu0cEDF1Mwc4p1aAWRxbccX8OZhkuWV7TVxLfdmMGe4tAXC3qq2NhMtskTMkTSP
	55BjtLyqzT1eBs5Ukckg0Kfqx9UuXrThex7IenHfMQXXEl/J5JA3KU2jVk0hYXAy8GCGSYByvXNaU
	9ayBNKgP+CamRUYswokyNJzN5+/ixcaXU7RJqNLUHGk7lRWBD7Ms41imEZv1Txs3PGKIinOtl4Y2n
	60uMMye+7mVUfoeN7AdrnuGR6E1RMuSgGnZRaqXbYNdt+dP+5CUytaroBuZftoUh5wJHFiVpUdNJd
	3hzmCdGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9oZ-00000006pIO-0yhy;
	Tue, 07 Apr 2026 17:02:11 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wA9oX-00000006pHa-1A00
	for kexec@lists.infradead.org;
	Tue, 07 Apr 2026 17:02:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=RU9CUTBlQTV9unvZiW1Jd4pICbElcO0miIF1kiEWLp4=; b=TDW7x8/Cs5bog2cDLG7VRZw7mI
	uXdr5mFUG0MHd/TjOmBDl3ivMIiF2q2rgA8LWXVvR0d3+AVnpWpRf4n4rjTlR/DSZEd02PSBfWqO9
	A0jZAJj3dFxox5lZ1fvv5iVwGTd5XhZNRXAuHKNn/DFmzdqGv4nvM9TGt7vSg5aFsVnH3hsfdoXza
	gif5GP1xJXNZOVc8ZjjZ9+lhp7iTfBQub4UeKgf8M+EQFEggWPgwcTMq7do11Bj0XsEEKL+7upZmc
	NyIp54SgnZzTgTe1ee+PcccgWdWh/a/NszTSpOWqQfOwUdtAglQZP7tUZL0tO7NHrBXN+03HQc8V+
	LTzBs2jw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wA9oO-007mvG-1S;
	Tue, 07 Apr 2026 17:01:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 07 Apr 2026 10:01:47 -0700
Subject: [PATCH] kho: fix error handling in kho_add_subtree()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-kho_fix_send-v1-1-b21977feb960@debian.org>
X-B4-Tracking: v=1; b=H4sIAHo41WkC/yXMTQqDMBAG0KsM39pAjH+Qq5QiaiY6LcSSaUUQ7
 y5tl2/zDihnYYWnA5k3UVkTPJUFYVqGNLORAE9w1rW2tp15LmsfZe+VUzADV1Us29A11qEgvDJ
 H2X/d7f63fsYHT+/vgfO8AOSrA1twAAAA
X-Change-ID: 20260407-kho_fix_send-ae33f16d7502
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270; i=leitao@debian.org;
 h=from:subject:message-id; bh=mGwEireWqSGdcxepiszY5FgqrgUhgGJ91Fpy3eOBcDM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp1TiD8BaOCojAoyo4gqxHXTLFN+vR9pNm/DeW3
 TfrpuAhq7yJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCadU4gwAKCRA1o5Of/Hh3
 bQYFD/0VGdPVpIsIE+BuFlsCe113eYUK+EoINu70uXmeeQkBov6zRr52bpi+VEaWBJd47lWSy7H
 XKY/7ME30RAOXDTT5aPAFNKnlaIbXh3voGs7YsJTmD+dWikCYu00M7rq/E7y92Di5/QnXmfiCNC
 lPhxivU8c4pl7f2LK5wV4D4R2TWPupeLDZta+7EkNm6HRuu9QxpqOKumCKyJzjNfI/vKXqHksBi
 HE3sLwzVVn+F1bwfMDMNbmkmE5gQceOTvCQU2BLr92qPRO3TJp+zE2zoSBHfMV7yyukt8aXy+C7
 +0yJMkcKFxXveJ8L6k8B/9Sa9VhiM3O7P5zcJbEEvK4f2MKd5HE8GwyKC6y8jXViK+L4G0/NDmf
 Y5NPV2JmP6dk1v734w+kDqOzxrCogiLSM8pYhMp6cgk1KSgyyr4Ts+Cl9W440s45dsH4aISs3EQ
 G/pL919eTfRLrVd5HZZrdgeZRbxQzf/5mO0+e+4mvY0SXm/+EbHXLu6zCqFZu2QFbccBpECsHti
 1Ayk9dMMgIuUoU53ik9kQ4cy8IfFyJtbu0/eDmo6AP2N6TTftctPOPi88p7fG3VrpX/Zwt35/M5
 RUaivx4dN/ow8yCQO/e7wOeV6cEqmM+C8vRndLhsC3l5Gb0f56tup1VgOF3N0uNI9FovLd4hjSS
 xrKD/hwBiQgiPYA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260407_100209_349888_0725F1AC 
X-CRM114-Status: GOOD (  10.97  )
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

Fix two error handling issues in kho_add_subtree(), where it doesn't
handle the error path correctly.

1. If fdt_setprop() fails after the subnode has been created, the
   subnode is not removed. This leaves an incomplete node in the FDT
   (missing "preserved-data" or "blob-size" properties).

2. The fdt_setprop() return value (an FDT error code) is stored
   directly in err and returned to the caller, which expects -errno.

Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
out_del_node label that removes the subnode on failure, and only setting
err = 0 on the success path, otherwise returning -ENOMEM (instead of
FDT_ERR_ errors that would come from fdt_setprop).

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/liveupdate/kexec_handover.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 94762de1fe5f0..18509d8082ea7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -762,19 +762,24 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
+			      &phys, sizeof(phys));
+	if (fdt_err < 0)
+		goto out_del_node;
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
-			  &size_u64, sizeof(size_u64));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
+			      &size_u64, sizeof(size_u64));
+	if (fdt_err < 0)
+		goto out_del_node;
 
 	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
 					  size, false));
 
+	err = 0;
+	goto out_pack;
+
+out_del_node:
+	fdt_del_node(root_fdt, off);
 out_pack:
 	fdt_pack(root_fdt);
 

---
base-commit: 9763aa6c6df784d7159925c0b3bef4dfb791e84f
change-id: 20260407-kho_fix_send-ae33f16d7502

Best regards,
--  
Breno Leitao <leitao@debian.org>


