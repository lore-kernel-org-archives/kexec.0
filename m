Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208CFC433FE
	for <kexec@archiver.kernel.org>; Mon, 21 Nov 2022 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kFPzPW5jfnuIlRWLVfhEbn2GXxV3Dqwk3+DRw++52/4=; b=pnaXd+qMHERW82
	5k0ilWAH/BcgQjkCASIPqbtFp22olsxtCmhv90gvV9f5sED19jlIKO8R62IHMXE43yytIMTwBpSn2
	bZHXqgHUs+8BxgxPW5GeDOQglHf3L/XB7+CsMdPZlnOZWI+xeD0T3ofBwxMT+kY9Xwh44CTalVIH2
	08Mo/RLxoygeXI9u62tCMj/JYi06gxbUMxxOUuYwZ+3ZlMB1xT6Hd/bnQAWr0Wv6bhnKEmF0NpVAd
	oBrujENdRqmGcD5OPPy0/09aLl212A413sOvbbEZephWbTtjxpgUt3QEXsMfARKTTgtRBVjhN/WfV
	EZf7DvkL0/tJFRBkVI7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Jj-00APkx-C5; Mon, 21 Nov 2022 07:34:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox1Fk-00ANNU-07
	for kexec@lists.infradead.org; Mon, 21 Nov 2022 07:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669015803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PzrpIQOcRog587drqyOgalYCERQdLn/ggTvNzPloyBI=;
	b=EPkjRyXWT5vkFhJ/ZsTMPPTuUQ2QklPSIK3fcoJpFsF65XlEPREGYVARJl9HxE64ejkFCu
	c+PqjWsBBC6kEBK9ToeJoOMQ7LKLHwtlOCkkm6tPK5seuX694EekQ8PDJdTpsfucrCo4sn
	M3U5u7cz6Y6yJD8iDY9e1iX7tc43W/o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-197-8aUfFjx7Np6zpKAt1vn8fA-1; Mon, 21 Nov 2022 02:29:57 -0500
X-MC-Unique: 8aUfFjx7Np6zpKAt1vn8fA-1
Received: by mail-pl1-f197.google.com with SMTP id t3-20020a170902e84300b00186ab03043dso8913850plg.20
        for <kexec@lists.infradead.org>; Sun, 20 Nov 2022 23:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzrpIQOcRog587drqyOgalYCERQdLn/ggTvNzPloyBI=;
        b=pVCTD03GNDaZZtaVxCZ1rqcfdRnQLsPAar/1U9GiO6SZkp2Y12qMP8HDOTbKgkl/kn
         Akxl5gt2KBusuIK6zQgVqwlviW+xJwo5+6ltjhB6rwkdR568FZDFZWfF0NNFTuAGb0F4
         wenf7PTfOysZg7QECkQbIjC4OeKCOOc1xA8WXfb88fLcA1YPT30eKQRhls0Scl+yM5hG
         H+MhRchd61FP18suI6HPy3BFtNwjSW2y7aG4tVsqJzJhN6iw0+KCPjRAl+d/zU1kHKwF
         nuo6MCZlBw3shWsySNqX1/NEGVp5O5VbAIylUwEdEG4+m9LOf/sYgtTwyhsFYf0wa5eJ
         4xvA==
X-Gm-Message-State: ANoB5pmCOvoMtY1nYt7rHSrF/fWXqcrK82jPp2EChZCU3E+26/iIVhtB
	WNlVgflVXwr1bYBAgqGk6x4eSofU7qFWST7Za3C0rAMUw4Fjwo6Q99C5rrdCbRLupQEtsOh0MZz
	k22xXntjFveZ0s+76MFolsahbIx02MaFNiAe1yj9xXSmN9g2jtxzRB5xPVpfTmGu4BSI=
X-Received: by 2002:a17:902:bcc7:b0:188:f42e:6a90 with SMTP id o7-20020a170902bcc700b00188f42e6a90mr926396pls.127.1669015795944;
        Sun, 20 Nov 2022 23:29:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7EcYX61iVqKcEdoBRAEQ94b78zalp2WbshZ4Dz+5rKx3bpryPWxZ9XpTzupJLi96mob2prPA==
X-Received: by 2002:a17:902:bcc7:b0:188:f42e:6a90 with SMTP id o7-20020a170902bcc700b00188f42e6a90mr926361pls.127.1669015795583;
        Sun, 20 Nov 2022 23:29:55 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm8886857plq.34.2022.11.20.23.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:29:54 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
	Jiri Bohac <jbohac@suse.cz>,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	James Morris <jmorris@namei.org>,
	Matthew Garrett <mjg59@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date: Mon, 21 Nov 2022 15:29:47 +0800
Message-Id: <20221121072947.836672-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_233004_156301_4BF3151D 
X-CRM114-Status: GOOD (  15.41  )
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

A kernel builder may not enable KEXEC_SIG and some architectures like
ppc64 simply don't have KEXEC_SIG. In these cases, unless both
IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
unsigned kernel image from being kexec'ed via the kexec_file_load
syscall whereas it could prevent one via the kexec_load syscall. Mandate
signature verification for those cases.

Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/kexec_file.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..04d56b6e6459 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -125,6 +125,20 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+static int mandate_signatute_verification(void)
+{
+	/*
+	 * If IMA is guaranteed to appraise a signature on the kexec
+	 * image, permit it even if the kernel is otherwise locked
+	 * down.
+	 */
+	if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
+	    security_locked_down(LOCKDOWN_KEXEC))
+		return -EPERM;
+
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
@@ -168,14 +182,9 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
-		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
-			return -EPERM;
+		ret = mandate_signatute_verification();
+		if (ret)
+			return ret;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
 	}
@@ -211,10 +220,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 #ifdef CONFIG_KEXEC_SIG
 	ret = kimage_validate_signature(image);
-
+#else
+	ret = mandate_signatute_verification();
+#endif
 	if (ret)
 		goto out;
-#endif
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
