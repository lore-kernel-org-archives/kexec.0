Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTO-0006U8-6F
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:23 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 483EF3EE0BD
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:39 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2F56A45DE4E
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1997B45DE4D
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 089E71DB802F
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:39 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B6A161DB8037
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:38 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 2/8] Add command-line processing for snappy
Date: Tue, 03 Jul 2012 12:07:38 +0900
Message-ID: <20120703030738.16633.80789.stgit@localhost6.localdomain6>
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

Specify -p option to compress vmcore in snappy.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d024e95..14fd9f6 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6968,7 +6968,7 @@ main(int argc, char *argv[])
 
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMRrsvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
 		case 'b':
@@ -7026,6 +7026,9 @@ main(int argc, char *argv[])
 		case 'M':
 			info->flag_dmesg = 1;
 			break;
+		case 'p':
+			info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
+			break;
 		case 'P':
 			info->xen_phys_start = strtoul(optarg, NULL, 0);
 			break;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
