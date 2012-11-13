Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJVN-00077X-FX
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:38:29 +0000
Date: Tue, 13 Nov 2012 11:38:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH][V2] vmcore-dmesg: Determine correct machine pointer size
Message-ID: <20121113163827.GB12529@redhat.com>
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

So determine the machine pointer size based on ELF class and arch and read
the bytes from file accordingly.

v2: Fixed the code as per suggestion from Eric.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

Index: kexec-tools/vmcore-dmesg/vmcore-dmesg.c
===================================================================
--- kexec-tools.orig/vmcore-dmesg/vmcore-dmesg.c	2012-08-01 13:27:09.304878654 -0400
+++ kexec-tools/vmcore-dmesg/vmcore-dmesg.c	2012-11-13 11:32:33.184358230 -0500
@@ -89,6 +89,24 @@ static uint64_t vaddr_to_offset(uint64_t
 	exit(30);
 }
 
+static unsigned machine_pointer_bits(void)
+{
+	uint8_t bits = 0;
+
+	/* Default to the size of the elf class */
+	switch(ehdr.e_ident[EI_CLASS]) {
+	case ELFCLASS32:        bits = 32; break;
+	case ELFCLASS64:        bits = 64; break;
+	}
+
+	/* Report the architectures pointer size */
+	switch(ehdr.e_machine) {
+	case EM_386:            bits = 32; break;
+	}
+
+        return bits;
+}
+
 static void read_elf32(int fd)
 {
 	Elf32_Ehdr ehdr32;
@@ -389,7 +407,8 @@ static uint64_t read_file_pointer(int fd
 {
 	uint64_t result;
 	ssize_t ret;
-	if (ehdr.e_ident[EI_CLASS] == ELFCLASS64) {
+
+	if (machine_pointer_bits() == 64) {
 		uint64_t scratch;
 		ret = pread(fd, &scratch, sizeof(scratch), addr);
 		if (ret != sizeof(scratch)) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
