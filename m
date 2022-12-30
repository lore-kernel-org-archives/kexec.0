Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F674C4332F
	for <kexec@archiver.kernel.org>; Fri, 30 Dec 2022 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TQASP6iJZwQLxovQJ+82uO2a9iokLdHKI5jttnYsxCI=; b=dPxOH8gIil3hWz
	reaCbNNfPicM2bERCvUnvcA1xgQovRMWJx4JJf/OQ6lawso5qYgVdUbERc0fIxTV0xa4vjYoDmPRW
	LXLXJmGfPXwjw7KK2CLFHQ7NxDm+tut+odpzmzQz2x4xmb4eW3A1nN5t3vSvKWb/yhI3RtSuO+Jno
	yCJjhG6yE/NKgR73C2AgCeTIHWtjXOUPxPZ9HlQatG6tl2o8qrJQVLvz2J53sFid9sPCRCEwsZbkm
	nnEUhodopAixF9FF6nJ0ba90htEoXPxAMCV8CvuT3sHSIBzWEYWcpkVaro0V8qeS3CHQX1+q1CrLR
	5mY7MM0XPQCuModQaxMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pB9MB-006f6a-Ht; Fri, 30 Dec 2022 06:59:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pB9M8-006f24-IF
	for kexec@lists.infradead.org; Fri, 30 Dec 2022 06:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1672383537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i6xNXZW5xcHpX8ctqGmuNcrSYwUwnLYg5NtdNPmfezg=;
	b=KgpyYeC673B2IJ9oz87xH/b061UzUiMU0jUl8PE/RN5yfqSw/b4KBmWc27sZLT0GPNpviB
	Ry9c+/KlGLc6IP/6qG+4ZXIAblZr+SrrBKnEs6KtLCZKIEcgxQeBNTqDg2ojLr0H0vfifO
	MLzqbUgKtkesJBmpBEq0sVDaAyvTn4g=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-35-1KBUOG0UMKKUJc1Ni568tQ-1; Fri, 30 Dec 2022 01:58:56 -0500
X-MC-Unique: 1KBUOG0UMKKUJc1Ni568tQ-1
Received: by mail-pl1-f199.google.com with SMTP id d2-20020a170902cec200b001899479b1d8so15290446plg.22
        for <kexec@lists.infradead.org>; Thu, 29 Dec 2022 22:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6xNXZW5xcHpX8ctqGmuNcrSYwUwnLYg5NtdNPmfezg=;
        b=qVuQHbivsJaIWkNhq1L6g1KjPTR151sjUTS2KY2VgcerWm7gwNYzIut+fWnI1/AVCl
         HJjZZM1turrcFIhnF6uhUF1jj6Bp60EgIaY1TUIVlCY3mKXEkBnek+2DubhYvPq0v33z
         RBrdp4kw3c4C8jgw+0DE69PPTB89gGjk+Gnnkwm91r1FzqlPoZXjXqrrw3G0b5bC1swV
         CIP8NSX4dBeFRWsbFxn8EdjA5HT6jxrI0qBlc9On8CTbYIo1NjDDvdA5EdPZqgMtJHko
         f2OOlUZ8AmlsN7a1qYoGT46gtGzVOC7jgGmFaKUYp/WMwApFExi7AWwwRrEr3r1Ewb5y
         qzGA==
X-Gm-Message-State: AFqh2kp5qPGJma4/5X6ncz+/nmP2tW9Vs6Zy0iYJmiDB/7NimgU9ch3d
	qYyY0FD9f9ZGXg9kRMwhUQvZlU2G2R3xuNIuqE1IF7EB+05xGIktF6lChhIvyqZBJMRcXXRrmUU
	Hvq5tUIFJsxJI3l5R9FB00bR9v/2tADKUA7A02fTbCrX1nKtQPLgmrBwoSUqEG3oynz8=
X-Received: by 2002:a05:6a20:1586:b0:9d:efc0:67 with SMTP id h6-20020a056a20158600b0009defc00067mr47397768pzj.15.1672383535028;
        Thu, 29 Dec 2022 22:58:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuS31o499EJ+P0QkGmvXR/8sEY71NzOuPxCXXw9OvVKvODqQywZozPkjeIXEo35ZNQmiVJihw==
X-Received: by 2002:a05:6a20:1586:b0:9d:efc0:67 with SMTP id h6-20020a056a20158600b0009defc00067mr47397736pzj.15.1672383534644;
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
Received: from localhost ([240e:478:10:2273:12cf:a540:d79b:db49])
        by smtp.gmail.com with ESMTPSA id s5-20020aa78bc5000000b00581e0b5ad8dsm1614157pfd.107.2022.12.29.22.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 22:58:54 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Jiri Bohac <jbohac@suse.cz>,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Matthew Garrett <mjg59@google.com>,
	James Morris <jmorris@namei.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date: Fri, 30 Dec 2022 14:58:49 +0800
Message-Id: <20221230065850.897967-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_225904_871726_800DD40A 
X-CRM114-Status: GOOD (  16.10  )
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
v3
 - add lockdown tests to explain why kexec_file_load failed [Mimi]

v2
 - collect reviewed-by tag from Mimi
 - s/mandate_signatute_verification/mandate_signature_verification [Mimi]
 - return the status of kexec_image_verify_sig correctly when signature
   verification is not mandated
---

 kernel/kexec_file.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd5983010b7b..2c1054ab21ef 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -125,6 +125,17 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+static bool mandate_signature_verification(void)
+{
+	/*
+	 * If IMA is guaranteed to appraise a signature on the kexec
+	 * image, permit it even if the kernel is otherwise locked
+	 * down.
+	 */
+	return !ima_appraise_signature(READING_KEXEC_IMAGE) &&
+	       security_locked_down(LOCKDOWN_KEXEC);
+}
+
 #ifdef CONFIG_KEXEC_SIG
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
@@ -168,13 +179,7 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
-		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
+		if (mandate_signature_verification())
 			return -EPERM;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
@@ -211,10 +216,13 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 
 #ifdef CONFIG_KEXEC_SIG
 	ret = kimage_validate_signature(image);
-
+#else
+	if (mandate_signature_verification())
+		ret = -EPERM;
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
