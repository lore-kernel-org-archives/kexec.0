Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KC5vt-0000HG-JT
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 04:51:38 +0000
Date: Fri, 27 Jun 2008 13:51:31 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: [PATCH] makedumpfile: fix illegal buffer access
Message-Id: <20080627133604.EE49.ODA@valinux.co.jp>
MIME-Version: 1.0
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
To: oomichi@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Hi,

Null padding of the vmcoreinfo (vmcoreinfo of xen is the case)
causes SIGSEGV (I met it on x86_64).
This fix avoids illegal buffer access.

Thanks.
Itsuro Oda

--- makedumpfile.c.org	2008-06-12 15:01:26.000000000 +0900
+++ makedumpfile.c	2008-06-12 16:16:11.000000000 +0900
@@ -2187,6 +2187,8 @@ read_vmcoreinfo_basic_info()
 
 	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
 		i = strlen(buf);
+		if (!i)
+			break;
 		if (buf[i - 1] == '\n')
 			buf[i - 1] = '\0';
 		if (strncmp(buf, STR_OSRELEASE, strlen(STR_OSRELEASE)) == 0) {
@@ -2244,6 +2246,8 @@ read_vmcoreinfo_symbol(char *str_symbol)
 
 	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
 		i = strlen(buf);
+		if (!i)
+			break;
 		if (buf[i - 1] == '\n')
 			buf[i - 1] = '\0';
 		if (strncmp(buf, str_symbol, strlen(str_symbol)) == 0) {
@@ -2275,6 +2279,8 @@ read_vmcoreinfo_long(char *str_structure
 
 	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
 		i = strlen(buf);
+		if (!i)
+			break;
 		if (buf[i - 1] == '\n')
 			buf[i - 1] = '\0';
 		if (strncmp(buf, str_structure, strlen(str_structure)) == 0) {
@@ -2304,6 +2310,8 @@ read_vmcoreinfo_string(char *str_in, cha
 
 	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
 		i = strlen(buf);
+		if (!i)
+			break;
 		if (buf[i - 1] == '\n')
 			buf[i - 1] = '\0';
 		if (strncmp(buf, str_in, strlen(str_in)) == 0) {
@@ -5790,6 +5798,8 @@ read_vmcoreinfo_basic_info_xen()
 
 	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
 		i = strlen(buf);
+		if (!i)
+			break;
 		if (buf[i - 1] == '\n')
 			buf[i - 1] = '\0';
 		if (strncmp(buf, STR_PAGESIZE, strlen(STR_PAGESIZE)) == 0) {

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
