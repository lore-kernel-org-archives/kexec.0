Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out26.alice.it ([85.33.2.26])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MuZLj-0002hX-AO
	for kexec@lists.infradead.org; Sun, 04 Oct 2009 22:14:43 +0000
From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH 1/1] kexec-tools_2.0.1: fix arm detection.
Date: Mon,  5 Oct 2009 00:14:33 +0200
Message-Id: <1254694473-10196-1-git-send-email-andrea.adami@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Andrea Adami <andrea.adami@gmail.com>


Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
--- kexec-tools/kexec/phys_arch.c.old	2008-07-15 02:46:43.000000000 +0200
+++ kexec-tools/kexec/phys_arch.c	2009-10-04 00:44:50.000000000 +0200
@@ -13,9 +13,12 @@
 		return -1;
 	}
 
-	for (i = 0; arches[i].machine; ++i)
+	for (i = 0; arches[i].machine; ++i) {
+		if ((strcmp(arches[i].machine, "arm") == 0) && (strncmp(utsname.machine, arches[i].machine, 3) == 0))
+			return arches[i].arch;
 		if (strcmp(utsname.machine, arches[i].machine) == 0)
 			return arches[i].arch;
+	}
 
 	fprintf(stderr, "Unsupported machine type: %s\n",
 		utsname.machine);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
