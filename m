Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1blplx-0001f7-KO
 for kexec@lists.infradead.org; Mon, 19 Sep 2016 04:01:38 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v10 2/3] Documentation: kdump: remind user of nr_cpus
Date: Mon, 19 Sep 2016 12:01:04 +0800
Message-Id: <1474257665-8838-3-git-send-email-bhe@redhat.com>
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

nr_cpus can help to save memory. So we should remind user of it.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Xunlei Pang <xpang@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/kdump/kdump.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 88ff63d..f7ef340 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -393,6 +393,8 @@ Notes on loading the dump-capture kernel:
 * We generally don' have to bring up a SMP kernel just to capture the
   dump. Hence generally it is useful either to build a UP dump-capture
   kernel or specify maxcpus=1 option while loading dump-capture kernel.
+  Note, though maxcpus always works, you had better replace it with
+  nr_cpus to save memory if supported by the current ARCH, such as x86.
 
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
