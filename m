Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE3p-00066r-3R
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:01:49 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A93743EE0AE
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:47 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D34845DEB7
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:47 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7262445DEB2
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:47 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C2EE1DB8038
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:47 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 126A81DB803B
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:47 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 03/10] Add new parameters to various tables
Date: Fri, 16 Nov 2012 14:01:46 +0900
Message-ID: <20121116050146.8280.94288.stgit@localhost6.localdomain6>
In-Reply-To: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
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
Cc: kexec@lists.infradead.org

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
