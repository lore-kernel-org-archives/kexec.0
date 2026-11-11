Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6F606A31C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wy+MUt2W;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DrOPq8eJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=edaELw1AlTqC7iqRTi5ns1dhzRr1Rv3VqoRIG0vbW60=; b=wy+MUt2WVbPBpL0TSFFg+aNqSs
	Kigi8ebSX2O+t0ur+EE32TbPIIB42dXAvNhGSLwkPFDXWQrQZ8ESOCsAST5QH1MtWxOpgNF9gE7P6
	YwB0ihBYl4Ykk/9f3mYxYIl2lF7lq1i1xt/hDPiFZ+x9yyMh9nUe3Vmn3Hmbe27zY2IXCZd+LLb5O
	TJHCIgc/ajZvcEFwxz+4uHSaGwDMzCtZMtve8OB8gzbf4f6ALJ9w/htetU+n3vHDC2oVtaRGF6mPm
	7KAZs6mT8xEr0PSGye5XgaJ1flGVEQEcI/NA5ymEjnvc0nBcRglb4MB9sh9cr8cpPL2/1lqJoei7I
	n0bniPRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR7cN-00000006hLx-1ei3;
	Wed, 11 Nov 2026 12:39:59 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR7cK-00000006hKZ-3ABt
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 12:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794400791; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=edaELw1AlTqC7iqRTi5ns1dhzRr1Rv3VqoRIG0vbW60=;
	b=DrOPq8eJBopDVX9sZ1TB21Nwe3BIBi+W6pN5OtyQmZVnclHGiYkNTmNa6rzbTkTFQ8PszAMWIjwiHMmmPfxPVYUzHejfwuQ5ZXbAn61EihYf98pI+7fGKwidgTes+G9yTm+MYcvqx7Q9/L7f6h7CnmYssKR9QCsab6t3WVSJ6AA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0XEYtvFV_1794400783;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0XEYtvFV_1794400783 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Nov 2026 20:39:50 +0800
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
Subject: [PATCH] x86/sgx: Skip EPC initialization in the kdump kernel
Date: Wed, 11 Nov 2026 20:39:42 +0800
Message-ID: <20261111123942.3842771-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_043957_159040_F6805BDA 
X-CRM114-Status: GOOD (  10.87  )
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

Reported-by: Challvy Tee <challvy.tee@gmail.com>
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4505f808af5e..5454cd3c976f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*  Copyright(c) 2016-20 Intel Corporation. */
 
+#include <linux/crash_dump.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
 #include <linux/highmem.h>
@@ -1027,6 +1028,10 @@ static int __init sgx_init(void)
 	int ret;
 	int i;
 
+	/* The kdump kernel has no use for SGX.  Skip it. */
+	if (is_kdump_kernel())
+		return -ENODEV;
+
 	if (!cpu_feature_enabled(X86_FEATURE_SGX))
 		return -ENODEV;
 
-- 
2.43.7


