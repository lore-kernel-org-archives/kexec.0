Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zn7-0002Lq-HH
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:07:54 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U87pFn011012
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:07:51 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U87pA03804 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:07:51 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U87owD015838
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:07:51 +0900 (JST)
Date: Thu, 30 Aug 2012 16:58:55 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 14/16] [PATCH] Update necessary elfutils version.
Message-Id: <20120830165855.441384809f2c2a149dcd8501@mxc.nes.nec.co.jp>
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
Date: Thu, 30 Aug 2012 11:28:36 +0900
Subject: [PATCH 14/16] [PATCH] Update necessary elfutils version.

For some vmlinux, -g option needs new elfutils(0.142 or later).
Therefore, this patch updates the version in README file.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 README |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 7ae3872..caebc3c 100644
--- a/README
+++ b/README
@@ -6,13 +6,13 @@
 * REQUIREMENTS
   Please download the following library file and install it exactly as below;
   do NOT use "make install".
-  - elfutils-0.137.tar.gz
+  - elfutils-0.142.tar.gz
     The "make install" of elfutils installs some commands (ld, readelf, etc.),
     and compiling problems sometimes happen due to using the installed
     commands. To install only the library & header files, use the following
     method:
-     # tar -zxvf elfutils-0.137.tar.gz
-     # cd elfutils-0.137
+     # tar -zxvf elfutils-0.142.tar.gz
+     # cd elfutils-0.142
      # ./configure
      # make
      #
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
