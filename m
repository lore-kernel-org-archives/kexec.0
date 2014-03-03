Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ernst.netinsight.se ([194.16.221.21])
 by merlin.infradead.org with smtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKRcP-0005T2-5y
 for kexec@lists.infradead.org; Mon, 03 Mar 2014 12:05:13 +0000
Date: Mon, 3 Mar 2014 13:04:49 +0100
From: Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?= <simon.kagstrom@netinsight.net>
Subject: [PATCH 1/4] build: Derive objects from source files
Message-ID: <20140303130449.2da76bdb@marrow.netinsight.se>
In-Reply-To: <20140303130213.1d441d32@marrow.netinsight.se>
References: <20140303130213.1d441d32@marrow.netinsight.se>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
 Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f20c118..d660951 100644
--- a/Makefile
+++ b/Makefile
@@ -41,9 +41,9 @@ endif
 
 SRC	= makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
 SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c
-OBJ_PART = print_info.o dwarf_info.o elf_info.o erase_info.o sadump_info.o cache.o
+OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c
-OBJ_ARCH = arch/arm.o arch/x86.o arch/x86_64.o arch/ia64.o arch/ppc64.o arch/s390x.o arch/ppc.o
+OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
 
 LIBS = -ldw -lbz2 -lebl -ldl -lelf -lz
 ifneq ($(LINKTYPE), dynamic)
-- 
1.7.9.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
