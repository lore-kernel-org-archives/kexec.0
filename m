Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZeFI-0006sM-AN
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 10:36:12 +0000
Subject: [PATCH] makedumpfile: fix a segmentation fault when pfn exceeds 2G
 boundary
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Mon, 14 Apr 2014 18:35:44 +0800
Message-ID: <20140414103543.31935.28496.stgit@k.asiapacific.hpqcorp.net>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, lisa.mitchell@hp.com

This patch intend to fix a segmentation fault when pfn exceeds 2G boundary.

In function is_on(), if the pfn (i) is greater than 2G, it will be a negative
value and will cause a segmentation fault.
is_on(char *bitmap, int i)
{
        return bitmap[i>>3] & (1 << (i & 7));
}


Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 makedumpfile.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 3d270c6..03d35a8 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1591,7 +1591,7 @@ int get_xen_info_ia64(void);
 #endif	/* s390x */
 
 static inline int
-is_on(char *bitmap, int i)
+is_on(char *bitmap, unsigned long long i)
 {
 	return bitmap[i>>3] & (1 << (i & 7));
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
