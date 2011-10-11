Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDe5B-0003Im-NZ
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 15:17:30 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8FB1C3EE0AE
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:27 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7904145DE50
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6322A45DE4F
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 57EFA1DB803B
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:27 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 263CE1DB802F
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:27 +0900 (JST)
Received: from m107.css.fujitsu.com (m107 [127.0.0.1])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id D3FA86A0006
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:26 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by m107.s.css.fujitsu.com (Postfix) with ESMTP id 67EF96A0003
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 00:17:26 +0900 (JST)
Date: Wed, 12 Oct 2011 00:17:22 +0900 (   )
Message-Id: <20111012.001722.276759242.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 11/12] Add description of sadump-related formts in usage
	information
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
 print_info.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/print_info.c b/print_info.c
index 547976e..19a578b 100644
--- a/print_info.c
+++ b/print_info.c
@@ -69,6 +69,11 @@ print_usage(void)
 	MSG("  # makedumpfile -g VMCOREINFO --xen-syms XEN-SYMS\n");
 	MSG("\n");
 	MSG("\n");
+	MSG("  Creating DUMPFILE from multiple VMCOREs generated on sadump diskset configuration:\n");
+	MSG("  # makedumpfile [-c] [-d DL] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2\n");
+	MSG("    [--diskset=VMCORE3 ..] DUMPFILE\n");
+	MSG("\n");
+	MSG("\n");
 	MSG("Available options:\n");
 	MSG("  [-c]:\n");
 	MSG("      Compress dump data by each page.\n");
@@ -163,6 +168,11 @@ print_usage(void)
 	MSG("      Exclude all the user domain pages from Xen kdump's VMCORE, and extract\n");
 	MSG("      the part of Xen and domain-0.\n");
 	MSG("\n");
+	MSG("  [--diskset=VMCORE]:\n");
+	MSG("      Specify multiple VMCOREs created on sadump diskset configuration the same\n");
+	MSG("      number of times as the number of VMCOREs in increasing order from left to\n");
+	MSG("      right.\n");
+	MSG("\n");
 	MSG("  [--message-level ML]:\n");
 	MSG("      Specify the message types.\n");
 	MSG("      Users can restrict output printed by specifying Message_Level (ML) with\n");
-- 
1.7.4.4



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
