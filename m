From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 31 Mar 2022 14:03:31 +0800
Subject: [PATCH] arm64: fix static data relocations in machine_apply_elf_rel()
Message-ID: <20220331060331.13866-1-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

As for 'static data relocations', instead of patching an instruction (OR
ops), it should be assigned to value directly.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
---
 kexec/arch/arm64/kexec-arm64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 311731d..ec6df4b 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -1249,13 +1249,12 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 	case R_AARCH64_ABS64:
 		type = "ABS64";
 		loc64 = ptr;
-		*loc64 = cpu_to_elf64(ehdr, elf64_to_cpu(ehdr, *loc64) + value);
+		*loc64 = cpu_to_elf64(ehdr, value);
 		break;
 	case R_AARCH64_PREL32:
 		type = "PREL32";
 		loc32 = ptr;
-		*loc32 = cpu_to_elf32(ehdr,
-			elf32_to_cpu(ehdr, *loc32) + value - address);
+		*loc32 = cpu_to_elf32(ehdr, value - address);
 		break;
 
 	/* Set a MOV[KZ] immediate field to bits [15:0] of X. No overflow check */
-- 
2.31.1


