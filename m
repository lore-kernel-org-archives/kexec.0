Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eybuw-0007cM-6I
 for kexec@lists.infradead.org; Wed, 21 Mar 2018 11:28:32 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LBNWc8107204
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:16 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gup6ch17v-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:15 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 11:28:12 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH v2 11/11] kexec_file: Move purgatories sha256 to common code
Date: Wed, 21 Mar 2018 12:27:51 +0100
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180321112751.22196-12-prudo@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

The code to verify the new kernels sha digest is applicable for all
architectures. Move it to common code.

One problem is the string.c implementation on x86. Currently sha256
includes x86/boot/string.h which defines memcpy and memset to be gcc
builtins. By moving the sha256 implementation to common code and changing
the include to linux/string.h both functions are no longer defined. Thus
definitions have to be provided in x86/purgatory/string.c

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/x86/purgatory/Makefile                    |  3 +++
 arch/x86/purgatory/purgatory.c                 |  2 +-
 arch/x86/purgatory/string.c                    | 12 ++++++++++++
 {arch/x86/purgatory => include/linux}/sha256.h | 11 ++++++++++-
 {arch/x86/purgatory => lib}/sha256.c           |  4 ++--
 5 files changed, 28 insertions(+), 4 deletions(-)
 rename {arch/x86/purgatory => include/linux}/sha256.h (62%)
 rename {arch/x86/purgatory => lib}/sha256.c (99%)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 2f15a2ac4209..414eed6b5065 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -6,6 +6,9 @@ purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
+$(obj)/sha256.o: $(srctree)/lib/sha256.c
+	$(call if_changed_rule,cc_o_c)
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 470edad96bb9..025c34ac0d84 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -11,9 +11,9 @@
  */
 
 #include <linux/bug.h>
+#include <linux/sha256.h>
 #include <asm/purgatory.h>
 
-#include "sha256.h"
 #include "../boot/string.h"
 
 unsigned long purgatory_backup_dest __section(.kexec-purgatory);
diff --git a/arch/x86/purgatory/string.c b/arch/x86/purgatory/string.c
index d886b1fa36f0..795ca4f2cb3c 100644
--- a/arch/x86/purgatory/string.c
+++ b/arch/x86/purgatory/string.c
@@ -10,4 +10,16 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#include <linux/types.h>
+
 #include "../boot/string.c"
+
+void *memcpy(void *dst, const void *src, size_t len)
+{
+	return __builtin_memcpy(dst, src, len);
+}
+
+void *memset(void *dst, int c, size_t len)
+{
+	return __builtin_memset(dst, c, len);
+}
diff --git a/arch/x86/purgatory/sha256.h b/include/linux/sha256.h
similarity index 62%
rename from arch/x86/purgatory/sha256.h
rename to include/linux/sha256.h
index 2867d9825a57..244fe01a65fb 100644
--- a/arch/x86/purgatory/sha256.h
+++ b/include/linux/sha256.h
@@ -13,9 +13,18 @@
 #include <linux/types.h>
 #include <crypto/sha.h>
 
+/*
+ * Stand-alone implementation of the SHA256 algorithm. It is designed to
+ * have as little dependencies as possible so it can be used in the
+ * kexec_file purgatory. In other cases you should use the implementation in
+ * crypto/.
+ *
+ * For details see lib/sha256.c
+ */
+
 extern int sha256_init(struct sha256_state *sctx);
 extern int sha256_update(struct sha256_state *sctx, const u8 *input,
-				unsigned int length);
+			 unsigned int length);
 extern int sha256_final(struct sha256_state *sctx, u8 *hash);
 
 #endif /* SHA256_H */
diff --git a/arch/x86/purgatory/sha256.c b/lib/sha256.c
similarity index 99%
rename from arch/x86/purgatory/sha256.c
rename to lib/sha256.c
index 548ca675a14a..4400c832e2aa 100644
--- a/arch/x86/purgatory/sha256.c
+++ b/lib/sha256.c
@@ -16,9 +16,9 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/sha256.h>
+#include <linux/string.h>
 #include <asm/byteorder.h>
-#include "sha256.h"
-#include "../boot/string.h"
 
 static inline u32 Ch(u32 x, u32 y, u32 z)
 {
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
