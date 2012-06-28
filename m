Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIfg-0005O7-W4
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:38:25 +0000
Received: by mail-pb0-f49.google.com with SMTP id rq13so3656417pbb.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:38:24 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 03/10] Add new parameters for various tables
Date: Fri, 29 Jun 2012 02:38:21 +0900
Message-ID: <20120628173821.19702.50899.stgit@fedora-machine>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 95c0abc..2808871 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1073,6 +1073,8 @@ struct size_table {
 	long	cpumask_t;
 	long	kexec_segment;
 	long	elf64_hdr;
+
+	long	pageflags;
 };
 
 struct offset_table {
@@ -1081,6 +1083,8 @@ struct offset_table {
 		long	_count;
 		long	mapping;
 		long	lru;
+		long	_mapcount;
+		long	private;
 	} page;
 	struct mem_section {
 		long	section_mem_map;
@@ -1242,6 +1246,10 @@ struct number_table {
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
