Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D61E77171
	for <kexec@archiver.kernel.org>; Fri,  6 Dec 2024 02:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2uIDdd0V/kxoh6bljvFCJEQ59PeBCSmHCu2Zac0+Mg=; b=oZoTJB2Tij6tMl86mXwvHgjgbS
	ubXLQFM/z8ZUbedTlrm+b0M0tEddqFTvgtY0UaA7OwksFYlmimBO1LQ2Asc8XZbUhDH7L8UYBvfkU
	QAzySEHDWMpKej1zLiQXHxDwqYEjm2k3fmxA8LKap1XQG4Le9Fo+uLmKFQFrdSdC5M7dE3vloKub3
	4/EYK1C0GDkABxRhHbsxF9Injyw1Psf+9YpeSFnUW/uZ++PojdaRykjcCXG/2axOZkkZaknjdHAAk
	VBj5ebgaYQaiXDtwLBB2FbN1Vfr1QDVpiGgS9pY389ElygRnF48i2y9ovS7kMJibuvHk8o6Kkyrzm
	UovhRA9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOLE-00000000MJu-18Vx;
	Fri, 06 Dec 2024 02:45:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJOLA-00000000MIm-0u6r
	for kexec@lists.infradead.org;
	Fri, 06 Dec 2024 02:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733453111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2uIDdd0V/kxoh6bljvFCJEQ59PeBCSmHCu2Zac0+Mg=;
	b=bxbsB4wIKP3WdXKfcjqUI8Q42qDd/8E/60aipEN5KPvV6nVIHXL/iZRcZ1a4tDncnEowVx
	eKbWCsmA4xYV3xHFiCL8wzqxOXttz6GsmP1CID6Hcf8QIL2d3cx05yOjuZOwg0HIhTImyD
	BhQlSPMxOzwi0AFPXanAictjYJL5N04=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-i4PI0mUuOGitILd6ibgUtg-1; Thu,
 05 Dec 2024 21:45:08 -0500
X-MC-Unique: i4PI0mUuOGitILd6ibgUtg-1
X-Mimecast-MFC-AGG-ID: i4PI0mUuOGitILd6ibgUtg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F34C1955F28;
	Fri,  6 Dec 2024 02:45:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C70A219560A2;
	Fri,  6 Dec 2024 02:45:04 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 2/2] pe-zboot: Truncate the trailing zero if Image is signed
Date: Fri,  6 Dec 2024 10:44:43 +0800
Message-ID: <20241206024445.10442-3-piliu@redhat.com>
In-Reply-To: <20241206024445.10442-1-piliu@redhat.com>
References: <20241206024445.10442-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: neP4tP3c1-FyVjkKnwIZyL_LJX8bCwJ6bTQHwi9fUSs_1733453107
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_184512_327638_9DD6999B 
X-CRM114-Status: GOOD (  19.37  )
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

*** Issue ***
In the linux kernel drivers/firmware/efi/libstub/Makefile.zboot, the
original Image is padded with zero, using the following instruction:
	truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@

Hence pe-zboot.c decomopresses and gets Image plus trailing zeroes.

These trailing zeroes don't affect loading the original PE file. But
they do raise an issue during the signature verfication. The root cause is
that the kernel function:
	static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
					     struct pefile_context *ctx,
					     struct shash_desc *desc)
treats [pebuf, pebuf+pelen] as valid payload, which includes the
trailing zeroes. But that is not the truth.

*** Solution ***
In pratice, the table of attribute certificates come at the end of a
PE file. This patch utilizes that fact and truncates at the boundary of the
certificate table to get the original Image.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
---
 include/pe.h           | 30 ++++++++++++++++++++++++++++++
 kexec/kexec-pe-zboot.c | 25 ++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/pe.h b/include/pe.h
index 1e1c59b..a1aa91e 100644
--- a/include/pe.h
+++ b/include/pe.h
@@ -88,6 +88,30 @@ struct pe32plus_opt_hdr {
 	uint32_t data_dirs;	/* number of data dir entries */
 };
 
+struct data_dirent {
+	uint32_t virtual_address;	/* relative to load address */
+	uint32_t size;
+};
+
+struct data_directory {
+	struct data_dirent exports;		/* .edata */
+	struct data_dirent imports;		/* .idata */
+	struct data_dirent resources;		/* .rsrc */
+	struct data_dirent exceptions;		/* .pdata */
+	struct data_dirent certs;		/* certs */
+	struct data_dirent base_relocations;	/* .reloc */
+	struct data_dirent debug;		/* .debug */
+	struct data_dirent arch;		/* reservered */
+	struct data_dirent global_ptr;		/* global pointer reg. Size=0 */
+	struct data_dirent tls;			/* .tls */
+	struct data_dirent load_config;		/* load configuration structure */
+	struct data_dirent bound_imports;	/* no idea */
+	struct data_dirent import_addrs;	/* import address table */
+	struct data_dirent delay_imports;	/* delay-load import table */
+	struct data_dirent clr_runtime_hdr;	/* .cor (object only) */
+	struct data_dirent reserved;
+};
+
 struct section_header {
 	char name[8];			/* name or "/12\0" string tbl offset */
 	uint32_t virtual_size;		/* size of loaded section in ram */
@@ -101,6 +125,12 @@ struct section_header {
 	uint32_t flags;
 };
 
+struct win_certificate {
+	uint32_t length;
+	uint16_t revision;
+	uint16_t cert_type;
+};
+
 /*
  * Return -1 if not PE, else offset of the PE header
  */
diff --git a/kexec/kexec-pe-zboot.c b/kexec/kexec-pe-zboot.c
index 3abd17d..5c65062 100644
--- a/kexec/kexec-pe-zboot.c
+++ b/kexec/kexec-pe-zboot.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include "kexec.h"
+#include <pe.h>
 #include <kexec-pe-zboot.h>
 
 #define FILENAME_IMAGE		"/tmp/ImageXXXXXX"
@@ -44,8 +45,11 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
 	int fd = 0;
 	char *fname = NULL;
 	char *kernel_uncompressed_buf = NULL;
-	off_t decompressed_size = 0;
+	char *parse;
+	off_t original_file_sz, decompressed_size = 0;
 	const struct linux_pe_zboot_header *z;
+	struct pe32plus_opt_hdr *opt_hdr;
+	struct data_directory *dir;
 
 	z = (const struct linux_pe_zboot_header *)(crude_buf);
 
@@ -91,12 +95,27 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
 	kernel_uncompressed_buf = slurp_decompress_file(fname,
 							&decompressed_size);
 
+	original_file_sz = decompressed_size;
 	dbgprintf("%s: decompressed size %ld\n", __func__, decompressed_size);
 
+	/* Makefile.zboot pads Image with zero, but the trailing zero is not part of PE file */
+	parse = kernel_uncompressed_buf + get_pehdr_offset(kernel_uncompressed_buf);
+	parse += sizeof(struct pe_hdr);
+	opt_hdr = (struct pe32plus_opt_hdr*)parse;
+	parse += sizeof(struct pe32plus_opt_hdr);
+	dir = (struct data_directory *)parse;
+	if (opt_hdr->data_dirs > ((char *)&dir->certs - (char *)dir)/sizeof(struct data_dirent)) {
+		/* If signed, the Attribute Certificate Table is always at the end of the PE file */
+		if (dir->certs.virtual_address != 0 && dir->certs.size != 0) {
+			original_file_sz = dir->certs.virtual_address + dir->certs.size;
+			ftruncate(fd, 0);
+		}
+	}
+
 	lseek(fd, 0, SEEK_SET);
 
 	if (write(fd,  kernel_uncompressed_buf,
-		  decompressed_size) != decompressed_size) {
+		  original_file_sz) != original_file_sz) {
 		dbgprintf("%s: Can't write the decompressed file %s\n",
 				__func__, fname);
 		ret = -1;
@@ -111,7 +130,7 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
 		goto fail_bad_header;
 	}
 
-	*kernel_size = decompressed_size;
+	*kernel_size = original_file_sz;
 	dbgprintf("%s: done\n", __func__);
 
 	ret = 0;
-- 
2.41.0


