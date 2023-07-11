Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F1EB64D9
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OTp4lO88B7mGQO38E/4nJTi4ZytthaOrtyUw16uAtMk=; b=na5eLt1ZBBq3tF
	8LNIF5iAldgCuXgeAk9lzaAchvbbFTu+YwI1jOAN+ySGN+/pOlF/u8BsOR66b7Af99TpCuIe//zZc
	Wg2vlGH6M94XgYmbc2GL8BqY9WqQ1DKIXpFSxG7wRexwh5ol9dM8rY2sR9oGTWtRMLwqwbwmNbfFC
	n8PNKvyMVsFO/yqsIjZjo/wZdkSyr0CRRzWdpYhCdMKO+Slcbf497FZFw20AHroKnOPiVDDITDz4s
	cejDkrAOnyeCC2ptF9S/rX+XDTV1CRwTw6CEbytZ0drYSqOdgu3DZKPZYNc4FGWYUgHmRlDX2L7Ne
	LZnUy/OqkspB1S717a+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ3rS-00DRYg-02;
	Tue, 11 Jul 2023 03:16:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ3rP-00DRXl-0G
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 03:16:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689045376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fXhj7EzANXxG2zR22cPkd+LCDvsMw/4Z29S4c6txddw=;
	b=Wge6ZjGl0LZ/3Kt2Zxko4flsvKd1X9R9alZkdcj6EM1rkYLgNu7j0INdOk0/syF6xctdct
	Nrl8bZhFmu8TjunjjqOjqgNX+DiQ/6F1L7kQjlTxhIZlDO/JEo8R44HZIaJUfYwuXRTTjs
	hbgioRl2IMcC+aky2Gm9gBPvmbAsnDU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-KyiDUVMVMXGdz7g1B7XlWw-1; Mon, 10 Jul 2023 23:16:15 -0400
X-MC-Unique: KyiDUVMVMXGdz7g1B7XlWw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-566659e9556so4201366eaf.2
        for <kexec@lists.infradead.org>; Mon, 10 Jul 2023 20:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689045374; x=1691637374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXhj7EzANXxG2zR22cPkd+LCDvsMw/4Z29S4c6txddw=;
        b=khLRAlQPhCKEK5L4S24/uKqnylg0riDcHedEFbxZD1Q2KQL84afNfqDbFTChX90HUa
         mFW3zsqlGyFYjzbPano+2wgrjh2kucJG8qEJq6lMKTQLVoRHF1DpdLVq7Y7vNxY3shwn
         xqKPG/jV6QLAgzREGx/OdAVioOeKWo0tzHAMQOJ3PLIQD53knN4MMLz8njN3W91xkJvB
         DqWc4EJpSbDiCflEi7JgPTrN9TgYzf7Dy3dFnbc9iSxfnI42OP/3vzujdpSQQ/udVRgi
         kE0kja19bbXvEn4SLef1iAzcLtaHB/dapIMB7ZyjAn2nkLh3Hp449MBe2t34AKVBStL8
         q44w==
X-Gm-Message-State: ABy/qLb98ce7eC+mrZK/v/Bi2s7UUmbz++wCteG12ckFC2uBhvGSd3U5
	hLs7GgzgU2WD+RsJ8yd+Yf5m7SiMYex7l8lRv91WfiTtMbRi3vld1e74ZJTlV0R8vdgpdKa32oW
	e9IyDkGCxTi37UEEiajgb
X-Received: by 2002:a05:6808:190b:b0:3a3:aedd:6b21 with SMTP id bf11-20020a056808190b00b003a3aedd6b21mr18778773oib.39.1689045374372;
        Mon, 10 Jul 2023 20:16:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxYZvl0B8mwmdXFaSoLskIzmhRC10jfKsKeBAMSMVBzej0sbUxtdM0TFtWtEyJ4k8kWK+yIg==
X-Received: by 2002:a05:6808:190b:b0:3a3:aedd:6b21 with SMTP id bf11-20020a056808190b00b003a3aedd6b21mr18778752oib.39.1689045373985;
        Mon, 10 Jul 2023 20:16:13 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s4-20020aa78284000000b0066883d75932sm488806pfm.204.2023.07.10.20.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 20:16:13 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	kexec@lists.infradead.org (open list:KEXEC),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] kexec_file: ima: allow loading a kernel with its IMA signature verified
Date: Tue, 11 Jul 2023 11:16:03 +0800
Message-ID: <20230711031604.717124-1-coxu@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_201619_208106_C0043C8D 
X-CRM114-Status: GOOD (  12.61  )
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

When IMA has verified the signature of the kernel image, kexec'ing this
kernel should be allowed.

Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/kexec_file.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 881ba0d1714c..96fce001fbc0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
 	ret = kexec_image_verify_sig(image, image->kernel_buf,
 				     image->kernel_buf_len);
 	if (ret) {
+		/*
+		 * If the kernel image already has its IMA signature verified, permit it.
+		 */
+		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
+			pr_notice("The kernel image already has its IMA signature verified.\n");
+			return 0;
+		}
 
 		if (sig_enforce) {
 			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
@@ -169,12 +176,9 @@ kimage_validate_signature(struct kimage *image)
 		}
 
 		/*
-		 * If IMA is guaranteed to appraise a signature on the kexec
-		 * image, permit it even if the kernel is otherwise locked
-		 * down.
+		 * When both IMA and KEXEC_SIG fail in lockdown mode, reject it.
 		 */
-		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
-		    security_locked_down(LOCKDOWN_KEXEC))
+		if (security_locked_down(LOCKDOWN_KEXEC))
 			return -EPERM;
 
 		pr_debug("kernel signature verification failed (%d).\n", ret);
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
