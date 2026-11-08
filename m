Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23B606A322
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IspVIFJf;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=a5SwbWrC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=rLyxJwr2Q1zmyzbvbW4Jg4mYpaRFZWR35m+j3Gs4cMU=; b=IspVIFJfmEd+m1+sQwoWuNH8ou
	QtTxXWUFBvjn2zDFN9x6fUNF1BSGdwlbhP/SMz1ljdTVngRrL3vvJSoQTPe3I7i6z5/1Bf9LihzhL
	h910H86UNyJellpaXLWRCOmSM4vNjX6rHHl0pJPuSYMEx7dGMolnZLUHQwQrmYJN472r8sOvYnGOw
	8ioh/5Zt15y/7zVtJ9dyFIDUnV/KW1BVnc0TJOD8GXAGkp2I2+0j+fQVfo2DzlyW6mqweuOtF8iQk
	Da3BEZ1aWCamfBImkv0axAJJ8jNCDvMiCvogiLo90MF2JIncxFL0exX09xDvZ/IyUiO7zeB7d/e9E
	xRHTiVOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ8Do-0000000GVlF-14r8;
	Sun, 08 Nov 2026 19:06:32 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ8Dm-0000000GVjS-0fVt
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 19:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=rLyxJwr2Q1zmyzbvbW4Jg4mYpaRFZWR35m+j3Gs4cMU=; b=a5SwbWrCywIz3dU7Pd5cFDAovJ
	tw1hgr/BiXpgfHmDacdZlRj1+jIEe9f9QDF5XE1GMEQyMAy3ENDUBtM6fwSiIimMTgBcOZzOWKtUX
	m+9rAKuXEtL7N7bl+bZT7OBAKuOGgyVSsVSNq5O8uufgFwtt40p3BXSI38F7m3t6/HDLkBBBWycqw
	xhkvHRBjX9rdMgpVQnRmwtiCIXqqH/rpSGY7ixvOEyjv3dtgsbx6Wb5iLvRdNGIAgKcaPyLFzxMZn
	WUGPxze9Lu+1LYeboGWEw3DI44JTkjYHZnxvSmCCT1HwEv8+VjhioWMfqdXE/Gumlka30XCl4wRVK
	oZ5TfiAg==;
Received: from [151.115.150.205] (port=41786 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xQ8D4-0000000GibV-17vF;
	Sun, 08 Nov 2026 20:05:46 +0100
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
Subject: [PATCH] ima: fix kexec measurement buffer overflow after failed loads
Date: Sun,  8 Nov 2026 19:04:04 +0000
Message-ID: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
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
X-CRM114-CacheID: sfid-20261108_110630_349083_4655485B 
X-CRM114-Status: UNSURE (   9.70  )
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

When kexec_file_load() fails to install a new image, it can leave the
global IMA scratch buffer larger than the IMA segment of the current
image. When that image is executed, ima_update_kexec_buffer() copies
the larger log past the end of its reserved segment. In a test, KASAN
reports it as:

  BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
  Write of size 868426 at addr ffffc9000004e000 by task init/1
  ...
  Call Trace:
   ...
   __asan_memcpy+0x3b/0x60
   ima_update_kexec_buffer+0x265/0x280
   ...
   blocking_notifier_call_chain+0x88/0xb0
   kernel_restart_prepare+0x18/0x40
   kernel_kexec+0xe4/0x130

Limit the dump to the smaller value between the scratch size and the
installed image segment size. Update the IMA mapping only after
machine_kexec_post_load() succeeds.

Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to execute")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/kexec_file.c                | 6 ++++--
 security/integrity/ima/ima_kexec.c | 8 +++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b668ce8d68eed..0b3245389b758 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -206,11 +206,13 @@ kimage_validate_signature(struct kimage *image)
 
 static int kexec_post_load(struct kimage *image, unsigned long flags)
 {
+	int ret = machine_kexec_post_load(image);
+
 #ifdef CONFIG_IMA_KEXEC
-	if (!(flags & KEXEC_FILE_ON_CRASH))
+	if (!ret && !(flags & KEXEC_FILE_ON_CRASH))
 		ima_kexec_post_load(image);
 #endif
-	return machine_kexec_post_load(image);
+	return ret;
 }
 
 /*
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 0d845693a1f78..f7be8d85bb9a7 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -65,7 +65,6 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 
 	ima_free_kexec_file_buf(&ima_kexec_file);
 
-	/* segment size can't change between kexec load and execute */
 	ima_kexec_file.buf = vmalloc(segment_size);
 	if (!ima_kexec_file.buf)
 		return -ENOMEM;
@@ -98,12 +97,14 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	struct ima_kexec_hdr khdr;
 	int ret = 0;
 
-	/* segment size can't change between kexec load and execute */
 	if (!ima_kexec_file.buf) {
 		pr_err("Kexec file buf not allocated\n");
 		return -EINVAL;
 	}
 
+	/* A failed replacement load may have resized the scratch buffer. */
+	ima_kexec_file.size = min_t(size_t, ima_kexec_file.size, segment_size);
+
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/*
@@ -239,7 +240,8 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
 		return ret;
 	}
 
-	ret = ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
+	ret = ima_dump_measurement_list(&buf_size, &buf,
+					kexec_image->ima_buffer_size);
 
 	if (ret)
 		pr_err("Dump measurements failed. Error:%d\n", ret);
-- 
2.47.3


