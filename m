Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kxetd-0005bk-5t
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 09:41:53 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id DCE8142969
	for <kexec@lists.infradead.org>; Wed,  5 Nov 2008 10:41:49 +0100 (CET)
Message-ID: <49116A5D.8040900@suse.de>
Date: Wed, 05 Nov 2008 10:41:49 +0100
From: Stefan Assmann <sassmann@suse.de>
MIME-Version: 1.0
Subject: [PATCH] Add include for offsetof macro
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

kexec/arch/i386/kexec-elf-x86.c and kexec/arch/x86_64/kexec-elf-x86_64.c
both use the macro offsetof() which according to the man page requires
#include <stddef.h>.
The include is not present at the moment and this patch adds it. This is
necessary for compatibility with i.e. uClibc.

Signed-off-by: Stefan Assmann <sassmann@suse.de>

---
 kexec/arch/i386/kexec-elf-x86.c      |    1 +
 kexec/arch/x86_64/kexec-elf-x86_64.c |    1 +
 2 files changed, 2 insertions(+)

--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -18,6 +18,7 @@
  */

 #define _GNU_SOURCE
+#include <stddef.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -18,6 +18,7 @@
  */

 #define _GNU_SOURCE
+#include <stddef.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>

-- 
Stefan Assmann          | SUSE LINUX Products GmbH
Software Engineer       | Maxfeldstr. 5, D-90409 Nuernberg
Mail: sassmann@suse.de  | GF: Markus Rex, HRB 16746 (AG Nuernberg)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
