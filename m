Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22981094481
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 01:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q0yOeqibN7XflIQPgK3OVma/nUGOvOfi7m24NVY99u0=; b=K2mmX0ibVjR18WtJ57r1WOGsXX
	NGOY7vIdtO8JgsH/m7EKdj8M12PDIKCuWtSXWzzzHZ/TKtgcVOZhg/iXLnGeBSZYABQNAgni56kE3
	iDsK7JG2MqGJtWj1jjY4LbXO5nKjA0xO+tqe51lJDWESCbeAoIIZazD3avuiuIjCj0A1JJoTdyRkG
	KpkPHGnNi3wxH4pgwvPUof/pRZVUTiCQ1bzbSM9iy6L7z4Pqx77w9iai5DoxuXVzZz0lG55ddi/XE
	V6snmLwXzgJbRzNrKFsuld9m4uLO5dJ8KdPo2GB3IYIULwDDqEb+cN36OSpl2jDLpc5WO94ir6RMf
	Y1e48txQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47tE-0000000Ewwx-29Tp;
	Sun, 22 Mar 2026 01:46:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47t9-0000000EwwA-1ohk
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 01:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0yOeqibN7XflIQPgK3OVma/nUGOvOfi7m24NVY99u0=;
	b=dP9WaqEOS7OTqqn6ehGzubUNemP6cIpRNxFJ+fwMcZHMW9V/LDK7DeF+YAhYKVVB58bF25
	sc32NpkvK4qhlGg4a12pFFwPttuqhyl84uOCToQQcnjE6rUHiGzXKeJy3oDJJgTGbG8KSH
	CXEXVDQEdmT67yb2qTNykOc4TE2L244=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-m1NarEj3M--uXAdcyh1NsA-1; Sat,
 21 Mar 2026 21:45:57 -0400
X-MC-Unique: m1NarEj3M--uXAdcyh1NsA-1
X-Mimecast-MFC-AGG-ID: m1NarEj3M--uXAdcyh1NsA_1774143954
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A84F180047F;
	Sun, 22 Mar 2026 01:45:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A6B6300019F;
	Sun, 22 Mar 2026 01:45:42 +0000 (UTC)
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
Subject: [PATCHv7 06/13] kexec_file: Chain the stages into a pipeline
Date: Sun, 22 Mar 2026 09:43:55 +0800
Message-ID: <20260322014402.8815-7-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Y0hICVhwkxSLIBHVkmBsGqrB6QqNxlLmVFaspLXEgXU_1774143954
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_184559_542242_7BB5A044 
X-CRM114-Status: GOOD (  16.20  )
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

Images may consist of multiple layers, each with a distinct format. For
example, an AArch64 UKI image typically embeds a zboot image in the
.linux section. The parser therefore determines whether its output
should be forwarded to the next stage.

Intermediate results are stored in next_parsing_buf and then promoted to
parsing_buf for the subsequent stage.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/kexec_bpf_loader.c | 47 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index af16f7b685d9a..7f7884411e2c7 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -41,6 +41,8 @@ struct kexec_context {
 	bool parsed;
 	char *parsing_buf[MAX_PARSING_BUF_NUM];
 	unsigned long parsing_buf_sz[MAX_PARSING_BUF_NUM];
+	char *next_parsing_buf[MAX_PARSING_BUF_NUM];
+	unsigned long next_parsing_buf_sz[MAX_PARSING_BUF_NUM];
 
 	char *kernel;
 	unsigned long kernel_sz;
@@ -278,8 +280,9 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
 	struct bpf_parser_buf *pbuf = parser->buf;
 	struct kexec_context *ctx = (struct kexec_context *)parser->data;
 	struct cmd_hdr *cmd = (struct cmd_hdr *)pbuf->buf;
-	char *decompressed_buf, *buf, *p;
+	char *decompressed_buf, *buf, *p, *pn;
 	unsigned long decompressed_sz;
+	bool fill_pipeline = false;
 	int ret = 0;
 
 	buf = pbuf->buf + sizeof(struct cmd_hdr);
@@ -288,6 +291,7 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
 				cmd->payload_len, pbuf->size);
 		return -EINVAL;
 	}
+	fill_pipeline = cmd->pipeline_flag & KEXEC_BPF_PIPELINE_FILL;
 	switch (cmd->cmd) {
 	case KEXEC_BPF_CMD_DONE:
 		ctx->parsed = true;
@@ -301,6 +305,23 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
 				vfree(ctx->kernel);
 				ctx->kernel = decompressed_buf;
 				ctx->kernel_sz = decompressed_sz;
+				if (fill_pipeline) {
+					int i;
+
+					for (i = 0; i < MAX_PARSING_BUF_NUM; i++) {
+						if (ctx->next_parsing_buf[i])
+							continue;
+						ctx->next_parsing_buf[i] = decompressed_buf;
+						ctx->next_parsing_buf_sz[i] = decompressed_sz;
+						break;
+					}
+					/* No enough parsing slot */
+					if (i == MAX_PARSING_BUF_NUM) {
+						ctx->kernel = NULL;
+						vfree(decompressed_buf);
+						return -ENOMEM;
+					}
+				}
 				break;
 			default:
 				vfree(decompressed_buf);
@@ -313,6 +334,22 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
 		if (!p)
 			return -ENOMEM;
 		memcpy(p, buf, cmd->payload_len);
+		if (fill_pipeline) {
+			pn = __vmalloc(cmd->payload_len, GFP_KERNEL | __GFP_ACCOUNT);
+			if (!pn) {
+				vfree(p);
+				return -ENOMEM;
+			}
+			memcpy(pn, buf, cmd->payload_len);
+			for (int i = 0; i < MAX_PARSING_BUF_NUM; i++) {
+				if (!ctx->next_parsing_buf[i]) {
+					ctx->next_parsing_buf[i] = pn;
+					ctx->next_parsing_buf_sz[i] = cmd->payload_len;
+					break;
+				}
+			}
+		}
+
 		switch (cmd->subcmd) {
 		case KEXEC_BPF_SUBCMD_KERNEL:
 			vfree(ctx->kernel);
@@ -637,6 +674,14 @@ static int process_bpf_parsers_container(const char *elf_buf, size_t elf_sz,
 			context->parsing_buf[i] = NULL;
 			context->parsing_buf_sz[i] = 0;
 		}
+		for (int i = 0; i < MAX_PARSING_BUF_NUM; i++) {
+			if (!context->next_parsing_buf[i])
+				break;
+			context->parsing_buf[i] = context->next_parsing_buf[i];
+			context->parsing_buf_sz[i] = context->next_parsing_buf_sz[i];
+			context->next_parsing_buf[i] = NULL;
+			context->next_parsing_buf_sz[i] = 0;
+		}
 
 		put_bpf_parser_context(bpf);
 		/* If the bpf-prog success, it flags by KEXEC_BPF_CMD_DONE */
-- 
2.49.0


