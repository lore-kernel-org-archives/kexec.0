Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIfR-0005MA-O9
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:38:10 +0000
Received: by mail-pz0-f49.google.com with SMTP id m1so3476359dad.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:38:09 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 01/10] Move page flags setup for old kernels after
 debuginfo initialization
Date: Fri, 29 Jun 2012 02:38:05 +0900
Message-ID: <20120628173805.19702.71171.stgit@fedora-machine>
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

The hard coded values need to be used only if the corresponding values
are not specified by debuginfo. So it should be done after debuginfo
initialization.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d024e95..a6b3de7 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2643,8 +2643,6 @@ initial(void)
 		debug_info = TRUE;
 	}
 
-	if (!get_value_for_old_linux())
-		return FALSE;
 out:
 	if (!info->page_size) {
 		/*
@@ -2706,6 +2704,9 @@ out:
 			return FALSE;
 	}
 
+	if (!get_value_for_old_linux())
+		return FALSE;
+
 	return TRUE;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
