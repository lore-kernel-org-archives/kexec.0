Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E76C433EF
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 01:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7BHxR2C9/BocMx4FYnSVpF8uh66MnCG/hCIUT6lxHlY=; b=VsQWZeFQxyMx5e
	x82YBhHQ7x3veDGc5jAOeCofJLFptqUjljELbLnRS8R43zQKwAkx134GDE8Cjk+AfV0RW2v6L51TF
	P6rqviAnC3DLWDzz25Efv1kTCR6R2wpTrDrj3B2b+Oocfv/Bxqfx5RD9fjbluQR88b95djxCUpH/V
	kwDgf2CkRKye9wp2hTXsa0ah4GzbOqMVRiSFrddrX0hMSD65mrztb2t1TfnNKc+QzrSb5z5zio3eu
	NmnPv++3WxuptwRjMKVvm2Zr0VChA6OQZ1zleTjpfpWS7mjw2z+hgHIBVVC/WiBSdvhbGVP2ff60p
	ulejAGGeoDBxrj56mOcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BGZ-0037ax-47; Mon, 04 Jul 2022 01:52:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BGO-0037OA-3h
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 01:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656899555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MT59o1vyNl28UvpV0L18f4IgJU3gRlDgKTViOwYZmyQ=;
	b=OeZRkGIG8x88qgaX5K1IxcqkNN1j0r/xUFOb1QSoNVgq17Ho37MZ2yJ6IHG9GQpfLevHsS
	BN1K5XysCz5HJqZm7/HQl8bOGrNySjnax7pwfanAqpQzSB9vaJ6fPMwIOQdZBWxPX9TwNd
	BCIfFt6LOFaGMlw3fz/RmoNh4G4D3gY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-dFQP1bwbMKOnEYk9wMaVcg-1; Sun, 03 Jul 2022 21:52:34 -0400
X-MC-Unique: dFQP1bwbMKOnEYk9wMaVcg-1
Received: by mail-pl1-f199.google.com with SMTP id z5-20020a170903018500b0016a561649abso4310162plg.12
        for <kexec@lists.infradead.org>; Sun, 03 Jul 2022 18:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MT59o1vyNl28UvpV0L18f4IgJU3gRlDgKTViOwYZmyQ=;
        b=iVkbFTqr4jJjOZm+jhFURgsYi////ztjEDmlUeNwUzCEfTN9ZgLjcmGUGTCDTRX+4c
         +OL1jy6NZokQQfYWp0/7WFQ1KJ++TF4iVyP9pkfth4RCIRZmF+uVWbD9OoDLTIjNcIkS
         nxeLaGhMteMmidqe/SIdVCU51WbDuHg6XCLB266eCtfE2hcbMDLvkgTUk/H7QLMuvTVm
         7OMGDV5zlevSWWjMF2tRMavgymV1ceq4l8PUNsOx/XhIGbg7x0RKiY8HLTn3bZI9nx/J
         x1RBWQ7KOK5ZoancbCwbubcB23imlhKCe8opfxQFMSrCXsLtthETwyyHc948spr5Q2dR
         NBNg==
X-Gm-Message-State: AJIora/PxqKR0oZlzJP88YYDQIqlRopkJRagcmsf0PdYhvvyVvqPMqcw
	kJCpLvXr1bsR6ZvEHlOH4Wka6tUEQjg429pNDBvsa0574XbhCK4bparkcfHCGYQXXdddgBsxPTv
	qK4ZlTWEFzeX+WLczlJ4+7NdtiZL4CSN87UAPGiSvrIkIDBNTMljwAEshyw3u3+xY4Yg=
X-Received: by 2002:a05:6a00:134b:b0:525:b7cc:30b5 with SMTP id k11-20020a056a00134b00b00525b7cc30b5mr34248677pfu.32.1656899552089;
        Sun, 03 Jul 2022 18:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1swtT1/ZGRM402/NNr6/11axGlFQ3W8t6/TrZaLKS4HwWEg/bXgrfKUGlU7DvgjIxWMijELOQ==
X-Received: by 2002:a05:6a00:134b:b0:525:b7cc:30b5 with SMTP id k11-20020a056a00134b00b00525b7cc30b5mr34248637pfu.32.1656899551714;
        Sun, 03 Jul 2022 18:52:31 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b0015edc07dcf3sm19697225plp.21.2022.07.03.18.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:31 -0700 (PDT)
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
Subject: [PATCH v9 1/4] kexec: clean up arch_kexec_kernel_verify_sig
Date: Mon,  4 Jul 2022 09:51:58 +0800
Message-Id: <20220704015201.59744-2-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_185236_308416_EAF4B36A 
X-CRM114-Status: GOOD (  15.82  )
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

Currently there is no arch-specific implementation of
arch_kexec_kernel_verify_sig. Even if we want to add an implementation
for an architecture in the future, we can simply use "(struct
kexec_file_ops*)->verify_sig". So clean it up.

Note this patch is dependent by later patches so it should backported to
the stable tree as well.

Cc: stable@vger.kernel.org
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Reviewed-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  4 ----
 kernel/kexec_file.c   | 34 +++++++++++++---------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..e3125fae1599 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -194,10 +194,6 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 				  unsigned long buf_len);
 void *arch_kexec_kernel_image_load(struct kimage *image);
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
-#ifdef CONFIG_KEXEC_SIG
-int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-				 unsigned long buf_len);
-#endif
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..c7cbadc754a1 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -89,25 +89,6 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
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
-int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
-					unsigned long buf_len)
-{
-	return kexec_image_verify_sig_default(image, buf, buf_len);
-}
-#endif
-
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
@@ -150,13 +131,24 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_KEXEC_SIG
+static int kexec_image_verify_sig(struct kimage *image, void *buf,
+		unsigned long buf_len)
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
 
 		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
