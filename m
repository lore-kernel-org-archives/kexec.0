Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D2D109448C
	for <kexec@archiver.kernel.org>; Sun, 22 Mar 2026 01:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nXTsiAuJ0Ml5eEoT2v3CB8gGptbXj7qArGf4X4fCTX0=; b=Cu8eMW1TAviH0SBfcVu6Gkph19
	V6ScpF3Iwb05xAfVF1ol0rW9jARh2UR6tsqMSs8tcUjedjWSLeEw9ElFMietwb5k3cwONWMxex0xB
	xvTjLPMB0NcRaaEzSRnmyQVzTznLxRZa+RIzLwOapovR3V74VjipEj2xefHUVTg67LdeDpa0vMzz0
	g4y7cMdypeffXxqWNhjNI5A/7w6+e1P3BxE4+jymL3mltBIu+fIlQc+mo9FogcTrizqMhB9zN9did
	Y+P/fNbSru8oG40oDL0WaibavqL2fpPOMpCZznEFPHLop7jgGqToPU8YaT51s4IjxmNZuSOsT49Pu
	IzrNCpSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47t2-0000000EwuV-3X5e;
	Sun, 22 Mar 2026 01:45:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w47sz-0000000EwtM-1HG8
	for kexec@lists.infradead.org;
	Sun, 22 Mar 2026 01:45:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXTsiAuJ0Ml5eEoT2v3CB8gGptbXj7qArGf4X4fCTX0=;
	b=gV4PZWK/dqr1cpAXBWjQTjvcoLJ+yi7QUZ9FpP6V7Ek1HrbvbADKFqDt/nQ+ad8eKJB0E6
	WeKPRf40q/hiVUhI6eju4LRz+mYnWm5Dp39G8f2d9ybY5HMMjYx6Wdye++o+N6izE3ZcK6
	LImLXO3ncjmNL2GHMK2U4PHxQi32rVE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-NyNUN4QhNkmZBjcJYupS-w-1; Sat,
 21 Mar 2026 21:45:44 -0400
X-MC-Unique: NyNUN4QhNkmZBjcJYupS-w-1
X-Mimecast-MFC-AGG-ID: NyNUN4QhNkmZBjcJYupS-w_1774143942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1281B18005B3;
	Sun, 22 Mar 2026 01:45:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94A1C300019F;
	Sun, 22 Mar 2026 01:45:30 +0000 (UTC)
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
Subject: [PATCHv7 05/13] kexec_file: Implement copy method for parser
Date: Sun, 22 Mar 2026 09:43:54 +0800
Message-ID: <20260322014402.8815-6-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: eTO8wd7jJOA6so1R8dLi09L0chRczzpXdPitk6lSUTQ_1774143942
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_184549_410502_900AA782 
X-CRM114-Status: GOOD (  11.08  )
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
 kernel/kexec_bpf_loader.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
index c79fb777d51bf..af16f7b685d9a 100644
--- a/kernel/kexec_bpf_loader.c
+++ b/kernel/kexec_bpf_loader.c
@@ -78,6 +78,7 @@ late_initcall(kexec_bpf_prog_run_init);
 #define KEXEC_BPF_CMD_INVALID		0x0
 #define KEXEC_BPF_CMD_DONE		0x1
 #define KEXEC_BPF_CMD_DECOMPRESS	0x2
+#define KEXEC_BPF_CMD_COPY		0x3
 
 #define KEXEC_BPF_SUBCMD_INVALID	0x0
 #define KEXEC_BPF_SUBCMD_KERNEL		0x1
@@ -307,6 +308,34 @@ static int kexec_buff_parser(struct bpf_parser_context *parser)
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
+		/* Todo: allow the concatenation of multiple initrd */
+		case KEXEC_BPF_SUBCMD_INITRD:
+			vfree(ctx->initrd);
+			ctx->initrd = p;
+			ctx->initrd_sz = cmd->payload_len;
+			break;
+		/* Todo: allow the concatenation of multiple cmdline */
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


