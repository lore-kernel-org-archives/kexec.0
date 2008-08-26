Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXwSl-00071v-V2
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 11:11:52 +0000
Received: by rv-out-0708.google.com with SMTP id b17so1911060rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 04:11:51 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2008 20:12:04 +0900
Message-Id: <20080826111204.615.30390.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
Subject: [PATCH 02/06] sh: Get system memory ranges from /proc/iomem
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Parse contents of /proc/iomem instead of hardcoding RAM ranges.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/kexec-sh.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- 0002/kexec/arch/sh/kexec-sh.c
+++ work/kexec/arch/sh/kexec-sh.c	2008-08-22 10:53:15.000000000 +0900
@@ -22,19 +22,31 @@
 #define MAX_MEMORY_RANGES 64
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
+static int kexec_sh_memory_range_callback(void *data, int nr,
+					  char *str,
+					  unsigned long base,
+					  unsigned long length)
+{
+	if (nr < MAX_MEMORY_RANGES) {
+		memory_range[nr].start = base;
+		memory_range[nr].end = base + length - 1;
+		memory_range[nr].type = RANGE_RAM;
+		return 0;
+	}
+
+	return 1;
+}
+
 /* Return a sorted list of available memory ranges. */
 int get_memory_ranges(struct memory_range **range, int *ranges,
 		      unsigned long kexec_flags)
 {
-	int memory_ranges;
+	int nr;
 
-	memory_ranges = 0;
-	memory_range[memory_ranges].start = 0x08000000;
-	memory_range[memory_ranges].end   = 0x10000000;
-	memory_range[memory_ranges].type  = RANGE_RAM;
-	memory_ranges++;
+	nr = kexec_iomem_for_each_line("System RAM\n",
+				       kexec_sh_memory_range_callback, NULL);
 	*range = memory_range;
-	*ranges = memory_ranges;
+	*ranges = nr;
 	return 0;
 }
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
