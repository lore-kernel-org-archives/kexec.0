Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9C606A8A5
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KbREs0UW;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=SQmozrjb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yX/L1x4ZGZXTilXb62Za88zoxS/rAl+itZPKFnz9f2E=; b=KbREs0UWM5WR+n
	/TtB8L+ic3dsS/09r8LBhTNp+Kj84c5loNsZmNn6aibyPJmuZ5vfkqbwlIMuFbJ35O9m430boQEwf
	Bczhw4x4EEu9zGTqbdJeajHVXDgLOChWA2hDCp8tn9Shz956uKl/nzxhp+L6+N2fIwO9V7IURGW/l
	u/ZBp4gHukVYvaTxfOyjCq6shwms8buucY6hUSYOQPwaNaF0rG9hIGEwayE6FCbErVjvPvywEH5nk
	0OQ7YAmC2UgflEuGQ21ovmBU/puo6y8/bZ0UVpGqR2wQPIclV1tJb3jVxOarI+rknFpdnLXnr8pu+
	H6sjqlUVE+2+QABSVgiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJN-00000009w47-2uKC;
	Thu, 12 Nov 2026 12:53:53 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJG-00000009vum-0ZoP
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 12:53:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yX/L1x4ZGZXTilXb62Za88zoxS/rAl+itZPKFnz9f2E=; b=SQmozrjb+tJVVe8WL8GEdZ4sYg
	gR3uXOb0qznPCASCyqeO4KUGyqh9c7ezNkKEYwDnQrcY6nyoIdC8CHg1MNDjRtHMaepoDSauZfqKq
	xbaQaFV8bdl/d/op5bC2rHBwKKVdWMyUHwpLzGPRBjPTVy+s09wD/0Qqvrphn1+2rQSIOy7hKy6ZC
	BpqSr3M2e5hDqUcE/JoDNKM7sHqthj5UteJc6DqhoVOuJq5RFd2dJsUi6KzjQkQhV9o7FF7uYe5In
	K73r26ZMk/kRkaTm8SG5TPOiJueuQOWrdVYTIp5wOMyDDohZTStWu3Cz3VdBjDYBCoFj1hBqXsKGZ
	I/xtjRyQ==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIZ-00000003H1G-2a6p;
	Thu, 12 Nov 2026 13:53:01 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] kexec_file: update IMA after machine post-load
Date: Thu, 12 Nov 2026 12:52:45 +0000
Message-ID: <20261112125246.2715174-3-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_045346_466370_1C6D0774 
X-CRM114-Status: UNSURE (   7.96  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ima_kexec_post_load() replaces the global IMA mapping with a mapping for
the new image. If machine_kexec_post_load() fails, the new image is
freed but that mapping remains. The installed image no longer receives
the execute-time IMA update, and the notifier can write the
measurement list into freed pages.

Call the machine hook first. Return its error before updating IMA so IMA
changes the mapping only for an image which will be installed.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/kexec_file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b668ce8d68ee..59f9ba1b0cd7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -206,11 +206,17 @@ kimage_validate_signature(struct kimage *image)
 
 static int kexec_post_load(struct kimage *image, unsigned long flags)
 {
+	int ret;
+
+	ret = machine_kexec_post_load(image);
+	if (ret)
+		return ret;
+
 #ifdef CONFIG_IMA_KEXEC
 	if (!(flags & KEXEC_FILE_ON_CRASH))
 		ima_kexec_post_load(image);
 #endif
-	return machine_kexec_post_load(image);
+	return 0;
 }
 
 /*

