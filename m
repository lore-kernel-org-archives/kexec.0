Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417A7C3DA59
	for <kexec@archiver.kernel.org>; Fri, 19 Jul 2024 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AUlrqSNXa8G0yjpvqM55qybZwVE9NHQPtDJcCiSEQ8Q=; b=WxoTcF3WR4UQ9F
	ued9Jc9LfwrqPbPKB0fVR6NX9o7YwZUfN0KqikDnCdS9prnQmWIdg/6BGbbp5Dn4SUwh5NzOuK3mS
	fd5VyCxWD4joFVbVQwTTLAgNwolkdkKHrDFCkTKHBJkwINTax07Kz1p06wr6mhArbn9VkcFWBQxf2
	TxRXE1ot5TbwMv8j1uf9hzS3AeuYpHumrf1ANF3TGdhbjfTwVAetALlNov/Y0BBabMx5w+FEcAODI
	77SsNYlqqemIMOT075Iyr+zW7VrF/4f47Y16cgJ1vcKQbknbw3N/vVOcsxIDBjxby6aeIywNg9PSs
	/Zg+iJDa85YXVMssImPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUrrN-00000003R2g-3mte;
	Fri, 19 Jul 2024 17:57:37 +0000
Received: from smtpfb2-g21.free.fr ([212.27.42.10])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUrr3-00000003QqZ-3wVg
	for kexec@lists.infradead.org;
	Fri, 19 Jul 2024 17:57:35 +0000
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 61D42428659
	for <kexec@lists.infradead.org>; Fri, 19 Jul 2024 19:54:49 +0200 (CEST)
Received: from home.juju.sh (unknown [IPv6:2a01:e0a:485:b220:8213:2270:4a8d:a1d5])
	(Authenticated sender: ju.o@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2CC08B00576;
	Fri, 19 Jul 2024 19:47:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721411281;
	bh=YsZv0PdOr5doc4+GaxNDYZzCJd2aAnUYvvImiOxMGYA=;
	h=From:To:Cc:Subject:Date:From;
	b=vautQaFQ5hN2JriFlKQCZDVmeIqyESKLMVZa7zezDStRYXAALH4lnfXz7MLlA4boq
	 cvUTo8+wFRrT5n2WsmUWrh8tQbgBeLVX8ov0HoT0jDT/zJYOhBqUexYEEXssSzhn/v
	 omZ7ipRH0lIeW3ZtlmAMdy0amN9pXOp0yO4hZP1QqI0dcY0s0/JT03UMTJX0HbE7vM
	 mJZsAl7dLNH9Nre9HWbXW/mUXfD0dGLD86vu8Ggiq+zidiQvuaS4mhpQDJIK9JaTmX
	 VkSRgwuCcY6vsHqunJLF1Sel08mkU/d0K4jpJwK8Iyvgyvdwn2TJf6cI9A8uh4HmoU
	 ENqXGpAdJsG7w==
From: Julien Olivain <ju.o@free.fr>
To: kexec@lists.infradead.org
Cc: Julien Olivain <ju.o@free.fr>
Subject: [PATCH 1/1] s390: add missing limits.h header inclusion
Date: Fri, 19 Jul 2024 19:47:44 +0200
Message-ID: <20240719174744.549913-1-ju.o@free.fr>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_105718_952104_1EA118E0 
X-CRM114-Status: GOOD (  10.87  )
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

Commit b84fcdd48c [1] introduced a usage of PATH_MAX in file
"kexec-s390.c". This constant is defined in the <limits.h> header.
See [2].

With some libc, such as musl, kexec-tools fails to build with output:

    kexec/arch/s390/kexec-s390.c: In function 'remove_offline_memory':
    kexec/arch/s390/kexec-s390.c:120:19: error: 'PATH_MAX' undeclared (first use in this function)
      120 |         char path[PATH_MAX];
          |                   ^~~~~~~~

The issue can be reproduced, for example, with Buildroot Linux, using
a s390 gcc toolchain with the musl libc and the following commands:

    git clone -b 2024.05.1 --depth 1 https://gitlab.com/buildroot.org/buildroot.git
    cd buildroot
    cat > .config <<EOF
    BR2_s390x=y
    BR2_TOOLCHAIN_BUILDROOT_MUSL=y
    BR2_PACKAGE_KEXEC=y
    EOF
    make olddefconfig
    make

Note: in this test, kexec-tools v2.0.28 is used.

This commit fixes the issue by adding the missing header inclusion.

[1] https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=b84fcdd48cbe70e54e66f2cf1b251e0db58f04f4
[2] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/limits.h.html

Signed-off-by: Julien Olivain <ju.o@free.fr>
---
 kexec/arch/s390/kexec-s390.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index f4dd7dc..ad3eb93 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
