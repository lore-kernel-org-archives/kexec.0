Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bU13S-0003mO-13
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 00:26:04 +0000
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v2] Documentation: kdump: add description of bringing up SMP
 dump-capture kernel
Date: Mon, 1 Aug 2016 08:23:08 +0800
Message-ID: <1470010988-18050-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

v1->v2: change nr_cpus to maxcpus

SMP dump-capture kernel is useful to improve the performance of kdump in
some cases. So add the description of bringing up SMP dump-capture kernel.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 Documentation/kdump/kdump.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 88ff63d..c5762b7 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -394,6 +394,12 @@ Notes on loading the dump-capture kernel:
   dump. Hence generally it is useful either to build a UP dump-capture
   kernel or specify maxcpus=1 option while loading dump-capture kernel.
 
+* We should bring up a SMP dump-capture kernel if we intend to use multi-threads
+  programs with it, such as parallel dump feature of makedumpfile. Otherwise,
+  the multi-threads program may have a great performance degradation.
+  To bring up a SMP dump-capture kernel, we should specify maxcpus=[X] and
+  disable_cpu_apic=[Y] options while loading it.
+
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
   is done on all other architectures. If no elfcorehdr= kernel parameter is
-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
