Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1erkoH-0000Zf-BF
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 13:33:18 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v3 5/5] kexec: document -s, -c and -a options.
Date: Fri,  2 Mar 2018 14:33:03 +0100
Message-Id: <71910238d489c7a3444ca4caa9d19cee02357784.1519997533.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519997533.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519997533.git.msuchanek@suse.de>
In-Reply-To: <20180302124610.3tyvym3dayq3coiz@verge.net.au>
References: <20180302124610.3tyvym3dayq3coiz@verge.net.au>
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
 kexec/kexec.8 | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index e0131b4ea827..b3543db3f413 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -144,6 +144,21 @@ Load the new kernel for use on panic.
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
+Try the new simpler KEXEC_FILE_LOAD syscall first and if it is not supported
+fall back to the old KEXEC_LOAD interface.
+
+There is no one single interface that always works. KEXEC_FILE_LOAD is required
+on systems that use locked-down secure boot to verify the kernel signature.
+KEXEC_LOAD is required for some kernel image formats and on architectures that
+do not support KEXEC_FILE_LOAD.
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
