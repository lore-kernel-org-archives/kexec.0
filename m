Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <ed987a299e11958861deb96beec0f02eebcaa646.1380746425.git.geoff@infradead.org>
In-Reply-To: <cover.1380746425.git.geoff@infradead.org>
References: <cover.1380746425.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/6] kexec: Fix the -? option
Date: Wed, 02 Oct 2013 20:49:46 +0000
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Add '?' to the short option string.  Fixes runtime errors like
these:

  kexec: invalid option -- '?'

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 kexec/kexec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index 715b568..2904e03 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -230,7 +230,7 @@ extern int file_types;
 	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 
-#define KEXEC_OPT_STR "hvdfxluet:p"
+#define KEXEC_OPT_STR "h?vdfxluet:p"
 
 extern void die(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
-- 
1.8.1.2



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
