Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DB01094481
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqZTaT+kdyZRnQ5tH5b3qqrQ/FmskQWQAl3eHGY05TE=; b=0EMFeLrk0/3TQNc27ipuiDxa75
	8JO7Og9nj3shk8ngwrnouwjPC15HwSF2MgwW+yQvPldF1p9Er2Kcy6rEHyKs0TeK+A3PNdVh4fkLC
	L/IFGbGsbAyHWZ9BdQwPsAz8US1NdhOotZCZSSr9vq6/Ll+vtFp+wWBm8fMMVVSAzRPVloAd2c9vq
	tYjvXT3nZFpGCYzAv7oNml3Qqiw2uzxg3UD3j79lMSM4TGfKsUUOArN/KqWrfhmOi27zDquRwrQs0
	k0mQsTHXJLPoibD8WJ/GGZFN3YlJuJzdpEa+eki3FXXgZoKAHkp78LyPLzqXBn5TSlkPCys174OkO
	LSTEqAAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47sr-0000000Ewrn-2D8T;
	Sun, 22 Mar 2026 01:45:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47so-0000000Ewr7-0uHt
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 01:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqZTaT+kdyZRnQ5tH5b3qqrQ/FmskQWQAl3eHGY05TE=;
	b=Q4vSOkLMyuQkjcrVlLolayJuBeQhSc36KvmXrhbA/MhbFUMn1MWjLaV+Gf2HirsxSIRpzX
	1V3g7tQEPaVv0ryOereSpESh5+7Ieg1hYHWRxAQo3A4gDbusPDrhvgcYRzicPZ7xB+AZE4
	qFVV5APztHM9frFOkMVnEEWoAa0rRc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-DIRbQntINgig3MQLEVGIhw-1; Sat,
 21 Mar 2026 21:45:32 -0400
X-MC-Unique: DIRbQntINgig3MQLEVGIhw-1
X-Mimecast-MFC-AGG-ID: DIRbQntINgig3MQLEVGIhw_1774143930
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E19E519560A2;
	Sun, 22 Mar 2026 01:45:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6248300019F;
	Sun, 22 Mar 2026 01:45:17 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
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
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv7 04/13] kexec_file: Implement decompress method for parser
Date: Sun, 22 Mar 2026 09:43:53 +0800
Message-ID: <20260322014402.8815-5-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: DkVo0fZQkd12xZH_ys5OrgW8e2JrknzL_7Aa4MOVtNc_1774143930
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_184538_332242_ABC1F916 
X-CRM114-Status: GOOD (  26.53  )
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

On arm64, there is no boot-time decompression for the kernel image.
Therefore, when a compressed kernel image is loaded, it must be
decompressed.

It is impractical to implement the complex decompression methods in BPF
bytecode. However, decompression routines exist in the kernel.  This
patch bridges the compressed data with the kernel's decompression
methods.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/Kconfig.kexec      |   2 +-
 kernel/kexec_bpf_loader.c | 236 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 0c5d619820bcd..dbfdf34a78aa0 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -49,7 +49,7 @@ config KEXEC_FILE
 config KEXEC_BPF
 	bool "Enable bpf-prog to parse the kexec image"
 	depends on KEXEC_FILE
-	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	depends on DEBUG_INFO_BTF && BPF_SYSCALL && KEEP_DECOMPRESSOR
 	help
 	  This is a feature to run bpf section inside a kexec image file, which
 	  parses the image properly and help kernel set up kexec boot protocol
diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index bd1800a767824..c79fb777d51bf 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -21,6 +21,7 @@
 #include <asm/byteorder.h>
 #include <asm/image.h>
 #include <asm/memory.h>
+#include <linux/decompress/generic.h>
 #include "kexec_internal.h"
 
 /* Load a ELF */
@@ -73,8 +74,243 @@ static int __init kexec_bpf_prog_run_init(void)
 }
 late_initcall(kexec_bpf_prog_run_init);
 
+/* Mark the bpf parser success */
+#define KEXEC_BPF_CMD_INVALID		0x0
+#define KEXEC_BPF_CMD_DONE		0x1
+#define KEXEC_BPF_CMD_DECOMPRESS	0x2
+
+#define KEXEC_BPF_SUBCMD_INVALID	0x0
+#define KEXEC_BPF_SUBCMD_KERNEL		0x1
+#define KEXEC_BPF_SUBCMD_INITRD		0x2
+#define KEXEC_BPF_SUBCMD_CMDLINE	0x3
+
+#define KEXEC_BPF_PIPELINE_INVALID	0x0
+#define KEXEC_BPF_PIPELINE_FILL		0x1
+
+struct cmd_hdr {
+	uint16_t cmd;
+	uint8_t subcmd;
+	uint8_t pipeline_flag;
+	/* sizeof(chunks) + sizeof(all data) */
+	uint32_t payload_len;
+	/* 0 */
+	uint16_t num_chunks;
+} __packed;
+
+/* Reserved for extension */
+struct cmd_chunk {
+	uint16_t type;
+	uint32_t len;
+} __packed;
+
+
+/* Max decompressed size is capped at 512M */
+#define MAX_UNCOMPRESSED_BUF_SIZE	(1 << 29)
+#define CHUNK_SIZE	(1 << 23)
+
+struct decompress_mem_allocator {
+	void *chunk_start;
+	unsigned int chunk_size;
+	void *chunk_cur;
+	unsigned int next_idx;
+	char **chunk_base_addr;
+};
+
+/*
+ * This global allocator for decompression is protected by kexec lock.
+ */
+static struct decompress_mem_allocator dcmpr_allocator;
+
+/*
+ * Set up an active chunk to hold partial decompressed data.
+ */
+static char *allocate_chunk_memory(void)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	char *p;
+
+	if (unlikely((a->next_idx * a->chunk_size >= MAX_UNCOMPRESSED_BUF_SIZE)))
+		return NULL;
+
+	p = __vmalloc(a->chunk_size, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!p)
+		return NULL;
+	a->chunk_base_addr[a->next_idx++] = p;
+	a->chunk_start = a->chunk_cur = p;
+
+	return p;
+}
+
+static int merge_decompressed_data(struct decompress_mem_allocator *a,
+			char **out, unsigned long *size)
+{
+	unsigned int last_chunk_sz = a->chunk_cur - a->chunk_start;
+	unsigned long total_sz;
+	char *dst, *cur_dst;
+	int i;
+
+	total_sz = (a->next_idx - 1) * a->chunk_size + last_chunk_sz;
+	cur_dst = dst = __vmalloc(total_sz, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!dst)
+		return -ENOMEM;
+
+	for (i = 0; i < a->next_idx - 1; i++) {
+		memcpy(cur_dst, a->chunk_base_addr[i], a->chunk_size);
+		cur_dst += a->chunk_size;
+		vfree(a->chunk_base_addr[i]);
+		a->chunk_base_addr[i] = NULL;
+	}
+
+	memcpy(cur_dst, a->chunk_base_addr[i], last_chunk_sz);
+	vfree(a->chunk_base_addr[i]);
+	a->chunk_base_addr[i] = NULL;
+	*out = dst;
+	*size = total_sz;
+
+	return 0;
+}
+
+static int decompress_mem_allocator_init(
+	struct decompress_mem_allocator *a,
+	unsigned int chunk_size)
+{
+	unsigned long sz = (MAX_UNCOMPRESSED_BUF_SIZE / chunk_size) * sizeof(void *);
+	char *buf;
+
+	a->chunk_base_addr = __vmalloc(sz, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!a->chunk_base_addr)
+		return -ENOMEM;
+
+	/* Pre-allocate the memory for the first chunk */
+	buf = __vmalloc(chunk_size, GFP_KERNEL | __GFP_ACCOUNT);
+	if (!buf) {
+		vfree(a->chunk_base_addr);
+		return -ENOMEM;
+	}
+	a->chunk_base_addr[0] = buf;
+	a->chunk_start = a->chunk_cur = buf;
+	a->chunk_size = chunk_size;
+	a->next_idx = 1;
+	return 0;
+}
+
+static void decompress_mem_allocator_fini(struct decompress_mem_allocator *a)
+{
+	int i;
+
+	for (i = 0; i < a->next_idx; i++) {
+		if (a->chunk_base_addr[i] != NULL)
+			vfree(a->chunk_base_addr[i]);
+	}
+	vfree(a->chunk_base_addr);
+}
+
+/*
+ * This is a callback for decompress_fn.
+ *
+ * It copies the partial decompressed content in [buf, buf + len) to dst. If the
+ * active chunk is not large enough, retire it and activate a new chunk to hold
+ * the remaining data.
+ */
+static long flush(void *buf, unsigned long len)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	long free, copied = 0;
+
+	if (unlikely(len > a->chunk_size)) {
+		pr_info("Chunk size is too small to hold decompressed data\n");
+		return -1;
+	}
+	free = a->chunk_start + a->chunk_size - a->chunk_cur;
+	BUG_ON(free < 0);
+	if (free < len) {
+		memcpy(a->chunk_cur, buf, free);
+		copied += free;
+		a->chunk_cur += free;
+		buf += free;
+		len -= free;
+		a->chunk_start = a->chunk_cur = allocate_chunk_memory();
+		if (unlikely(!a->chunk_start)) {
+			pr_info("Decompression runs out of memory\n");
+			return -1;
+		}
+	}
+	memcpy(a->chunk_cur, buf, len);
+	copied += len;
+	a->chunk_cur += len;
+	return copied;
+}
+
+static int parser_cmd_decompress(char *compressed_data, int image_gz_sz,
+		char **out_buf, unsigned long *out_sz, struct kexec_context *ctx)
+{
+	struct decompress_mem_allocator *a = &dcmpr_allocator;
+	decompress_fn decompressor;
+	const char *name;
+	int ret;
+
+	ret = decompress_mem_allocator_init(a, CHUNK_SIZE);
+	if (ret < 0)
+		return ret;
+	decompressor = decompress_method(compressed_data, image_gz_sz, &name);
+	if (!decompressor) {
+		pr_err("Can not find decompress method\n");
+		ret = -1;
+		goto err;
+	}
+	pr_debug("Find decompressing method: %s, compressed sz:0x%x\n",
+			name, image_gz_sz);
+	ret = decompressor(compressed_data, image_gz_sz, NULL, flush,
+				NULL, NULL, NULL);
+	if (!!ret)
+		goto err;
+	ret = merge_decompressed_data(a, out_buf, out_sz);
+
+err:
+	decompress_mem_allocator_fini(a);
+
+	return ret;
+}
+
 static int kexec_buff_parser(struct bpf_parser_context *parser)
 {
+	struct bpf_parser_buf *pbuf = parser->buf;
+	struct kexec_context *ctx = (struct kexec_context *)parser->data;
+	struct cmd_hdr *cmd = (struct cmd_hdr *)pbuf->buf;
+	char *decompressed_buf, *buf, *p;
+	unsigned long decompressed_sz;
+	int ret = 0;
+
+	buf = pbuf->buf + sizeof(struct cmd_hdr);
+	if (cmd->payload_len + sizeof(struct cmd_hdr) > pbuf->size) {
+		pr_info("Invalid payload size:0x%x, while buffer size:0x%x\n",
+				cmd->payload_len, pbuf->size);
+		return -EINVAL;
+	}
+	switch (cmd->cmd) {
+	case KEXEC_BPF_CMD_DONE:
+		ctx->parsed = true;
+		break;
+	case KEXEC_BPF_CMD_DECOMPRESS:
+		ret = parser_cmd_decompress(buf, cmd->payload_len, &decompressed_buf,
+					&decompressed_sz, ctx);
+		if (!ret) {
+			switch (cmd->subcmd) {
+			case KEXEC_BPF_SUBCMD_KERNEL:
+				vfree(ctx->kernel);
+				ctx->kernel = decompressed_buf;
+				ctx->kernel_sz = decompressed_sz;
+				break;
+			default:
+				vfree(decompressed_buf);
+				break;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.49.0


