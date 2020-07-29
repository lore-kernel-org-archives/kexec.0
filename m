Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0kVP-0004wq-ME
 for kexec@lists.infradead.org; Wed, 29 Jul 2020 11:44:21 +0000
Subject: [PATCH v6 11/11] ppc64/kexec_file: enable early kernel's OPAL calls
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Wed, 29 Jul 2020 17:14:06 +0530
Message-ID: <159602303975.575379.5032301944162937479.stgit@hbathini>
In-Reply-To: <159602259854.575379.16910915605574571585.stgit@hbathini>
References: <159602259854.575379.16910915605574571585.stgit@hbathini>
MIME-Version: 1.0
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>

Kernel built with CONFIG_PPC_EARLY_DEBUG_OPAL enabled expects r8 & r9
to be filled with OPAL base & entry addresses respectively. Setting
these registers allows the kernel to perform OPAL calls before the
device tree is parsed.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---

v5 -> v6:
* Added Reviewed-by tag from Thiago.
* Moved the patch to end of the series for mpe to take a call on whether
  to have it or not.

v4 -> v5:
* New patch. Updated opal_base & opal_entry values in r8 & r9 respectively.
  This change was part of the below dropped patch in v4:
    - https://lore.kernel.org/patchwork/patch/1275667/


 arch/powerpc/kexec/file_load_64.c      |   20 ++++++++++++++++++++
 arch/powerpc/purgatory/trampoline_64.S |   16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index c6a37ad5a0a4..53bb71e3a2e1 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -876,6 +876,7 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
 			  const void *fdt, unsigned long kernel_load_addr,
 			  unsigned long fdt_load_addr)
 {
+	struct device_node *dn = NULL;
 	int ret;
 
 	ret = setup_purgatory(image, slave_code, fdt, kernel_load_addr,
@@ -903,9 +904,28 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
 					     &image->arch.backup_start,
 					     sizeof(image->arch.backup_start),
 					     false);
+	if (ret)
+		goto out;
+
+	/* Setup OPAL base & entry values */
+	dn = of_find_node_by_path("/ibm,opal");
+	if (dn) {
+		u64 val;
+
+		of_property_read_u64(dn, "opal-base-address", &val);
+		ret = kexec_purgatory_get_set_symbol(image, "opal_base", &val,
+						     sizeof(val), false);
+		if (ret)
+			goto out;
+
+		of_property_read_u64(dn, "opal-entry-address", &val);
+		ret = kexec_purgatory_get_set_symbol(image, "opal_entry", &val,
+						     sizeof(val), false);
+	}
 out:
 	if (ret)
 		pr_err("Failed to setup purgatory symbols");
+	of_node_put(dn);
 	return ret;
 }
 
diff --git a/arch/powerpc/purgatory/trampoline_64.S b/arch/powerpc/purgatory/trampoline_64.S
index e79077ff1355..e6a6e7e6dfe4 100644
--- a/arch/powerpc/purgatory/trampoline_64.S
+++ b/arch/powerpc/purgatory/trampoline_64.S
@@ -87,6 +87,10 @@ master:
 	li	%r4,28
 	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */
 1:
+	/* Load opal base and entry values in r8 & r9 respectively */
+	ld	%r8,(opal_base - 0b)(%r18)
+	ld	%r9,(opal_entry - 0b)(%r18)
+
 	/* load the kernel address */
 	ld	%r4,(kernel - 0b)(%r18)
 
@@ -133,6 +137,18 @@ backup_start:
 	.8byte  0x0
 	.size backup_start, . - backup_start
 
+	.balign 8
+	.globl opal_base
+opal_base:
+	.8byte  0x0
+	.size opal_base, . - opal_base
+
+	.balign 8
+	.globl opal_entry
+opal_entry:
+	.8byte  0x0
+	.size opal_entry, . - opal_entry
+
 	.data
 	.balign 8
 .globl purgatory_sha256_digest



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
