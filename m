Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGWG8-0006aW-Ux
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 15:09:29 +0000
Date: Fri, 15 Mar 2013 16:09:21 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 1/2] xen: Improve calculation of beginning of virtual address
 space
Message-ID: <20130315150921.GB12758@debian70-amd64.local.net-space.pl>
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

Xen changeset 26447 (x86: re-introduce map_domain_page() et al) once again
altered virtual address space. Current algorithm calculating its start could
not cope with that change. New version establishes this value on the base of
image start address and is more generic.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

diff -Npru crash-6.1.4.orig/xen_hyper.c crash-6.1.4/xen_hyper.c
--- crash-6.1.4.orig/xen_hyper.c	2013-02-14 21:38:54.000000000 +0100
+++ crash-6.1.4/xen_hyper.c	2013-03-15 13:11:16.595713662 +0100
@@ -43,10 +43,14 @@ xen_hyper_init(void)
 #endif
 
 #ifdef X86_64
-	if (xen_major_version() >= 4)
-		xht->xen_virt_start = 0xffff82c480000000;
-	else
-		xht->xen_virt_start = 0xffff828c80000000;
+	xht->xen_virt_start = symbol_value("start");
+
+	/*
+	 * Xen virtual mapping is aligned to 1 GiB boundary.
+	 * Image starts no more than 1 GiB below
+	 * beginning of virtual address space.
+	 */
+	xht->xen_virt_start &= 0xffffffffc0000000;
 #endif
 
 	if (machine_type("X86_64") &&

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
