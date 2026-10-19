Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57748CCA490
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1qJK14zquZVZQXJj1ZTJgob9CLSSkOEckqrXS5MxL0I=; b=xtcWBT9BDkMXuM/B9lTZjYesJC
	dOds8BSoLwtOhGRO1DvJGhusckRxc9Bmy+eiLUVAIXQF0RJ8TCE0526H2MdIXmczzHSwP/Qex/SXg
	MXYjUgHYsuUID/HQtje/CCQpEZiHN9Wk53cmr5uU8KTfhTIBsCoYhKAr/ElGaCo/jQmBJF4N394RY
	7xENQT+b25PfYZ9959Tr73FQRT70Tow4N+xKLTUdf6tPGOgL/DjUjD/b8GMp9ivlK+f6ijAWRNaXz
	qW5jT45OWmf3/J/ZlPCS74LMKtPOEyKs9D4i46oCY4ohsAfEJm8pq9ud+Zp5ySZMuORnliuhkhcBV
	tZwfF/1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqR-00000006RPo-22O9;
	Mon, 19 Oct 2026 02:11:23 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqN-00000006ROq-1Kql
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:11:20 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5eac4855401so234181e0c.1
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792375878; x=1792980678; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1qJK14zquZVZQXJj1ZTJgob9CLSSkOEckqrXS5MxL0I=;
        b=AufvpEDmQ5lXmGm3nsP94dJKNnn0k5g0qqoCby9148U7du5vgzb1vxjFe8opbjHOgg
         uebtt2wvosDaNiECrqvIEkPSjSwYHXFKo/gdyH35ldm4cqeTVS27ctXplgLU7zxnQjq2
         t5uM08Yb1LczKqEowAovOOCDt3ORrR+gAAj+LYGDLkC8UC2mk2m9VFp1jW7c2+DpCvUc
         wvjq7FG+pJ7X752OgPRZRwpt7GM5zH3QxFPyIFgwJ9gpanIszZjcD4ckSWV11Xe5lRuJ
         Q+nJgQin2n2HSBSBQujYgvNtG2ZCselgvBA9j54kONUr0GeGJVi95s2PDDb/mx8U9nCe
         aEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375878; x=1792980678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1qJK14zquZVZQXJj1ZTJgob9CLSSkOEckqrXS5MxL0I=;
        b=Q+By9DPzbOnlMsr64ZunlXH7VgbLqCW0Mv/PiJ8OxmWjkfhAtVsiVwEYlG9vftCOKM
         djpN/r8WheIEga/OmBPyks+KY3X/A+LzcaRQaqglQYJEoJVS4RkwLo8BXZuWXBcbx2QQ
         5ir10CibobLkrb7bt1vdYHMnkKK+X8JFdNGiCz7syq2nZOr1lfwtTI6yCth4ATF9SfGa
         bKCKYbL0Ouk0CMZzQ4ymlI+eTJ3bmgJ+W7zRtWIGdAp/QKzHKJRglyJYtVS3J9qbkRAP
         1+nF6x8sKn64uE5cxKmT4vIZtkyvpIy58md+nvf1k7NqQBX1Eq4aNKpIb/ljPYx10dIp
         NfMA==
X-Forwarded-Encrypted: i=1; AKwUvBw0vL5Jx/NfaflPiZeI9OyNHOttEhkm7LQ4QMywfXYK2UgMN1injL1Glt9vaH0gasfPAWThow==@lists.infradead.org
X-Gm-Message-State: AFq9FYJiD/hIXWWduYa4rfpOUgjVOlNEc8iyLIfEVP8ktRnOx/ga1iyw
	ApgCNWg6CXVFtFRUG8b8zfV9Uy9KYJO9OviPCa7EOHod+ddGzdvT3TgZBuZXMpZ2sx8=
X-Gm-Gg: AYBFou2q0fyufB5qOoT3Qvm3YgNyjczEYsineGV/XACzrZQqX9iZ+5kDlnL897mqqBt
	3OxY5+V6KX5e6B2V/y5OG8KyLGDrcPMDf2EW1OncRO3TGQevT1DGTy23KCATHIXSfPdGewAipyh
	2/FzN4XFjOUix5JxjI5De5rE0o6JnP6zyxT0//CRW6lDja1dHDRyd9y3pX2a2NzqLZgxSv5esq2
	EBO9Ye9nvl75z9ghMEhJiOvESWIjxbpXre+ys6NvRn+oBecctNV1RWzY2wXH1HKeHUHiHTbWEii
	BWP5ls1K5H7I8273EuKk2NupwQ7lEktmbQmqV4hh2MBREVssm2hmf9wgs7rEwRGP7W7Dtt4b6gn
	EbfvKEHGLwzOkILqmsgxhZNZfvGapXf2GtLWiT+iv+h/+Qsik4GTg6nAsy2otbKJbpD2WFyY/D5
	HC68nP3nHzOs+udocAo++8dcKyElUkcauOcI87gpFH8ruJ+4ssRu2uLXi7qKpp3aer1VD1HWep5
	tr99WKCaVSKZ2EPqZh7K++I42MyiVvKq/rp4YB8cbgS0jkanH5YgDmYpWsa4uTAsfwGnbktch6l
	n+1ERxB9791IMIVormmrDpce/c5jFw==
X-Received: by 2002:a05:6122:4b1a:b0:5c9:c60e:3a44 with SMTP id 71dfb90a1353d-5eaaa8b81a1mr2041402e0c.22.1792375877949;
        Sun, 18 Oct 2026 19:11:17 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm4271383e0c.2.2026.10.18.19.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:11:17 -0700 (PDT)
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
Subject: [PATCH v1 1/8] kho: expose physical address of outgoing FDT
Date: Sun, 18 Oct 2026 22:11:04 -0400
Message-ID: <20261019021111.990394-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261019021111.990394-1-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_191119_372040_21FEF106 
X-CRM114-Status: GOOD (  15.79  )
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
2.56.0.176.g3575e65682-goog


