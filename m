Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bSyQ1-00040r-SS
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 03:25:02 +0000
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] Documentation: kdump: update maxcpus to nr_cpus
Date: Fri, 29 Jul 2016 11:23:14 +0800
Message-ID: <1469762595-1085-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, bhe@redhat.com

Parameter nr_cpus is used to bring up a SMP dump-capture kernel,
instead of the old parameter maxcpus. This commit update it in
Documentation/kdump/kdump.txt.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 Documentation/kdump/kdump.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 88ff63d..9a77247 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -392,7 +392,7 @@ Notes on loading the dump-capture kernel:
 
 * We generally don' have to bring up a SMP kernel just to capture the
   dump. Hence generally it is useful either to build a UP dump-capture
-  kernel or specify maxcpus=1 option while loading dump-capture kernel.
+  kernel or specify nr_cpus=1 option while loading dump-capture kernel.
 
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
