Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1Avk-0002Oh-7U
 for kexec@lists.infradead.org; Wed, 28 Mar 2018 13:16:03 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 6/6] kexec: Document -s, -c and -a options in the man page
Date: Wed, 28 Mar 2018 15:15:19 +0200
Message-Id: <20180328131528.17050-1-msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
References: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
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
v5: document that KEXEC_LOAD may be disabled
v6: document that fallback happens in case the kernel does not
understand the image
---
 kexec/kexec.8 | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index e0131b4ea827..fb8a4c9caa45 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -144,6 +144,26 @@ Load the new kernel for use on panic.
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
+Try the new KEXEC_FILE_LOAD syscall first and when it is not supported or the
+kernel does not understand the supplied image fall back to the old KEXEC_LOAD
+interface.
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
