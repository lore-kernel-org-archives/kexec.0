Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx7s3-0006h5-Mc
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 22:26:04 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(124-170-211-133.dyn.iinet.net.au [124.170.211.133])
	by kirsty.vergenet.net (Postfix) with ESMTP id AE7F0240B2
	for <kexec@lists.infradead.org>; Tue,  4 Nov 2008 09:26:02 +1100 (EST)
Date: Tue, 4 Nov 2008 09:26:02 +1100
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] Make x86_setup_jump_back_entry() static with a void
	argument list
Message-ID: <20081103222600.GA20744@verge.net.au>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1229679810=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============1229679810==
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline

gcc complains because x86_setup_jump_back_entry() has no arguments,
making the argument list void resolves this.

Also, make the function static as it isn't used in any other files.
And move the function above where it is used, to eliminate the
need for a forward-declaration.

Signed-off-by: Simon Horman <horms@verge.net.au>

--- 

# gcc --version
gcc (Debian 4.3.2-1) 4.3.2
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# make
...
gcc -Wall -O2 -fomit-frame-pointer -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss  -Os -fno-builtin -ffreestanding  -I./purgatory/include -I./purgatory/arch/i386/include -I./util_lib/include -I/usr/lib/gcc/i486-linux-gnu/4.3.2/include  -c -MD -o purgatory/arch/i386/purgatory-x86.o purgatory/arch/i386/purgatory-x86.c
purgatory/arch/i386/purgatory-x86.c:45: warning: function declaration isn’t
a prototype
purgatory/arch/i386/purgatory-x86.c:55: warning: function declaration isn’t
a prototype

Index: kexec-tools/purgatory/arch/i386/purgatory-x86.c
===================================================================
--- kexec-tools.orig/purgatory/arch/i386/purgatory-x86.c	2008-11-04 09:05:51.000000000 +1100
+++ kexec-tools/purgatory/arch/i386/purgatory-x86.c	2008-11-04 09:06:06.000000000 +1100
@@ -42,7 +42,12 @@ void setup_arch(void)
 	/* if (legacy_timer) x86_setup_legacy_timer(); */
 }
 
-extern void x86_setup_jump_back_entry();
+static void x86_setup_jump_back_entry(void)
+{
+	if (cmdline_end)
+		sprintf(cmdline_end, " kexec_jump_back_entry=0x%x",
+			jump_back_entry);
+}
 
 /* This function can be used to execute after the SHA256 verification. */
 void post_verification_setup_arch(void)
@@ -50,10 +55,3 @@ void post_verification_setup_arch(void)
 	if (panic_kernel)    crashdump_backup_memory();
 	if (jump_back_entry) x86_setup_jump_back_entry();
 }
-
-void x86_setup_jump_back_entry()
-{
-	if (cmdline_end)
-		sprintf(cmdline_end, " kexec_jump_back_entry=0x%x",
-			jump_back_entry);
-}


--===============1229679810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1229679810==--
