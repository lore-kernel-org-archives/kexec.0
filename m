Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xdvrh-0001Hs-Q3
 for kexec@lists.infradead.org; Tue, 14 Oct 2014 06:45:50 +0000
Message-ID: <1413269123.514.72.camel@serendib>
Subject: [PATCH] makedumpfile.8: "cache without private" column of the table
 for -d appears to be incorrect
From: Harshula Jayasuriya <harshula@redhat.com>
Date: Tue, 14 Oct 2014 17:45:23 +1100
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
To: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Minoru Usui <usui@mxm.nes.nec.co.jp>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

Hi,

The makedumpfile man page contains a table explaining the usage of -d.
The "cache without private" column implies that -d 4 would exclude "cache
without private" pages. However, a -d 4 should only exclude "cache with
private".

makedumpfile.h:
------------------------------------------------------------
 #define DL_EXCLUDE_CACHE        (0x002) /* Exclude Cache Pages
                                            without Private Pages */
------------------------------------------------------------

makedumpfile.8:
------------------------------------------------------------
                     |      |cache  |cache  |      |
                dump | zero |without|with   | user | free
               level | page |private|private| data | page
              -------+------+-------+-------+------+------
                   0 |      |       |       |      |
                   1 |  X   |       |       |      |
                   2 |      |   X   |       |      |
                   3 |  X   |   X   |       |      |
                   4 |      |   X   |   X   |      |
                   5 |  X   |   X   |   X   |      |
                   6 |      |   X   |   X   |      |
                   7 |  X   |   X   |   X   |      |
                   8 |      |       |       |  X   |
------------------------------------------------------------

Signed-off-by: Harshula Jayasuriya <harshula@redhat.com>
---
 makedumpfile.8 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 9cb12c0..382c6ee 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -174,32 +174,32 @@ by dump_level 11, makedumpfile retries it by dump_level 31.
      1 |  X   |       |       |      |
      2 |      |   X   |       |      |
      3 |  X   |   X   |       |      |
-     4 |      |   X   |   X   |      |
-     5 |  X   |   X   |   X   |      |
+     4 |      |       |   X   |      |
+     5 |  X   |       |   X   |      |
      6 |      |   X   |   X   |      |
      7 |  X   |   X   |   X   |      |
      8 |      |       |       |  X   |
      9 |  X   |       |       |  X   |
     10 |      |   X   |       |  X   |
     11 |  X   |   X   |       |  X   |
-    12 |      |   X   |   X   |  X   |
-    13 |  X   |   X   |   X   |  X   |
+    12 |      |       |   X   |  X   |
+    13 |  X   |       |   X   |  X   |
     14 |      |   X   |   X   |  X   |
     15 |  X   |   X   |   X   |  X   |
     16 |      |       |       |      |  X
     17 |  X   |       |       |      |  X
     18 |      |   X   |       |      |  X
     19 |  X   |   X   |       |      |  X
-    20 |      |   X   |   X   |      |  X
-    21 |  X   |   X   |   X   |      |  X
+    20 |      |       |   X   |      |  X
+    21 |  X   |       |   X   |      |  X
     22 |      |   X   |   X   |      |  X
     23 |  X   |   X   |   X   |      |  X
     24 |      |       |       |  X   |  X
     25 |  X   |       |       |  X   |  X
     26 |      |   X   |       |  X   |  X
     27 |  X   |   X   |       |  X   |  X
-    28 |      |   X   |   X   |  X   |  X
-    29 |  X   |   X   |   X   |  X   |  X
+    28 |      |       |   X   |  X   |  X
+    29 |  X   |       |   X   |  X   |  X
     30 |      |   X   |   X   |  X   |  X
     31 |  X   |   X   |   X   |  X   |  X
 
-- 
1.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
