Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1baCV3-0006LV-Nd
 for kexec@lists.infradead.org; Thu, 18 Aug 2016 01:52:06 +0000
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v7 2/2] Documentation: kdump: add description of enable
 multi-cpus support
Date: Thu, 18 Aug 2016 09:50:11 +0800
Message-ID: <1471485011-19035-3-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1471485011-19035-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1471485011-19035-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: bhe@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org, kexec@lists.infradead.org, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

multi-cpu support is useful to improve the performance of kdump in
some cases. So add the description of enable multi-cpu support in
dump-capture kernel.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/kdump/kdump.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 96da2b7..c93a6e0 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -396,6 +396,13 @@ Notes on loading the dump-capture kernel:
   Note, though maxcpus always works, you should replace it by nr_cpus to
   save memory if supported by the current ARCH, such as x86.
 
+* You should enable multi-cpu support in dump-capture kernel if you intend
+  to use multi-thread programs with it, such as parallel dump feature of
+  makedumpfile. Otherwise, the multi-thread program may have a great
+  performance degradation. To enable multi-cpu support, you should bring up
+  a SMP dump-capture kernel and specify maxcpus\nr_cpus, disable_cpu_apicid=[X]
+  options while loading it.
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
