Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsTZc-0005Dy-Js
 for kexec@lists.infradead.org; Wed, 13 May 2015 10:07:35 +0000
From: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH] prepend elfcorehdr instead of appending it to the
 crash-kernel command-line.
Date: Wed, 13 May 2015 12:05:54 +0200
Message-Id: <1431511554-16861-1-git-send-email-karahmed@amazon.de>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, x86@kernel.org, aliguori@amazon.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Any parameter passed after '--' in the kernel command-line will not be parsed
by the kernel at all, instead it will be passed directly to init process.

Currently the kernel appends elfcorehdr=<paddr> to the cmdline passed from kexec
load, and if this command-line is used to pass parameters to init process this
means that 'elfcorehdr' will not be parsed as a kernel parameter at all which
will be a problem for vmcore subsystem since it will know nothing about the
location of the ELF structure!

Prepending 'elfcorehdr' instead of appending it fixes this problem since it
ensures that it always comes before '--' and so it's always parsed as a kernel
command-line parameter.

Even with this patch things can still go wrong if 'CONFIG_CMDLINE' was also used
to embedd a command-line to the crash dump kernel and this command-line contains
'--' since the current behavior of the kernel is to actually append the boot
loader command-line to the embedded command-line.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
---
 arch/x86/kernel/kexec-bzimage64.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index ca05f86..ca83f7ac 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -72,15 +72,16 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 			 unsigned long cmdline_len)
 {
 	char *cmdline_ptr = ((char *)params) + cmdline_offset;
-	unsigned long cmdline_ptr_phys, len;
+	unsigned long cmdline_ptr_phys, len = 0;
 	uint32_t cmdline_low_32, cmdline_ext_32;
 
-	memcpy(cmdline_ptr, cmdline, cmdline_len);
 	if (image->type == KEXEC_TYPE_CRASH) {
-		len = sprintf(cmdline_ptr + cmdline_len - 1,
-			" elfcorehdr=0x%lx", image->arch.elf_load_addr);
-		cmdline_len += len;
+		len = sprintf(cmdline_ptr,
+			"elfcorehdr=0x%lx ", image->arch.elf_load_addr);
 	}
+	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
+	cmdline_len += len;
+
 	cmdline_ptr[cmdline_len - 1] = '\0';
 
 	pr_debug("Final command line is: %s\n", cmdline_ptr);
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
