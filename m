Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FBCC32771
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:Cc:To
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Y1ud7Jge9ondGFCW34ZTfYOar7xtuGjRg8TaneCzfxA=; b=RYLlESm3YKgX0J
	1jIJQJYhybBEt0FERECGsZd79wToHr1x9p4C8362LwDtNXkaWXjISvs8Njx3UuPA1aXxQHuzYTqBI
	Q2eGU8DVURar5MqnBtq8veVfe5r+Q0Qm9WwE8aGRqxkiNN2mjENJ8GunmhHnSagjSJCjpIkthPAii
	qVE4Ffat9+TYlQVclyUCrFfrkJSAsqSf8Jzij69FnHE21nM9TthuOoFEBCbIlTW9Z3XikrSlrYMZV
	CbA/IcpDBaDSnSex9UZDGg26QcWc4MtKB/8PLJbPgb25P6i5DWrHqkWH3EX8yAPvtSfCdaNDKt1K7
	IyNfLJZB2JwQ5Bvd48DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP3Gp-009ccq-Jh; Fri, 19 Aug 2022 14:46:47 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP3Gl-009cZX-BP
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 14:46:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C6A51B827E9;
	Fri, 19 Aug 2022 14:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169F6C433C1;
	Fri, 19 Aug 2022 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1660920400;
	bh=MoVqbR3uHN1d70nyhamXoSx7bI6cPwGtbJxs1FO+9rU=;
	h=Subject:To:Cc:From:Date:From;
	b=0WOR75MGr7Oj/LvCGtfCM1ga/xGtcDgdJOeF9sTLloH+GgogUSoGbxQDaIQVjyzPh
	 AsjrwP0R9hWppanQCRTipSuTAEUPKD2OXQqByUKkpVpM36aigfcUzAb9MwCYaE8BrV
	 giteUicaskFDH+Ym+kuTkToYrJwMVJA7YGiYXflA=
Subject: Patch "kexec, KEYS: make the code in bzImage64_verify_sig generic" has been added to the 5.15-stable tree
To: coxu@redhat.com,gregkh@linuxfoundation.org,kexec@lists.infradead.org,msuchanek@suse.de,zohar@linux.ibm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Aug 2022 16:46:13 +0200
Message-ID: <166092037311424@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_074644_108115_0F99695C 
X-CRM114-Status: GOOD (  18.55  )
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


This is a note to let you know that I've just added the patch titled

    kexec, KEYS: make the code in bzImage64_verify_sig generic

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kexec-keys-make-the-code-in-bzimage64_verify_sig-generic.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From c903dae8941deb55043ee46ded29e84e97cd84bb Mon Sep 17 00:00:00 2001
From: Coiby Xu <coxu@redhat.com>
Date: Thu, 14 Jul 2022 21:40:25 +0800
Subject: kexec, KEYS: make the code in bzImage64_verify_sig generic

From: Coiby Xu <coxu@redhat.com>

commit c903dae8941deb55043ee46ded29e84e97cd84bb upstream.

commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
signature verify") adds platform keyring support on x86 kexec but not
arm64.

The code in bzImage64_verify_sig uses the keys on the
.builtin_trusted_keys, .machine, if configured and enabled,
.secondary_trusted_keys, also if configured, and .platform keyrings
to verify the signed kernel image as PE file.

Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Coiby Xu <coxu@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kexec-bzimage64.c |   20 +-------------------
 include/linux/kexec.h             |    7 +++++++
 kernel/kexec_file.c               |   17 +++++++++++++++++
 3 files changed, 25 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/efi.h>
-#include <linux/verification.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -528,28 +527,11 @@ static int bzImage64_cleanup(void *loade
 	return 0;
 }
 
-#ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	int ret;
-
-	ret = verify_pefile_signature(kernel, kernel_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_KEXEC_PE_SIGNATURE);
-	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
-		ret = verify_pefile_signature(kernel, kernel_len,
-					      VERIFY_USE_PLATFORM_KEYRING,
-					      VERIFYING_KEXEC_PE_SIGNATURE);
-	}
-	return ret;
-}
-#endif
-
 const struct kexec_file_ops kexec_bzImage64_ops = {
 	.probe = bzImage64_probe,
 	.load = bzImage64_load,
 	.cleanup = bzImage64_cleanup,
 #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
-	.verify_sig = bzImage64_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 
 #include <uapi/linux/kexec.h>
+#include <linux/verification.h>
 
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
@@ -206,6 +207,12 @@ static inline void *arch_kexec_kernel_im
 }
 #endif
 
+#ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
+#endif
+#endif
+
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -123,6 +123,23 @@ void kimage_file_post_load_cleanup(struc
 }
 
 #ifdef CONFIG_KEXEC_SIG
+#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
+int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
+{
+	int ret;
+
+	ret = verify_pefile_signature(kernel, kernel_len,
+				      VERIFY_USE_SECONDARY_KEYRING,
+				      VERIFYING_KEXEC_PE_SIGNATURE);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
+		ret = verify_pefile_signature(kernel, kernel_len,
+					      VERIFY_USE_PLATFORM_KEYRING,
+					      VERIFYING_KEXEC_PE_SIGNATURE);
+	}
+	return ret;
+}
+#endif
+
 static int kexec_image_verify_sig(struct kimage *image, void *buf,
 				  unsigned long buf_len)
 {


Patches currently in stable-queue which might be from coxu@redhat.com are

queue-5.15/arm64-kexec_file-use-more-system-keyrings-to-verify-kernel-image-signature.patch
queue-5.15/kexec-keys-make-the-code-in-bzimage64_verify_sig-generic.patch
queue-5.15/kexec-clean-up-arch_kexec_kernel_verify_sig.patch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
