Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <69be4da0495fc4331ae63e39ddd16c3b7e5513ec.1426719370.git.geoff@infradead.org>
In-Reply-To: <cover.1426719370.git.geoff@infradead.org>
References: <cover.1426719370.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/4] purgatory: Generate map file
Date: Wed, 18 Mar 2015 23:04:03 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

To aid in debugging purgatory and its relocation generate a linker map
file when purgatory is built.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 purgatory/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 6b17e71..2d6b2c0 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -12,6 +12,7 @@ PURGATORY_SRCS =
 PURGATORY_SRCS += purgatory/purgatory.c
 PURGATORY_SRCS += purgatory/printf.c
 PURGATORY_SRCS += purgatory/string.c
+PURGATORY_MAP = purgatory/purgatory.map
 
 dist += purgatory/Makefile $(PURGATORY_SRCS)				\
 	purgatory/include/purgatory.h purgatory/include/string.h
@@ -59,7 +60,8 @@ $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(shell $(CC) -print-file-name=include)
 $(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
 			-Wl,--no-undefined -nostartfiles -nostdlib \
-			-nodefaultlibs -e purgatory_start -r
+			-nodefaultlibs -e purgatory_start -r \
+			-Wl,-Map=$(PURGATORY_MAP)
 
 $(PURGATORY): $(PURGATORY_OBJS)
 	$(MKDIR) -p $(@D)
-- 
2.1.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
