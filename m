Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpqBV-0003Dd-0L
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 05:48:51 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v3 2/3] powerpc/fadump: Use the correct VMCOREINFO_NOTE_SIZE
 for phdr
Date: Mon, 20 Mar 2017 13:50:32 +0800
Message-Id: <1489989033-1179-2-git-send-email-xlpang@redhat.com>
In-Reply-To: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Xunlei Pang <xlpang@redhat.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

vmcoreinfo_max_size stands for the vmcoreinfo_data, the
correct one we should use is vmcoreinfo_note whose total
size is VMCOREINFO_NOTE_SIZE.

Like explained in commit 77019967f06b ("kdump: fix exported
size of vmcoreinfo note"), it does not affect the actual 
function, we better fix it, also this change should be safe 
and backward compatible.

After this, we can get rid of variable vmcoreinfo_max_size,
let's use the macro VMCOREINFO_BYTES instead, fewer variables
means more safety for vmcoreinfo operation.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/powerpc/kernel/fadump.c | 3 +--
 include/linux/kexec.h        | 1 -
 kernel/kexec_core.c          | 3 +--
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8ff0dd4..b8e15cf 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -906,8 +906,7 @@ static int fadump_create_elfcore_headers(char *bufp)
 
 	phdr->p_paddr	= fadump_relocate(paddr_vmcoreinfo_note());
 	phdr->p_offset	= phdr->p_paddr;
-	phdr->p_memsz	= vmcoreinfo_max_size;
-	phdr->p_filesz	= vmcoreinfo_max_size;
+	phdr->p_memsz	= phdr->p_filesz = VMCOREINFO_NOTE_SIZE;
 
 	/* Increment number of program headers. */
 	(elf->e_phnum)++;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f1c601b..6918fda 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -319,7 +319,6 @@ extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
 extern note_buf_t __percpu *crash_notes;
 extern u32 *vmcoreinfo_note;
 extern size_t vmcoreinfo_size;
-extern size_t vmcoreinfo_max_size;
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e3a4bda..e503b48 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -54,7 +54,6 @@
 /* vmcoreinfo stuff */
 static unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
-size_t vmcoreinfo_max_size = VMCOREINFO_BYTES;
 u32 *vmcoreinfo_note;
 
 /* Flag to indicate we are going to kexec a new kernel */
@@ -1386,7 +1385,7 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	r = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
-	r = min(r, vmcoreinfo_max_size - vmcoreinfo_size);
+	r = min(r, VMCOREINFO_BYTES - vmcoreinfo_size);
 
 	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
 
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
