Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1D0C43217
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ATgV8888TyTRFTJljrYRsEGBx6EgLI5cIUm66GarmJY=; b=D+or0N4BtcSPwe
	fwXQjjTsApKvvJkvrzpJOc2APNf9vT/IpJPeb3wBO/oh6giKhdgLM6NQQpb7oMnX3hPwVfNXss2WA
	6pxRhE+d5PtrKhkS7FNxX49O6gXbtbWF+Lm98J5+W+HvpQIb5t0HTcp1U5676MFwYhea9HZI0uyR7
	nhh+ex5GxlQUW403d1V1LjvuGyYdclnXMQ0RVAwomCCI6kGojEspkUQ0E34rDYhcfBBEL7APrVwi7
	HFKCFGqfz2vqPKrjRvVHXnDhAvOTYm6Hpf418IS590jqjm8DHjvp/67muwqeLV85zshM6J4MFXAXz
	vZkOKNh1NdHoJ/21BZwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxJ22-002SKj-KX; Tue, 22 Nov 2022 02:29:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxJ1z-002SIi-MR
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 02:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669084142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEmhWIzG88GfbOvn0VVAGamAN6Tv4nOnLrUclwx8MGE=;
	b=ASfLAThrJGEgSjV3Qyp3+u9TNAGK5Z9JVT7Pz2Rsf0I1t4vVzk0GLjri1H3/wGcZUjKjTl
	NY3IZr71GQqxGVe1DFZydAD6dgn3MNMYx3Kv/9H20IRymh1JDyaJf+xEk+MlzhedLH7TMJ
	Rdb6XBPWHqBt5Tgz+GR2NkwzNnVMrJ4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-_25qrA3WPayla9ji4TCIiQ-1; Mon, 21 Nov 2022 21:29:00 -0500
X-MC-Unique: _25qrA3WPayla9ji4TCIiQ-1
Received: by mail-pj1-f70.google.com with SMTP id n9-20020a17090a2bc900b0021010dca313so6820102pje.7
        for <kexec@lists.infradead.org>; Mon, 21 Nov 2022 18:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEmhWIzG88GfbOvn0VVAGamAN6Tv4nOnLrUclwx8MGE=;
        b=c06+/UKIlis13VZuy/oOfwVTg6Y5CvZKQDpV4NWHjwEq0BvF5iYHmeeBrc8ri+DvdS
         OydUh+Yp1EkqB079PMTfV7pQqKCsviI42FR0JsoOa0ZbrBBMa/6h6//XqvBrEDQ0LfWi
         vbpJxXK+Uh9jExuXdULCCfUU/RzjqSzPRpWaXAE242+z6tUhx79xYqP3c0X77pXuLhgE
         07HGxZF3l7epl1i4HJ6gSdb2TQg7v1Lxtk42Pk2pvvgDtJJ0dULSlVEc55sJEHpJ91Pg
         /heLsmI7up4IT694+sNk7fnoqdFR1EtqaxKVIgV4NdY1XkqtoYCcT/Am0vkhDatsHaa3
         4UUg==
X-Gm-Message-State: ANoB5pkYlZVC9FcltRSaMquzXUXs3tn5nHZ7Vm9G6gyRVa2MJUVS7vdN
	nfYUQYbkbuJbMyp/B5RqU8LmRVPvlMdUTjM6x2hUB45fxk1nGwDAD2HY4/9i5R4moeV81sjB3nG
	dV3rUCGe8wr/fEjg/4yInNjfFcHB95EyB5z7O41FZzZdoCehmjNEsM1qDx6MMSEtXGbs=
X-Received: by 2002:a17:90a:5918:b0:213:ff:1cda with SMTP id k24-20020a17090a591800b0021300ff1cdamr22749682pji.86.1669084139397;
        Mon, 21 Nov 2022 18:28:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf64JiXXabiXu4vcDpmIq38bPW0Ra2Qsb9SUEESTKt8MF2CRsg61tFBxLECGkJJFsOUhhUh8Dw==
X-Received: by 2002:a17:90a:5918:b0:213:ff:1cda with SMTP id k24-20020a17090a591800b0021300ff1cdamr22749644pji.86.1669084138958;
        Mon, 21 Nov 2022 18:28:58 -0800 (PST)
Received: from localhost ([240e:3a1:2e3:6280:f5b8:e7c9:62bf:459])
        by smtp.gmail.com with ESMTPSA id a27-20020aa794bb000000b0056e8eb09d57sm9393859pfl.63.2022.11.21.18.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:28:58 -0800 (PST)
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
Subject: [PATCH v2] lockdown: kexec_file: prevent unsigned kernel image when KEXEC_SIG not enabled
Date: Tue, 22 Nov 2022 10:28:55 +0800
Message-Id: <20221122022855.888910-1-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121072947.836672-1-coxu@redhat.com>
References: <20221121072947.836672-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_182903_837858_B88260DE 
X-CRM114-Status: GOOD (  16.06  )
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
v2
 - collect reviewed-by tag from Mimi
 - s/mandate_signatute_verification/mandate_signature_verification [Mimi]
 - return the status of kexec_image_verify_sig correctly when signature
   verification is not mandated
---
 kernel/kexec_file.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..dcde7a50fbeb 100644
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
