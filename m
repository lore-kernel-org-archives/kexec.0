Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2362FCDB471
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 22:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1NOYzLzQAQS0m9MRiDTCQXpcLo3JF92UmgVDsUD8aNE=; b=rK+YkZhSLKvmuYb7WVbXv+JuHi
	vFyE80VjY6uoVNnXxOJbWKEuOpA905QfGyGlrMR47J7pAbMFCdhd22cuT18VFCeEszI3cqRqX/HsQ
	h0hXuy8z1Jwv9009BGmG5q8P33pOiCBaUN+M0uuvzLGt2RKtixMUDgKjFNjcv4166lSZloprsIIL6
	Gw9i2ty0nazB4om6MdCIIJFTHMCZtwjr0nkd5vtYmSpmp0NKmffsvDKHxRNcYCq3FG9n6cCsLrmj3
	cuoySQtj7NmhoXKP9Yp6yL+cGfT4MpuxS22ACkJKyc8Y/gkGBgqOnSmAdxgNuujI2E+Qe5dbhFuqV
	OiECTsSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnaM-00000005S91-06Ba;
	Mon, 22 Jun 2026 22:57:46 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnaI-00000005S7m-0N6y
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 22:57:43 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-69557a7f1a5so5021334a12.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169060; x=1782773860; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NOYzLzQAQS0m9MRiDTCQXpcLo3JF92UmgVDsUD8aNE=;
        b=vBz0bnyLgXVjgN04ZZHHjvlUZ7Nbn8GH/DAu21MKWU/Bgys76cKpuGoihBVymjIcOc
         /0bjWeQBWmBV++5LN4nJE5fr6JUXJQdeMtmuzHNjYy6dvOQnTlyejmliy/H13dE5ZwgF
         QOIHw3g2w5nVYB3UwebWoRbvbfprXLWwL9AdREXoQBRot7fPs4JNOgAOqrGUuASk4vTh
         heeTGd+Hfyoy6We2gAUqC3SU+Q3PdKHYAZ5pi/jX7pJcEqrK3VqN3nsJvcRoxwNzGqP/
         vbORKJNacgb6/kB10YANcQ+RExemNghAlNm5RFimwdTUMcqEjzGU7NK1HSN587rcoFKp
         7Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169060; x=1782773860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NOYzLzQAQS0m9MRiDTCQXpcLo3JF92UmgVDsUD8aNE=;
        b=hXI9jArwz6YlnRvdPyTvlYCVMQfPpJLB/tJhSFBfcgqHFDJL6nBjtVZ+ZX6QCrGPQm
         6ABjbNoy46NmRx/Hkfs9Zu1bKVxu+bUFU2zJxWeHHcfZGnor1IsA1keNuC+DsKHtUT44
         6GQnOH3tCDR7iSpmqXz+hvTmGa/+bauRiSViS2+AjLC4xp0t8Hq759/hIfqac+WcUvRV
         2eUerjYSaj3q2hb76FhhRe92f+0jHjxxd4rijJrtq9IzmLbB9Htua+SQ1BZ5kWdwQd5W
         ErM0plsMwskXLXs+6Up1HWq8o1CNsCLpmFLWCdymxQOHHguClIw+w1zeZe/DE542UaYW
         zaIA==
X-Forwarded-Encrypted: i=1; AFNElJ9OgYTMlBmIwGVT4MIkxPxrr5Qrhf4tHgPOPn+NNKWkzuQA38HNtI1a3Fu0bzmfux2AHQjXCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyHi78nmPJ7ZI6u7S9F1vxtxhFJjzfwZ5BrEam+b+4iY8fCK+SH
	bjtQw3Evmc53WsAusVpSBvSBXNh9w473EsQbdai7+E71CwRu41bk9oghs1x+IoC/z4j6jAJvMKM
	ZdWUHauELCqICSYBfAg==
X-Received: from ejbla19.prod.google.com ([2002:a17:906:ad93:b0:beb:5fe:489])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c97:b0:c0d:2ab6:8055 with SMTP id a640c23a62f3a-c0d2ac5cc8emr526314366b.53.1782169059511;
 Mon, 22 Jun 2026 15:57:39 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:57:35 +0000
In-Reply-To: <20260622225736.2961438-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622225736.2961438-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622225736.2961438-2-tarunsahu@google.com>
Subject: [PATCH v4 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_155742_131030_728B8848 
X-CRM114-Status: GOOD (  10.06  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Adding KHOSER_COPY_TYPESAFE and KHOSER_COPY_TYPEUNSAFE to copy one
serializeable pointer to another. It basically allows copy of phys val
of the serializeable pointer.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/kexec_handover.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 5e2eb8519bda..c1b61d875dcc 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -139,6 +139,17 @@
 		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
 	})
 
+/* Copies one serializable pointer to another. */
+#define KHOSER_COPY_PTR(dest, src) \
+	({ \
+		static_assert( \
+			__builtin_types_compatible_p(typeof((dest).ptr), typeof((src).ptr)) || \
+			__builtin_types_compatible_p(typeof((dest).ptr), void *) || \
+			__builtin_types_compatible_p(typeof((src).ptr), void *), \
+			"pointer type mismatch in KHOSER_COPY_PTR" \
+		); \
+		(dest).phys = (src).phys; \
+	})
 /*
  * This header is embedded at the beginning of each `kho_vmalloc_chunk`
  * and contains a pointer to the next chunk in the linked list,
-- 
2.55.0.rc0.786.g65d90a0328-goog


