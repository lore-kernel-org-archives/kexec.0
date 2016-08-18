Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1baDm6-0002EM-K3
 for kexec@lists.infradead.org; Thu, 18 Aug 2016 03:13:47 +0000
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v9 1/2] Documentation: kdump: remind user of nr_cpus
Date: Thu, 18 Aug 2016 11:11:46 +0800
Message-ID: <1471489907-27737-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1471489907-27737-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1471489907-27737-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
Cc: bhe@redhat.com, corbet@lwn.net, xlpang@redhat.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, joe@perches.com, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

nr_cpus can help to save memory. So we should remind user of it.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Xunlei Pang <xpang@redhat.com>
---
 Documentation/kdump/kdump.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 88ff63d..d900080 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -393,6 +393,8 @@ Notes on loading the dump-capture kernel:
 * We generally don' have to bring up a SMP kernel just to capture the
   dump. Hence generally it is useful either to build a UP dump-capture
   kernel or specify maxcpus=1 option while loading dump-capture kernel.
+  Note, though maxcpus always works, you should replace it by nr_cpus to
+  save memory if supported by the current ARCH, such as x86.
 
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
