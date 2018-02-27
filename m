Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqXCb-0005YI-22
 for kexec@lists.infradead.org; Tue, 27 Feb 2018 04:49:47 +0000
Received: by mail-pg0-x244.google.com with SMTP id m19so7111199pgn.1
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 20:49:10 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 6/7] x86: kexec_file: clean up prepare_elf64_headers()
Date: Tue, 27 Feb 2018 13:48:13 +0900
Message-Id: <20180227044814.24808-7-takahiro.akashi@linaro.org>
In-Reply-To: <20180227044814.24808-1-takahiro.akashi@linaro.org>
References: <20180227044814.24808-1-takahiro.akashi@linaro.org>
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
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, prudo@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

removing bufp variable in prepare_elf64_headers() makes the code simpler
and more understandable.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index bfc37ad20d4a..a842fd847684 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -334,7 +334,7 @@ static int prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
 	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf, *bufp;
+	unsigned char *buf;
 	unsigned int cpu, i;
 	unsigned long long notes_addr;
 	unsigned long mstart, mend;
@@ -359,9 +359,8 @@ static int prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
 	if (!buf)
 		return -ENOMEM;
 
-	bufp = buf;
-	ehdr = (Elf64_Ehdr *)bufp;
-	bufp += sizeof(Elf64_Ehdr);
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
 	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
 	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
 	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
@@ -377,33 +376,30 @@ static int prepare_elf64_headers(struct crash_mem *cmem, int kernel_map,
 
 	/* Prepare one phdr of type PT_NOTE for each present cpu */
 	for_each_present_cpu(cpu) {
-		phdr = (Elf64_Phdr *)bufp;
-		bufp += sizeof(Elf64_Phdr);
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
 		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
 		(ehdr->e_phnum)++;
+		phdr++;
 	}
 
 	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr = (Elf64_Phdr *)bufp;
-	bufp += sizeof(Elf64_Phdr);
 	phdr->p_type = PT_NOTE;
 	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
 	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
 	(ehdr->e_phnum)++;
+	phdr++;
 
 	/* Prepare PT_LOAD type program header for kernel text region */
 	if (kernel_map) {
-		phdr = (Elf64_Phdr *)bufp;
-		bufp += sizeof(Elf64_Phdr);
 		phdr->p_type = PT_LOAD;
 		phdr->p_flags = PF_R|PF_W|PF_X;
 		phdr->p_vaddr = (Elf64_Addr)_text;
 		phdr->p_filesz = phdr->p_memsz = _end - _text;
 		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		(ehdr->e_phnum)++;
+		ehdr->e_phnum++;
+		phdr++;
 	}
 
 	/* Go through all the ranges in cmem->ranges[] and prepare phdr */
-- 
2.16.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
