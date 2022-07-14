Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31929C433EF
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g7mtREYufVxVfHLwCR/Ab+7r9kehlIC4M2Mmi+5ufSo=; b=kL3DVvHwZyJpsY
	eYIpc2HGUJGz1hs1fYrqspN0eakQK5blQwR706REU7rPDUw+onbivrGJT5lnr3hCoIGWaFztrUZzI
	85GnXC04HOc/yqz3jv+fuxGRyTI8bKf8Jmx87fJTouFTqsinjPxTPhMBZTyMhiTrdTVTQQuKo627m
	36giRl0gt6tvRrnHdwD0HxfD1mVgU9gFNzvY4xCRI1VlZw0cqayQu+sFJdUNDqTopPD+OY9SvjjRl
	nKY4JduXg6sv0eKBRt+32wQvMc+TU21BkZRr+zw7ShWK7Dk8ZLVSwaFkGtwBnYVCFtBLTMufKNrt1
	XWw1BVv5fyM3FcEqia6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz5T-00EoSO-3t; Thu, 14 Jul 2022 13:41:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz5E-00EoHj-QO
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 13:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657806047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiVvGqWued69KlQMltHUGXgLkEsQEsLtjAg7jnmKF7w=;
	b=VKwVJmn7VECzQdUU2pP50y+YSdfg8IM99eJivo+FOSKI9GCdMgt0KgRLkVERS8fSLvuZKs
	W1C6KfZT1FUqayd1X5PT/pLrfJbassLhPVHK9VuuFMqL/s3kmXe9Vi1+VLXXjCra37XmhP
	WrvD3dnyd3xLaOC6nMqhIQDTP3cDvB4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-8P6u6fynNvSpK4YjWqVkXg-1; Thu, 14 Jul 2022 09:40:46 -0400
X-MC-Unique: 8P6u6fynNvSpK4YjWqVkXg-1
Received: by mail-pg1-f197.google.com with SMTP id u64-20020a638543000000b00412b09eae15so1260210pgd.15
        for <kexec@lists.infradead.org>; Thu, 14 Jul 2022 06:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiVvGqWued69KlQMltHUGXgLkEsQEsLtjAg7jnmKF7w=;
        b=G+B4PpWoUWqdYSB+ntdIkeNHNgf3p1WpenG8QbzOQpqkvCNLwGVt7DHRyMg5rhmxRJ
         v6AQAlgEVwbnFFG2tjvjYR2oasuDlYnq11JIeXLYDHkBJrz6RP7v1Py9CKZ6Uh83nqrN
         1npeQG06dOLXBMNCBbHw43QOz36/MzEGrjz5qHhB+jR8LNI+XOTZBnAHSxDKs2dAtWvd
         u6lC8FRvkEgnhubgHgiD8d9ZGoSkip1k30V4zaC+71oR5F31jSCtaAQcMNIGbY8D/wv9
         VRatSJDBbzZqMuO3RIdXB4VO8+2Wo0pmO/pgoPMdVVym1v9q5SvZPLU1+21f2JBeaiHR
         SXJQ==
X-Gm-Message-State: AJIora8Xf7DbMHR+6Ws4OXgWRtpJCebcB4u8qbAameMq5s1GMKdvjSQY
	rLXV8QZxxHLjMAbCOgrPpPOBTEZa6mejh4v+dVTlEBURoI2dc/NxJg4tFKHvEbrb15Ydoue+rZu
	53TVHK0MUzCMF4CBfjyDoBOfThtve2uLoGiaG6VN6TxuaQBw8lLof/Eb43kZX7gD7IN4=
X-Received: by 2002:a17:903:2310:b0:16c:1546:19ba with SMTP id d16-20020a170903231000b0016c154619bamr8463346plh.57.1657806045481;
        Thu, 14 Jul 2022 06:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vR6P1tHGe2AUAKkpHoPoHZ3qPv099U+d+IUX/aj3wmn46jrsJ1Kfs8MRjpFEQ0YAvbKCgu6w==
X-Received: by 2002:a17:903:2310:b0:16c:1546:19ba with SMTP id d16-20020a170903231000b0016c154619bamr8463303plh.57.1657806045096;
        Thu, 14 Jul 2022 06:40:45 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o21-20020a170902779500b0016be24e3668sm1425461pll.291.2022.07.14.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:40:44 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Date: Thu, 14 Jul 2022 21:40:24 +0800
Message-Id: <20220714134027.394370-2-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_064048_963957_C324B470 
X-CRM114-Status: GOOD (  14.15  )
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

Before commit 105e10e2cf1c ("kexec_file: drop weak attribute from
functions"), there was already no arch-specific implementation
of arch_kexec_kernel_verify_sig. With weak attribute dropped by that
commit, arch_kexec_kernel_verify_sig is completely useless. So clean it
up.

Note this patch is dependent by later patches so it should backported to
the stable tree as well.

Cc: stable@vger.kernel.org
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  5 -----
 kernel/kexec_file.c   | 33 +++++++++++++--------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6958c6b471f4..6e7510f39368 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -212,11 +212,6 @@ static inline void *arch_kexec_kernel_image_load(struct kimage *image)
 }
 #endif
 
-#ifdef CONFIG_KEXEC_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-				 unsigned long buf_len);
-#endif
-
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0c27c81351ee..6dc1294c90fc 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -81,24 +81,6 @@ int kexec_image_post_load_cleanup_default(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
 }
 
-#ifdef CONFIG_KEXEC_SIG
-static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
-					  unsigned long buf_len)
-{
-	if (!image->fops || !image->fops->verify_sig) {
-		pr_debug("kernel loader does not support signature verification.\n");
-		return -EKEYREJECTED;
-	}
-
-	return image->fops->verify_sig(buf, buf_len);
-}
-
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf, unsigned long buf_len)
-{
-	return kexec_image_verify_sig_default(image, buf, buf_len);
-}
-#endif
-
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
@@ -141,13 +123,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+static int kexec_image_verify_sig(struct kimage *image, void *buf,
+				  unsigned long buf_len)
+{
+	if (!image->fops || !image->fops->verify_sig) {
+		pr_debug("kernel loader does not support signature verification.\n");
+		return -EKEYREJECTED;
+	}
+
+	return image->fops->verify_sig(buf, buf_len);
+}
+
 static int
 kimage_validate_signature(struct kimage *image)
 {
 	int ret;
 
-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
-					   image->kernel_buf_len);
+	ret = kexec_image_verify_sig(image, image->kernel_buf,
+				     image->kernel_buf_len);
 	if (ret) {
 
 		if (sig_enforce) {
-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
