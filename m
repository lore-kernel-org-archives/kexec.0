Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C6EC0015E
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jj3FwVnfZgrpq+B1tH3aC08FlHC1NrqPslHQHnid10Q=; b=SSZuUGiq0uiokK
	s+5gosVbZ0xBgarNzf3aNt0uMWvD7NI9OoKYQyIzDWUtXYpkTUCF0fzUa7W8d2vAC8pFs+BGEp6sN
	dUJ8Nz8c5J3EbE9rpiDrnNDjUQWkFEpYK/PQONRWL030nc/K3cnNkhHZfxpgYawhnCOeYTYlQooga
	7QVT/YCyAjRdMT3WK5jt2dKJgynvwz0uT9vgTs1+Qr86u+5c3WwKkzSLjp34oDJs3Gywj1Mdcwuz/
	DlPWYAQqjjHcOLdp/wWhjrdd7ZktxWFK4wCIpmXsOzaVdO85Gx4sE+Ykz1Pnx1iCy9qVivqcsb62o
	7Tjlyf55KOHuRn94FzCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNyc-0044CN-34;
	Mon, 17 Jul 2023 13:09:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNyI-004463-1M
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 13:09:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689599341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWULwYfeiBxmgCaZ3cTaaFL3BgsK1esVf8sTy5ixa6A=;
	b=hhhv72wH2hELVBYXcdirFZo+crwEYjGVItNRzFsuYm2PMWLNHj0xnfkXR83NqzJzAUOHuB
	znABnTHFLRMeNkgly/NUA6y6Uu6TuDekEF+xT29a8hs9iytss24aZ4yfBvvKrAGT3zbMVt
	3QBJgCha3GriA3BjjjmTw/c6wFEXT9E=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-cfq0zVORO4-OKMkOiWnRNA-1; Mon, 17 Jul 2023 09:08:58 -0400
X-MC-Unique: cfq0zVORO4-OKMkOiWnRNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EC3A1C07246;
	Mon, 17 Jul 2023 13:08:58 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C5221121314;
	Mon, 17 Jul 2023 13:08:54 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv5 7/8] arm64: Add ZBOOT PE containing compressed image support
Date: Mon, 17 Jul 2023 21:07:31 +0800
Message-Id: <20230717130732.22710-8-piliu@redhat.com>
In-Reply-To: <20230717130732.22710-1-piliu@redhat.com>
References: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_060902_585229_3119E994 
X-CRM114-Status: GOOD (  24.31  )
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

From: Jeremy Linton <jeremy.linton@arm.com>

The kernel EFI stub ZBOOT feature creates a PE that
contains a compressed linux kernel image. The stub
when run in a valid UEFI environment then decompresses
the resulting image and executes it.

Support these image formats with kexec as well to avoid
having to keep an alternate kernel image around.

This patch adds a the _probe() and usage() routines needed
for kexec to understand this format.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
[Modified by Pingfan to adapt the new probe interface]
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
 kexec/arch/arm64/image-header.h        |   1 +
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 102 +++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c

diff --git a/kexec/arch/arm64/image-header.h b/kexec/arch/arm64/image-header.h
index 158d411..26bb02f 100644
--- a/kexec/arch/arm64/image-header.h
+++ b/kexec/arch/arm64/image-header.h
@@ -37,6 +37,7 @@ struct arm64_image_header {
 
 static const uint8_t arm64_image_magic[4] = {'A', 'R', 'M', 0x64U};
 static const uint8_t arm64_image_pe_sig[2] = {'M', 'Z'};
+static const uint8_t arm64_pe_machtype[6] = {'P','E', 0x0, 0x0, 0x64, 0xAA};
 static const uint64_t arm64_image_flag_be = (1UL << 0);
 static const uint64_t arm64_image_flag_page_size = (3UL << 1);
 static const uint64_t arm64_image_flag_placement = (1UL << 3);
diff --git a/kexec/arch/arm64/kexec-vmlinuz-arm64.c b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
new file mode 100644
index 0000000..30e99a9
--- /dev/null
+++ b/kexec/arch/arm64/kexec-vmlinuz-arm64.c
@@ -0,0 +1,102 @@
+/*
+ * ARM64 PE compressed Image (vmlinuz, ZBOOT) support.
+ *
+ * Several distros use 'make zinstall' rule inside
+ * 'arch/arm64/boot/Makefile' to install the arm64
+ * ZBOOT compressed file inside the boot destination
+ * directory (for e.g. /boot).
+ *
+ * Currently we cannot use kexec_file_load() to load vmlinuz
+ * PE images that self decompress.
+ *
+ * To support ZBOOT, we should:
+ * a). Copy the compressed contents of vmlinuz to a temporary file.
+ * b). Decompress (gunzip-decompress) the contents inside the
+ *     temporary file.
+ * c). Validate the resulting image and write it back to the
+ *     temporary file.
+ * d). Pass the 'fd' of the temporary file to the kernel space.
+ *
+ * Note this, module doesn't provide a _load() function instead
+ * relying on image_arm64_load() to load the resulting decompressed
+ * image.
+ *
+ * So basically the kernel space still gets a decompressed
+ * kernel image to load via kexec-tools.
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "kexec-arm64.h"
+#include <kexec-pe-zboot.h>
+#include "arch/options.h"
+
+
+/* Returns:
+ * -1 : in case of error/invalid format (not a valid PE+compressed ZBOOT format.
+ */
+int pez_arm64_probe(const char *kern_fname, struct parsed_info *info)
+{
+	int ret = -1;
+	const struct arm64_image_header *h;
+	char *buf;
+	off_t buf_sz;
+
+	buf = slurp_file(kern_fname, &buf_sz);
+	if (!buf)
+		return -1;
+	h = (const struct arm64_image_header *)buf;
+
+	dbgprintf("%s: PROBE.\n", __func__);
+	if (buf_sz < sizeof(struct arm64_image_header)) {
+		dbgprintf("%s: Not large enough to be a PE image.\n", __func__);
+		return -1;
+	}
+	if (!arm64_header_check_pe_sig(h)) {
+		dbgprintf("%s: Not an PE image.\n", __func__);
+		return -1;
+	}
+
+	if (buf_sz < sizeof(struct arm64_image_header) + h->pe_header) {
+		dbgprintf("%s: PE image offset larger than image.\n", __func__);
+		return -1;
+	}
+
+	if (memcmp(&buf[h->pe_header],
+		   arm64_pe_machtype, sizeof(arm64_pe_machtype))) {
+		dbgprintf("%s: PE header doesn't match machine type.\n", __func__);
+		return -1;
+	}
+
+	/* Output info is filled by this parser */
+	ret = pez_prepare(buf, buf_sz, info);
+
+	if (!ret) {
+	    /* validate the arm64 specific header */
+	    struct arm64_image_header hdr_check;
+	    if (read(info->fd, &hdr_check, sizeof(hdr_check)) != sizeof(hdr_check))
+		goto bad_header;
+
+	    lseek(info->fd, 0, SEEK_SET);
+
+	    if (!arm64_header_check_magic(&hdr_check)) {
+		dbgprintf("%s: Bad arm64 image header.\n", __func__);
+		goto bad_header;
+	    }
+	}
+
+	return ret;
+bad_header:
+	close(info->fd);
+	free(buf);
+	return -1;
+}
+
+void pez_arm64_usage(void)
+{
+	printf(
+"     An ARM64 vmlinuz, PE image of a compressed, little endian.\n"
+"     kernel, built with ZBOOT enabled.\n\n");
+}
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
