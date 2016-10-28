Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzyaz-0006KK-SK
 for kexec@lists.infradead.org; Fri, 28 Oct 2016 04:16:47 +0000
Received: by mail-qk0-f173.google.com with SMTP id v138so17949930qka.0
 for <kexec@lists.infradead.org>; Thu, 27 Oct 2016 21:16:24 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH V2] arm64: Add support of R_AARCH64_PREL32 relocation in
 purgatory
Date: Fri, 28 Oct 2016 09:46:09 +0530
Message-Id: <f970f7938109c40833fc45e3d6d72b1dcdf14595.1477627895.git.panand@redhat.com>
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
To: geoff@infradead.org, horms@verge.net.au
Cc: Pratyush Anand <panand@redhat.com>, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

gcc version in fedora koji is  6.2.1-2.fc25. kexec-tools compiled with this
gcc produced another relocation error:

machine_apply_elf_rel: ERROR Unknown type: 261

This patch fixes the above error.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
v1 -> v2: fixed line width to less than 80 chars

 kexec/arch/arm64/kexec-arm64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 218f0bc832cd..eb0c3b87354e 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -720,6 +720,10 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 # define R_AARCH64_ABS64 257
 #endif
 
+#if !defined(R_AARCH64_PREL32)
+# define R_AARCH64_PREL32 261
+#endif
+
 #if !defined(R_AARCH64_LD_PREL_LO19)
 # define R_AARCH64_LD_PREL_LO19 273
 #endif
@@ -761,6 +765,12 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
 		loc64 = ptr;
 		*loc64 = cpu_to_elf64(ehdr, elf64_to_cpu(ehdr, *loc64) + value);
 		break;
+	case R_AARCH64_PREL32:
+		type = "PREL32";
+		loc32 = ptr;
+		*loc32 = cpu_to_elf32(ehdr,
+			elf32_to_cpu(ehdr, *loc32) + value - address);
+		break;
 	case R_AARCH64_LD_PREL_LO19:
 		type = "LD_PREL_LO19";
 		loc32 = ptr;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
