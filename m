Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45888EEB56B
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2xTwhnbqy8EHOb2edxIGKXM+kvgDoewmB+CEFC9RBFg=; b=Orrn95qiDtmdcC
	LuW1fdXL/KfdO3UFnUdGMw2YMe3YPxPcmcCDh/pY/B4GR5gwRFlNQE3IJ8hTMS1C3yGsdtExv/uwH
	505m2sg9z4/Rx2v7HouAC9nNE85n9tb0tMN1NbHgLwEaBX5pScJHUUbZpBzMthXqu0k1Zvtz3Q3/J
	9iHvNjkxYxGPGNnuAws6P8B8T1ou7FcC4+U7QKL9EgTMGtWro5ULUqrqX9TeweBDVR42/kXEtW/54
	RUE9qtcIGCQXHhUasm5jnf5Dc3Wv7YXirqtmPeNd+w7mmeuUZ9cuFG40ZvyHT+PCvQRFMBS3UuHB7
	KOTLvQODS0jU1Ay9NGdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qehgx-00EQR0-23;
	Fri, 08 Sep 2023 20:02:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qehgv-00EQPY-03
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 20:02:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694203376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4V6bm459ozDimu1heDZpH+ZMi6MrCIxlIoO52rIEKGg=;
	b=czx7leJI+d6u2ujanNzx8zfCQQrmOZBN8mqWkTe0m/lqDsmtqqA8y2FKYfPB2DNcE/+6us
	lcI1bB13IHXK+G1yBsNN45cSsWgNgQBfCc4ut0w4zNsl/Wk5CUd6+SXQeg7Ujrodyczfr9
	9U1t5ijHjqwy+yCZkQ69+j7shrV8oRk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-FmvI0BpNMquGvNNrkPHIlw-1; Fri, 08 Sep 2023 16:02:52 -0400
X-MC-Unique: FmvI0BpNMquGvNNrkPHIlw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4059b5c3dd0so3340411cf.0
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203372; x=1694808172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V6bm459ozDimu1heDZpH+ZMi6MrCIxlIoO52rIEKGg=;
        b=PGdAddSNREB4AVywYGOycOtNp3HN+2dFf0dOnPkHAavVcoMj9268E7VbPQLuX047kL
         fBDzDvuS+1f0xPQPrpd5KrLs6oeSVWJRXHFInNt5qfKSO+pRCKWO5LWCDcPuI63pTqFZ
         PuTuBoKyseVikkvEaQ6thwEsfjpwFNx3nPyS70g02TnziaNQ5rfytPNOIztOBI9snBCm
         F6ahwbfWQ+P3AWeiOLmSnNi4a7mR/tq5ES+whWVfeQtN4N/A0P6XCRJQUaxj10Dke6hU
         OnpO5KKfK/OntvsRSts6V58u6zswMY4I6UX4ft/G/rj9Xg+KDOfENSyM/l5W23qhJbxj
         eNMQ==
X-Gm-Message-State: AOJu0Yy2D+poPrlB3eb/aAz5ER91g8YINMIJs4ujLuPJUMUB6r3rRrNJ
	IM+kdY8mhE8DIUZ+0RGi+WG2OKM36yvC0kfdnzzoFCubtVl865x9Ca22sgaRXLiyCCYBrAy8CiJ
	Y6skAsRU5KxBAKP9o+l5y
X-Received: by 2002:a05:622a:1997:b0:40f:da40:88a with SMTP id u23-20020a05622a199700b0040fda40088amr3927383qtc.4.1694203372361;
        Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUR/6fW5sKr+U41wFGsfMKmuUv8vxb4fBBYTs7l3DnJhhPgBBiRmpLahG272yCMwIEUruJgg==
X-Received: by 2002:a05:622a:1997:b0:40f:da40:88a with SMTP id u23-20020a05622a199700b0040fda40088amr3927365qtc.4.1694203372058;
        Fri, 08 Sep 2023 13:02:52 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id x19-20020ac85393000000b0041511b21a7csm262984qtp.40.2023.09.08.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:02:51 -0700 (PDT)
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
	David Airlie <airlied@redhat.com>
Subject: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Date: Fri,  8 Sep 2023 21:59:40 +0200
Message-ID: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_130257_122237_706F17E9 
X-CRM114-Status: GOOD (  13.83  )
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
---
 include/linux/string.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..8c9fc76c7154 100644
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
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
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
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
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
