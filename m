Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEnuh-0002Ay-LY
 for kexec@lists.infradead.org; Wed, 28 Aug 2013 22:08:33 +0000
Subject: [PATCH] makedumpfile: use non-cyclic when possible
Message-Id: <E1VEnuJ-0000Jz-JI@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 28 Aug 2013 17:08:07 -0500
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
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>

If there is plenty of memory use non-cyclic mode.

Diffed against makedumpfile-1.5.4
Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |   26 ++++++++++++++++++++++++++

Index: makedumpfile-1.5.4/makedumpfile.c
===================================================================
--- makedumpfile-1.5.4.orig/makedumpfile.c
+++ makedumpfile-1.5.4/makedumpfile.c
@@ -7638,6 +7638,23 @@ writeout_multiple_dumpfiles(void)
 	return ret;
 }
 
+/*
+ * Plenty of memory to do a non-cyclic dump.
+ * Default to non-cyclic in this case.
+ */
+static int
+plenty_of_memory(void)
+{
+	unsigned long free_size;
+	unsigned long needed_size;
+
+	free_size = get_free_memory_size();
+	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
+	if (free_size > (needed_size + (10*1024*1024)))
+		return 1;
+	return 0;
+}
+
 int
 create_dumpfile(void)
 {
@@ -7655,6 +7672,15 @@ create_dumpfile(void)
 
 	print_vtop();
 
+	if (plenty_of_memory()) {
+		if (info->flag_cyclic == TRUE)
+			MSG("Plenty of memory; using non-cyclic mode.\n");
+		info->flag_cyclic = FALSE;
+	} else {
+		if (info->flag_cyclic == TRUE)
+			MSG("Restricted memory; staying in cyclic mode.\n");
+	}
+
 	num_retry = 0;
 retry:
 	if (info->flag_refiltering) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
