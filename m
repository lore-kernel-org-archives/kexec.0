Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22a.google.com ([2607:f8b0:400e:c03::22a])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zb1Vj-0003Pq-LB
 for kexec@lists.infradead.org; Sun, 13 Sep 2015 07:15:40 +0000
Received: by padhk3 with SMTP id hk3so113118069pad.3
 for <kexec@lists.infradead.org>; Sun, 13 Sep 2015 00:15:18 -0700 (PDT)
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH] kexec: Add prefix "kexec" to output message
Date: Sun, 13 Sep 2015 15:15:12 +0800
Message-Id: <1442128512-32578-1-git-send-email-mnfhuang@gmail.com>
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
To: akpm@linux-foundation.org, dyoung@redhat.com, ebiederm@xmission.com
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

kexec output message misses the prefix "kexec", when Dave Young split
the kexec code. To keep the same format, add the prefix "kexec" to
output message.

Following is the format of output message now.
[  140.290795] SYSC_kexec_load: hello, world

Ideally, the format of output message likes below.
[  140.291534] kexec: sanity_check_segment_list: hello, world

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
 kernel/kexec.c      | 2 ++
 kernel/kexec_file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 4c5edc3..15351ba 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -6,6 +6,8 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#define pr_fmt(fmt)	"kexec: " fmt
+
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 6a9a3f2..b1ad01b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -9,6 +9,8 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#define pr_fmt(fmt)	"kexec: " fmt
+
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
-- 
2.4.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
