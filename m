Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzpHb-0004pa-O9
 for kexec@lists.infradead.org; Fri, 10 Aug 2012 13:29:44 +0000
Date: Fri, 10 Aug 2012 15:28:21 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 5/6] xen: Read data correctly from dynamically allocated
 console ring, too
Message-ID: <20120810132821.GF2576@host-192-168-1-59.local.net-space.pl>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: anderson@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

console ring is dynamically allocated since 19543 changeset (New option
conring_size= to allow larger console ring). Take into account that
and read data correctly from it, too.

v2 - Dave Anderson suggestions/fixes:
   - check conring type before determining its value.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.0.8.orig/xen_hyper_command.c crash-6.0.8/xen_hyper_command.c
--- crash-6.0.8.orig/xen_hyper_command.c	2012-06-29 16:59:18.000000000 +0200
+++ crash-6.0.8/xen_hyper_command.c	2012-08-10 14:05:24.000000000 +0200
@@ -590,24 +590,35 @@ xen_hyper_dump_log(void)
 	ulong conring;
 	char *buf;
 	char last;
+	uint32_t conring_size;
+
+	if (get_symbol_type("conring", NULL, NULL) == TYPE_CODE_ARRAY)
+		conring = symbol_value("conring");
+	else
+		get_symbol_data("conring", sizeof(ulong), &conring);
 
-	conring = symbol_value("conring");
 	get_symbol_data("conringc", sizeof(uint), &conringc);
 	get_symbol_data("conringp", sizeof(uint), &conringp);
+
+	if (symbol_exists("conring_size"))
+		get_symbol_data("conring_size", sizeof(uint32_t), &conring_size);
+	else
+		conring_size = XEN_HYPER_CONRING_SIZE;
+
 	warp = FALSE;
-	if (conringp >= XEN_HYPER_CONRING_SIZE) {
-		if ((start = conringp & (XEN_HYPER_CONRING_SIZE - 1))) {
+	if (conringp >= conring_size) {
+		if ((start = conringp & (conring_size - 1))) {
 			warp = TRUE;
 		}
 	} else {
 		start = 0;
 	}
 
-	buf = GETBUF(XEN_HYPER_CONRING_SIZE);
-	readmem(conring, KVADDR, buf, XEN_HYPER_CONRING_SIZE,
+	buf = GETBUF(conring_size);
+	readmem(conring, KVADDR, buf, conring_size,
 		"conring contents", FAULT_ON_ERROR);
 	idx = start;
-	len = XEN_HYPER_CONRING_SIZE;
+	len = conring_size;
 	last = 0;
 
 wrap_around:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
