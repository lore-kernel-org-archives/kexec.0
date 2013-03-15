Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGWGr-0006ke-8T
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 15:10:13 +0000
Date: Fri, 15 Mar 2013 16:10:06 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 2/2] xen: Fix console buffer content length calculation
Message-ID: <20130315151006.GC12758@debian70-amd64.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
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
To: anderson@redhat.com, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Function displaying console buffer always assumes its content lenght
equal to console buffer size. This is not true and sometimes it sends
garbage to the screen. This patch fixes this issue.

Additionally, remove references to unused conringc variable.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.1.4.orig/xen_hyper_command.c crash-6.1.4/xen_hyper_command.c
--- crash-6.1.4.orig/xen_hyper_command.c	2013-02-14 21:38:54.000000000 +0100
+++ crash-6.1.4/xen_hyper_command.c	2013-03-14 15:03:58.045075917 +0100
@@ -585,11 +585,10 @@ xen_hyper_cmd_log(void)
 void
 xen_hyper_dump_log(void)
 {
-	uint conringc, conringp;
-	uint warp, start, len, idx, i;
+	uint conringp, warp, len, idx, i;
 	ulong conring;
 	char *buf;
-	char last;
+	char last = 0;
 	uint32_t conring_size;
 
 	if (get_symbol_type("conring", NULL, NULL) == TYPE_CODE_ARRAY)
@@ -597,7 +596,6 @@ xen_hyper_dump_log(void)
 	else
 		get_symbol_data("conring", sizeof(ulong), &conring);
 
-	get_symbol_data("conringc", sizeof(uint), &conringc);
 	get_symbol_data("conringp", sizeof(uint), &conringp);
 
 	if (symbol_exists("conring_size"))
@@ -605,21 +603,19 @@ xen_hyper_dump_log(void)
 	else
 		conring_size = XEN_HYPER_CONRING_SIZE;
 
-	warp = FALSE;
 	if (conringp >= conring_size) {
-		if ((start = conringp & (conring_size - 1))) {
-			warp = TRUE;
-		}
+		idx = conringp & (conring_size - 1);
+		len = conring_size;
+		warp = TRUE;
 	} else {
-		start = 0;
+		idx = 0;
+		len = conringp;
+		warp = FALSE;
 	}
 
 	buf = GETBUF(conring_size);
 	readmem(conring, KVADDR, buf, conring_size,
 		"conring contents", FAULT_ON_ERROR);
-	idx = start;
-	len = conring_size;
-	last = 0;
 
 wrap_around:
 	for (i = idx; i < len; i++) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
