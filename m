Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A53DCAC5AA
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 06:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rv9mFF7E2sFvptVpGDdTuMXUDFf71q1L+UqIP/87aRQ=; b=k2CD3gWEsN1RmopNRTtF5kdm6J
	0P3NzZCEn8fPq666nIdjXuG0IheKPTyLeqG4GcIolRtqkScKUzM+AmgIC6vBPFddTXHWUquKjZ0nX
	HyV9/Jc7rG7NMN0K09ZoJfiXetfUnfThQrAzQWvj3JZm1AObUuYMQysT6MTFIHh81SrsnkXORK3Pv
	FlV9OW3rfqjPiriH5xKPHJDEI++ghMP171w1P7j7fBjk1NVZj+QCeEcJOUuqj7f4537xRDN5N+VHF
	VVM3629zDhERckba/SM3yHrB/fBqXZQhyDG1Y3Pjfy8pkxbwMFcn62GoMIuSW/D4w119Y2wKCkWse
	2cKKd7MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1fXY-00000006JMq-3D65;
	Thu, 25 Sep 2025 06:33:16 +0000
Received: from out-181.mta1.migadu.com ([2001:41d0:203:375::b5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1fXV-00000006JFx-2v8F
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 06:33:15 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758781985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rv9mFF7E2sFvptVpGDdTuMXUDFf71q1L+UqIP/87aRQ=;
	b=Qy0hq1RNWQm1HXpofa+21NYOZmcBkB3QUCCX6M3kqQvKDYRqE6pdc9EWOJU3edpe5n1dfH
	a0ILJUjCHp/tvvEp3RzVmtopckAFnqMdlLRdIEwD3vsgCkzre/a1YoO7QpqXFbNaGKNJK4
	GbbzVWyUAIhVb8fis4gcajApbKO1jnM=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@kernel.org>
Cc: Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/2] Remove the "mem=" parameter when using the --reuse-cmdline option in kdump operation
Date: Thu, 25 Sep 2025 14:32:40 +0800
Message-ID: <20250925063241.337897-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_233314_168362_6B4655F6 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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

From: Youling Tang <tangyouling@kylinos.cn>

During kdump operations, the capture kernel cannot reuse the "mem="
parameter from the production kernel. The "mem=" parameter is used
to specify the available memory range for the kernel. Reusing the
"mem=" memory range may destroy the production environment.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index c9e4bcb..fadf986 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1256,8 +1256,10 @@ char *get_command_line(void)
 		*p = '\0';
 
 	remove_parameter(line, "BOOT_IMAGE");
-	if (kexec_flags & KEXEC_ON_CRASH)
+	if (kexec_flags & KEXEC_ON_CRASH) {
 		remove_parameter(line, "crashkernel");
+		remove_parameter(line, "mem=");
+	}
 
 	return line;
 }
-- 
2.48.1


