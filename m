Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZE3g-00065r-4G
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 05:01:41 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 53CF23EE0BC
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:37 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3215145DD78
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:37 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 099C645DE53
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:37 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id ED76A1DB803A
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:36 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A27551DB803E
 for <kexec@lists.infradead.org>; Fri, 16 Nov 2012 14:01:36 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 01/10] Move page flags setup for old kernels after
 debuginfo initialization
Date: Fri, 16 Nov 2012 14:01:36 +0900
Message-ID: <20121116050136.8280.47809.stgit@localhost6.localdomain6>
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
