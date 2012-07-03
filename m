Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTO-0006UA-Jl
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:23 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6F8C03EE0C3
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:50 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5745545DEAD
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:50 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FE4945DEA6
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:50 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 342601DB8038
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:50 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E0E471DB803B
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:49 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 4/8] Notify snappy unsupporting when disabled
Date: Tue, 03 Jul 2012 12:07:48 +0900
Message-ID: <20120703030748.16633.89751.stgit@localhost6.localdomain6>
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

 makedumpfile.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 14fd9f6..a47a3ec 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2538,6 +2538,15 @@ initial(void)
 	}
 #endif
 
+#ifndef USESNAPPY
+	if (info->flag_compress == DUMP_DH_COMPRESSED_SNAPPY) {
+		MSG("'-p' option is disabled, ");
+		MSG("because this binary doesn't support snappy "
+		    "compression.\n");
+		MSG("Try `make USESNAPPY=on` when building.\n");
+	}
+#endif
+
 	if (!is_xen_memory() && info->flag_exclude_xen_dom) {
 		MSG("'-X' option is disable,");
 		MSG("because %s is not Xen's memory core image.\n", info->name_memory);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
