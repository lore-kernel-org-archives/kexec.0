Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOie-00065n-FE
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:18 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DE95C3EE0C1
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:13 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BFC8F45DEB5
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:13 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id AB23345DEB2
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:13 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9D31F1DB803C
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:13 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 546C81DB803E
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:13 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 01/10] Move page flags setup for old kernels after debuginfo
 initialization
Date: Thu, 08 Nov 2012 18:48:12 +0900
Message-ID: <20121108094812.30421.71275.stgit@localhost6.localdomain6>
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

Page flags setup needs to be done after debuginfo initialization. We
use hard coded values only when debugging information doesn't provide
corresponding values.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 1183330..6513059 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2723,8 +2723,6 @@ initial(void)
 		debug_info = TRUE;
 	}
 
-	if (!get_value_for_old_linux())
-		return FALSE;
 out:
 	if (!info->page_size) {
 		/*
@@ -2789,6 +2787,9 @@ out:
 	if (is_xen_memory() && !get_dom0_mapnr())
 		return FALSE;
 
+	if (!get_value_for_old_linux())
+		return FALSE;
+
 	return TRUE;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
