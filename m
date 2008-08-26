Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYAFE-0001AK-Cn
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 01:54:49 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(124-170-204-174.dyn.iinet.net.au [124.170.204.174])
	by kirsty.vergenet.net (Postfix) with ESMTP id 7E2C224076
	for <kexec@lists.infradead.org>; Wed, 27 Aug 2008 11:54:47 +1000 (EST)
Resent-Message-ID: <20080827015447.GB19066@verge.net.au>
Resent-To: kexec@lists.infradead.org
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KXv2w-0000Xa-VF
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 09:41:07 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8E42E45D54
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 11:41:05 +0200 (CEST)
Content-Type: multipart/mixed; boundary="===============8925425014036418479=="
MIME-Version: 1.0
Subject: [PATCH] Use /usr/bin/nm -D on stripped binaries
Message-Id: <0eff1a298f2c6402f554.1219743656@halley.suse.de>
Date: Tue, 26 Aug 2008 11:40:56 +0200
From: Bernhard Walle <bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============8925425014036418479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Use "nm -D" to retrieve also the symbols of crash when having stripped binaries.
Use the presence of the symbol table to determine if the binary has been
stripped or not.

Because we don't have static symbols in stripped binaries, we check the size
of the function (the "nm -S" output) and report "unknown" if the looked address
is outside of the function.


Signed-off-by: Bernhard Walle <bwalle@suse.de>


2 files changed, 55 insertions(+), 12 deletions(-)
defs.h    |    1 
symbols.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++------------



--===============8925425014036418479==
Content-Type: text/x-patch; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=crash-use-nm-d.diff

Use "nm -D" to retrieve also the symbols of crash when having stripped binaries.
Use the presence of the symbol table to determine if the binary has been
stripped or not.

Because we don't have static symbols in stripped binaries, we check the size
of the function (the "nm -S" output) and report "unknown" if the looked address
is outside of the function.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

diff --git a/defs.h b/defs.h
--- a/defs.h
+++ b/defs.h
@@ -3296,6 +3296,7 @@
 void dump_offset_table(char *, ulong);
 int is_elf_file(char *);
 int is_kernel(char *);
+int is_binary_stripped(char *filename);
 int file_elf_version(char *);
 int is_system_map(char *);
 int select_namelist(char *);
diff --git a/symbols.c b/symbols.c
--- a/symbols.c
+++ b/symbols.c
@@ -2719,6 +2719,32 @@
         return TRUE;
 }
 
+int
+is_binary_stripped(char *filename)
+{
+#if defined(GDB_6_0) || defined(GDB_6_1)
+        struct bfd *bfd;
+#else
+        struct _bfd *bfd;
+#endif
+
+	if ((bfd = bfd_openr(filename, NULL)) == NULL) {
+		error(INFO, "Cannot open ELF file: %s\n", filename);
+		return FALSE;
+	}
+
+	if (!bfd_check_format(bfd, bfd_object)) {
+		error(INFO, "Invalid ELF file: %s\n", filename);
+		return FALSE;
+	}
+
+	int number_of_symbols;
+	number_of_symbols = bfd_canonicalize_symtab(bfd, NULL);
+
+	bfd_close(bfd);
+	
+	return number_of_symbols == 0;
+}
 
 /*
  *  This command may be used to:
@@ -9048,9 +9074,11 @@
 	char *arglist[MAXARGS];
 	char buf[BUFSIZE];
 	FILE *pipe;
-	ulong vaddr, lookfor;
-	ulong last_vaddr;
+	ulong vaddr, size, lookfor;
+	ulong last_vaddr, last_size;
 	char symbol[BUFSIZE];
+	int stripped_binary;
+	const char *nm_call;
 
 	fflush(fp);
 	fflush(stdout);
@@ -9073,11 +9101,17 @@
 		return;
 	}
 
+	stripped_binary = is_binary_stripped(thisfile);
+	if (stripped_binary)
+		nm_call = "/usr/bin/nm -DSBn %s";
+	else
+		nm_call = "/usr/bin/nm -BSn %s";
+
         for (i = 0; i < NUMBER_STACKFRAMES; i++) {
 		if (!(lookfor = retaddr[i]))
 			continue;
 
-		sprintf(buf, "/usr/bin/nm -Bn %s", thisfile);
+		sprintf(buf, nm_call, thisfile);
 	        if (!(pipe = popen(buf, "r"))) {
 			perror("pipe");
 			break;
@@ -9086,20 +9120,28 @@
 		last_vaddr = 0;
 		BZERO(symbol, BUFSIZE);
 
-	        while (fgets(buf, 80, pipe)) {
+	        while (fgets(buf, BUFSIZE, pipe)) {
 			c = parse_line(strip_linefeeds(buf), arglist);
-			if (c != 3)
+			if (c != 4)
 				continue;
 			vaddr = htol(arglist[0], FAULT_ON_ERROR, NULL);
+			size = htol(arglist[1], FAULT_ON_ERROR, NULL);
 			if (vaddr > lookfor) {
-				fprintf(stderr, "%s  %lx: %s+%ld\n",
-					i == 0 ? "\n" : "", 
-					lookfor, symbol, 
-					lookfor-last_vaddr);
-				break;
-			}
-			strcpy(symbol, arglist[2]);
+				if ((lookfor - last_vaddr) > last_size)
+					fprintf(stderr, "%s  %lx: %s+%ld\n",
+						i == 0 ? "\n" : "", 
+						lookfor, "unknown", 
+						lookfor-last_vaddr);
+				else
+					fprintf(stderr, "%s  %lx: %s+%ld\n",
+						i == 0 ? "\n" : "", 
+						lookfor, symbol, 
+						lookfor-last_vaddr);
+				break;
+			}
+			strcpy(symbol, arglist[3]);
 			last_vaddr = vaddr;
+			last_size = size;
 		}
 
 		pclose(pipe);

--===============8925425014036418479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============8925425014036418479==--


