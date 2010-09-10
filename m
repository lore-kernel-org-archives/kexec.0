Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ou97v-0006dw-0p
	for kexec@lists.infradead.org; Fri, 10 Sep 2010 19:19:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <1616446052.695411284137699709.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	(caiqian@redhat.com's message of "Fri, 10 Sep 2010 12:54:59 -0400
	(EDT)")
References: <1616446052.695411284137699709.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Fri, 10 Sep 2010 12:19:06 -0700
Message-ID: <m1aanpe79x.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
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
To: caiqian@redhat.com
Cc: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>

caiqian@redhat.com writes:

> BTW, kexec commandline was like this if helps.
>
> /sbin/kexec -p '--command-line=ro root=/dev/mapper/vg_intels3e3601-lv_root rd_LVM_LV=vg_intels3e3601/lv_root rd_LVM_LV=vg_intels3e3601/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us console=ttyS0,115200n81 irqpoll maxcpus=1 reset_devices cgroup_disable=memory sysrq_always_enabled ' --initrd=/boot/initrd-2.6.36-rc2-mm1-fix+kdump.img /boot/vmlinuz-2.6.36-rc2-mm1-fix+
>

Thanks for keeping me honest.  It looks like I did something foolish,
and wound up putting 386 headers on the x86_64 crash dump.

I have rebased updated my kexec-tools-devel branch.  Could you try it
now?  I haven't had a chance to test it yet but when I inspected the
code it appeared very obvious what I had done wrong.

The active part of the fix is below (I have an earlier patch that just
defines KEXEC_ARCH_NATIVE).

Eric
---

From 0a9bffb31c3aee53f58c62dde349c2842060c760 Mon Sep 17 00:00:00 2001
From: Eric W. Biederman <ebiederm@xmission.com>
Date: Fri, 10 Sep 2010 11:57:36 -0700
Subject: [PATCH] x86 crashdump: On x86_64 generate EM_X86_64 crashdump headers.

Paper bag time.  I forgot to double check my changes worked
on x86_64.  So I wound up with x86_64 putting i386 crashdump headers
on when it generated a crashdump header.  Ouch!

Fix it by using the new KEXEC_ARCH_NATIVE value so we can see what
we are doing.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 kexec/arch/i386/crashdump-x86.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 06e5ae9..e202e36 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -690,19 +690,32 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	int nr_ranges, align = 1024, i;
 	struct memory_range *mem_range, *memmap_p;
 	struct crash_elf_info elf_info;
+	unsigned kexec_arch;
 
 	/* Constant parts of the elf_info */
 	elf_info.data             = ELFDATA2LSB;
 	elf_info.backup_src_start = BACKUP_SRC_START;
 	elf_info.backup_src_end   = BACKUP_SRC_END;
 
+	/* Get the architecture of the running kernel */
+	kexec_arch = elf_info.machine & KEXEC_ARCH_MASK;
+	if (kexec_arch == KEXEC_ARCH_DEFAULT)
+		kexec_arch = KEXEC_ARCH_NATIVE;
+	
         /* Get the elf architecture of the running kernel */
-	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64) {
+	switch(kexec_arch) {
+	case KEXEC_ARCH_X86_64:
 		elf_info.machine = EM_X86_64;
-	} else {
+		break;
+	case KEXEC_ARCH_386:
 		elf_info.machine       = EM_386;
 		elf_info.lowmem_limit  = X86_MAXMEM;
 		elf_info.get_note_info = get_crash_notes;
+		break;
+	default:
+		fprintf(stderr, "unsupported crashdump architecture: %04x\n",
+			kexec_arch);
+		return -1;
 	}
 
 	if (get_crash_memory_ranges(&mem_range, &nr_ranges,
-- 
1.6.5.2.143.g8cc62


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
