Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eyJcq-0006qy-Lk
 for kexec@lists.infradead.org; Tue, 20 Mar 2018 15:56:38 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v5 5/5] kexec: Document -s, -c and -a options
Date: Tue, 20 Mar 2018 16:56:20 +0100
Message-Id: <40379fa560cf0885d14a68fac7f7d3fe3cf8522a.1521561315.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1521561315.git.msuchanek@suse.de>
References: <20180316114714.4tmf4gr3d6boowi5@verge.net.au>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1521561315.git.msuchanek@suse.de>
In-Reply-To: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
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
To: kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, Dave Young <dyoung@redhat.com>, Michal Suchanek <msuchanek@suse.de>, Petr Tesarik <ptesarik@suse.cz>, horms@verge.net.au

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kexec/kexec.8 | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index e0131b4ea827..0682df06f931 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -144,6 +144,25 @@ Load the new kernel for use on panic.
 Specify that the new kernel is of this
 .I type.
 .TP
+.BI \-s\ (\-\-kexec-file-syscall)
+Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.
+.TP
+.BI \-c\ (\-\-kexec-syscall)
+Specify that the old KEXEC_LOAD syscall should be used exclusively (the default).
+.TP
+.BI \-a\ (\-\-kexec-syscall-auto)
+Try the new KEXEC_FILE_LOAD syscall first and if it is not supported fall back
+to the old KEXEC_LOAD interface.
+
+There is no one single interface that always works.
+
+KEXEC_FILE_LOAD is required on systems that use locked-down secure boot to
+verify the kernel signature.  KEXEC_LOAD may be also disabled in the kernel
+configuration.
+
+KEXEC_LOAD is required for some kernel image formats and on architectures that
+do not implement KEXEC_FILE_LOAD.
+.TP
 .B \-u\ (\-\-unload)
 Unload the current
 .B kexec
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
