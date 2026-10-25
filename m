Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B3606A337
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qaoHe3cW;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=LMUWL90R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nlyb5eFqjPdmH1nFRtnItgVGTITVkyurMpQB27D3UKE=; b=qaoHe3cWfkQ1C0
	Sxdhyv9SUkwibL3VTGwGQUiRpCFnrvf/JDRkhojnwNrSG5V1sM+4yOGXgF54OG7cjlDPZO5/z1fzz
	Rv43QocRVHIb42zorqO/FfpdU/t66hXWpXemNdv4sSsmo3E+ZypTHGmJefdYFA0I5o5IV00VSf7Xh
	QUBVEXRRKTmCS1kWH6qIjBNj3rQ6tf7k/pHqiyM5XVrIddcM7QQq8SKp3r0LFH0k62VJFlr+a0+dW
	GYrEHGVL2Nwr5NDKF5+GFcU+2VsFAVSkLNDLgm4JXqjZRpJInp47oyLUPMUr3yq5SYHSkZ+n8e2Do
	qIogmyk+XDi2nzst/HpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cm-00000001EqF-0lub;
	Sun, 25 Oct 2026 17:40:24 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Ck-00000001EoZ-1RxD
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:23 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so912884e0c.2
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950021; x=1793554821; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nlyb5eFqjPdmH1nFRtnItgVGTITVkyurMpQB27D3UKE=;
        b=LMUWL90R/vKuC3i37HMkjtc2wgXMBkG06GpCsf9nDgDcr1NIXM5mhAFxGqepbE/SW2
         FDg2kPkoyAXn+claeuSdSwS45kzA/Tiyrp+gHL5WpXVERLOiRlUdfLPeOJxrMEvUzP9K
         2FafbJsMdr4d4cMm3kKH78DUZ0L3vVB6V5Oir2OgwaOda72J2SJhWyJ+HEvMvkq52Du+
         XpOLf72A/KTXYi7gga3Q+Iyh3/ZxUun1m5mA7fsGKxuc3SwN+Pzz83OEt5s3j+mYEd97
         /FOsxZRElrytS7jwvOS0CSGrim6ZmC0LO1V5fuXog0EJ8WXxPKgwoqySJuC/aTqWfNrl
         EO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950021; x=1793554821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nlyb5eFqjPdmH1nFRtnItgVGTITVkyurMpQB27D3UKE=;
        b=MiTjNMDdcuqmsHddpkSKuZDp+awAcrbKnvN4I1yp7eI6RCmspM236YLeevbbLXpXX8
         Md1hdd3jfbi2+R6OjjPTeW2N9k0V9QudpySyxYKtKtR/1xpv1Obuh/Et7kdCeeFCTXvB
         vUBhTqmTzJmOVAXsDE7ox5AUnluoh22lztIPBeHIDT5+7kFsnHTHX9+qDPaiCol+/OqE
         G+f87KClvZtpMxSTqReU1LNaHLOGIjrPx3Jl1SGF1Pijbmpt23LyH3BhUkFsd+taPDZ/
         T375xWHfWk+ogyp75VbhHCDIPyGn/ogbQzzfHErkB8kswX/m9CFtF93vPsvjkGqOAFI2
         XvYg==
X-Forwarded-Encrypted: i=1; AKwUvBzlmvj0yC82O8Ayq64sivdJpCfBH0Qgyuoi5/WVt2Hg4sTGJ+7zRMohzonzsfvhMEm+z1rOeA==@lists.infradead.org
X-Gm-Message-State: AFq9FYI4ycz+Wd7nSmOvB2L1AoQz7ZZp2HYe2cW2rZoYWhtYfv4mImx/
	UAEQEiCVIwbBUAbf3HZjChf88C0pbSj7s2qycuI4nQ/515kLOo2CeAHLFpRnbLN/IQA=
X-Gm-Gg: AYBFou00AS0vwsU5P7AJaw+ucQazCFfYmaFCFqJbzwVfwoFmDnTJ3d6Dd5+B5y5vDmu
	whjzIfLg1QnKG8D7htM8gaJ6U0/IGh8ZxP1fMFU0CMxNQgCIwbGgml2HcEi69OHIQ7CuINwPgDc
	DpHhNyTcK0IvYiQ+PkMMQa1CKlUxibENGrNI2N0TsfBPI7RZ1lkmQgQizz5IQnL1WG1zARVpVQO
	7Getzm8bTRUoHQjBUDj01n4xyCFYi7pY2NhZbvFS/6aVg0G8FZFwKpE1bat9pS4iwPR4+z6dw24
	XjwVB6T24RA702qM+lMNmQygzX+Hjcjvd3firJIBicoLARqjzxd5S9kVAKv3iaRzl+ur6ifoa6G
	/0SKAxa3oLlf7I6KVBeMmq8z5KjWYYLdUapUnk3Np9fRB/lQvKQ9DGYtj6ipqcW6O9TxmmS5UOl
	9pbSxAy16I6S/Do2UbEoPGjAYAm6NzbleN7vFhyZE1KIRMlh5ywp6sfRG6WjFVG14TQFW5tphPG
	Vh2YBTiI7vjHdVupYbeGYjEtMxuHbuQpDP19ADEbwWY3m3Re4yKkehl+nBm5Y8ctq/cOT2OlCLL
	Heq7nvSNB4K8BGzi+7zl8x9CCio2B19IEpf0lxciJOgR9JIexTO0I+rSXFvJL6EqE7TVXIRh7o1
	9
X-Received: by 2002:a05:6122:1829:b0:5ea:d649:d1bc with SMTP id 71dfb90a1353d-5ec232b5465mr1591325e0c.18.1792950021033;
        Sun, 25 Oct 2026 10:40:21 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:20 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v2 1/9] kho: expose physical address of outgoing FDT
Date: Sun, 25 Oct 2026 13:40:08 -0400
Message-ID: <20261025174017.3870481-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104022_401712_56F01D37 
X-CRM114-Status: GOOD (  15.54  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the physical address of the outgoing KHO FDT via
/sys/kernel/debug/kho/out/fdt_phys (analogous to bootmem_phys) so
that userspace tooling can locate the root KHO FDT in physical memory.

Also add kho_debugfs_cleanup() and remove the KHO debugfs directory
if kho_init() fails after initializing debugfs, ensuring fdt_phys
does not retain a dangling pointer to a freed FDT.

This is going to be used by the upcoming KHO read-only mode.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/admin-guide/mm/kho.rst        |  3 +++
 kernel/liveupdate/kexec_handover.c          | 10 ++++++----
 kernel/liveupdate/kexec_handover_debugfs.c  | 22 ++++++++++++++++++++-
 kernel/liveupdate/kexec_handover_internal.h |  7 +++++--
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 902d171a780a..2ba884c620c5 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -96,6 +96,9 @@ stabilized.
     current KHO state in this file. Kexec user space tooling can use this
     as input file for the KHO payload image.
 
+``/sys/kernel/debug/kho/out/fdt_phys``
+    Physical address of the outgoing KHO FDT blob.
+
 ``/sys/kernel/debug/kho/out/bootmem_len``
     Lengths of KHO bootmem regions, which are physically contiguous
     memory regions that will always stay available for future kexec
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3181..ce5983abf181 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1851,17 +1851,17 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
-	err = kho_out_debugfs_init(&kho_out.dbg);
+	err = kho_out_debugfs_init(&kho_out.dbg, kho_out.fdt);
 	if (err)
-		goto err_free_fdt;
+		goto err_cleanup_debugfs;
 
 	err = kho_out_fdt_setup();
 	if (err)
-		goto err_free_fdt;
+		goto err_cleanup_debugfs;
 
 	err = kho_kexec_metadata_init(fdt);
 	if (err)
-		goto err_free_fdt;
+		goto err_cleanup_debugfs;
 
 	if (fdt) {
 		kho_in_debugfs_init(&kho_in.dbg, fdt);
@@ -1893,6 +1893,8 @@ static __init int kho_init(void)
 
 	return 0;
 
+err_cleanup_debugfs:
+	kho_debugfs_cleanup();
 err_free_fdt:
 	kho_unpreserve_free(kho_out.fdt);
 err_free_kho_radix_tree:
diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
index 7d74477da0b7..db3830829398 100644
--- a/kernel/liveupdate/kexec_handover_debugfs.c
+++ b/kernel/liveupdate/kexec_handover_debugfs.c
@@ -95,6 +95,15 @@ static int bootmem_len_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(bootmem_len);
 
+static int fdt_phys_show(struct seq_file *m, void *v)
+{
+	void *fdt = m->private;
+
+	seq_printf(m, "0x%llx\n", (unsigned long long)virt_to_phys(fdt));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(fdt_phys);
+
 __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 {
 	struct dentry *dir, *sub_fdt_dir;
@@ -172,7 +181,7 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 	}
 }
 
-__init int kho_out_debugfs_init(struct kho_debugfs *dbg)
+__init int kho_out_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
 {
 	struct dentry *dir, *f, *sub_fdt_dir;
 
@@ -196,6 +205,11 @@ __init int kho_out_debugfs_init(struct kho_debugfs *dbg)
 	if (IS_ERR(f))
 		goto err_rmdir;
 
+	f = debugfs_create_file("fdt_phys", 0400, dir, (void *)fdt,
+				&fdt_phys_fops);
+	if (IS_ERR(f))
+		goto err_rmdir;
+
 	dbg->dir = dir;
 	dbg->sub_fdt_dir = sub_fdt_dir;
 	return 0;
@@ -212,3 +226,9 @@ __init int kho_debugfs_init(void)
 		return -ENOENT;
 	return 0;
 }
+
+__init void kho_debugfs_cleanup(void)
+{
+	debugfs_remove_recursive(debugfs_root);
+	debugfs_root = NULL;
+}
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index e9685e1ef6d7..38181076f603 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -24,16 +24,19 @@ extern unsigned int kho_bootmem_cnt;
 
 #ifdef CONFIG_KEXEC_HANDOVER_DEBUGFS
 int kho_debugfs_init(void);
+void kho_debugfs_cleanup(void);
 void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
-int kho_out_debugfs_init(struct kho_debugfs *dbg);
+int kho_out_debugfs_init(struct kho_debugfs *dbg, const void *fdt);
 int kho_debugfs_blob_add(struct kho_debugfs *dbg, const char *name,
 			 const void *blob, size_t size, bool root);
 void kho_debugfs_blob_remove(struct kho_debugfs *dbg, void *blob);
 #else
 static inline int kho_debugfs_init(void) { return 0; }
+static inline void kho_debugfs_cleanup(void) { }
 static inline void kho_in_debugfs_init(struct kho_debugfs *dbg,
 				       const void *fdt) { }
-static inline int kho_out_debugfs_init(struct kho_debugfs *dbg) { return 0; }
+static inline int kho_out_debugfs_init(struct kho_debugfs *dbg,
+				       const void *fdt) { return 0; }
 static inline int kho_debugfs_blob_add(struct kho_debugfs *dbg,
 				       const char *name, const void *blob,
 				       size_t size, bool root) { return 0; }
-- 
2.56.0.307.g5fe7bd680c-goog


