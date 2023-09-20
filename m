Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1689ECE79CF
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 12:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dOc/v7Ca16QCBkZhS7l88Y5gp5yjWhrF+RuDgomprq0=; b=fAHnvu1cf/oP1+
	3Rk3aX0JTLCcCqnTQSpNNMKjZ7n9kAR3K0n97inoAsHuaRXd1Y/5LVvbyLh2kJxzTMvPlQB8nmuvO
	PAp7kYSmmPH3jTzxhKO5ZvUYaPehsL0+bHdsn9y1YH+/I2+3FeV9WaQbdqzputYdztbod9b17XsFi
	TY4ZOu993DcPo05Ju0Y6l9hZfncbYfap2EjPMC33Tqn4d9VjYgpkMm0//k7C1tXKBeDErsBBDBNtM
	LqtzsORThJAG5wP+9L2f6/0cAyfs39stWVvo4PLZuWqUp5gIxM2DRmPD4Sajs6ptM3+GQp4J6M6N3
	d4FBeFfpG7KbaisF0D/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwRm-0032uB-2P;
	Wed, 20 Sep 2023 12:36:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiwRj-0032t0-2G
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 12:36:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJRnSvDMQADh3Wr31msjxxHMdDRAXuX2nElLtMGFtqc=;
	b=A8rZcPDIyF6ygJJItp+WVhTO/ZMB2pxZ/yxs+xKz8B9wJ5RVBE9m355u8NnbeaP1Z0PGmD
	wAK7qYZr3lTFtvENGtCUTGUlhIbWrgRCOYd90nOBTShPRynfp2C+eG8urYWR7uczSdYw9f
	6SYlwkv+2jIDWSrZ4+nLL8j9aJHFmOQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-5bAQJwbuPpekXlxwEvYF5Q-1; Wed, 20 Sep 2023 08:36:43 -0400
X-MC-Unique: 5bAQJwbuPpekXlxwEvYF5Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae3a2a03f7so23614666b.1
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 05:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213402; x=1695818202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJRnSvDMQADh3Wr31msjxxHMdDRAXuX2nElLtMGFtqc=;
        b=fVayHIM6gYxHq2DkZXb2/ysUFO8dNlNZdoAwF+VqfjXXCD/32w8y9RI76+pkWuMVX8
         9jSfkjmnQq1j73kh4PBVIP9dYIAwL5pSWk607XG2GaM2aFP6u941F95FNeSir2YlKRrE
         qzTXASQcyKWJAxNEYd2hRhsj3u0RyS05XXKv2uWXgwvqBeIuVet/PS6PmM7pwQ+yris6
         TLvgtQjt0E2/eOkZDfTGG1f2SdSmea5W/1sU6lf9YjKlBkgeVDxKx/aGg6WRoO5/RqDn
         SqaZ/5OcExSIlFOaTAitdYF+fp+DafwviHdUr+cNZLaCVKpTvXbB6cBJ5DwqNABAzg+D
         cixw==
X-Gm-Message-State: AOJu0YwgbnAKwaLCtIdEiS0zEYkmlCYxVCFaMNtpjTQmTB+/v5ut0Yk2
	RT6lGJ7/yHe/DfxomdYH1uvOB5Ebe3UxaX+RgLDEpBhP9Ko1Dv/b34/lk+YH3mTb84bXeIC5ind
	9ABkoyE2YSoGZf8N2EvKE
X-Received: by 2002:a17:906:196:b0:9a5:9f3c:961f with SMTP id 22-20020a170906019600b009a59f3c961fmr1815594ejb.3.1695213401728;
        Wed, 20 Sep 2023 05:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERwQ2SjAJQSsC9ZRe6AiF2nzMLomaRThlvgCuHfKcv/TAIMXpcfLWGpl0wj1aEZwFhaqVjcw==
X-Received: by 2002:a17:906:196:b0:9a5:9f3c:961f with SMTP id 22-20020a170906019600b009a59f3c961fmr1815563ejb.3.1695213401348;
        Wed, 20 Sep 2023 05:36:41 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906191200b0098e42bef736sm9348305eje.176.2023.09.20.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:37 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Siddh Raman Pant <code@siddh.me>,
	Nick Alcock <nick.alcock@oracle.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Zack Rusin <zackr@vmware.com>
Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/5] string.h: add array-wrappers for (v)memdup_user()
Date: Wed, 20 Sep 2023 14:36:09 +0200
Message-ID: <20230920123612.16914-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_053647_853845_51869587 
X-CRM114-Status: GOOD (  14.18  )
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

Currently, user array duplications are sometimes done without an
overflow check. Sometimes the checks are done manually; sometimes the
array size is calculated with array_size() and sometimes by calculating
n * size directly in code.

Introduce wrappers for arrays for memdup_user() and vmemdup_user() to
provide a standardized and safe way for duplicating user arrays.

This is both for new code as well as replacing usage of (v)memdup_user()
in existing code that uses, e.g., n * size to calculate array sizes.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..debf4ef1098f 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -5,7 +5,9 @@
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,44 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure. Result may be not
+ * physically contiguous. Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (check_mul_overflow(n, size, &nbytes))
+		return ERR_PTR(-EOVERFLOW);
+
+	return vmemdup_user(src, nbytes);
+}
+
 /*
  * Include machine specific inline routines
  */
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
