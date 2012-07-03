Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTR-0006UC-Kp
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:24 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 9B50F3EE0AE
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:00 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8317A45DEAD
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:00 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D17045DEA6
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:00 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F26D1DB803C
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:00 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1A86A1DB8038
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:00 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 6/8] Add uncompression processing
Date: Tue, 03 Jul 2012 12:07:59 +0900
Message-ID: <20120703030759.16633.87085.stgit@localhost6.localdomain6>
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

 makedumpfile.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1525b30..e42b07d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -279,6 +279,22 @@ readpmem_kdump_compressed(unsigned long long paddr, void *bufptr, size_t size)
 		}
 		memcpy(bufptr, buf2 + page_offset, size);
 #endif
+#ifdef USESNAPPY
+	} else if ((pd.flags & DUMP_DH_COMPRESSED_SNAPPY)) {
+
+		ret = snappy_uncompressed_length(buf, pd.size, &retlen);
+		if (ret != SNAPPY_OK) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			goto error;
+		}
+
+		ret = snappy_uncompress(buf, pd.size, buf2, &retlen);
+		if ((ret != SNAPPY_OK) || (retlen != info->page_size)) {
+			ERRMSG("Uncompress failed: %d\n", ret);
+			goto error;
+		}
+		memcpy(bufptr, buf2 + page_offset, size);
+#endif
 	} else
 		memcpy(bufptr, buf + page_offset, size);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
