Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aXpAn-0001pk-EJ
 for kexec@lists.infradead.org; Mon, 22 Feb 2016 12:01:11 +0000
Subject: [RFC v2 PATCH 7/7] purgatory/ipmi/x86: Support logging of IP
 registers into SEL
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 22 Feb 2016 20:56:31 +0900
Message-ID: <20160222115631.4231.11798.stgit@softrs>
In-Reply-To: <20160222115617.4231.50041.stgit@softrs>
References: <20160222115617.4231.50041.stgit@softrs>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Corey Minyard <minyard@acm.org>

If you specify both --output-cpu-ip and --ipmi-handle-panic, the
values of IP registers are logged to BMC's SEL in the panic case.
This kind of information is useful when the first kernel hanged up
and panicked by NMI but booting the second kernel failed.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 purgatory/arch/i386/purgatory-x86.h          |    1 +
 purgatory/arch/x86_64/purgatory-elf-x86_64.c |   33 ++++++++++++++++++++++++++
 purgatory/arch/x86_64/purgatory-x86_64.c     |   13 +++++++++-
 purgatory/include/purgatory.h                |    1 +
 purgatory/ipmi.c                             |   24 +++++++++++++++++++
 5 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/purgatory/arch/i386/purgatory-x86.h b/purgatory/arch/i386/purgatory-x86.h
index 16dfafd..54c253f 100644
--- a/purgatory/arch/i386/purgatory-x86.h
+++ b/purgatory/arch/i386/purgatory-x86.h
@@ -6,5 +6,6 @@ void x86_setup_legacy_pic(void);
 void x86_setup_legacy_timer(void);
 void crashdump_backup_memory(void);
 void print_ip(void);
+void write_ip_to_sel(void);
 
 #endif /* PURGATORY_X86_H */
diff --git a/purgatory/arch/x86_64/purgatory-elf-x86_64.c b/purgatory/arch/x86_64/purgatory-elf-x86_64.c
index 513974b..631be18 100644
--- a/purgatory/arch/x86_64/purgatory-elf-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-elf-x86_64.c
@@ -43,7 +43,40 @@ static void fn_print_ip(Elf64_Phdr *phdr)
 		printf("RIP: %lx\n", get_ip_from_crash_note(phdr));
 }
 
+static void fn_write_ip_to_sel(Elf64_Phdr *phdr)
+{
+	static int seqnum = 0;
+	unsigned long rip;
+	unsigned char *src, *dst;
+	int i;
+	struct {
+		uint8_t reserved[3];
+		uint16_t le_seqnum;
+		uint64_t be_ip;
+	} __attribute__((packed)) sel_data;
+
+	memset(&sel_data, 0, sizeof(sel_data));
+
+	if (is_valid_crash_note(phdr)) {
+		sel_data.le_seqnum = seqnum++;
+		rip = get_ip_from_crash_note(phdr);
+
+		/* Convert to big-endian for convenience */
+		src = (unsigned char *)&rip;
+		dst = (unsigned char *)&sel_data.be_ip;
+		for (i= 0; i < sizeof(rip); i++)
+			dst[i] = src[7 - i];
+
+		ipmi_sel_write((unsigned char *)&sel_data, sizeof(sel_data));
+	}
+}
+
 void print_ip(void)
 {
 	process_elf_notes(fn_print_ip);
 }
+
+void write_ip_to_sel(void)
+{
+	process_elf_notes(fn_write_ip_to_sel);
+}
diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_64/purgatory-x86_64.c
index cfc9d97..3b8f77b 100644
--- a/purgatory/arch/x86_64/purgatory-x86_64.c
+++ b/purgatory/arch/x86_64/purgatory-x86_64.c
@@ -27,8 +27,11 @@ void x86_setup_jump_back_entry(void)
 /* This function can be used to execute after the SHA256 verification. */
 void post_verification_setup_arch(void)
 {
+	int valid_elf = 0;
+
 	if (panic_kernel) {
 		crashdump_backup_memory();
+		valid_elf = have_valid_elf_header();
 
 		if (ipmi_handle_panic || ipmi_wdt)
 			ipmi_init_timeout();
@@ -44,8 +47,16 @@ void post_verification_setup_arch(void)
 		if (ipmi_wdt)
 			ipmi_wdt_start_stop();
 
-		if (output_cpu_ip && have_valid_elf_header())
+		if (output_cpu_ip && valid_elf) {
+			/*
+			 * Since this may fill up all SEL entries on many core
+			 * machine, do it last.
+			 */
+			if (ipmi_handle_panic)
+				write_ip_to_sel();
+
 			print_ip();
+		}
 	}
 
 	if (jump_back_entry) x86_setup_jump_back_entry();
diff --git a/purgatory/include/purgatory.h b/purgatory/include/purgatory.h
index 7afa890..c78dc50 100644
--- a/purgatory/include/purgatory.h
+++ b/purgatory/include/purgatory.h
@@ -15,5 +15,6 @@ void post_verification_setup_arch(void);
 void ipmi_init_timeout(void);
 void ipmi_wdt_start_stop(void);
 void ipmi_send_panic_event(void);
+void ipmi_sel_write(unsigned char *buf, int size);
 
 #endif /* PURGATORY_H */
diff --git a/purgatory/ipmi.c b/purgatory/ipmi.c
index 59c0366..a8f7c43 100644
--- a/purgatory/ipmi.c
+++ b/purgatory/ipmi.c
@@ -1,4 +1,5 @@
 #include <stdint.h>
+#include <string.h>
 #include <sys/io.h>
 #include <purgatory.h>
 #include "../kexec/ipmi.h"
@@ -63,6 +64,16 @@ const unsigned char cmd_panic_event[] = {
 	0x00,		/* Data 3 */
 };
 
+unsigned char cmd_add_sel_entry[18] = {
+	0x0a << 2,	/* Storage */
+	0x44,		/* Add SEL Entry */
+	0x00, 0x00,	/* Record ID: 0 for Add SEL Entry */
+	0xf1,		/* Record Type: OEM event without timestamp */
+	/* Remaining 13 bytes convey any data */
+};
+
+#define SEL_DATA_START	5
+
 /* Total timeout for IPMI operations */
 static struct timeout_info ipmi_to = {
 	.end = INT64_MAX, /* never time out */
@@ -335,3 +346,16 @@ void ipmi_send_panic_event(void)
 {
 	issue_ipmi_cmd(cmd_panic_event, sizeof(cmd_panic_event));
 }
+
+void ipmi_sel_write(unsigned char *buf, int size)
+{
+	/* We can write less than 13 bytes at once */
+	if (size > sizeof(cmd_add_sel_entry) - SEL_DATA_START)
+		return;
+
+	memset(&cmd_add_sel_entry[SEL_DATA_START], 0,
+	       sizeof(cmd_add_sel_entry) - SEL_DATA_START);
+	memcpy(&cmd_add_sel_entry[SEL_DATA_START], buf, size);
+
+	issue_ipmi_cmd(cmd_add_sel_entry, sizeof(cmd_add_sel_entry));
+}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
