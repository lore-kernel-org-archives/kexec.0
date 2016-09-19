Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1blpm2-0001fK-Kd
 for kexec@lists.infradead.org; Mon, 19 Sep 2016 04:01:43 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v10 3/3] Documentation: kdump: add description of enable
 multi-cpus support
Date: Mon, 19 Sep 2016 12:01:05 +0800
Message-Id: <1474257665-8838-4-git-send-email-bhe@redhat.com>
In-Reply-To: <1474257665-8838-1-git-send-email-bhe@redhat.com>
References: <1474257665-8838-1-git-send-email-bhe@redhat.com>
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
To: corbet@lwn.net, akpm@linux-foundation.org
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>, xlpang@redhat.com, linux-kernel@vger.kernel.org, dyoung@redhat.com

From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>

Multi-cpu support is useful to improve the performance of kdump in
some cases. So add the description of enable multi-cpu support in
dump-capture kernel.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Xunlei Pang <xpang@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/kdump/kdump.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index f7ef340..b0eb27b 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -396,6 +396,13 @@ Notes on loading the dump-capture kernel:
   Note, though maxcpus always works, you had better replace it with
   nr_cpus to save memory if supported by the current ARCH, such as x86.
 
+* You should enable multi-cpu support in dump-capture kernel if you intend
+  to use multi-thread programs with it, such as parallel dump feature of
+  makedumpfile. Otherwise, the multi-thread program may have a great
+  performance degradation. To enable multi-cpu support, you should bring up an
+  SMP dump-capture kernel and specify maxcpus/nr_cpus, disable_cpu_apicid=[X]
+  options while loading it.
+
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
   is done on all other architectures. If no elfcorehdr= kernel parameter is
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
