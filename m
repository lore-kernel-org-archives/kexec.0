Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFB3C6FD1F
	for <kexec@archiver.kernel.org>; Sun, 19 Mar 2023 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:cc:Subject
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c/jkAg5L+7YmhbvP2q+DgmPXOVSWD4nLMJraz/9Ggsg=; b=yrWMYW75exa6QM
	/EINen6liQH42R3jrKlBVwhF3g12dHoDHR4XpoFeettkyYwYINSsVt7olw1bA1DE3MK2B4CllOFmb
	HRQHDDpbyFlvBbWrK9wqgvLOIJzoqa922cL7y2Obsf4qiEC14Vb0jefDJcM3Fk924w/6EDKrGrmTL
	WnED6IAc4+QZA9tQYXNX/YZ05Jm0TtlvM2H4o4ik2d6iK1tRxiKxp5Ju+MZhCOh2v/taeQfEuUaGg
	+qgx+6UhSZquvdf7qczqJC+OKPQTngrLGom/6CVx2pUWcwlXO51VHZCDLVhjkjYTektMf/OJF9/FN
	KWJRG9oaaIFdwZ0qOmjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pdxTB-0079FO-2f;
	Sun, 19 Mar 2023 18:09:25 +0000
Received: from myhtic.telent.net ([176.126.240.165] helo=mail.telent.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pdxT5-0079EH-0k
	for kexec@lists.infradead.org;
	Sun, 19 Mar 2023 18:09:21 +0000
Received: from noetbook (1.b.c.8.e.4.b.0.b.5.0.a.0.b.e.1.e.d.0.4.a.3.e.d.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:de3a:40de:1eb0:a05b:b4e:8cb1])
	by mail.telent.net (Postfix) with ESMTPSA id EFB45100070;
	Sun, 19 Mar 2023 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=telent.net; s=mail;
	t=1679248850; bh=bqy5BTHzbS3HUPgWlwYe2ig/MYAyvk0Hbnil3chJOjM=;
	h=From:To:Subject:cc:Date;
	b=aZRHjOj6x51e9cGpV6Pvhh7hbvBWCtzUi1WxuASfbWK2CYS5s6p0YoD+9KGxMzFAl
	 9rLoRCYZ8AZAhOZhUwkmm6uJAx+JWCxEDx6/sLjqmAAXNaToJ3fQvcuOM9BNjX4pLB
	 p6657/zkSzY+k40n9VTPd1dCM+q79zDOCBVtXjOg=
From: dan@telent.net
To: kexec@lists.infradead.org
Subject: [PATCH RFC] add --map-file option to map arbitrary files into physmem
cc: horms@verge.net.au
Date: Sun, 19 Mar 2023 18:00:47 +0000
Message-ID: <87r0tkfwog.fsf@telent.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230319_110919_552673_14C43155 
X-CRM114-Status: GOOD (  22.83  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


This is useful e.g. in conjunction with the MTD "phram" driver on
embedded devices: a kernel can be booted with kexec and a root
filesystem entirely in RAM to see if it works before writing it to
flash. Something like this:

   kexec --map-file ./squashfs@104857600 --dtb ./dtb  --command-line "mtdparts=phram0:9945088(rootfs) phram.phram=phram0,104857600,9945088 memmap=9945088$104857600" vmlinux

My use case might be quite niche :-) but the implementation is
I hope general enough that it could be used for other things as
well. Or maybe it's impossibly general and shouldn't be offered
at all without safety warnings.

Feedback welcome on any or all of style, correctness, general
desirability and/or other.  This is clearly not ever going to work with
KEXEC_FILE_LOAD.


Daniel

---
 kexec/kexec.8 | 14 ++++++++++++-
 kexec/kexec.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kexec/kexec.h |  4 +++-
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 3a344c5..3140ccb 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -143,10 +143,17 @@ into the current kernel.
 .B \-p\ (\-\-load\-panic)
 Load the new kernel for use on panic.
 .TP
-.BI \-t\ (\-\-type= type )
+.BI \-m\ (\-\-type= type )
 Specify that the new kernel is of this
 .I type.
 .TP
+.BI \-t\ (\-\-map-file= filename@addr )
+Read
+.I filename
+and arrange for it to be mapped into physical memory at the address
+.I addr.
+This option may be repeated if there are multiple files to map.
+.TP
 .BI \-s\ (\-\-kexec-file-syscall)
 Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.
 .TP
@@ -206,6 +213,11 @@ Reuse initrd from first boot.
 .BI \-\-print-ckr-size
 Print crash kernel region size, if available.
 
+.PP
+Options taking an
+.I addr
+parameter will accept a memory address written in hexadecimal (with leading
+0x), or octal (leading 0), or decimal (no leading sigil).
 
 .SH SUPPORTED KERNEL FILE TYPES AND OPTIONS
 .B Beoboot-x86
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 36bb2ad..c3b40a4 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -63,6 +63,13 @@ static unsigned long kexec_flags = 0;
 static unsigned long kexec_file_flags = 0;
 int kexec_debug = 0;
 
+#define MAPPED_FILES_MAX 10 	/* arbitrary number */
+struct mapped_file {
+	const char *filename;
+	unsigned long long phys_address;
+} mapped_files[MAPPED_FILES_MAX] = { { .filename = NULL } };
+
+
 void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
 {
 	int i;
@@ -771,6 +778,19 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	}
 	info.kexec_flags |= native_arch;
 
+	for(struct mapped_file *m = mapped_files; m->filename; m++) {
+		off_t file_size = 0;
+		char *buf = slurp_file(m->filename, &file_size);
+		add_buffer(&info,
+			   buf, file_size, file_size, sizeof (void *),
+			   m->phys_address,
+			   mem_max, 1);
+		free(m->filename);
+		/* do we free() memory returned by slurp_file()?
+		 * we don't know if it was mmaped, so maybe not
+		 */
+	};
+
 	result = file_type[i].load(argc, argv, kernel_buf, kernel_size, &info);
 	if (result < 0) {
 		switch (result) {
@@ -1035,6 +1055,8 @@ void usage(void)
 	       "                      load code into.\n"
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
+	       "     --map-file=<filename@addr> Map a file into memory for the\n"
+	       "                      new kernel before kexec.\n"
 	       "     --reuseinitrd    Reuse initrd from first boot.\n"
 	       "     --print-ckr-size Print crash kernel region size.\n"
 	       "     --load-preserve-context Load the new kernel and preserve\n"
@@ -1396,6 +1418,33 @@ static void print_crashkernel_region_size(void)
 	printf("%" PRIu64 "\n", (start != end) ? (end - start + 1) : 0UL);
 }
 
+static int add_mapped_file(char * optarg)
+{
+	char *at = strchr(optarg, '@');
+	if(!at)
+		return 1;
+
+	struct mapped_file *m = mapped_files;
+	struct mapped_file *m_end = mapped_files +
+	    ((sizeof mapped_files) / (sizeof mapped_files[0]));
+
+	while(m->filename && m < m_end)
+		m++;
+
+	if(m >= m_end)
+		return 1;
+
+	m->phys_address = strtoull(at + 1, NULL, 0);
+	if(m->phys_address == 0)
+		return 1;
+
+	m->filename = strndup(optarg, at - optarg);
+
+	(m+1)->filename = NULL;
+	return 0;
+}
+
+
 int main(int argc, char *argv[])
 {
 	int has_opt_load = 0;
@@ -1521,6 +1570,14 @@ int main(int argc, char *argv[])
 			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
 			kexec_flags = KEXEC_ON_CRASH;
 			break;
+		case OPT_MAP_FILE:
+			if(add_mapped_file(optarg)) {
+				fprintf(stderr,
+					"Bad option value or too many mapped files in --mapped-file=%s\n",
+					optarg);
+				return 1;
+			}
+			break;
 		case OPT_MEM_MIN:
 			mem_min = strtoul(optarg, &endptr, 0);
 			if (*endptr) {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0d820ad..78022b6 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -224,6 +224,7 @@ extern int file_types;
 #define OPT_STATUS		'S'
 #define OPT_MEM_MIN             256
 #define OPT_MEM_MAX             257
+#define OPT_MAP_FILE		'm'
 #define OPT_REUSE_INITRD	258
 #define OPT_LOAD_PRESERVE_CONTEXT 259
 #define OPT_LOAD_JUMP_BACK_HELPER 260
@@ -258,8 +259,9 @@ extern int file_types;
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
+	{ "map-file",		1, 0, OPT_MAP_FILE }, \
 
-#define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
+#define KEXEC_OPT_STR "h?vdfixyluet:pscaSm"
 
 extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
 extern void die(const char *fmt, ...)
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
