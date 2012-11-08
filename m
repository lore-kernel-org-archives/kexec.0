Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOis-00067B-Su
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:32 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7F9363EE0BC
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:24 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6599A45DE4F
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:24 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5169445DE4E
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:24 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 463E01DB8040
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:24 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id F1BA71DB803E
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:23 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 03/10] Add new parameters to various tables
Date: Thu, 08 Nov 2012 18:48:23 +0900
Message-ID: <20121108094823.30421.16717.stgit@localhost6.localdomain6>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

Add new parameters required for mem_map-based freepages filtering, to
various tables.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 20f4d99..1304df0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1163,6 +1163,8 @@ struct size_table {
 	long	cpumask_t;
 	long	kexec_segment;
 	long	elf64_hdr;
+
+	long	pageflags;
 };
 
 struct offset_table {
@@ -1171,6 +1173,8 @@ struct offset_table {
 		long	_count;
 		long	mapping;
 		long	lru;
+		long	_mapcount;
+		long	private;
 	} page;
 	struct mem_section {
 		long	section_mem_map;
@@ -1332,6 +1336,10 @@ struct number_table {
 	long	PG_lru;
 	long	PG_private;
 	long	PG_swapcache;
+	long	PG_buddy;
+	long	PG_slab;
+
+	long	PAGE_BUDDY_MAPCOUNT_VALUE;
 };
 
 struct srcfile_table {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
