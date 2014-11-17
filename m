Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XqFUc-0006lM-G4
 for kexec@lists.infradead.org; Mon, 17 Nov 2014 06:08:55 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 1/2] makedumpfile: Modify the description of the dump level.
Date: Mon, 17 Nov 2014 06:06:39 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D68867@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "harshula@redhat.com" <harshula@redhat.com>

Hello,

This is a documentation improvement for the thread below:

http://lists.infradead.org/pipermail/kexec/2014-October/012776.html

Any comments are helpful.


Thanks,
Atsushi Kumagai

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Wed, 12 Nov 2014 16:50:04 +0900
Subject: [PATCH 1/2] Modify the description of the dump level.

There are two kinds of dump level related to cache pages as:

  - Exclude cache pages without private flag (level:2)
  - Exclude all cache pages (level:4)

The former excludes only the cache pages which don't have private
flag while the latter excludes all cache pages.

However, the man page occasionally make users misunderstood due to
the incomplete description, so it would be better to add the
description of each base dump level and to unify the expression.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.8 | 26 +++++++++++++++++++++-----
 print_info.c   |  6 +++---
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 5e121fd..68db7e8 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -45,9 +45,9 @@ be excluded.
 .br
 .B \- Pages filled with zero
 .br
-.B \- Cache pages without private pages
+.B \- Cache pages without private flag (non-private cache)
 .br
-.B \- All cache pages with private pages
+.B \- Cache pages with private flag (private cache)
 .br
 .B \- User process data pages
 .br
@@ -164,10 +164,26 @@ by dump_level 11, makedumpfile retries it by dump_level 31.
 # makedumpfile \-d 11 \-x vmlinux /proc/vmcore dumpfile
 .br
 # makedumpfile \-d 11,31 \-x vmlinux /proc/vmcore dumpfile
+.br
+.B Base level:
+.br
+dump_level consists of five bits, so there are five base levels to specify the type of unnecessary page.
+.br
+	\fB 1\fR :	Exclude the pages filled with zero.
+.br
+	\fB 2\fR :	Exclude the non-private cache pages.
+.br
+	\fB 4\fR :	Exclude all cache pages.
+.br
+	\fB 8\fR :	Exclude the user process data pages.
+.br
+	\fB16\fR :	Exclude the free pages.
+
+Here is the all combinations of the bits.
 
-       |      |cache  |cache  |      |
-  dump | zero |without|with   | user | free
- level | page |private|private| data | page
+       |      |non-   |       |      |
+  dump | zero |private|private| user | free
+ level | page |cache  |cache  | data | page
 .br
 \-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-\-+\-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-
      0 |      |       |       |      |
diff --git a/print_info.c b/print_info.c
index efdf578..9215e0f 100644
--- a/print_info.c
+++ b/print_info.c
@@ -116,9 +116,9 @@ print_usage(void)
 	MSG("      The maximum of Dump_Level is 31.\n");
 	MSG("      Note that Dump_Level for Xen dump filtering is 0 or 1 except on x86_64\n");
 	MSG("\n");
-	MSG("            |         cache    cache\n");
-	MSG("      Dump  |  zero   without  with     user    free\n");
-	MSG("      Level |  page   private  private  data    page\n");
+	MSG("            |         non-\n");
+	MSG("      Dump  |  zero   private  private  user    free\n");
+	MSG("      Level |  page   cache    cache    data    page\n");
 	MSG("     -------+---------------------------------------\n");
 	MSG("         0  |\n");
 	MSG("         1  |   X\n");
-- 
1.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
