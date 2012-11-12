Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TY0lh-0006Ym-3s
 for kexec@lists.infradead.org; Mon, 12 Nov 2012 20:38:06 +0000
Date: Mon, 12 Nov 2012 15:38:00 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] vmcore-dmesg: Determine file data size based on e_machine
Message-ID: <20121112203800.GE24254@redhat.com>
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
To: Kexec Mailing List <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>

A 32bit arch can prepare ELF64 headers. For example for PAE case to
preresent file offsets 64bit but data size at the offset still remains
32bit. If we just base our decision based on EI_CLASS, then we will try
to read 64bit data from file and can run into various issues.

We ran into following issue when we tried to run vmcore-dmesg on a 32bit
PAE system vmcore which had 64bit elf headers.

No program header covering vaddr 0xc0a6a688c0b89100found kexec bug?

Basically we try to read value of log_buf variable from address
log_buf_vaddr. We read in 64bit value and then pass that value again
to vaddr_to_offset() in an attempt to get to actual log_buf start
and get error message.

So determine the data size based on arch and read the bytes from
file accordingly.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

Index: kexec-tools/vmcore-dmesg/vmcore-dmesg.c
===================================================================
--- kexec-tools.orig/vmcore-dmesg/vmcore-dmesg.c	2012-08-03 15:46:54.000000000 -0400
+++ kexec-tools/vmcore-dmesg/vmcore-dmesg.c	2012-11-08 05:30:17.918099858 -0500
@@ -89,6 +89,23 @@ static uint64_t vaddr_to_offset(uint64_t
 	exit(30);
 }
 
+/*
+ * For PAE arch, one can prepare 64bit ELF headers to make offsets 64bit in
+ * file but data size still remains 32bit. Determine data size based on arch
+ * (e_machine).
+ *
+ * returns 1 if arch passed in is 64bit
+ */
+static bool file_data_size_64bit(unsigned int e_machine)
+{
+	switch(e_machine) {
+		/* TODO: keep on adding 32bit arch to get vmcore-dmesg right */
+		case EM_386:
+			return 0;
+	}
+	return 1;
+}
+
 static void read_elf32(int fd)
 {
 	Elf32_Ehdr ehdr32;
@@ -389,7 +406,8 @@ static uint64_t read_file_pointer(int fd
 {
 	uint64_t result;
 	ssize_t ret;
-	if (ehdr.e_ident[EI_CLASS] == ELFCLASS64) {
+	if (ehdr.e_ident[EI_CLASS] == ELFCLASS64 &&
+	    file_data_size_64bit(ehdr.e_machine)) {
 		uint64_t scratch;
 		ret = pread(fd, &scratch, sizeof(scratch), addr);
 		if (ret != sizeof(scratch)) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
