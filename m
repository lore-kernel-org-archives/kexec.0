Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <6859689cd7561950eda3a0fef52a2eedd22c14fb.1426719370.git.geoff@infradead.org>
In-Reply-To: <cover.1426719370.git.geoff@infradead.org>
References: <cover.1426719370.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 4/4] purgatory: Add printf type checking
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

To better catch coding problems add stricter type checking to the
purgatory printf routines.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 purgatory/include/purgatory.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/purgatory/include/purgatory.h b/purgatory/include/purgatory.h
index ed50dc4..788ce49 100644
--- a/purgatory/include/purgatory.h
+++ b/purgatory/include/purgatory.h
@@ -2,8 +2,9 @@
 #define PURGATORY_H
 
 void putchar(int ch);
-void sprintf(char *buffer, const char *fmt, ...);
-void printf(const char *fmt, ...);
+void sprintf(char *buffer, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+void printf(const char *fmt, ...) __attribute__ ((format (printf, 1, 2)));
 void setup_arch(void);
 void post_verification_setup_arch(void);
 
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
