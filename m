Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DC606A321
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HVW5wgUi;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fR5zRllt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=I88pmf1i9KwkUDAp+VlFVURLkgncDv2aMPZAk6UPui8=; b=HVW5wgUijTbzAAeDJai0BXmiQo
	pAA6rtrCdV4aMBhseFhWBEhpeLaOijEcbVZxVfCg5pW7tX4RpBcj7iAejLCV8UL/kI5/XZkY+2u+x
	PEXmKXVPPzclUqg9JthIMnrRsFbsF3s0YMD0PhaDfCHkSN9pRQP87FUBLHS01su3gRYUN3ve8ogH+
	UJSFDQJvH/bwUAnUvRA7O+4EUJqyMsoSWZKWfUSGT/v62z7s1zhG3afv7/aoZUwBY9H+BAlajenk1
	kL0VMbY59aym5CGKeRQ/6661b4wSblcG7Sf+e2yPZIOsUtdxFpHujCXzpspY6jiiywyjY+ZDam3PE
	n8Hnwe+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRiJF-0000000BbhU-0GUg;
	Fri, 13 Nov 2026 03:50:41 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRiJA-0000000Bbfs-2wRr
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 03:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794541827; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I88pmf1i9KwkUDAp+VlFVURLkgncDv2aMPZAk6UPui8=;
	b=fR5zRlltmIF5MgKPIDQqh8jEr3/TFIiKd6JjOutBLv7vw8kQIqV3YMSHsqsNf9b0GcM2t+CXHO42zAiN3Yr9z/C/1t0uqU37kEvPsGyF/TYllFpAST85iO7eJ1jKVXe7jKB2Eqrln0XBbjQU1TNvTHRXHTMAz1q9p9BMVBQBki0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XEdmoxy_1794541819;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XEdmoxy_1794541819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Nov 2026 11:50:27 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com
Cc: x86@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	challvy.tee@gmail.com,
	xiangzao@linux.alibaba.com
Subject: [PATCH v2] x86/crash: Disable SGX in the kdump kernel
Date: Fri, 13 Nov 2026 11:50:19 +0800
Message-ID: <20261113035019.3747461-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_195037_480338_2A59677C 
X-CRM114-Status: GOOD (  10.16  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kdump capture kernel cannot use SGX: EPC memory is e820-reserved,
so it is not part of the crash dump, and no enclave will ever run
during dump capture.  Yet sgx_init() runs unconditionally and pays the
full EPC bookkeeping: sgx_setup_epc_section() allocates one struct
sgx_epc_page (32 bytes) per 4K EPC page, i.e. EPC/128, plus a memremap
of the whole EPC range.

The capture kernel has no memory other than the crashkernel
reservation.  On a VM with 15.5G EPC the bookkeeping alone costs
124 MB of vmalloc - nearly half of the stock crashkernel=256M -
and the cost scales with EPC size, not RAM.

That is enough to break kdump outright: with the default 256M the
capture kernel OOMs in early userspace (udevadm and journald are killed
before the root device is enumerated) and no vmcore is produced, while
512M works.  With this change the same 256M reservation captures a
complete vmcore; SGX initializes as usual on normal boots.

Clear X86_FEATURE_SGX from an x86 early handler for elfcorehdr=, which
only the capture kernel receives, so sgx_init() bails out on its
existing capability check and no kdump knowledge leaks into the SGX
code.  Like nosgx, it has to be an early parameter: clearing a feature
after alternatives are patched is too late.

Reported-by: Challvy Tee <challvy.tee@gmail.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20261111123942.3842771-1-xiangzao@linux.alibaba.com/

- Clear X86_FEATURE_SGX from an x86 elfcorehdr= early handler instead
  of checking is_kdump_kernel() in sgx_init() (Dave Hansen); retitled
  to x86/crash accordingly.

 arch/x86/kernel/crash_dump_64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 32d710f7eb84..4a275b969f3c 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -12,6 +12,8 @@
 #include <linux/io.h>
 #include <linux/cc_platform.h>
 
+#include <asm/cpufeature.h>
+
 static ssize_t __copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 				  size_t csize, unsigned long offset,
 				  bool encrypted)
@@ -62,3 +64,15 @@ ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 	return read_from_oldmem(&iter, count, ppos,
 				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
 }
+
+/*
+ * elfcorehdr= is passed only to the capture kernel.  Turn off the
+ * features it has no use for.
+ */
+static int __init kdump_disable_features(char *arg)
+{
+	/* SGX metadata for a large EPC can exhaust crashkernel memory. */
+	setup_clear_cpu_cap(X86_FEATURE_SGX);
+	return 0;
+}
+early_param("elfcorehdr", kdump_disable_features);
-- 
2.43.7


