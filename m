Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B01C54FB3
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 04:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNCqutEYCGxkPLPPDptf/fqRtu8WQpYy2xLrXDrGIyA=; b=xydCehpa8ugWvme/F7yj5lNTj7
	CR1lB3+GPwha47luOkTmX+X5lMh9qI04u7soTfXY6WGrY/39q5DBf0H+gMyWu0iCf07xnmF8AyIA4
	PAYbQHcGYL/etW7FEBA7JKBICSFiIm4CbwiSwZQhuLUHzJ/xB0LtJRperM9kE0qHumU5gkItLQj/W
	9dd5Yi+WtQaTD4p2QpQNgkjSs2h6lEhXKF7BDYIln2qqM7K0oEMVeRaMypRyk4jCdllkhTATF8AFl
	++nwQaDojczQ8GE9arR2w5TGF0trLOZeBNzcxZFodARPiNIycU4ecFn+s0ea4dRGwtdbjbsVKIVxi
	LjT70Q3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUjW-0000000EtNl-2AWa;
	Thu, 29 May 2025 04:19:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUjU-0000000EtN9-0fND
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 04:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNCqutEYCGxkPLPPDptf/fqRtu8WQpYy2xLrXDrGIyA=;
	b=ig0CQ4CHs8jWViPd68CtzfaTdB3m9H4HIkgRPW2B1idy82WAyvSoWJwG3+kslvJfXlpO2f
	NbuVQpYeve7W7UGgmUWN3LbniAvNwo/StJ0LLsG67jGOeJ/WYBWr0OlDttLlGDQt+JKhx4
	oFp0vYnldtP4hlzLOA0qfYWvWQ8TpJA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-sGGsIEEPMcaCE9IEmBYFfw-1; Thu,
 29 May 2025 00:19:03 -0400
X-MC-Unique: sGGsIEEPMcaCE9IEmBYFfw-1
X-Mimecast-MFC-AGG-ID: sGGsIEEPMcaCE9IEmBYFfw_1748492341
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8AE71955DAB;
	Thu, 29 May 2025 04:19:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62B1718003FC;
	Thu, 29 May 2025 04:18:48 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCHv3 2/9] lib/decompress: Keep decompressor when CONFIG_KEXEC_PE_IMAGE
Date: Thu, 29 May 2025 12:17:37 +0800
Message-ID: <20250529041744.16458-3-piliu@redhat.com>
In-Reply-To: <20250529041744.16458-1-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_211908_277851_B52FEDC2 
X-CRM114-Status: GOOD (  12.40  )
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

The KEXE PE format parser needs the kernel built-in decompressor to
decompress the kernel image. So moving the decompressor out of __init
sections.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/mm.h | 7 +++++++
 lib/decompress.c              | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index ac862422df158..e8948260e2bbe 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -92,7 +92,14 @@ MALLOC_VISIBLE void free(void *where)
 #define large_malloc(a) vmalloc(a)
 #define large_free(a) vfree(a)
 
+#ifdef CONFIG_KEXEC_PE_IMAGE
+#define INIT
+#define INITCONST
+#else
 #define INIT __init
+#define INITCONST __initconst
+#endif
+
 #define STATIC
 
 #include <linux/init.h>
diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc646..3d5b6304bb0f1 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/decompress/generic.h>
-
+#include <linux/decompress/mm.h>
 #include <linux/decompress/bunzip2.h>
 #include <linux/decompress/unlzma.h>
 #include <linux/decompress/unxz.h>
@@ -48,7 +48,7 @@ struct compress_format {
 	decompress_fn decompressor;
 };
 
-static const struct compress_format compressed_formats[] __initconst = {
+static const struct compress_format compressed_formats[] INITCONST = {
 	{ {0x1f, 0x8b}, "gzip", gunzip },
 	{ {0x1f, 0x9e}, "gzip", gunzip },
 	{ {0x42, 0x5a}, "bzip2", bunzip2 },
@@ -60,7 +60,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0, 0}, NULL, NULL }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn INIT decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
-- 
2.49.0


