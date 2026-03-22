Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE95109448C
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 01:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PRFUJjfw8UMJDn1AP+nn88xxm2eq7v+YRmLLVNEOIyw=; b=147edNa8/6lXJdR3TpLyi5K3zc
	aUiq/FV5AmkdjaV6uHb3EJLapLHv4aqzVLO87LWth9WpjcGRraEuV904BLIfInfSq1/CHgMmYJRBR
	K0KD0yJkdz35EsyBdbsRpDqpnRiS7dz4iYtFbkKkWbzD0dvNTtnIUbr0d2dOGABQKlDDBwYw/1pqs
	5adx2A8zRSyAEXK8VGDIHXvHGsUR4rZTqmZ2CTljjYcnalT1eBIGT6EkApxxgJWWvCN9H7fkSabI7
	hOGvHEoh2tS6E9rKYThlAMpN+nO1jFPkXnnR7k0CWBozdVKrIeccwrVH+siak9fL140EK2ErInadc
	FclG4imA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47se-0000000EwpM-11QX;
	Sun, 22 Mar 2026 01:45:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47sc-0000000Ewob-1xDf
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 01:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRFUJjfw8UMJDn1AP+nn88xxm2eq7v+YRmLLVNEOIyw=;
	b=QV/t1T0uToNfoLb/oSuMfw513IUjqCjCPkH/U0iho9xxmx0EF50XkQklNmyci655ZdOQYj
	0B+g9jP4JrmsQ/ZhTE4Xbn1nmoA1obxF6PUOeivAtqatGQEto+63zo3htG1g7TclntXTTI
	D+EzuvQTdXY719pTs2iMi/AvoqC5Acw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-ffZhTjeJPqmBcyCxX4zRnQ-1; Sat,
 21 Mar 2026 21:45:19 -0400
X-MC-Unique: ffZhTjeJPqmBcyCxX4zRnQ-1
X-Mimecast-MFC-AGG-ID: ffZhTjeJPqmBcyCxX4zRnQ_1774143917
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA91E19560B4;
	Sun, 22 Mar 2026 01:45:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 287AF300019F;
	Sun, 22 Mar 2026 01:45:02 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv7 03/13] lib/decompress: Keep decompressor when CONFIG_KEEP_DECOMPRESSOR
Date: Sun, 22 Mar 2026 09:43:52 +0800
Message-ID: <20260322014402.8815-4-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 25kgnluKSLKEN0iYVxxcGeJaQnm4ZdAInAmn_YWfqsk_1774143917
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_184526_574945_F7C4E758 
X-CRM114-Status: GOOD (  14.49  )
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
 include/linux/decompress/mm.h | 8 ++++++++
 lib/Kconfig                   | 6 ++++++
 lib/decompress.c              | 6 +++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index ac862422df158..39df02bcbc661 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -81,6 +81,7 @@ MALLOC_VISIBLE void free(void *where)
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <generated/autoconf.h>
 
 /* Use defines rather than static inline in order to avoid spurious
  * warnings when not needed (indeed large_malloc / large_free are not
@@ -92,7 +93,14 @@ MALLOC_VISIBLE void free(void *where)
 #define large_malloc(a) vmalloc(a)
 #define large_free(a) vfree(a)
 
+#ifdef CONFIG_KEEP_DECOMPRESSOR
+#define INIT
+#define INITCONST
+#else
 #define INIT __init
+#define INITCONST __initconst
+#endif
+
 #define STATIC
 
 #include <linux/init.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb96106476..e91347da12906 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -165,6 +165,12 @@ config RANDOM32_SELFTEST
 #
 # compression support is select'ed if needed
 #
+config KEEP_DECOMPRESSOR
+	bool "keeps the decompress routines after kernel initialization"
+	default n
+	help
+	  This option keeps the decompress routines after kernel initialization
+
 config 842_COMPRESS
 	select CRC32
 	tristate
diff --git a/lib/decompress.c b/lib/decompress.c
index 7785471586c62..29d4c749f1fc4 100644
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
 	{ .magic = {0x1f, 0x8b}, .name = "gzip", .decompressor = gunzip },
 	{ .magic = {0x1f, 0x9e}, .name = "gzip", .decompressor = gunzip },
 	{ .magic = {0x42, 0x5a}, .name = "bzip2", .decompressor = bunzip2 },
@@ -60,7 +60,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ /* sentinel */ }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn INIT decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
-- 
2.49.0


