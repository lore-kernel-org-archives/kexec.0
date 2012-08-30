Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zpF-0002Ux-Oh
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:10:06 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U8A3Vc020077
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:10:03 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U8A3u07477 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:10:03 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U8A3NT017247
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:10:03 +0900 (JST)
Date: Thu, 30 Aug 2012 17:00:04 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 15/16] [PATCH] Support newer kernels.
Message-Id: <20120830170004.b5c417c8c6799f65dad46cec@mxc.nes.nec.co.jp>
In-Reply-To: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 30 Aug 2012 11:28:46 +0900
Subject: [PATCH 15/16] [PATCH] Support newer kernels.

A new makedumpfile supports newer kernels:

      - 3.2 to 3.4    (x86 FLATMEM)
      - 3.2 to 3.4    (x86 SPARSEMEM)
      - 3.2 to 3.4    (x86_64 SPARSEMEM)

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 README         |    2 ++
 makedumpfile.h |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/README b/README
index caebc3c..8a8aa7f 100644
--- a/README
+++ b/README
@@ -83,6 +83,8 @@
   3.0    | OK | ** |    |    |    | ** |    | -- | OK | OK |    |    |
   3.1    | OK | ** |    |    |    | ** |    | -- | OK | OK |    |    |
   3.2    | OK | ** | OK |    |    | ** |    | -- | OK | OK |    |    |
+  3.3    | OK | ** |    |    |    | ** |    | -- | OK | OK |    |    |
+  3.4    | OK | ** |    |    |    | ** |    | -- | OK | OK |    |    |
 
   OK    : Support.
   --    : Not support.
diff --git a/makedumpfile.h b/makedumpfile.h
index 7f5e1c6..2b88fa4 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -382,7 +382,7 @@ do { \
 #define KVER_MIN_SHIFT 16
 #define KERNEL_VERSION(x,y,z) (((x) << KVER_MAJ_SHIFT) | ((y) << KVER_MIN_SHIFT) | (z))
 #define OLDEST_VERSION		KERNEL_VERSION(2, 6, 15)/* linux-2.6.15 */
-#define LATEST_VERSION		KERNEL_VERSION(3, 2, 16)/* linux-3.2.16 */
+#define LATEST_VERSION		KERNEL_VERSION(3, 4, 8)/* linux-3.4.8 */
 
 /*
  * vmcoreinfo in /proc/vmcore
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
