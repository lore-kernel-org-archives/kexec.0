Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDe5M-0003Jl-EW
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 15:17:41 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 487423EE0AE
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:38 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 31A1B45DE56
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:38 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1AF3345DE54
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:38 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0D5DF1DB8050
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:38 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CD27A1DB8052
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:37 +0900 (JST)
Received: from m105.css.fujitsu.com (m105 [127.0.0.1])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id 8F2509C802B
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:37 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id 1FD379C8001
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:37 +0900 (JST)
Date: Wed, 12 Oct 2011 00:17:32 +0900 (   )
Message-Id: <20111012.001732.246509084.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 12/12] Add description of sadump-related formats in manual page
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
References: <20111012.001338.193691420.d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.8 |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 1da16b9..f7dfe04 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -20,6 +20,8 @@ makedumpfile \- make a small dumpfile of kdump
 .br
 \fBmakedumpfile\fR \-\-dump-dmesg [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fILOGFILE\fR
 .br
+\fBmakedumpfile\fR    [\fIOPTION\fR] \-x \fIVMLINUX\fR \-\-diskset=\fIVMCORE1\fR \-\-diskset=\fIVMCORE2\fR [\-\-diskset=\fIVMCORE3\fR ..] \fIDUMPFILE\fR
+.br
 .B makedumpfile
 \-h
 .br
@@ -104,6 +106,14 @@ one of dump_level 3 like the following:
 # makedumpfile \-c \-d 3 /proc/vmcore dumpfile.1
 .br
 # makedumpfile \-c \-d 31 dumpfile.1 dumpfile.2
+.PP
+makedumpfile can read \fIVMCORE\fR(s) in three kinds of sadump
+formats: single partition format, diskset format and media backup
+format, and can convert each of them into kdump-compressed format with
+filtering and compression processing. Note that for \fIVMCORE\fR(s)
+created by sadump, you always need to pass \fIVMLINUX\fR with -x
+option. Also, to pass multiple \fIVMCORE\fRs created on diskset
+configuration, you need to use --diskset option.
 
 .PP
 .SH OPTIONS
@@ -460,6 +470,18 @@ it is necessary to specfiy [\-x \fIVMLINUX\fR] or [\-i \fIVMCOREINFO\fR].
 .br
 
 .TP
+\fB\-\-diskset=VMCORE\fR
+Specify multiple \fIVMCORE\fRs created on sadump diskset configuration
+the same number of times as the number of \fIVMCORE\fRs in increasing
+order from left to right.  \fIVMCORE\fRs are assembled into a single
+\fIDUMPFILE.
+
+.br
+.B Example:
+.br
+# makedumpfile \-x vmlinux \-\-diskset=vmcore1 \-\-diskset=vmcore2 dumpfile
+
+.TP
 \fB\-D\fR
 Print debugging message.
 
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
