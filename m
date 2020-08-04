Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2ovi-00018K-0r
 for kexec@lists.infradead.org; Tue, 04 Aug 2020 04:52:02 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 3/3] kexec_file: correctly output debugging information for
 the PT_LOAD elf header
Date: Tue,  4 Aug 2020 12:49:33 +0800
Message-Id: <20200804044933.1973-4-lijiang@redhat.com>
In-Reply-To: <20200804044933.1973-1-lijiang@redhat.com>
References: <20200804044933.1973-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: k-hagio@ab.jp.nec.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

Currently, when we enable the debugging switch to debug kexec_file,
always get the following wrong results:

kexec_file: Crash PT_LOAD elf header. phdr=00000000c988639b vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=51 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=000000003cca69a0 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=52 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000c584cb9f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=53 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000cf85d57f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=54 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000a4a8f847 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=55 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000272ec49f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=56 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000ea0b65de vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=57 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=000000001f5e490c vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=58 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000dfe4109e vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=59 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000480ed2b6 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=60 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=0000000080b65151 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=61 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=0000000024e31c5e vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=62 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000332e0385 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=63 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=000000002754d5da vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=64 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000783320dd vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=65 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=0000000076fe5b64 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=66 p_offset=0x0

The reason is that kernel always prints the values of the next PT_LOAD
instead of the current PT_LOAD. Change it to ensure that we can get the
correct debugging information.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kernel/kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 41616b6a80ad..e2c03b4ce31b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1323,10 +1323,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
 		phdr->p_align = 0;
 		ehdr->e_phnum++;
-		phdr++;
 		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
 			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
 			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
 	}
 
 	*addr = buf;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
