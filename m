Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VEnuh-0002Av-Eu
 for kexec@lists.infradead.org; Wed, 28 Aug 2013 22:08:32 +0000
Subject: [PATCH] makedumpfile: show needed memory
Message-Id: <E1VEnuJ-0000KK-Qu@eag09.americas.sgi.com>
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

If there is not enough memory available to run in cyclic mode display
how much more would be needed to do so.

Diffed against makedumpfile-1.5.4
Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 makedumpfile.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: makedumpfile-1.5.4/makedumpfile.c
===================================================================
--- makedumpfile-1.5.4.orig/makedumpfile.c
+++ makedumpfile-1.5.4/makedumpfile.c
@@ -7778,11 +7778,15 @@ plenty_of_memory(void)
 {
 	unsigned long free_size;
 	unsigned long needed_size;
+	long slack = 10; /* 10M extra */
+	long meg = 1024*1024;
 
 	free_size = get_free_memory_size();
-	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
-	if (free_size > (needed_size + (10*1024*1024)))
+	needed_size = ((info->max_mapnr * 2) / BITPERBYTE) + (slack * meg);
+	if (free_size > needed_size)
 		return 1;
+	PROGRESS_MSG("Need %ldM more memory to use noncyclic mode.\n",
+		(needed_size - free_size)/meg);
 	return 0;
 }
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
