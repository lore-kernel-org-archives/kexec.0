Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA24EC98315
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 03:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yw3aB1Il7lON1+TKtraAyWydt+eFZrLxkMUyC2AOIMc=; b=JLq3wU3obuIU3u3KfznsVv16d5
	8qik8eyiWKin0jGCYB9pmGGdVI8kTHRWgCX5NHuwFyXWu0B0DeixwPxPrmjXfQU+8PuGc2ts5jW3b
	Ivh3oqpj2tTDdar0GpYa4Hb2Uo9jm4Zm1fHrTKCAdEbkUp/mtwPHfS0nXY39c2vTsIDJrydnmX6hm
	7z9lhf5V4hINqJH4zx6zDf/d/Vus7vtFKkZGhF/ChazkiXN1DxwsI1f1Z19YOXiWcRdhbXLQNkv3O
	Y5l3qauCwvxIo31/A4a5/pOAo/mPtI1G7dYewwUxvIudMi2M77F6r9q1iQ9VaZnkhSoxHBfCgm23x
	GxY/vMeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhfug-00000001Jbl-436w;
	Mon, 19 Jan 2026 03:26:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhfue-00000001JaV-0yTq
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 03:26:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yw3aB1Il7lON1+TKtraAyWydt+eFZrLxkMUyC2AOIMc=;
	b=esOhLfAwfj6xKGipkVoorIMkn1Za+Yo48DAN/tuU62/appbPKhoeaXgn39WLSFz/LWoILu
	o34K1Is9WuNYOgRABo7LhNnsVd690s3/d5hIIeZwxGYRV/7nDB8N9erz+BqYMBZzCAsSEU
	XrDxqIQTLP4G2rBBayDMTFscCGM0QIA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-oldMCqooNXCBv0xnVXj0ww-1; Sun,
 18 Jan 2026 22:26:40 -0500
X-MC-Unique: oldMCqooNXCBv0xnVXj0ww-1
X-Mimecast-MFC-AGG-ID: oldMCqooNXCBv0xnVXj0ww_1768793198
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E08771956046;
	Mon, 19 Jan 2026 03:26:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5642F1955F22;
	Mon, 19 Jan 2026 03:26:26 +0000 (UTC)
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
Subject: [PATCHv6 07/13] kexec_file: Implement copy method for parser
Date: Mon, 19 Jan 2026 11:24:18 +0800
Message-ID: <20260119032424.10781-8-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_192644_648923_7DB77295 
X-CRM114-Status: GOOD (  11.77  )
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

Copying the bpf code parsing result to the proper place:
image->kernel_buf, initrd_buf, cmdline_buf.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/kexec_bpf_loader.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index bd6a47fc53ed3..5ad67672dead1 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -82,6 +82,7 @@ static int __init kexec_bpf_prog_run_init(void)
 late_initcall(kexec_bpf_prog_run_init);
 
 #define KEXEC_BPF_CMD_DECOMPRESS	0x1
+#define KEXEC_BPF_CMD_COPY		0x2
 
 #define KEXEC_BPF_SUBCMD_KERNEL		0x1
 #define KEXEC_BPF_SUBCMD_INITRD		0x2
@@ -281,6 +282,32 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
 			}
 		}
 		break;
+	case KEXEC_BPF_CMD_COPY:
+		p = __vmalloc(cmd->payload_len, GFP_KERNEL | __GFP_ACCOUNT);
+		if (!p)
+			return -ENOMEM;
+		memcpy(p, buf, cmd->payload_len);
+		switch (cmd->subcmd) {
+		case KEXEC_BPF_SUBCMD_KERNEL:
+			vfree(ctx->kernel);
+			ctx->kernel = p;
+			ctx->kernel_sz = cmd->payload_len;
+			break;
+		case KEXEC_BPF_SUBCMD_INITRD:
+			vfree(ctx->initrd);
+			ctx->initrd = p;
+			ctx->initrd_sz = cmd->payload_len;
+			break;
+		case KEXEC_BPF_SUBCMD_CMDLINE:
+			vfree(ctx->cmdline);
+			ctx->cmdline = p;
+			ctx->cmdline_sz = cmd->payload_len;
+			break;
+		default:
+			vfree(p);
+			break;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.49.0


