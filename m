Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG4ZT-0003UX-Bx
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 09:35:37 +0000
Message-ID: <51419956.5000403@cn.fujitsu.com>
Date: Thu, 14 Mar 2013 17:33:10 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 09/13] kexec: ppc: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com> <5140B824.5050601@gmail.com>
In-Reply-To: <5140B824.5050601@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be more clear.

Besides, remove the duplicate _ALIGN_* definition in file
kexec/arch/ppc/crashdump-powerpc.h.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/crashdump-powerpc.c |    2 +-
 kexec/arch/ppc/crashdump-powerpc.h |    2 --
 kexec/arch/ppc/fs2dt.c             |    5 ++---
 kexec/arch/ppc/kexec-dol-ppc.c     |   10 +++++-----
 kexec/arch/ppc/kexec-elf-ppc.c     |    8 ++++----
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index d367643..eee5b37 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -329,7 +329,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 	info->backup_src_size = BACKUP_SRC_SIZE;
 #ifndef CONFIG_BOOKE
 	/* Create a backup region segment to store backup data*/
-	sz = (BACKUP_SRC_SIZE + align - 1) & ~(align - 1);
+	sz = _ALIGN(BACKUP_SRC_SIZE, align);
 	tmp = xmalloc(sz);
 	memset(tmp, 0, sz);
 	info->backup_start = add_buffer(info, tmp, sz, sz, align,
diff --git a/kexec/arch/ppc/crashdump-powerpc.h b/kexec/arch/ppc/crashdump-powerpc.h
index 84a73aa..efdc7e3 100644
--- a/kexec/arch/ppc/crashdump-powerpc.h
+++ b/kexec/arch/ppc/crashdump-powerpc.h
@@ -35,8 +35,6 @@ extern struct arch_options_t arch_options;
 #endif
 
 #define KDUMP_BACKUP_LIMIT	BACKUP_SRC_SIZE
-#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
 
 extern unsigned long long crash_base;
 extern unsigned long long crash_size;
diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index cdae69e..56ffb91 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -407,8 +407,7 @@ int create_flatten_tree(struct kexec_info *info, unsigned char **bufp,
 	putnode();
 	*dt++ = 9;
 
-	len = sizeof(bb[0]);
-	len += 7; len &= ~7;
+	len = _ALIGN(sizeof(bb[0]), 8);
 
 	bb->off_mem_rsvmap = len;
 
@@ -426,7 +425,7 @@ int create_flatten_tree(struct kexec_info *info, unsigned char **bufp,
 
 	len = propnum("");
 	bb->dt_strings_size = len;
-	len +=  3; len &= ~3;
+	len = _ALIGN(len, 4);
 	bb->totalsize = bb->off_dt_strings + len;
 
 	bb->magic = 0xd00dfeed;
diff --git a/kexec/arch/ppc/kexec-dol-ppc.c b/kexec/arch/ppc/kexec-dol-ppc.c
index 5fc5e06..8d0d1a0 100644
--- a/kexec/arch/ppc/kexec-dol-ppc.c
+++ b/kexec/arch/ppc/kexec-dol-ppc.c
@@ -87,11 +87,11 @@ typedef struct {
 #define PAGE_SHIFT		12
 #define PAGE_SIZE		(1UL << PAGE_SHIFT)
 #define PAGE_MASK		(~((1 << PAGE_SHIFT) - 1))
-#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
+#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
 
 #define MAX_COMMAND_LINE   256
 
-#define UPSZ(X) ((sizeof(X) + 3) & ~3)
+#define UPSZ(X) _ALIGN_UP(sizeof(X), 4)
 static struct boot_notes {
 	Elf_Bhdr hdr;
 	Elf_Nhdr bl_hdr;
@@ -442,14 +442,14 @@ int dol_ppc_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	}
 
 	/* build the setup glue and argument segment (segment 0) */
-	note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
-	arg_bytes = note_bytes + ((setup_dol_size + 3) & ~3);
+	note_bytes = sizeof(elf_boot_notes) + _ALIGN(command_line_len, 4);
+	arg_bytes = note_bytes + _ALIGN(setup_dol_size, 4);
 
 	arg_buf = xmalloc(arg_bytes);
 	arg_base = add_buffer(info,
 		arg_buf, arg_bytes, arg_bytes, 4, 0, 0xFFFFFFFFUL, 1);
 
-	notes = (struct boot_notes *)(arg_buf + ((setup_dol_size + 3) & ~3));
+	notes = (struct boot_notes *)(arg_buf + _ALIGN(setup_dol_size, 4));
 
 	notes->hdr.b_size = note_bytes;
 	notes->cmd_hdr.n_descsz = command_line_len;
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 5f63a64..65a65cc 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -37,7 +37,7 @@ const char *ramdisk;
 int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
 			char *);
 
-#define UPSZ(X) ((sizeof(X) + 3) & ~3)
+#define UPSZ(X) _ALIGN_UP(sizeof(X), 4);
 #ifdef WITH_GAMECUBE
 static struct boot_notes {
 	Elf_Bhdr hdr;
@@ -327,14 +327,14 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 		setup_size = setup_simple_size;
 		setup_simple_regs.spr8 = ehdr.e_entry;	/* Link Register */
 	}
-	note_bytes = sizeof(elf_boot_notes) + ((command_line_len + 3) & ~3);
-	arg_bytes = note_bytes + ((setup_size + 3) & ~3);
+	note_bytes = sizeof(elf_boot_notes) + _ALIGN(command_line_len, 4);
+	arg_bytes = note_bytes + _ALIGN(setup_size, 4);
 
 	arg_buf = xmalloc(arg_bytes);
 	arg_base = add_buffer(info, 
 		arg_buf, arg_bytes, arg_bytes, 4, 0, elf_max_addr(&ehdr), 1);
 
-	notes = (struct boot_notes *)(arg_buf + ((setup_size + 3) & ~3));
+	notes = (struct boot_notes *)(arg_buf + _ALIGN(setup_size, 4));
 
 	memcpy(arg_buf, setup_start, setup_size);
 	memcpy(notes, &elf_boot_notes, sizeof(elf_boot_notes));
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
