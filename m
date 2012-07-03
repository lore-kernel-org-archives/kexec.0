Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTO-0006U7-SH
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:24 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 10FBB3EE0AE
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:37 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id ED54F45DEAD
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:33 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D332745DE9E
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:33 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C2B1D1DB803C
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:33 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 73B401DB8038
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:33 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 1/8] Add dump header for snappy
Date: Tue, 03 Jul 2012 12:07:32 +0900
Message-ID: <20120703030732.16633.31086.stgit@localhost6.localdomain6>
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

 diskdump_mod.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diskdump_mod.h b/diskdump_mod.h
index e672485..af060b6 100644
--- a/diskdump_mod.h
+++ b/diskdump_mod.h
@@ -80,6 +80,8 @@ struct kdump_sub_header {
 /* page flags */
 #define DUMP_DH_COMPRESSED_ZLIB	0x1	/* page is compressed with zlib */
 #define DUMP_DH_COMPRESSED_LZO	0x2	/* paged is compressed with lzo */
+#define DUMP_DH_COMPRESSED_SNAPPY	0x4
+					/* paged is compressed with snappy */
 
 /* descriptor of each page for vmcore */
 typedef struct page_desc {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
