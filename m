Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWFSI-0007R0-Tw
 for kexec@lists.infradead.org; Wed, 25 Jan 2017 04:45:13 +0000
Received: by mail-pg0-f44.google.com with SMTP id 3so2336892pgj.3
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 20:44:49 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] /proc/kcore: Update physical address for kcore ram and text
Date: Wed, 25 Jan 2017 10:14:34 +0530
Message-Id: <f951340d2917cdd2a329fae9837a83f2059dc3b2.1485318868.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, anderson@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

Currently all the p_paddr of PT_LOAD headers are assigned to 0, which is
not true and could be misleading, since 0 is a valid physical address.

User space tools like makedumpfile needs to know physical address for
PT_LOAD segments of direct mapped regions. Therefore this patch updates
paddr for such regions. It also sets an invalid paddr (-1) for other
regions, so that user space tool can know whether a physical address
provided in PT_LOAD is correct or not.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 fs/proc/kcore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 0b80ad87b4d6..ea9f3d1ae830 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -373,7 +373,10 @@ static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
 		phdr->p_flags	= PF_R|PF_W|PF_X;
 		phdr->p_offset	= kc_vaddr_to_offset(m->addr) + dataoff;
 		phdr->p_vaddr	= (size_t)m->addr;
-		phdr->p_paddr	= 0;
+		if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
+			phdr->p_paddr	= __pa(m->addr);
+		else
+			phdr->p_paddr	= (elf_addr_t)-1;
 		phdr->p_filesz	= phdr->p_memsz	= m->size;
 		phdr->p_align	= PAGE_SIZE;
 	}
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
