From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 31 Mar 2022 11:38:07 +0800
Subject: [PATCH 3/3] arm64/kexec-arm64: add support for R_AARCH64_MOVW_UABS_G*
 rela
In-Reply-To: <20220331033807.9802-1-piliu@redhat.com>
References: <20220331033807.9802-1-piliu@redhat.com>
Message-ID: <20220331033807.9802-4-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Build kexec-tools with clang(clang version 13.0.1 (Fedora 13.0.1-1.fc36)).
Then when kexec loads kernel, it runs into the error message
"machine_apply_elf_rel: ERROR Unknown type: 264".

This is caused by the following reloc type in purgatory/purgatory.ro,
which is not supported yet.
  R_AARCH64_MOVW_UABS_G0_NC
  R_AARCH64_MOVW_UABS_G1_NC
  R_AARCH64_MOVW_UABS_G2_NC
  R_AARCH64_MOVW_UABS_G3

Adding code to support these relocs, so kexec can work smoothly.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
---
 kexec/arch/arm64/kexec-arm64.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 0aa2544..311731d 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -1214,6 +1214,10 @@ enum aarch64_rel_type {
 	R_AARCH64_NONE = 0,
 	R_AARCH64_ABS64 = 257,
 	R_AARCH64_PREL32 = 261,
+	R_AARCH64_MOVW_UABS_G0_NC = 264,
+	R_AARCH64_MOVW_UABS_G1_NC = 266,
+	R_AARCH64_MOVW_UABS_G2_NC = 268,
+	R_AARCH64_MOVW_UABS_G3 =269,
 	R_AARCH64_LD_PREL_LO19 = 273,
 	R_AARCH64_ADR_PREL_LO21 = 274,
 	R_AARCH64_ADR_PREL_PG_HI21 = 275,
@@ -1224,6 +1228,12 @@ enum aarch64_rel_type {
 	R_AARCH64_LDST128_ABS_LO12_NC = 299
 };
 
+static uint32_t get_bits(uint32_t value, int start, int end)
+{
+	uint32_t mask = ((uint32_t)1 << (end + 1 - start)) - 1;
+	return (value >> start) & mask;
+}
+
 void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 	unsigned long r_type, void *ptr, unsigned long address,
 	unsigned long value)
@@ -1247,6 +1257,36 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 		*loc32 = cpu_to_elf32(ehdr,
 			elf32_to_cpu(ehdr, *loc32) + value - address);
 		break;
+
+	/* Set a MOV[KZ] immediate field to bits [15:0] of X. No overflow check */
+	case R_AARCH64_MOVW_UABS_G0_NC:
+		type = "MOVW_UABS_G0_NC";
+		loc32 = ptr;
+		imm = get_bits(value, 0, 15);
+		*loc32 = cpu_to_le32(le32_to_cpu(*loc32) + (imm << 5));
+		break;
+	/* Set a MOV[KZ] immediate field to bits [31:16] of X. No overflow check */
+	case R_AARCH64_MOVW_UABS_G1_NC:
+		type = "MOVW_UABS_G1_NC";
+		loc32 = ptr;
+		imm = get_bits(value, 16, 31);
+		*loc32 = cpu_to_le32(le32_to_cpu(*loc32) + (imm << 5));
+		break;
+	/* Set a MOV[KZ] immediate field to bits [47:32] of X. No overflow check */
+	case R_AARCH64_MOVW_UABS_G2_NC:
+		type = "MOVW_UABS_G2_NC";
+		loc32 = ptr;
+		imm = get_bits(value, 32, 47);
+		*loc32 = cpu_to_le32(le32_to_cpu(*loc32) + (imm << 5));
+		break;
+	/* Set a MOV[KZ] immediate field to bits [63:48] of X */
+	case R_AARCH64_MOVW_UABS_G3:
+		type = "MOVW_UABS_G3";
+		loc32 = ptr;
+		imm = get_bits(value, 48, 63);
+		*loc32 = cpu_to_le32(le32_to_cpu(*loc32) + (imm << 5));
+		break;
+
 	case R_AARCH64_LD_PREL_LO19:
 		type = "LD_PREL_LO19";
 		loc32 = ptr;
-- 
2.31.1


