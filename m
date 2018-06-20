Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVZnA-0000Fj-LR
 for kexec@lists.infradead.org; Wed, 20 Jun 2018 09:52:46 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 2/2] makedumpfile: Check if clock_gettime() requires -lrt
Date: Wed, 20 Jun 2018 11:50:19 +0200
Message-Id: <20180620095019.18449-2-ptesarik@suse.com>
In-Reply-To: <20180620095019.18449-1-ptesarik@suse.com>
References: <20180620095019.18449-1-ptesarik@suse.com>
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
To: lijiang <lijiang@redhat.com>, kexec-ml <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.com>

For glibc versions before 2.17, clock_gettime() was contained in a
separate library and required linking with -lrt.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Makefile b/Makefile
index e870b13..9c24387 100644
--- a/Makefile
+++ b/Makefile
@@ -68,6 +68,18 @@ endif
 
 LIBS := -lpthread $(LIBS)
 
+try-run = $(shell set -e;		\
+	TMP=".$$$$.tmp";		\
+	if ($(1)) >/dev/null 2>&1;	\
+	then echo "$(2)";		\
+	else echo "$(3)";		\
+	fi;				\
+	rm -f "$$TMP")
+
+LINK_TEST_PROG="int clock_gettime(); int main(){ return clock_gettime(); }"
+LIBS := $(LIBS) $(call try-run,\
+	echo $(LINK_TEST_PROG) | $(CC) $(CFLAGS) -o "$$TMP" -x c -,,-lrt)
+
 all: makedumpfile
 
 $(OBJ_PART): $(SRC_PART)
-- 
2.16.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
