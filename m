Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7CDC32773
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:Cc:To
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ofnF0yZqt2QGuiJldCNKJ4BcwWSvB7wIzBujsgKvaCA=; b=isJFUiQIHT7dkB
	AovuA1D6dsiYpcnqkwnMu7c055T/532Bp6Q+VB/vVZvnC11IDZDW8VmTJV+I+xSPtpZoQ/Fr9UgC4
	IpX8jcKyuMl6Sl4b7GdnPIMIT43o1+gANV03kGxEAjDxeuGPaBznEmb7FOIJFziJzBROJt3YODlyL
	peE999tnC7Qp0qAhZs/emP+D42m8OZlBpq8e94NAXERi/eU1Bdejssd4Ls4QODZov6/d4fqQRldg0
	SkO91rO3Wu6S//35aOI6jo+CxFB3DcKoUyDtfDJ0j2rtk119V/64AkOUVEkxh0xMxSwxGBPIcPYUH
	mnCtGrnfFRHKFzBOB8PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP3Gr-009cez-LA; Fri, 19 Aug 2022 14:46:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP3Gm-009cah-Fs
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 14:46:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E7E2C6143D;
	Fri, 19 Aug 2022 14:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DBC433D6;
	Fri, 19 Aug 2022 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1660920403;
	bh=u0qHVCc08/zk0XDikZjlWOGH4P0ng2IZu6407g7AZQM=;
	h=Subject:To:Cc:From:Date:From;
	b=ltAC8Di7+mAqK/L00qirMMRgXoQaaVGhRNs91T8zcPpOyuyoDGwNt1KDgMMKOtCaI
	 BOdnS5uLPsjxyFbqsi+b3VC4sdq88RcCBJR8Eml1Gcu/E0X08angI+fHzs00Do8OLC
	 B8p8JEECN5iXRDE+ZcZd6uQvQ9EoLc4BaN3CeV10=
Subject: Patch "arm64: kexec_file: use more system keyrings to verify kernel image signature" has been added to the 5.18-stable tree
To: bhe@redhat.com,coxu@redhat.com,gregkh@linuxfoundation.org,kexec@lists.infradead.org,msuchanek@suse.de,will@kernel.org,zohar@linux.ibm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 19 Aug 2022 16:46:26 +0200
Message-ID: <166092038656165@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_074644_728566_5B17C524 
X-CRM114-Status: GOOD (  17.26  )
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

    arm64: kexec_file: use more system keyrings to verify kernel image signature

to the 5.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     arm64-kexec_file-use-more-system-keyrings-to-verify-kernel-image-signature.patch
and it can be found in the queue-5.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 0d519cadf75184a24313568e7f489a7fc9b1be3b Mon Sep 17 00:00:00 2001
From: Coiby Xu <coxu@redhat.com>
Date: Thu, 14 Jul 2022 21:40:26 +0800
Subject: arm64: kexec_file: use more system keyrings to verify kernel image signature

From: Coiby Xu <coxu@redhat.com>

commit 0d519cadf75184a24313568e7f489a7fc9b1be3b upstream.

Currently, when loading a kernel image via the kexec_file_load() system
call, arm64 can only use the .builtin_trusted_keys keyring to verify
a signature whereas x86 can use three more keyrings i.e.
.secondary_trusted_keys, .machine and .platform keyrings. For example,
one resulting problem is kexec'ing a kernel image  would be rejected
with the error "Lockdown: kexec: kexec of unsigned images is restricted;
see man kernel_lockdown.7".

This patch set enables arm64 to make use of the same keyrings as x86 to
verify the signature kexec'ed kernel image.

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
Cc: stable@vger.kernel.org # 105e10e2cf1c: kexec_file: drop weak attribute from functions
Cc: stable@vger.kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
Cc: stable@vger.kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
Acked-by: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/kexec_image.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -130,18 +129,10 @@ static void *image_load(struct kimage *i
 	return NULL;
 }
 
-#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-static int image_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
-}
-#endif
-
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-	.verify_sig = image_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };


Patches currently in stable-queue which might be from coxu@redhat.com are

queue-5.18/arm64-kexec_file-use-more-system-keyrings-to-verify-kernel-image-signature.patch
queue-5.18/kexec-keys-make-the-code-in-bzimage64_verify_sig-generic.patch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
