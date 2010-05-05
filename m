From: Simon Horman <horms@verge.net.au>
Date: Wed, 5 May 2010 13:33:21 +1000
Subject: [PATCH] build: Don't modify CFLAGS in kexec/arch/mips/Makefile
Message-ID: <mailman.356.1273030777.2170.kexec@lists.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Revert this portion of recent MIPS changes as it actually effects the
CFLAGS for all architectures.  Moreover I'm somewhat dubious about
defaulting to -Werror for any architecture.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/mips/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
index 831b263..03bdb9a 100644
--- a/kexec/arch/mips/Makefile
+++ b/kexec/arch/mips/Makefile
@@ -14,5 +14,3 @@ dist += kexec/arch/mips/Makefile $(mips_KEXEC_SRCS)			\
 	kexec/arch/mips/kexec-mips.h					\
 	kexec/arch/mips/crashdump-mips.h				\
 	kexec/arch/mips/include/arch/options.h
-
-CFLAGS +=-Wall -Werror
-- 
1.7.1


