Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g6t0186.atlanta.hp.com ([15.193.32.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhyTc-0001Yy-EX
 for kexec@lists.infradead.org; Thu, 30 May 2013 08:44:53 +0000
Subject: [PATCH] Add a help message into man page of makedumpfile for -b
 option.
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Thu, 30 May 2013 16:44:19 +0800
Message-ID: <20130530084418.15640.42675.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: bhe@redhat.com, kexec-kdump-list@redhat.com, jin.wang@hp.com, kexec@lists.infradead.org, gang.xing@hp.com, nan.chen2@hp.com, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, jingbai.ma@hp.com, nigel.croxon@hp.com, dyoung@redhat.com, vgoyal@redhat.com

This is a minor change that only adds a help message to -b option in makedumpfile man page.
This message has been in Red Hat's makedumpfile source, they would like it in upstream also.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 makedumpfile.8 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index cfd1270..1e844db 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -534,6 +534,10 @@ order from left to right.  \fIVMCORE\fRs are assembled into a single
 Print debugging message.
 
 .TP
+\fB-b <order>\fR
+cache 2^order pages in ram when generating vmcore info before writing to output
+
+.TP
 \fB\-h\fR
 Show help message and LZO/snappy support status (enabled/disabled).
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
