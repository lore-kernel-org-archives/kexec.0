Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77912C83F16
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 13:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+CYoO65o+W1D7FApwGzawyvmf7ckotSmNgM9dabyvdo=; b=Kn6LE3r2lHKm91
	dwO/oqwsO5h4Pn/prBjxfjTld32Vn8YoqeVrxSjZt1RQvftXrCgd1Ym+z0yJ0TGyj7NEmCYB2w496
	oXJqhdYkkhA7LUiPFfLrOkB2IYKH70Js4kGMJS5O8/0UMwmzECHvVpQkfskqq2f4jjYtf1oyYZKDJ
	mPqwqn4Uj7jvCpgWCVvcINbTOYws7xVMXojQKr3rphahTilD4BdHXDXFnN9tkA1KsEUpNpExRGEyd
	c+TeNHWm79rHQNjG1gWRfON9qkcGsJEAf12fdIRG59OnxZnwQmf4e5Vr/24gPedozosmysNI678Je
	m0kOUsBCOpI4QPhxA29A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWl-00Dbp6-1s;
	Wed, 30 Aug 2023 13:46:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLWj-00Dbla-06
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 13:46:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693403189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTYt2BSQEZut8ffX05oFQAoT2Tz1O17bKncsR4XeBIs=;
	b=BfS0DuiV8z5gwUJjXvvmr7wSZZ9lI5xfyijCCeVaHwT+acQmf8bwBfG9bAhOqBmHhNvNUH
	zxe9/WIYiPwxfHU4dRBWVoYjzUwPm7jOyFmmv5Mx1QLmVT+HyMF15wtsIIX22YGO9zGha/
	nx6eNSaUHnAfAWJC/f5HSFP81lmKtI4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-rhhxMoLfMdesQIASADq6wg-1; Wed, 30 Aug 2023 09:46:26 -0400
X-MC-Unique: rhhxMoLfMdesQIASADq6wg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a5b578b1c1so72600766b.1
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 06:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403185; x=1694007985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTYt2BSQEZut8ffX05oFQAoT2Tz1O17bKncsR4XeBIs=;
        b=jDCMsuYjdcgu4owAMIk0edznvbGo+PcAgNUK78nF80qCy7PQhH9kD7MtELfyU9Wp91
         3IbGcpzVloiVIafixWfiljzRVJqhXrs4iG70m7HZBC7ZpBHNQL3nVb7kU61ptmIneKAC
         1V04Bd686jcyWVJiwdonCCGSupHbS6QDLsdPGHOqctUM6+CeECoRwgAPcJRcoHpmYo78
         UZBrgvI4f2ZesshegDexSWkLoqyjMaxHTKdkRZHQszVUPQeETDLSF5OwgxaGMjONP2eQ
         j9KmZqp4CUOPI2nA6LpHZTxwKysFZMJJ/VNsgPNwUDtDFRXzKqXeSNgmnnWFhc4ajb5Y
         R3hQ==
X-Gm-Message-State: AOJu0Yy6r2jgHCoC3QrcE3MKMlr31wKU8htghlHENcgi3eAoElqpuCg1
	QzQvtDpPJOP7jsb7hxGX5bWzDtFSLqFUlmVKsLYaG4dU2J9v1vxLTKMcCG+nOHeQJ0EO8MAZroZ
	b0iMWq7f86yCACuK1F6Yk
X-Received: by 2002:a17:906:74cb:b0:9a1:eb67:c0d3 with SMTP id z11-20020a17090674cb00b009a1eb67c0d3mr1497339ejl.4.1693403185525;
        Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs3XWD3GCd0nxchFLVqW0usUrIz+VOttxkboYOB/XHHWAwTxGY9Rlu6B7+6AhH9DbE4wdw7w==
X-Received: by 2002:a17:906:74cb:b0:9a1:eb67:c0d3 with SMTP id z11-20020a17090674cb00b009a1eb67c0d3mr1497324ejl.4.1693403185198;
        Wed, 30 Aug 2023 06:46:25 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709063e5a00b009829dc0f2a0sm7174419eji.111.2023.08.30.06.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:24 -0700 (PDT)
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
Subject: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
Date: Wed, 30 Aug 2023 15:45:52 +0200
Message-ID: <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_064633_138871_5C4B5E8D 
X-CRM114-Status: GOOD (  13.56  )
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
 include/linux/string.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..0e8e7a40bae7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/errno.h>	/* for E2BIG */
+#include <linux/overflow.h>	/* for check_mul_overflow() */
+#include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -14,6 +16,46 @@ extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+/**
+ * memdup_array_user - duplicate array from user space
+ *
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure.  Result is physically
+ * contiguous, to be freed by kfree().
+ */
+static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(src, nbytes);
+}
+
+/**
+ * vmemdup_array_user - duplicate array from user space
+ *
+ * @src: source address in user space
+ * @n: number of array members to copy
+ * @size: size of one array member
+ *
+ * Return: an ERR_PTR() on failure.  Result may be not
+ * physically contiguous.  Use kvfree() to free.
+ */
+static inline void *vmemdup_array_user(const void __user *src, size_t n, size_t size)
+{
+	size_t nbytes;
+
+	if (unlikely(check_mul_overflow(n, size, &nbytes)))
+		return ERR_PTR(-EINVAL);
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
