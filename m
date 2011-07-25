Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QlFq8-0002JO-9P
	for kexec@lists.infradead.org; Mon, 25 Jul 2011 07:44:37 +0000
Date: Mon, 25 Jul 2011 17:35:42 +1000
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] kexec-tools: powerpc: dt_reserve doesn't allocate enough
	memory for large properties
Message-ID: <20110725173542.2abe960e@kryten>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org


On a large ppc64 box I got the following error from kexec -l: 

unrecoverable error: could not read "/proc/device-tree/ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory": Bad address

dt_reserve was assuming a property was never larger than
INIT_TREE_WORDS (65536), but on this box ibm,dynamic-memory is
119995 words.

Allocate INIT_TREE_WORDS or the number of words requested, whatever
is larger.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 4400f13..d2b6b18 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -57,9 +57,14 @@ extern int my_debug;
  */
 void dt_reserve(unsigned **dt_ptr, unsigned words)
 {
+	unsigned int sz = INIT_TREE_WORDS;
+
+	if (sz < words)
+		sz = words;
+
 	if (((*dt_ptr - dt_base) + words) >= dt_cur_size) {
 		int offset;
-		unsigned int new_size = dt_cur_size + INIT_TREE_WORDS;
+		unsigned int new_size = dt_cur_size + sz;
 		unsigned *new_dt = realloc(dt_base, new_size*4);
 
 		if (!new_dt)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
