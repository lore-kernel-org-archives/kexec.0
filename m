Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTR-0006UN-OJ
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:26 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6FDC63EE0C8
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:11 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5579A45DE4E
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:11 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3C32E45DD78
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:11 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A60F1DB803F
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:11 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D6E041DB803A
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:10 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 8/8] Add manual description
Date: Tue, 03 Jul 2012 12:08:10 +0900
Message-ID: <20120703030810.16633.7641.stgit@localhost6.localdomain6>
In-Reply-To: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
References: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.8 |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 1fb9756..e9d4cbe 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -121,9 +121,10 @@ configuration, you need to use --diskset option.
 .SH OPTIONS
 
 .TP
-\fB\-c,\-l\fR
-Compress dump data by each page using zlib for -c option or lzo for -l option.
-(-l option needs USELZO=on when building.)
+\fB\-c,\-l,\-p\fR
+Compress dump data by each page using zlib for -c option, lzo for -l
+option or snappy for -p option.
+(-l option needs USELZO=on and -p option needs USESNAPPY=on when building)
 .br
 A user cannot specify this option with \-E option, because the ELF format does
 not support compressed data.
@@ -492,7 +493,7 @@ Print debugging message.
 
 .TP
 \fB\-h\fR
-Show help message and LZO support status (enabled/disabled).
+Show help message and LZO/snappy support status (enabled/disabled).
 
 .TP
 \fB\-v\fR


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
