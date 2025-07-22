Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD80C83F1A
	for <kexec@archiver.kernel.org>; Tue, 22 Jul 2025 02:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BNCqutEYCGxkPLPPDptf/fqRtu8WQpYy2xLrXDrGIyA=; b=i7oZaPPmFA452tTEHbYSYeJi92
	S38Eq+wQZIVZNnoktX4+l8iAiE+kyHQZ/j0EdkKPJhyYlg9n/mMYPRNsKvezYqGKPgA+v8lQbQ5sg
	KEOKOVYOjJJICMCMsHh1beI5lFBfYqwDH39a8VB7uhqORixb4QiT7juq1+FFO4HZq86FqfnTK8y2N
	8TMda5gqTo/6jvQGwmjh7F2n7IHGhocDgaBHqcUWI4fyJNeolwv6Ubwhs2PwayPOBI6pw8PWrys4c
	XHBiQLo9DJH6TKYZTpRnFTUN9wcVv2sxYXq2OSJw3mRORJ5FkVW58DXQAinOWNF1Hyce4r9Xb4VkL
	LgXT+jww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue2Mj-000000014Os-0nE8;
	Tue, 22 Jul 2025 02:04:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue2Mg-000000014Nb-0AVT
	for kexec@lists.infradead.org;
	Tue, 22 Jul 2025 02:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753149861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNCqutEYCGxkPLPPDptf/fqRtu8WQpYy2xLrXDrGIyA=;
	b=A80U6ifq+M+ijiVWygwM7hvvPaxQz6mnickz0yj2DZWXwKonAHoXNdfozCcx+5hVzM4egK
	+9WrHrVXpuOHQR3bfdgjtubrZWnRBlfrMNKDWD0YDB3wNHKyCEbc16KKV/Gm0eNO/eOdAn
	V3lgPJGmfInEaVGE8edgKFLNJw83Lgo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-YEplb8HYO_2Qo6bhdbxZqQ-1; Mon,
 21 Jul 2025 22:04:17 -0400
X-MC-Unique: YEplb8HYO_2Qo6bhdbxZqQ-1
X-Mimecast-MFC-AGG-ID: YEplb8HYO_2Qo6bhdbxZqQ_1753149855
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A0981956088;
	Tue, 22 Jul 2025 02:04:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.104])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C28BF180045B;
	Tue, 22 Jul 2025 02:04:03 +0000 (UTC)
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
Subject: [PATCHv4 02/12] lib/decompress: Keep decompressor when CONFIG_KEXEC_PE_IMAGE
Date: Tue, 22 Jul 2025 10:03:09 +0800
Message-ID: <20250722020319.5837-3-piliu@redhat.com>
In-Reply-To: <20250722020319.5837-1-piliu@redhat.com>
References: <20250722020319.5837-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_190422_150696_BD921B91 
X-CRM114-Status: GOOD (  12.38  )
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


