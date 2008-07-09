Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGY8q-000443-3k
	for kexec@lists.infradead.org; Wed, 09 Jul 2008 11:47:24 +0000
Date: Wed, 9 Jul 2008 13:48:01 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] makedumpfile: Improve error handing when SIZE(nodemask_t)
	is undefined
Message-ID: <20080709134801.149fbdb4@halley.suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

Hi,

I accidentally used a new makedumpfile with an old VMCOREINFO that did
not contain the SIZE(nodemask_t). Then len was -1, and malloc(-1)
failed. Which looked like memory was too low.

This patch just improves the error message in that case so that the
user knows what is wrong.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 makedumpfile.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -u -r1.7.2.37 makedumpfile.c
--- makedumpfile.c	9 Jul 2008 00:22:09 -0000	1.7.2.37
+++ makedumpfile.c	9 Jul 2008 11:39:43 -0000
@@ -2580,6 +2580,11 @@
 	    && (SYMBOL(node_states) == NOT_FOUND_SYMBOL))
 		return 0;

+	if (SIZE(nodemask_t) == NOT_FOUND_LONG_VALUE) {
+		ERRMSG("SIZE(nodemask_t) undefined.\n");
+		return 0;
+	}
+
 	len = SIZE(nodemask_t);
 	vt.node_online_map_len = len/sizeof(unsigned long);
 	if (!(vt.node_online_map = (unsigned long *)malloc(len))) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
