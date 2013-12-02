Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnUJU-0006Wu-N0
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 14:17:30 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 3/4] makedumpfile/xen: Fail immediately on every
 architecture if dump level is invalid
Date: Mon,  2 Dec 2013 15:16:43 +0100
Message-Id: <1385993804-27721-4-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
References: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Do not try to process Xen crash dump on every architecture if dump level
is invalid. Fail immediately and print relevant error message.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5a378d1..45f96aa 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7637,14 +7637,14 @@ initial_xen(void)
 		MSG("Try `makedumpfile --help' for more information.\n");
 		return FALSE;
 	}
-#ifndef __x86_64__
+
 	if (DL_EXCLUDE_ZERO < info->max_dump_level) {
 		MSG("Dump_level is invalid. It should be 0 or 1.\n");
 		MSG("Commandline parameter is invalid.\n");
 		MSG("Try `makedumpfile --help' for more information.\n");
 		return FALSE;
 	}
-#endif
+
 	if (!init_xen_crash_info())
 		return FALSE;
 	/*
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
