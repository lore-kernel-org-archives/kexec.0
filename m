Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fg1jX-0003ZV-F6
 for kexec@lists.infradead.org; Thu, 19 Jul 2018 05:44:14 +0000
Received: by mail-pl0-f65.google.com with SMTP id p23-v6so3100785plo.6
 for <kexec@lists.infradead.org>; Wed, 18 Jul 2018 22:44:01 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 2/2] arm64: Add runtime kaslr offset if it exists
Date: Thu, 19 Jul 2018 11:13:41 +0530
Message-Id: <1531979021-31780-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1531979021-31780-1-git-send-email-bhsharma@redhat.com>
References: <1531979021-31780-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, k-hagio@ab.jp.nec.com

If we have to erase a symbol from vmcore whose address is not present in
vmcoreinfo, then we need to pass vmlinux as well to get the symbol
address.
When kaslr is enabled, virtual address of all the kernel symbols are
randomized with an offset. vmlinux always has a static address, but all
the arch specific calculation are based on run time kernel address. So
we need to find a way to translate symbol address from vmlinux to kernel
run time address.

Without this patch:
   # cat > scrub.conf << EOF
   [vmlinux]
   erase jiffies
   erase init_task.utime
   for tsk in init_task.tasks.next within task_struct:tasks
       erase tsk.utime
   endfor
   EOF

  # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
  readpage_elf: Attempt to read non-existent page at 0xffffa8a5bf180000.
  readmem: type_addr: 1, addr:ffffa8a5bf180000, size:8
  vaddr_to_paddr_arm64: Can't read pgd
  readmem: Can't convert a virtual address(ffff0000092a542c) to physical
  address.
  readmem: type_addr: 0, addr:ffff0000092a542c, size:390
  check_release: Can't get the address of system_utsname

After this patch check_release() is ok, and also we are able to erase
symbol from vmcore (I checked this with kernel 4.18.0-rc4+):

  # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
  The kernel version is not supported.
  The makedumpfile operation may be incomplete.
  Checking for memory holes                         : [100.0 %] \
  Checking for memory holes                         : [100.0 %] |
  Checking foExcluding unnecessary pages                       : [100.0 %]
  \
  Excluding unnecessary pages                       : [100.0 %] \

  The dumpfiles are saved to dumpfile_1, dumpfile_2, and dumpfile_3.

  makedumpfile Completed.

This feature also requires a fix in the kernel as well which has been submitted
upstream (see[0]).

[0] https://patchwork.kernel.org/patch/10533333/

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |  3 ++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 9e8c77c76935..9772022605ec 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -181,6 +181,47 @@ get_phys_base_arm64(void)
 	return TRUE;
 }
 
+unsigned long
+get_kaslr_offset_arm64(unsigned long vaddr)
+{
+	unsigned int i;
+	char buf[BUFSIZE_FGETS], *endp;
+
+	if (!info->kaslr_offset && info->file_vmcoreinfo) {
+		if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
+			ERRMSG("Can't seek the vmcoreinfo file(%s). %s\n",
+					info->name_vmcoreinfo, strerror(errno));
+			return FALSE;
+		}
+
+		while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
+			i = strlen(buf);
+			if (!i)
+				break;
+			if (buf[i - 1] == '\n')
+				buf[i - 1] = '\0';
+			if (strncmp(buf, STR_KERNELOFFSET,
+					strlen(STR_KERNELOFFSET)) == 0) {
+				info->kaslr_offset =
+					strtoul(buf+strlen(STR_KERNELOFFSET),&endp,16);
+				DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
+			}
+		}
+	}
+
+	if (vaddr >= __START_KERNEL_map &&
+			vaddr < __START_KERNEL_map + info->kaslr_offset) {
+		DEBUG_MSG("info->kaslr_offset: %lx\n", info->kaslr_offset);
+		return info->kaslr_offset;
+	} else {
+		/*
+		 * TODO: we need to check if it is vmalloc/vmmemmap/module
+		 * address, we will have different offset
+		 */
+		return 0;
+	}
+}
+
 ulong
 get_stext_symbol(void)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 5297279f0f3b..4daf71ef14b7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -967,12 +967,13 @@ unsigned long long vaddr_to_paddr_arm64(unsigned long vaddr);
 int get_versiondep_info_arm64(void);
 int get_xen_basic_info_arm64(void);
 int get_xen_info_arm64(void);
+unsigned long get_kaslr_offset_arm64(unsigned long vaddr);
 #define find_vmemmap()		stub_false()
 #define vaddr_to_paddr(X)	vaddr_to_paddr_arm64(X)
 #define get_phys_base()		get_phys_base_arm64()
 #define get_machdep_info()	get_machdep_info_arm64()
 #define get_versiondep_info()	get_versiondep_info_arm64()
-#define get_kaslr_offset(X)	stub_false()
+#define get_kaslr_offset(X)	get_kaslr_offset_arm64(X)
 #define get_xen_basic_info_arch(X) get_xen_basic_info_arm64(X)
 #define get_xen_info_arch(X) get_xen_info_arm64(X)
 #define is_phys_addr(X)		stub_true_ul(X)
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
