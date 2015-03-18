Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <64c184a7a1ddaa68607d2e53dac485c0c03c6150.1426719370.git.geoff@infradead.org>
In-Reply-To: <cover.1426719370.git.geoff@infradead.org>
References: <cover.1426719370.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/4] purgatory: Generate symbol file
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

To aid in debugging purgatory update its makefile to generate a
stand alone symbol file that can me loaded by a debugger.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 purgatory/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 1c7d2c0..6b17e71 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -63,10 +63,9 @@ $(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
 
 $(PURGATORY): $(PURGATORY_OBJS)
 	$(MKDIR) -p $(@D)
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
-
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@.sym $^
 #	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
-	$(STRIP) --strip-debug $@
+	$(STRIP) --strip-debug -o $@ $@.sym
 
 echo::
 	@echo "PURGATORY_SRCS $(PURGATORY_SRCS)"
-- 
2.1.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
