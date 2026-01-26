Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971F3D19501
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JGr10StQBeBR7KNeSzsI6aZ5StNmX9VCvqO6kZy3tw=; b=ghjuFDpiYLadjGxRzatWE2t8t/
	bNoofpx2fatDVu1174fq5125sqveNYGGAyCeU2ej/aFr3A4MhnwgsSM+dJ8xh4DSQ0bfSo8GsB/DX
	FS0OJpsfx0UFiifMAgcQ3uYi7mS0qFn57noyztdYCTR7lWsL0CcsXLM2SCk5OXGFrPkC8xlLNvaPB
	l/bH54hrlYJDTsGvMV1OWLLTpzM5IaKaJcCRAHzlPpEbTcrFkGcf0+ism6t5/Agm1tFxfLheLHGUQ
	zkZb2g2e2B7zwENB10ZsU+ahW+n1TLw6aCF8y/dSmACFE658oda2qCMpGhqtmoTIVJy2e3T8urDjy
	7GJW70+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP8C-0000000Cpak-3jmL;
	Mon, 26 Jan 2026 16:08:00 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP8A-0000000CpZ4-21gE
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 16:07:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=7JGr10StQBeBR7KNeSzsI6aZ5StNmX9VCvqO6kZy3tw=; b=IFBAArkZBkmrlMtfkO0gCudcxo
	qjG0+7l1OBtx17boj2WQXW0YKmJlSJIXxV1I1qqGPAVo3pfL+gxP49gylrOHHViitAsr59l0aNEZ2
	Lkd3+Wdt+33LmlJN8l1lLwKt2u5cJaxe2wZJg+h0ADCoNCHqilphtqA6VXLi2W1F9BfSL8GWtNh/p
	UF4EgvVdvmfiSS30vEwWZ4gnCftmPych44tPlDPyUW+3TmBV2Jo1bp8QX8MvdaxDZro8Qr74JbznB
	AbkUz0FgQ0hApMYYIbtrL+6rgdOJL0s/jW/RI5XyBcFz56WS5NYTfFfDzsWmTmPyOaic+VKySSM5W
	gw8UEM4g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkP88-00GI7L-J0; Mon, 26 Jan 2026 16:07:56 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 08:07:24 -0800
Subject: [PATCH v5 2/4] kho: rename fdt parameter to blob in
 kho_add/remove_subtree()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kho-v5-2-7cd0f69ab204@debian.org>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
In-Reply-To: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3996; i=leitao@debian.org;
 h=from:subject:message-id; bh=FxhEMlYSxj7IocH/QDYLiRAsQ2AOrEP3RLJsCaReCLk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd5FN9yco88W0GzD0jdb73XAIa/o6fVHCFpXhH
 TUpn882EBuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXeRTQAKCRA1o5Of/Hh3
 bcn/EACKQ20zX7uH+X3Q1wI4dAzNApPR+EwiF3KDnV6lnyAJTk4BFpuLbDSzHXOTZVwVpEEwS4T
 juqOyVNxYcXd1fIm/hLxr1zF/e6J5hdKboBPIt7F+2HtjFvTQ6ntuDE6qVR/z1l1Givlf51ZEaZ
 vmRtOKO4uVsoEHb1eTKupgiVFKxbflitt/bgpkhmzALJy3GLM3nAmNAGN8tGbRfHQCKou6N4e31
 i6eh2s3yQOupy70iiBgMcMaVEu8RBomFWBkHSOCOZp0+3nlY+JfBzLNwBO+TIRSguRE8ZUoh7A3
 j7MFFSjN4rU51mggIBalrOtxG4Z+dPLFCK1usuQPRwxucTl/yvGWWrUmxNbyQq3ht2rStH92+m8
 WErXY1PNCu7uYXBDjxh1nem1umAxhBwnkZRjuM4LcL92GZyBGVBSvlo2z9vQ8fK/p5NldbYFi0L
 4bedgdgMTWJVGXA2cPOx4AtrO48y/DHJi+ZS99Q5lnletvhWgziAbZsJop97xvJt+iXcMnVtT7S
 qNz/CFh+GQv3wLX9A/dr+0fKL0qrn7BFfDfbs9yIteQu0PvFWbNLb+O30HRNcyAKnU+54bK/OPI
 ARrgwpuYPGMfdmhh8IwcrAJDheBQHms5jDKpLJZVVhLdh6GFO2GMeqV2YJ9tEIEbJKAeXXt5BnO
 sxYi0lvNRra3D8g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_080758_527593_F34FE835 
X-CRM114-Status: GOOD (  13.71  )
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

Since kho_add_subtree() now accepts arbitrary data blobs (not just
FDTs), rename the parameter from 'fdt' to 'blob' to better reflect
its purpose. Apply the same rename to kho_remove_subtree() for
consistency.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/kexec_handover.h     |  8 ++++----
 kernel/liveupdate/kexec_handover.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index abb1d324f42d0..0666cf298c7f4 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -32,8 +32,8 @@ void kho_restore_free(void *mem);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
-int kho_add_subtree(const char *name, void *fdt, size_t size);
-void kho_remove_subtree(void *fdt);
+int kho_add_subtree(const char *name, void *blob, size_t size);
+void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
 void kho_memory_init(void);
@@ -97,12 +97,12 @@ static inline void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 	return NULL;
 }
 
-static inline int kho_add_subtree(const char *name, void *fdt, size_t size)
+static inline int kho_add_subtree(const char *name, void *blob, size_t size)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline void kho_remove_subtree(void *fdt) { }
+static inline void kho_remove_subtree(void *blob) { }
 
 static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ad2da9e4e6a04..b1f3222a0052a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -723,13 +723,13 @@ static void __init kho_reserve_scratch(void)
 }
 
 /**
- * kho_add_subtree - record the physical address of a sub FDT in KHO root tree.
+ * kho_add_subtree - record the physical address of a sub blob in KHO root tree.
  * @name: name of the sub tree.
- * @fdt: the sub tree blob.
+ * @blob: the sub tree blob.
  * @size: size of the blob in bytes.
  *
  * Creates a new child node named @name in KHO root FDT and records
- * the physical address of @fdt. The pages of @fdt must also be preserved
+ * the physical address of @blob. The pages of @blob must also be preserved
  * by KHO for the new kernel to retrieve it after kexec.
  *
  * A debugfs blob entry is also created at
@@ -738,9 +738,9 @@ static void __init kho_reserve_scratch(void)
  *
  * Return: 0 on success, error code on failure
  */
-int kho_add_subtree(const char *name, void *fdt, size_t size)
+int kho_add_subtree(const char *name, void *blob, size_t size)
 {
-	phys_addr_t phys = virt_to_phys(fdt);
+	phys_addr_t phys = virt_to_phys(blob);
 	void *root_fdt = kho_out.fdt;
 	int err = -ENOMEM;
 	int off, fdt_err;
@@ -763,7 +763,7 @@ int kho_add_subtree(const char *name, void *fdt, size_t size)
 	if (err < 0)
 		goto out_pack;
 
-	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, size, false));
+	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, blob, size, false));
 
 out_pack:
 	fdt_pack(root_fdt);
@@ -772,9 +772,9 @@ int kho_add_subtree(const char *name, void *fdt, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_add_subtree);
 
-void kho_remove_subtree(void *fdt)
+void kho_remove_subtree(void *blob)
 {
-	phys_addr_t target_phys = virt_to_phys(fdt);
+	phys_addr_t target_phys = virt_to_phys(blob);
 	void *root_fdt = kho_out.fdt;
 	int off;
 	int err;
@@ -796,7 +796,7 @@ void kho_remove_subtree(void *fdt)
 
 		if ((phys_addr_t)*val == target_phys) {
 			fdt_del_node(root_fdt, off);
-			kho_debugfs_fdt_remove(&kho_out.dbg, fdt);
+			kho_debugfs_fdt_remove(&kho_out.dbg, blob);
 			break;
 		}
 	}

-- 
2.47.3


