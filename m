Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888FFC43334
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fOg2VosRuu8L1woabWpqS/q7Uh6+X8cHobrqioONHX8=; b=BZs0Pr8lhQWz8L
	V1AgNiikFQ63zuyBi4xKuNliJ/jvk5BsUiir4CqCGjO9hr1TXCpVdpTphJvgHsTjZoW9ahrSe+ema
	V+CQDNEnGeiDmJcMFjdp/ic4HsD+dy/5j4ICzArdePWSwm0bCpK6uyiGRnUL3gPhkpX6AUmOdIPHn
	2sSovO+IWJY7L7k7C4Pn/syc5V8R46cKa+8zPeh/a0Ang7/GgBAzH1XPGiH3bI8z3HCuWugaz5H9t
	/il+I1fqhD5j+aSTBQfxbETEvY9RhDgDIrCizKFcy6iAk3C5/Oenr9UP8lXXkvtFt7Hqz9HRgyBvL
	+PSS3druaGu7UvLaNGLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBCGd-009Hs9-3E; Tue, 12 Jul 2022 09:33:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBCGb-009Hp6-3P
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 09:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657618393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C8hxIj8W6IqTe1eGgWCKuGOk0xM/C1HXIo4o+0ApBic=;
	b=dC0RClX7wAuzAiFEw83MfnFLC70R85TTk3nGYk9D1kUZ1Of3ushHTaAQWQ/sI/5IXjf/g3
	gR4oRRuAucDTyVw1qEuaVyV3o5YJyeVU2E6p41KsCWIIJUahS+9Fcv1mZktjP8TF9BQjVr
	n9S7xEETXwf6jevQVVR5qpOHmoV89Z8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-A9PrkWNwPTeWov-euKfr1w-1; Tue, 12 Jul 2022 05:33:12 -0400
X-MC-Unique: A9PrkWNwPTeWov-euKfr1w-1
Received: by mail-pj1-f70.google.com with SMTP id 1-20020a17090a190100b001f05565f004so696990pjg.0
        for <kexec@lists.infradead.org>; Tue, 12 Jul 2022 02:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8hxIj8W6IqTe1eGgWCKuGOk0xM/C1HXIo4o+0ApBic=;
        b=18cncJ9qY7sR/JoMNBQBpEvF/eHsgpy1SfzQY/yL7cZE4WUkMZx41dkyQ9EMw3bx5y
         M2F090cGDl5qKJzCDY60QbMB9Jy88BUTFgbUtWqpqTT7SIHgmRd+ks0gpNaChSpS6/Xc
         9pSZVP8cVHASdZSYMvvhMv+TMJm6evBSqDuSUdP2CZmCgc6Ikx3uhnDKS+xMEz8aB8zU
         ZznYWbEvOVlg0HZJLEtAhDT4deFS6uqGijPeukvA+7d7ukgZpUoZ5+ztOc8Y6A4dAiiz
         cYlChn5fYhTw37QfCEuJGdkUmkPv2nVOtZ6lu6Qv+UqI+AWUWXcgD5SS/2RKAg54j2nA
         AY/w==
X-Gm-Message-State: AJIora+16cNDi/jkMrPNbFofVqG1ZVEQYaMLLE9IC0tQ2YG7sV3Z62Tt
	LZqkwl+iF35FCT/qvla0Z9M0TctHnX6G3b95lZY9250n0A3ZAP2LPhGDMXOc1AXZLeCxdjVPUb+
	q+2CHyJeuON0W21lN+gNP
X-Received: by 2002:a17:90b:3143:b0:1f0:3971:37ae with SMTP id ip3-20020a17090b314300b001f0397137aemr3053913pjb.223.1657618390971;
        Tue, 12 Jul 2022 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOFdkJayybBuHE8OnzykQjiCZL0lFlbFjIsgPcu72kuqlDypFwfzh30+3NjLaon1pSkzF5jw==
X-Received: by 2002:a17:90b:3143:b0:1f0:3971:37ae with SMTP id ip3-20020a17090b314300b001f0397137aemr3053889pjb.223.1657618390754;
        Tue, 12 Jul 2022 02:33:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b0015e8d4eb26esm6247747pli.184.2022.07.12.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:33:09 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Howells <dhowells@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Matthew Garrett <mjg59@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] ima: force signature verification when CONFIG_KEXEC_SIG is configured
Date: Tue, 12 Jul 2022 17:33:01 +0800
Message-Id: <20220712093302.49490-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_023317_254148_A03210A6 
X-CRM114-Status: GOOD (  13.78  )
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

Currently, an unsigned kernel could be kexec'ed when IMA arch specific
policy is configured unless lockdown is enabled. Enforce kernel
signature verification check in the kexec_file_load syscall when IMA
arch specific policy is configured.

Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h            |  3 +++
 kernel/kexec_file.c              | 11 ++++++++++-
 security/integrity/ima/ima_efi.c |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..4b8e8d5bcea9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -134,6 +134,9 @@ typedef int (kexec_cleanup_t)(void *loader_data);
 #ifdef CONFIG_KEXEC_SIG
 typedef int (kexec_verify_sig_t)(const char *kernel_buf,
 				 unsigned long kernel_len);
+void set_kexec_sig_enforced(void);
+#else
+static inline void set_kexec_sig_enforced(void) {}
 #endif
 
 struct kexec_file_ops {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..f9261c07b048 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,6 +29,15 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#ifdef CONFIG_KEXEC_SIG
+static bool sig_enforce = IS_ENABLED(CONFIG_KEXEC_SIG_FORCE);
+
+void set_kexec_sig_enforced(void)
+{
+	sig_enforce = true;
+}
+#endif
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /*
@@ -159,7 +168,7 @@ kimage_validate_signature(struct kimage *image)
 					   image->kernel_buf_len);
 	if (ret) {
 
-		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
+		if (sig_enforce) {
 			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
 			return ret;
 		}
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 71786d01946f..ae3fe4cb8d86 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2018 IBM Corporation
  */
 #include <linux/efi.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/ima.h>
 #include <asm/efi.h>
@@ -67,6 +68,8 @@ const char * const *arch_get_ima_policy(void)
 	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
 			set_module_sig_enforced();
+		if (IS_ENABLED(CONFIG_KEXEC_SIG))
+			set_kexec_sig_enforced();
 		return sb_arch_rules;
 	}
 	return NULL;
-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
