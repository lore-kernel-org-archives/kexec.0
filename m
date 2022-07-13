Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B629CCA479
	for <kexec@archiver.kernel.org>; Wed, 13 Jul 2022 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aIL+QGeZYXUo8Yymwlk74aTh9rMW2kQhxwT3qzv4mSE=; b=BFvE+dDdx55S3K
	zY7IyXzH+4j9xqjskK1cVBG69TYsIruU1574oafsRPMJhK2tTf+VfjIvBg0V1pWHX+t5zeXh6+6gY
	vu3zc79uLprDfr4oKv/QQ3t6/RgXvEZxOrzsVIRnegVuhuh8KURVqAJAiev4SiPKzVgBSpt8Ydw0W
	1lP8gkCJEMJ2yAwF8obLEFtnIkwnkfnsfjFqUKK+hl4n/Em0m6NXDJVvjaGzUPSGEz+SWoGLdQrll
	iVScBZsb9eilzg3OL+Hot4PLHBipICvwipYuqlMcKGALx9DFYr0iBk34envTAb3pkBrqFaLlDERtT
	GkOOR2kV2S3/UWC1Xn/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWgW-001Azp-GE; Wed, 13 Jul 2022 07:21:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWgQ-001Avi-T0
	for kexec@lists.infradead.org; Wed, 13 Jul 2022 07:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657696877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bzHcA1yQj57CCPYm74jUoouv+RLrdBI+n61plkR9Go=;
	b=fWTpltsm1iqS3wzQgbrtwSjjKer/CGQAlaUY3KMO+qbD+MDq/VL7hm0X9Y+3S1uJQzgHpu
	CQ5SYQWzW2v7Xb9zz9PDQMyb5DfSIgcNKZPg4YQgc/oLPtMhKMCM8BZ2e8l+VSMM3dnH68
	mkciMmi1EcWjiSpj/JPMxPJwE91ffO4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-mQt50gVjNc-4B1KNSc1IQw-1; Wed, 13 Jul 2022 03:21:16 -0400
X-MC-Unique: mQt50gVjNc-4B1KNSc1IQw-1
Received: by mail-pj1-f71.google.com with SMTP id v19-20020a17090abb9300b001ef7bbd5a28so1047494pjr.0
        for <kexec@lists.infradead.org>; Wed, 13 Jul 2022 00:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bzHcA1yQj57CCPYm74jUoouv+RLrdBI+n61plkR9Go=;
        b=C67UC+5eULaUCjio1ssar72kNeZgaC0/DkHJQxmQ/25ml0v1ewILnhOf5xLwaj5mvB
         rnz+dPI63drcu//ePHdPciTkbaqcOQiiaWWaoXvNmwLU6y5EyFQAFoTvrVdC9OkvASqz
         1TYP5gZG4YdoUZCxfiBod3on96GRQGMRoEyhbpfsgsjr7DQD/4isis2T1AfE59pQwWfi
         E5/Hs7ulM+oRy+h+WivLlSV1aiC/5YW7P/M/TdGB9f4heLDtTNIXsKnixIFGHe4jhOBq
         uYTruDF1S6g+IKh5TGsU8Ap/OD4RB+9MWB3XwjgkrLmKdqmPYmgSSF9AYjqBjifQu2rJ
         Weqg==
X-Gm-Message-State: AJIora9JD+kSNdAfzhBixL0PPbzqmxqtG0eli4of9Awz6mCqOxFZhuRr
	IRMbs6DVrhi78OU2faD+WyX3fAgPtaSaTK0sD6TO9+DOqRSltQUKxM2ytoi3Y7GEBnbJ+u6q+KQ
	5Pc6n4uc4bUYmW12l9LAp
X-Received: by 2002:a17:902:e153:b0:16b:dccf:5a89 with SMTP id d19-20020a170902e15300b0016bdccf5a89mr2137305pla.69.1657696874946;
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBQYf48YTRO3J0cXEwN13e016x/uaZqgH8q/LrUIWqrRZZ1fxgfGwjni6KBVsTw3wzYIRdGg==
X-Received: by 2002:a17:902:e153:b0:16b:dccf:5a89 with SMTP id d19-20020a170902e15300b0016bdccf5a89mr2137291pla.69.1657696874696;
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
Received: from localhost ([240e:3a1:31b:3d30:c711:d753:abde:647d])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b0016c5b2a16ffsm2912305plb.142.2022.07.13.00.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jiri Bohac <jbohac@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Matthew Garrett <mjg59@google.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2] ima: force signature verification when CONFIG_KEXEC_SIG is configured
Date: Wed, 13 Jul 2022 15:21:11 +0800
Message-Id: <20220713072111.230333-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712093302.49490-1-coxu@redhat.com>
References: <20220712093302.49490-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_002119_032907_3E356127 
X-CRM114-Status: GOOD (  14.87  )
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
v2
 - don't include linux/kexec.h since it's already been included in
   linux/ima.h
 - fix build errors when KEXEC_FILE/KEXEC_CORE is disable as caught by
   kernel test robot <lkp@intel.com>

---
 include/linux/kexec.h            |  6 ++++++
 kernel/kexec_file.c              | 11 ++++++++++-
 security/integrity/ima/ima_efi.c |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..475683cd67f1 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -452,6 +452,12 @@ static inline int kexec_crash_loaded(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_KEXEC_SIG
+void set_kexec_sig_enforced(void);
+#else
+static inline void set_kexec_sig_enforced(void) {}
+#endif
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
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
index 71786d01946f..9db66fe310d4 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -67,6 +67,8 @@ const char * const *arch_get_ima_policy(void)
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
