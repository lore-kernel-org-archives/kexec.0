Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D465D1AD43
	for <kexec@archiver.kernel.org>; Wed, 16 Oct 2024 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y2JvIk1KJ/2kia1kctS6ZGOSETHVlMImha6gsD5fg7Q=; b=JgodFgc4DMpR1c
	AvOXqOdgwrvScjoPKfuxJwGDi12p1mKpMMd9+Urm8S0130I2sEw1si/NsqEnAmoLyFPBX0Ig06tHo
	TLCC0CabBtwvE0X/hi4zUgUi0LruFBHzUl/Tj+k2BEJsLjndJhx2XPlZ4/jMbibjPHQ1wY/qvR38h
	JE4zjJQSyowNYrv/OIwVemZxlcJ9oPMr9DN0h3ozZ8ifS3SOV6FgJvelQ7n3FZaq7ERd+oSX4zOkB
	LuGuzGNi8w/h7av6rnkUEwSrekHj3j42PfXnsFrq5WToCt7nkUCHHSsXfR7vNIXBxpQXS54j+sP65
	rMM9YGEn/U6MUmDWd/bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t12Ic-0000000BbDT-3bee;
	Wed, 16 Oct 2024 11:34:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t12Ia-0000000BbCT-01eE
	for kexec@lists.infradead.org;
	Wed, 16 Oct 2024 11:34:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729078479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXdUsGHqz3e9xFnmV99kWNpPTHf7B81o8cEPrSIjL5Q=;
	b=ZpP2CdxslRGpEmwk2opSltsbLOJCBtsOyzodZ8bF/LS1tNoUohoF949CPjGzASk+keOQJn
	LNGrjPRw0sPqe6iywxT9WyG66n0TArJl7mOpypzPB4VfaJyCQlisV9jU78J1FZvGR0ZwV7
	pPT++vxC7zBDC1bpKsR+wPos/c+DGTs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-TPV7-YCZMMe0shtisClf3g-1; Wed,
 16 Oct 2024 07:34:36 -0400
X-MC-Unique: TPV7-YCZMMe0shtisClf3g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6442195608A;
	Wed, 16 Oct 2024 11:34:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.65])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D5C9195607C;
	Wed, 16 Oct 2024 11:34:28 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: 
Cc: Pingfan Liu <piliu@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	kexec@lists.infradead.org
Subject: [PATCHv2 1/3] kexec: Introduce implicit_initrd_fd to pass internal initrd information
Date: Wed, 16 Oct 2024 19:34:13 +0800
Message-ID: <20241016113418.22568-2-piliu@redhat.com>
In-Reply-To: <20241016113418.22568-1-piliu@redhat.com>
References: <20241016113418.22568-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_043440_143360_CFB60B19 
X-CRM114-Status: GOOD (  13.36  )
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

At present, initrd information is passed through --initrd args, and
handled until image load. But for the UKI case, the initrd may be stored
implicitly in the .initrd section.

It means that initrd is perceived at the probe stage. And there should
be a way to carry this information forward to the load stage. In oder to
implement that, introducing a global implicit_initrd_fd.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
---
 kexec/arch/arm64/kexec-image-arm64.c | 3 ++-
 kexec/arch/x86_64/kexec-bzImage64.c  | 3 ++-
 kexec/kexec.c                        | 2 ++
 kexec/kexec.h                        | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm64/kexec-image-arm64.c b/kexec/arch/arm64/kexec-image-arm64.c
index a196747..b6f8912 100644
--- a/kexec/arch/arm64/kexec-image-arm64.c
+++ b/kexec/arch/arm64/kexec-image-arm64.c
@@ -50,7 +50,8 @@ int image_arm64_load(int argc, char **argv, const char *kernel_buf,
 				result = EFAILED;
 				goto exit;
 			}
-		}
+		} else if (implicit_initrd_fd != -1)
+			info->initrd_fd = implicit_initrd_fd;
 
 		if (arm64_opts.command_line) {
 			info->command_line = (char *)arm64_opts.command_line;
diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index aba4e3b..210bc0a 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -307,7 +307,8 @@ int bzImage64_load_file(int argc, char **argv, struct kexec_info *info)
 			ret = -1;
 			goto out;
 		}
-	}
+	} else if (implicit_initrd_fd != -1)
+		info->initrd_fd = implicit_initrd_fd;
 
 	info->command_line = command_line;
 	info->command_line_len = command_line_len;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 7c614b0..4f51987 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -67,6 +67,8 @@ int do_hotplug = 0;
 static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
+/* initrd detected in probe phase */
+int implicit_initrd_fd = -1;
 int kexec_debug = 0;
 
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 31c323f..e70c18d 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -114,6 +114,7 @@ do { \
 #define _ALIGN(addr, size)     _ALIGN_UP(addr, size)
 
 extern unsigned long long mem_min, mem_max;
+extern int implicit_initrd_fd;
 extern int kexec_debug;
 
 #define dbgprintf(...) \
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
