Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C4BC6FD1E
	for <kexec@archiver.kernel.org>; Tue,  7 Mar 2023 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vopEd4vYwaGYVD0weqMopyhRoWMH/O8Dzpwf7liFzmU=; b=TRKdKcqWPjqc/5
	bwGflMW+p7DdU8nZ5X5dkl2zFVf9ZuTpi7BuNAFIM40ke/l48Q0jt+uf/K3Onra7lV7SiFTbY6DHi
	0mHO3e1nn4yxzBX/aTncHSoHm61fA6wQp4rw5GEjyuylE5s+Fauzvqe1Mjy9+8PXABgVRKSUXiOnN
	4xkfb5Wgw3/Q4aKEG+prnYesZLnLq6ZJSnpR4POCFDPy4hHLy7z6wZ1yy1CIb/stFVgyvKrsrlNLp
	T+rsDaC2BaSb7Ybd4fQx8UDX5mj0wKIWz3nrBC9gb+Yf6d5CcscU9VUskxOWSbQvF/YQ1M7gQupJO
	m//hJoc23xblOpfx3AgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZg39-002kQf-RG; Tue, 07 Mar 2023 22:44:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZg34-002kNi-L3
	for kexec@lists.infradead.org; Tue, 07 Mar 2023 22:44:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2A1BA615B8;
	Tue,  7 Mar 2023 22:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A71CC433D2;
	Tue,  7 Mar 2023 22:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678229085;
	bh=HcbEYAk5/hvYxwMQ1XV4yIwIyUKWjpgb4DPd91dMy6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jsoHgkhIk35zpsQCjEMr3lWiaWSGqUQPSughiqH4A1oDxHRLHX6b/eue0ppdvRdLE
	 8h/FNndbDlr48QOyHaeBgGtwHBCoHGbGhxyPMfCpISNlJhUKiMvp5JHZTIB9vcO+H3
	 BjdinWjuHagF8Jhf8vGKEolrJuLm45jWf1H/ApZXFRd6MjRCKkzOWollyWRNB91d0s
	 R9HtgqT5QZE68tbl/OT7Cl5dcGPVTj2rAKOh7xoF+JrJybpqU7S3d4aWToD4ff7OLz
	 YmIiI2eLb/mx6LmD3n8NgxuSdrjn8cQrbOxr6KucT/QomSDWARcsxNU1/raNbdZSFj
	 bR94GM5IVdbcA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] kexec: Remove unnecessary arch_kexec_kernel_image_load()
Date: Tue,  7 Mar 2023 16:44:16 -0600
Message-Id: <20230307224416.907040-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307224416.907040-1-helgaas@kernel.org>
References: <20230307224416.907040-1-helgaas@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_144446_819761_A5F4E923 
X-CRM114-Status: GOOD (  13.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>

arch_kexec_kernel_image_load() only calls kexec_image_load_default(), and
there are no arch-specific implementations.

Remove the unnecessary arch_kexec_kernel_image_load() and make
kexec_image_load_default() static.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/kexec.h | 6 ------
 kernel/kexec_file.c   | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 4746bc9d39c9..22b5cd24f581 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -190,7 +190,6 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   void *buf, unsigned int size,
 				   bool get_value);
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
-void *kexec_image_load_default(struct kimage *image);
 
 #ifndef arch_kexec_kernel_image_probe
 static inline int
@@ -207,11 +206,6 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 #endif
 
-static inline void *arch_kexec_kernel_image_load(struct kimage *image)
-{
-	return kexec_image_load_default(image);
-}
-
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..f989f5f1933b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -65,7 +65,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
 	return ret;
 }
 
-void *kexec_image_load_default(struct kimage *image)
+static void *kexec_image_load_default(struct kimage *image)
 {
 	if (!image->fops || !image->fops->load)
 		return ERR_PTR(-ENOEXEC);
@@ -249,8 +249,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* IMA needs to pass the measurement list to the next kernel. */
 	ima_add_kexec_buffer(image);
 
-	/* Call arch image load handlers */
-	ldata = arch_kexec_kernel_image_load(image);
+	/* Call image load handler */
+	ldata = kexec_image_load_default(image);
 
 	if (IS_ERR(ldata)) {
 		ret = PTR_ERR(ldata);
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
