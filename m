From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 31 Mar 2022 11:38:06 +0800
Subject: [PATCH 2/3] arm64/kexec-arm64: use enum to organize the reloc type
In-Reply-To: <20220331033807.9802-1-piliu@redhat.com>
References: <20220331033807.9802-1-piliu@redhat.com>
Message-ID: <20220331033807.9802-3-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

More and more reloc type need to be supported on aarch64. Using enum to
organize them to shorten the #ifdef macro list.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
---
 kexec/arch/arm64/kexec-arm64.c | 56 +++++++++-------------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index e25f600..0aa2544 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -1210,50 +1210,24 @@ int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 	return (ehdr->e_machine == EM_AARCH64);
 }
 
+enum aarch64_rel_type {
+	R_AARCH64_NONE = 0,
+	R_AARCH64_ABS64 = 257,
+	R_AARCH64_PREL32 = 261,
+	R_AARCH64_LD_PREL_LO19 = 273,
+	R_AARCH64_ADR_PREL_LO21 = 274,
+	R_AARCH64_ADR_PREL_PG_HI21 = 275,
+	R_AARCH64_ADD_ABS_LO12_NC = 277,
+	R_AARCH64_JUMP26 = 282,
+	R_AARCH64_CALL26 = 283,
+	R_AARCH64_LDST64_ABS_LO12_NC = 286,
+	R_AARCH64_LDST128_ABS_LO12_NC = 299
+};
+
 void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 	unsigned long r_type, void *ptr, unsigned long address,
 	unsigned long value)
 {
-#if !defined(R_AARCH64_ABS64)
-# define R_AARCH64_ABS64 257
-#endif
-
-#if !defined(R_AARCH64_PREL32)
-# define R_AARCH64_PREL32 261
-#endif
-
-#if !defined(R_AARCH64_LD_PREL_LO19)
-# define R_AARCH64_LD_PREL_LO19 273
-#endif
-
-#if !defined(R_AARCH64_ADR_PREL_LO21)
-# define R_AARCH64_ADR_PREL_LO21 274
-#endif
-
-#if !defined(R_AARCH64_ADR_PREL_PG_HI21)
-# define R_AARCH64_ADR_PREL_PG_HI21 275
-#endif
-
-#if !defined(R_AARCH64_ADD_ABS_LO12_NC)
-# define R_AARCH64_ADD_ABS_LO12_NC 277
-#endif
-
-#if !defined(R_AARCH64_JUMP26)
-# define R_AARCH64_JUMP26 282
-#endif
-
-#if !defined(R_AARCH64_CALL26)
-# define R_AARCH64_CALL26 283
-#endif
-
-#if !defined(R_AARCH64_LDST64_ABS_LO12_NC)
-# define R_AARCH64_LDST64_ABS_LO12_NC 286
-#endif
-
-#if !defined(R_AARCH64_LDST128_ABS_LO12_NC)
-# define R_AARCH64_LDST128_ABS_LO12_NC 299
-#endif
-
 	uint64_t *loc64;
 	uint32_t *loc32;
 	uint64_t *location = (uint64_t *)ptr;
@@ -1261,7 +1235,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 	uint64_t imm;
 	const char *type = NULL;
 
-	switch(r_type) {
+	switch((enum aarch64_rel_type)r_type) {
 	case R_AARCH64_ABS64:
 		type = "ABS64";
 		loc64 = ptr;
-- 
2.31.1


