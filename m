Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1847F46455
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CrU8iiVUzo7pzSuSlrROr+d13XFM4fDOr9PEDnip+Ig=; b=zuMLnNMakCZp9y0Ivg1sPdwEsT
	CWqZXGYdbf2XiSiADGzAaFWp04K8tV8QNMynqoNxcRQWbzqGtKzlRyaElV5bHYomdPnPwBebbl0a3
	ZwZ43zEsg0zGeLxTKAzf+5v5hgzVisiZmQhr3gz2V+9v/D5mlIWMOlZFU4Y/SFMaLyGRLGu3cbiau
	d26gFJa4oS/LflhZukFBN6Xk++dsIzPNzsED1itzC/cDLScXnGjVD8Wmyyq2QlFlomMg1DcVcskHK
	9LDk2/FpAxTDszlneo+eD7wLvc7cnSlysgj6FI6ajUUB0BEAJtP1ZVKo4ZwylpKstpxqeBtArrl96
	djoOtZzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26Yh-00000003s1b-0iyR;
	Mon, 16 Mar 2026 11:56:31 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26Ye-00000003rzG-3Hhl
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 11:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=CrU8iiVUzo7pzSuSlrROr+d13XFM4fDOr9PEDnip+Ig=; b=eNv2Gl9d4wYCGxiYb9k5o8EJfY
	eNiOmFRtE5PUpTBnH28VW7jwhd/8SQe852fGq6zh51WyuRLYq8TgQpz2wIN8lOgYb65Di77WPieLz
	WC8fqGpv1Ahls+R/W5QUGkAjc4oMwGT/BMbCVCTOV6nZn0+ANauxTK0aY+ISlRJ4pvvdt6LvrN0Mg
	4Oae993m4dkSRkyXLMRCAblIe8b54fYdDrYmHZf6Flavp8mgwVymBHqqL3NB2vZE0oofbQ4Nu/sBL
	AV9dJN8MY5VDLdVnSxwfx3Cf+d5Nwhm97/wjT4ktXeqqoxvF+VLkY6fRdf8hpdYALmI3fhneTF7SI
	Pg884qZw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w26YZ-0025zV-Rq; Mon, 16 Mar 2026 11:56:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 16 Mar 2026 04:54:34 -0700
Subject: [PATCH v9 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-kho-v9-4-ed6dcd951988@debian.org>
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
In-Reply-To: <20260316-kho-v9-0-ed6dcd951988@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usama.arif@linux.dev, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=leitao@debian.org;
 h=from:subject:message-id; bh=NdnEnb82h7S9muDEUV3/7Wtzdn0YHHb9hUPR57PIUzA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpt+/QHPzXS1ApQQHREue5wikETwUmtKSVrZnZ3
 eHOP/JL5c6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabfv0AAKCRA1o5Of/Hh3
 beOTD/42Ij2t2+/+Rqjfwm8NNjanxcOJ58mHmWDZuXoyPvGHmSXH/SY69y40/LrHEJNf9TRZgZ7
 Riyh8VL6H6HMJnHTYFuQc0cymBgEBTn9QqDeiOAmWjWJTfH5fCufmVWTTseNRrYFP3xhtmruHxz
 0kdGvpz7a4DUsJhWlnwyWJSZrGDVXp/kI+jkNDvYimoO3pVwt1txEhOn01K0Y6bQV8RRfLJTcHn
 Jd/Rj3qlXJB0v/oN4WevdrZjExLxykDRwkDKVvskGGCYEmC/kQlEnSLvrM3YjQmSgRwxI9O4LRn
 bjQSLwEFSMrqpO1KxeKe4X1B6GEWPWHaxappsva0lNkH25FFgG2Ofrj4b+o99ZrvoXGq4icPr/l
 Oa469NQz8su/0HBEfLvGCTxZniQiqhYVCXnEB6AzRhOKvnTgllFFp+RtZ/MPUVSxjs7lc8Xlkv0
 c+U2TFB/5HSkDgtXv/2ikSA4Jpb0mvjR6fZbvae9o4wcwUG1OKKTak59W9WUuJYWW0+2Rak7oxL
 uJ2ARLkaLXLLCC2yChKodg58TBI7OZ5UYJP7lAoxttq4fcKAmEDKCyZIaT31W41MaHg0pNUcwhD
 DNvuh1KVfOSK7/3Gms85Qs86wJ1kZ4WVif2Soo8RK1jBObxAvGjvjWfmSn5xICgcPVoO/VXndkk
 14u+16jjvmFTo0w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_045628_896724_EA55D958 
X-CRM114-Status: GOOD (  10.03  )
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

kho_in_debugfs_init() calls fdt_totalsize() to determine blob sizes,
which assumes all blobs are FDTs. This breaks for non-FDT blobs like
struct kho_kexec_metadata.

Fix this by reading the "blob-size" property from the FDT (persisted
by kho_add_subtree()) instead of calling fdt_totalsize(). Also rename
local variables from fdt_phys/sub_fdt to blob_phys/blob for
consistency with the non-FDT-specific naming.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/liveupdate/kexec_handover_debugfs.c | 32 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index b416846810d78..257ee8a52be66 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -122,24 +122,34 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 	fdt_for_each_subnode(child, fdt, 0) {
 		int len = 0;
 		const char *name = fdt_get_name(fdt, child, NULL);
-		const u64 *fdt_phys;
-		void *sub_fdt;
+		const u64 *blob_phys;
+		const u64 *blob_size;
+		void *blob;
 
-		fdt_phys = fdt_getprop(fdt, child,
+		blob_phys = fdt_getprop(fdt, child,
 					KHO_SUB_TREE_PROP_NAME, &len);
-		if (!fdt_phys)
+		if (!blob_phys)
 			continue;
-		if (len != sizeof(*fdt_phys)) {
-			pr_warn("node %s prop fdt has invalid length: %d\n",
-				name, len);
+		if (len != sizeof(*blob_phys)) {
+			pr_warn("node %s prop %s has invalid length: %d\n",
+				name, KHO_SUB_TREE_PROP_NAME, len);
 			continue;
 		}
-		sub_fdt = phys_to_virt(*fdt_phys);
+
+		blob_size = fdt_getprop(fdt, child,
+					KHO_SUB_TREE_SIZE_PROP_NAME, &len);
+		if (!blob_size || len != sizeof(*blob_size)) {
+			pr_warn("node %s missing or invalid %s property\n",
+				name, KHO_SUB_TREE_SIZE_PROP_NAME);
+			continue;
+		}
+
+		blob = phys_to_virt(*blob_phys);
 		err = __kho_debugfs_blob_add(&dbg->fdt_list, sub_fdt_dir, name,
-					     sub_fdt, fdt_totalsize(sub_fdt));
+					     blob, *blob_size);
 		if (err) {
-			pr_warn("failed to add fdt %s to debugfs: %pe\n", name,
-				ERR_PTR(err));
+			pr_warn("failed to add blob %s to debugfs: %pe\n",
+				name, ERR_PTR(err));
 			continue;
 		}
 	}

-- 
2.52.0


