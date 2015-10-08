Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1444346484.29301.81.camel@infradead.org>
Subject: [PATCH 2/2] util_lib: Silence ar informational message
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 08 Oct 2015 16:21:24 -0700
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Add the -c option to ar to silence the informational
message 'ar creating libutil.a'.  ar outputs this
message to stderr, and some tools interpret this as
a build warning.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 util_lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util_lib/Makefile b/util_lib/Makefile
index 54ccdc5..15b84e5 100644
--- a/util_lib/Makefile
+++ b/util_lib/Makefile
@@ -18,5 +18,5 @@ $(UTIL_LIB): CPPFLAGS += -I$(srcdir)/util_lib/include
 
 $(UTIL_LIB): $(UTIL_LIB_OBJS)
 	@$(MKDIR) -p $(@D)
-	$(AR) rs $(UTIL_LIB) $(UTIL_LIB_OBJS)
+	$(AR) rs -c $(UTIL_LIB) $(UTIL_LIB_OBJS)
 
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
