Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830CEC4332F
	for <kexec@archiver.kernel.org>; Thu, 15 Dec 2022 18:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c83JOKa3BKotduGaLlaYPeRqT7BbaofoClrdI7iBZIY=; b=c2MZuzSFDgeIwH
	ZxISxLdDuegYmc+rRaSy0WtJ34m3NR2T4RCfzOgAPUwZXPOJe7pcOF9iyyyNgY55UltarDDfjw5R8
	fJtgN+SLUywSavdKymsW7sG/NKpQ1y+tRKwXC2TFkLspCUqb3h+hg0i2sVzf2MZVx4+5gREibnIQL
	IiZt8C3RpKmnViutlNlWOPSkQrvcd+bKansgB2sduAqY8LbpTXnoVtDMR9bg2jvigQO9gTeYZsd/6
	lssnwNRpcw7X2uWL1yDi51gNTY4We4VWUFctME38I/V4YJzjjCSnc5ssF+yzMwNFeUOkNHrHmbPqg
	P26twI+7+osCyXe37cxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5ste-00AoWg-Pa; Thu, 15 Dec 2022 18:23:54 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5sta-00AoTt-W2
	for kexec@lists.infradead.org; Thu, 15 Dec 2022 18:23:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AE3B8B81C3B;
	Thu, 15 Dec 2022 18:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0C2C433EF;
	Thu, 15 Dec 2022 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671128628;
	bh=EzpeGu7n5zTSaE1MJ3GyQVMhUoUmeNkelZBjZU+Lqgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4jObftwCzhu9BbVq2qRzfBiVdRpA1YZBwORx0UiCJXPN4LlDTw3G3ccC6W8rrSpx
	 N//3en4df78W/YWsp/VLnlfLBn4VdD3V9IEdxM/C0myOxIYlQ0c0bkSYXrerfwq19z
	 tiyAKB4Hs7zgfe2Tw5nrGWrkVpYSqFkYlziL9SHoWVXJMq1rPwjnJeV8wfXPFMAKn0
	 mNoK4WfcHKWoFPG03j5SjAxu3s6q8KO/c6qgdQgWAWxDRLkWUpRu+ZQ/isN949U7gO
	 FY2x1wxoZEiUlx5ygL5wQxnoLf4+IYH7cvOaMPDZj7qaRVFtj39Fet5BFhRCefAAdo
	 Hz+niQwNZaDkA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] kexec: Remove unnecessary arch_kexec_kernel_image_load()
Date: Thu, 15 Dec 2022 12:23:39 -0600
Message-Id: <20221215182339.129803-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215182339.129803-1-helgaas@kernel.org>
References: <20221215182339.129803-1-helgaas@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_102351_347780_28ADCA37 
X-CRM114-Status: GOOD (  13.70  )
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
kexec_image_load_default() static .

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

kexec: make static

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/kexec.h | 6 ------
 kernel/kexec_file.c   | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c08d5d52223a..8844e7debfa4 100644
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
index dd5983010b7b..39ddf09ab573 100644
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
