Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV7Sr-0007PR-U6
 for kexec@lists.infradead.org; Thu, 14 Nov 2019 05:14:44 +0000
Received: by mail-pf1-x442.google.com with SMTP id b19so3333918pfd.3
 for <kexec@lists.infradead.org>; Wed, 13 Nov 2019 21:14:41 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 1/3] libfdt: define UINT32_MAX in libfdt_env.h
Date: Thu, 14 Nov 2019 14:15:08 +0900
Message-Id: <20191114051510.17037-2-takahiro.akashi@linaro.org>
In-Reply-To: <20191114051510.17037-1-takahiro.akashi@linaro.org>
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com
Cc: kexec@lists.infradead.org, james.morse@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

In the implementation of kexec_file_load-based kdump for arm64,
fdt_appendprop_addrrange() will be used, but fdt_addresses.c
will fail to compile due to missing UINT32_MAX.

So just define it in libfdt_env.h.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 include/linux/libfdt_env.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index edb0f0c30904..9ca00f11d9b1 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -3,6 +3,7 @@
 #define LIBFDT_ENV_H
 
 #include <linux/kernel.h>	/* For INT_MAX */
+#include <linux/limits.h>	/* For UINT32_MAX */
 #include <linux/string.h>
 
 #include <asm/byteorder.h>
@@ -11,6 +12,8 @@ typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
 typedef __be64 fdt64_t;
 
+#define UINT32_MAX U32_MAX
+
 #define fdt32_to_cpu(x) be32_to_cpu(x)
 #define cpu_to_fdt32(x) cpu_to_be32(x)
 #define fdt64_to_cpu(x) be64_to_cpu(x)
-- 
2.21.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
