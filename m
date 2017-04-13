Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1492085938.20068.6.camel@infradead.org>
Subject: [PATCH 2/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 comments etc.
From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 13 Apr 2017 13:18:58 +0100
In-Reply-To: <20170404092604.GB14898@arm.com>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org> <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
 <1491291844.6218.25.camel@infradead.org> <20170404092604.GB14898@arm.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5421181353823188697=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, catalin.marinas@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org


--===============5421181353823188697==
Content-Type: multipart/signed; micalg="sha-256";
	protocol="application/x-pkcs7-signature";
	boundary="=-0zDr41JbMvF84kUoeA1g"


--=-0zDr41JbMvF84kUoeA1g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Less important than in user-visible messages, but still good practice as
there's still no excuse for ARM64 code to look like it was written before
1996.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  2 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |  2 +-
 arch/arm64/boot/dts/broadcom/ns2-xmc.dts           | 24 +++++++++++-------=
----
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |  2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts      |  2 +-
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts      |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  2 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |  2 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  2 +-
 arch/arm64/include/asm/assembler.h                 |  2 +-
 arch/arm64/include/asm/boot.h                      |  4 ++--
 arch/arm64/include/asm/elf.h                       |  2 +-
 arch/arm64/include/asm/fixmap.h                    |  6 +++---
 arch/arm64/kernel/head.S                           |  8 ++++----
 arch/arm64/kernel/hyp-stub.S                       |  2 +-
 arch/arm64/kernel/kaslr.c                          | 14 ++++++-------
 arch/arm64/kernel/module-plts.c                    |  2 +-
 arch/arm64/kernel/vmlinux.lds.S                    | 18 ++++++++--------
 arch/arm64/mm/mmu.c                                |  2 +-
 arch/arm64/mm/proc.S                               |  2 +-
 22 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/a=
rm/juno-base.dtsi
index df539e8..f70fb13 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -694,7 +694,7 @@
=20
 	memory@80000000 {
 		device_type =3D "memory";
-		/* last 16MB of the first memory area is reserved for secure world use b=
y firmware */
+		/* last 16MiB of the first memory area is reserved for secure world use =
by firmware */
 		reg =3D <0x00000000 0x80000000 0x0 0x7f000000>,
 		      <0x00000008 0x80000000 0x1 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/ar=
m64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
index e3a1711..38ece4b 100644
--- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
+++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
@@ -60,7 +60,7 @@
=20
 	memory@80000000 {
 		device_type =3D "memory";
-		reg =3D <0 0x80000000 0 0x80000000>; /* 2GB @ 2GB */
+		reg =3D <0 0x80000000 0 0x80000000>; /* 2GiB @ 2GiB */
 	};
=20
 	gic: interrupt-controller@2c001000 {
diff --git a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts b/arch/arm64/boot/dts=
/broadcom/ns2-xmc.dts
index 99a2723..5908524 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-xmc.dts
@@ -87,36 +87,36 @@
=20
 		partition@0 {
 			label =3D "nboot";
-			reg =3D <0x00000000 0x00280000>; /*  2.5MB */
+			reg =3D <0x00000000 0x00280000>; /*  2.5MiB */
 			read-only;
 		};
=20
 		partition@280000 {
 			label =3D "nenv";
-			reg =3D <0x00280000 0x00040000>; /* 0.25MB */
+			reg =3D <0x00280000 0x00040000>; /* 0.25MiB */
 			read-only;
 		};
=20
 		partition@2c0000 {
 			label =3D "ndtb";
-			reg =3D <0x002c0000 0x00040000>; /* 0.25MB */
+			reg =3D <0x002c0000 0x00040000>; /* 0.25MiB */
 			read-only;
 		};
=20
 		partition@300000 {
 			label =3D "nsystem";
-			reg =3D <0x00300000 0x03d00000>; /*   61MB */
+			reg =3D <0x00300000 0x03d00000>; /*   61MiB */
 			read-only;
 		};
=20
 		partition@4000000 {
 			label =3D "nrootfs";
-			reg =3D <0x04000000 0x06400000>; /*  100MB */
+			reg =3D <0x04000000 0x06400000>; /*  100MiB */
 		};
=20
 		partition@0a400000{
 			label =3D "ncustfs";
-			reg =3D <0x0a400000 0x35c00000>; /*  860MB */
+			reg =3D <0x0a400000 0x35c00000>; /*  860MiB */
 		};
 	};
 };
@@ -156,32 +156,32 @@
=20
 		partition@0 {
 			label =3D "bl0";
-			reg =3D <0x00000000 0x00080000>; /*  512KB */
+			reg =3D <0x00000000 0x00080000>; /*  512KiB */
 		};
=20
 		partition@80000 {
 			label =3D "fip";
-			reg =3D <0x00080000 0x00150000>; /* 1344KB */
+			reg =3D <0x00080000 0x00150000>; /* 1344KiB */
 		};
=20
 		partition@1e0000 {
 			label =3D "env";
-			reg =3D <0x001e0000 0x00010000>;/*    64KB */
+			reg =3D <0x001e0000 0x00010000>;/*    64KiB */
 		};
=20
 		partition@1f0000 {
 			label =3D "dtb";
-			reg =3D <0x001f0000 0x00010000>; /*   64KB */
+			reg =3D <0x001f0000 0x00010000>; /*   64KiB */
 		};
=20
 		partition@200000 {
 			label =3D "kernel";
-			reg =3D <0x00200000 0x00e00000>; /*   14MB */
+			reg =3D <0x00200000 0x00e00000>; /*   14MiB */
 		};
=20
 		partition@1000000 {
 			label =3D "rootfs";
-			reg =3D <0x01000000 0x01000000>; /*   16MB */
+			reg =3D <0x01000000 0x01000000>; /*   16MiB */
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-ls1043a-rdb.dts
index c37110b..71ce1f1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -126,7 +126,7 @@
 	flash@0 {
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
-		compatible =3D "n25q128a13", "jedec,spi-nor";  /* 16MB */
+		compatible =3D "n25q128a13", "jedec,spi-nor";  /* 16MiB */
 		reg =3D <0>;
 		spi-max-frequency =3D <1000000>; /* input clock */
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls2080a.dtsi
index e5935f2..43e549f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -152,7 +152,7 @@
 	memory@80000000 {
 		device_type =3D "memory";
 		reg =3D <0x00000000 0x80000000 0 0x80000000>;
-		      /* DRAM space - 1, size : 2 GB DRAM */
+		      /* DRAM space - 1, size : 2 GiB DRAM */
 	};
=20
 	sysclk: sysclk {
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boo=
t/dts/marvell/berlin4ct-dmp.dts
index fae6c69..4b3a5e2 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
@@ -56,7 +56,7 @@
=20
 	memory@1000000 {
 		device_type =3D "memory";
-		/* the first 16MB is for firmwares' usage */
+		/* the first 16MiB is for firmwares' usage */
 		reg =3D <0 0x01000000 0 0x7f000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boo=
t/dts/marvell/berlin4ct-stb.dts
index d47edad..049018b 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
+++ b/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
@@ -56,7 +56,7 @@
=20
 	memory@1000000 {
 		device_type =3D "memory";
-		/* the first 16MB is for firmwares' usage */
+		/* the first 16MiB is for firmwares' usage */
 		reg =3D <0 0x01000000 0 0x7f000000>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/bo=
ot/dts/renesas/r8a7795-h3ulcb.dts
index c5f8f69..15f57e6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -29,7 +29,7 @@
=20
 	memory@48000000 {
 		device_type =3D "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg =3D <0x0 0x48000000 0x0 0x38000000>;
 	};
=20
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm6=
4/boot/dts/renesas/r8a7795-salvator-x.dts
index 7a8986e..35f7cd2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -52,7 +52,7 @@
=20
 	memory@48000000 {
 		device_type =3D "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg =3D <0x0 0x48000000 0x0 0x38000000>;
 	};
=20
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/bo=
ot/dts/renesas/r8a7796-m3ulcb.dts
index c3f064a..4d1295e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -28,7 +28,7 @@
=20
 	memory@48000000 {
 		device_type =3D "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg =3D <0x0 0x48000000 0x0 0x38000000>;
 	};
=20
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm6=
4/boot/dts/renesas/r8a7796-salvator-x.dts
index c7f40f8..2a019a3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -28,7 +28,7 @@
=20
 	memory@48000000 {
 		device_type =3D "memory";
-		/* first 128MB is reserved for secure area. */
+		/* first 128MiB is reserved for secure area. */
 		reg =3D <0x0 0x48000000 0x0 0x78000000>;
 	};
=20
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/as=
sembler.h
index 1b67c37..56094e2 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -165,7 +165,7 @@ lr	.req	x30		// link register
=20
 /*
  * Pseudo-ops for PC-relative adr/ldr/str <reg>, <symbol> where
- * <symbol> is within the range +/- 4 GB of the PC when running
+ * <symbol> is within the range +/- 4 GiB of the PC when running
  * in core kernel context. In module context, a movz/movk sequence
  * is used, since modules may be loaded far away from the kernel
  * when KASLR is in effect.
diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
index ebf2481..95e26bc 100644
--- a/arch/arm64/include/asm/boot.h
+++ b/arch/arm64/include/asm/boot.h
@@ -6,14 +6,14 @@
=20
 /*
  * arm64 requires the DTB to be 8 byte aligned and
- * not exceed 2MB in size.
+ * not exceed 2MiB in size.
  */
 #define MIN_FDT_ALIGN		8
 #define MAX_FDT_SIZE		SZ_2M
=20
 /*
  * arm64 requires the kernel image to placed
- * TEXT_OFFSET bytes beyond a 2 MB aligned base
+ * TEXT_OFFSET bytes beyond a 2 MiB aligned base
  */
 #define MIN_KIMG_ALIGN		SZ_2M
=20
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 5d17004..28e63ff 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -156,7 +156,7 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
=20
-/* 1GB of VA */
+/* 1GiB of VA */
 #ifdef CONFIG_COMPAT
 #define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
 						0x7ff >> (PAGE_SHIFT - 12) : \
diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixma=
p.h
index caf86be..7e90ab2 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -37,13 +37,13 @@ enum fixed_addresses {
 	FIX_HOLE,
=20
 	/*
-	 * Reserve a virtual window for the FDT that is 2 MB larger than the
+	 * Reserve a virtual window for the FDT that is 2 MiB larger than the
 	 * maximum supported size, and put it at the top of the fixmap region.
 	 * The additional space ensures that any FDT that does not exceed
 	 * MAX_FDT_SIZE can be mapped regardless of whether it crosses any
-	 * 2 MB alignment boundaries.
+	 * 2 MiB alignment boundaries.
 	 *
-	 * Keep this at the top so it remains 2 MB aligned.
+	 * Keep this at the top so it remains 2 MiB aligned.
 	 */
 #define FIX_FDT_SIZE		(MAX_FDT_SIZE + SZ_2M)
 	FIX_FDT_END,
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4fb6ccd..067ddd6 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -45,11 +45,11 @@
 #define __PHYS_OFFSET	(KERNEL_START - TEXT_OFFSET)
=20
 #if (TEXT_OFFSET & 0xfff) !=3D 0
-#error TEXT_OFFSET must be at least 4KB aligned
+#error TEXT_OFFSET must be at least 4KiB aligned
 #elif (PAGE_OFFSET & 0x1fffff) !=3D 0
-#error PAGE_OFFSET must be at least 2MB aligned
+#error PAGE_OFFSET must be at least 2MiB aligned
 #elif TEXT_OFFSET > 0x1fffff
-#error TEXT_OFFSET must be less than 2MB
+#error TEXT_OFFSET must be less than 2MiB
 #endif
=20
 /*
@@ -360,7 +360,7 @@ ENDPROC(preserve_boot_args)
  * Setup the initial page tables. We only setup the barest amount which is
  * required to get the kernel running. The following sections are required=
:
  *   - identity mapping to enable the MMU (low address, TTBR0)
- *   - first few MB of the kernel linear mapping to jump to once the MMU h=
as
+ *   - first few MiB of the kernel linear mapping to jump to once the MMU =
has
  *     been enabled
  */
 __create_page_tables:
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index d3b5f75..9585ea7 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -106,7 +106,7 @@ ENDPROC(\label)
  * be called on each CPU.
  *
  * x0 must be the physical address of the new vector table, and must be
- * 2KB aligned.
+ * 2KiB aligned.
  *
  * Before calling this, you must check that the stub hypervisor is install=
ed
  * everywhere, by waiting for any secondary CPUs to be brought up and then
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index d7e90d9..a5a3068 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -118,9 +118,9 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_off=
set)
 	 * OK, so we are proceeding with KASLR enabled. Calculate a suitable
 	 * kernel image offset from the seed. Let's place the kernel in the
 	 * lower half of the VMALLOC area (VA_BITS - 2).
-	 * Even if we could randomize at page granularity for 16k and 64k pages,
-	 * let's always round to 2 MB so we don't interfere with the ability to
-	 * map using contiguous PTEs
+	 * Even if we could randomize at page granularity for 16KiB and 64KiB
+	 * pages, let's always round to 2 MiB so we don't interfere with the
+	 * ability to map using contiguous PTEs
 	 */
 	mask =3D ((1UL << (VA_BITS - 2)) - 1) & ~(SZ_2M - 1);
 	offset =3D seed & mask;
@@ -129,10 +129,10 @@ u64 __init kaslr_early_init(u64 dt_phys, u64 modulo_o=
ffset)
 	memstart_offset_seed =3D seed >> 48;
=20
 	/*
-	 * The kernel Image should not extend across a 1GB/32MB/512MB alignment
-	 * boundary (for 4KB/16KB/64KB granule kernels, respectively). If this
-	 * happens, increase the KASLR offset by the size of the kernel image
-	 * rounded up by SWAPPER_BLOCK_SIZE.
+	 * The kernel Image should not extend across a 1GiB/32MiB/512MiB
+	 * alignment boundary (for 4KiB/16KiB/64KiB granule kernels,
+	 * respectively). If this happens, increase the KASLR offset by
+	 * the size of the kernel image rounded up by SWAPPER_BLOCK_SIZE.
 	 */
 	if ((((u64)_text + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT) !=3D
 	    (((u64)_end + offset + modulo_offset) >> SWAPPER_TABLE_SHIFT)) {
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plt=
s.c
index 1ce90d8..0d66734 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -118,7 +118,7 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_R=
ela *rela, int num)
 			 * We only have to consider branch targets that resolve
 			 * to undefined symbols. This is not simply a heuristic,
 			 * it is a fundamental limitation, since the PLT itself
-			 * is part of the module, and needs to be within 128 MB
+			 * is part of the module, and needs to be within 128 MiB
 			 * as well, so modules can never grow beyond that limit.
 			 */
 			s =3D syms + ELF64_R_SYM(rela[i].r_info);
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.ld=
s.S
index b8deffa..93b39d6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -25,12 +25,12 @@ jiffies =3D jiffies_64;
=20
 #define HYPERVISOR_TEXT					\
 	/*						\
-	 * Align to 4 KB so that			\
+	 * Align to 4 KiB so that			\
 	 * a) the HYP vector table is at its minimum	\
 	 *    alignment of 2048 bytes			\
 	 * b) the HYP init code will not cross a page	\
 	 *    boundary if its size does not exceed	\
-	 *    4 KB (see related ASSERT() below)		\
+	 *    4 KiB (see related ASSERT() below)	\
 	 */						\
 	. =3D ALIGN(SZ_4K);				\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) =3D .;	\
@@ -60,7 +60,7 @@ jiffies =3D jiffies_64;
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
  * FileAlignment, which we set to its minimum value of 0x200. 'stext'
- * itself is 4 KB aligned, so padding out _edata to a 0x200 aligned
+ * itself is 4 KiB aligned, so padding out _edata to a 0x200 aligned
  * boundary should be sufficient.
  */
 PECOFF_FILE_ALIGNMENT =3D 0x200;
@@ -74,16 +74,16 @@ PECOFF_FILE_ALIGNMENT =3D 0x200;
=20
 #if defined(CONFIG_DEBUG_ALIGN_RODATA)
 /*
- *  4 KB granule:   1 level 2 entry
- * 16 KB granule: 128 level 3 entries, with contiguous bit
- * 64 KB granule:  32 level 3 entries, with contiguous bit
+ *  4 KiB granule:   1 level 2 entry
+ * 16 KiB granule: 128 level 3 entries, with contiguous bit
+ * 64 KiB granule:  32 level 3 entries, with contiguous bit
  */
 #define SEGMENT_ALIGN			SZ_2M
 #else
 /*
- *  4 KB granule:  16 level 3 entries, with contiguous bit
- * 16 KB granule:   4 level 3 entries, without contiguous bit
- * 64 KB granule:   1 level 3 entry
+ *  4 KiB granule:  16 level 3 entries, with contiguous bit
+ * 16 KiB granule:   4 level 3 entries, without contiguous bit
+ * 64 KiB granule:   1 level 3 entry
  */
 #define SEGMENT_ALIGN			SZ_64K
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d28dbcf..5d8b743 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -229,7 +229,7 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long ad=
dr, unsigned long end,
 		next =3D pud_addr_end(addr, end);
=20
 		/*
-		 * For 4K granule only, attempt to put down a 1GB block
+		 * For 4KiB granule only, attempt to put down a 1GiB block
 		 */
 		if (use_1G_block(addr, next, phys) && !page_mappings_only) {
 			pud_set_huge(pud, phys, prot);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 877d42f..daba6ba 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -221,7 +221,7 @@ ENTRY(__cpu_setup)
 	bic	x0, x0, x5			// clear bits
 	orr	x0, x0, x6			// set bits
 	/*
-	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
+	 * Set/prepare TCR and TTBR. We use 512GiB (39-bit) address range for
 	 * both user and kernel.
 	 */
 	ldr	x10, =3DTCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
--=20
2.9.3

--=20
dwmw2
--=-0zDr41JbMvF84kUoeA1g
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDzUw
ggSvMIIDl6ADAgECAhEA4CPLFRKDU4mtYW56VGdrITANBgkqhkiG9w0BAQsFADBvMQswCQYDVQQG
EwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0IEV4dGVybmFsIFRU
UCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290MB4XDTE0MTIyMjAw
MDAwMFoXDTIwMDUzMDEwNDgzOFowgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEw
PwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBF
bWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAImxDdp6UxlOcFIdvFamBia3
uEngludRq/HwWhNJFaO0jBtgvHpRQqd5jKQi3xdhTpHVdiMKFNNKAn+2HQmAbqUEPdm6uxb+oYep
LkNSQxZ8rzJQyKZPWukI2M+TJZx7iOgwZOak+FaA/SokFDMXmaxE5WmLo0YGS8Iz1OlAnwawsayT
QLm1CJM6nCpToxDbPSBhPFUDjtlOdiUCISn6o3xxdk/u4V+B6ftUgNvDezVSt4TeIj0sMC0xf1m9
UjewM2ktQ+v61qXxl3dnUYzZ7ifrvKUHOHaMpKk4/9+M9QOsSb7K93OZOg8yq5yVOhM9DkY6V3Rh
UL7GQD/L5OKfoiECAwEAAaOCARcwggETMB8GA1UdIwQYMBaAFK29mHo0tCb3+sQmVO8DveAky1Qa
MB0GA1UdDgQWBBSSYWuC4aKgqk/sZ/HCo/e0gADB7DAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/
BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEQYDVR0gBAowCDAGBgRV
HSAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9BZGRUcnVzdEV4
dGVybmFsQ0FSb290LmNybDA1BggrBgEFBQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3Nw
LnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQELBQADggEBABsqbqxVwTqriMXY7c1V86prYSvACRAj
mQ/FZmpvsfW0tXdeDwJhAN99Bf4Ss6SAgAD8+x1banICCkG8BbrBWNUmwurVTYT7/oKYz1gb4yJj
nFL4uwU2q31Ypd6rO2Pl2tVz7+zg+3vio//wQiOcyraNTT7kSxgDsqgt1Ni7QkuQaYUQ26Y3NOh7
4AEQpZzKOsefT4g0bopl0BqKu6ncyso20fT8wmQpNa/WsadxEdIDQ7GPPprsnjJT9HaSyoY0B7ks
yuYcStiZDcGG4pCS+1pCaiMhEOllx/XVu37qjIUgAmLq0ToHLFnFmTPyOInltukWeh95FPZKEBom
+nyK+5swggU9MIIEJaADAgECAhBqC1BYlVMtBFBN4igR/howMA0GCSqGSIb3DQEBCwUAMIGbMQsw
CQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3Jk
MRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xp
ZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYxMjIwMDAwMDAwWhcN
MTcxMjIwMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwbTrFaiGdvN2pThnR9q+4eaXB2wQZQNqhter5ZrJ
pPO47e87bZ+f1tmYoh6+rB90G/XN24NErPRfvU4zVzNT9pCtCzSSVnBlZQBpaEYMKhcXo5PGKNsm
An8BoGwNXjlxwbBNRaNO+ky0wNCaMNd1JLxEuvqg9J7rrcpHhWmnpXD5IKa8gv9GyVAJgOpiBOts
p91sShc2kHvWJ5waPEWPCHDH9J+twGGKqKIIU7fdbURLUgUL1wlDSAHf/lgIAVCSj2H2HpoGqHpy
HgOAClX9iRSLNa0Znj8HTaqfOwxXevsz1KkLFY+Ahm426GIEqdfkK2iT6Hhgc7tjNO3f8i5ALQID
AQABo4IB8TCCAe0wHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFILE
dmHLtK6oxmFJZvBhTQhvqrS0MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQA+AfvNhFwtapF5Lzjapgul3zYuEnMfR538Ya1vhP8wuOkcoJeT2gEFXzVO2WUu
eWM0g0/DumnRB53htV/Qq/+vsL0i6a2+iOO7kHi5O7bZkgbdNv0t2lzonDUHi6LTa7NUj+tv+j6y
hW+iNquC3ACP1dIZH8gJmicHblW63qRgp6wxhn315MLBeavi3uiSag2eeKFePiTIwJjN2UYq6kWg
PL5G/Ycf9x/xN1XBTfJiURc0FsXhrA98VMWnt52C5Lo4txhGjzTI+IZg40b3YDs6E7mTYb5KKmbc
QZA9priOFDdj1z5W9BdWhU6I/D0P9y8Z4Tr6+ZscMUVD0RqWy2LeMIIFPTCCBCWgAwIBAgIQagtQ
WJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQsFADCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdy
ZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExp
bWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBMB4XDTE2MTIyMDAwMDAwMFoXDTE3MTIyMDIzNTk1OVowJDEiMCAGCSqG
SIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMG06xWohnbzdqU4Z0favuHmlwdsEGUDaobXq+WayaTzuO3vO22fn9bZmKIevqwfdBv1zduD
RKz0X71OM1czU/aQrQs0klZwZWUAaWhGDCoXF6OTxijbJgJ/AaBsDV45ccGwTUWjTvpMtMDQmjDX
dSS8RLr6oPSe663KR4Vpp6Vw+SCmvIL/RslQCYDqYgTrbKfdbEoXNpB71iecGjxFjwhwx/SfrcBh
iqiiCFO33W1ES1IFC9cJQ0gB3/5YCAFQko9h9h6aBqh6ch4DgApV/YkUizWtGZ4/B02qnzsMV3r7
M9SpCxWPgIZuNuhiBKnX5Ctok+h4YHO7YzTt3/IuQC0CAwEAAaOCAfEwggHtMB8GA1UdIwQYMBaA
FJJha4LhoqCqT+xn8cKj97SAAMHsMB0GA1UdDgQWBBSCxHZhy7SuqMZhSWbwYU0Ib6q0tDAOBgNV
HQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAXBggrBgEFBQcDBAYLKwYBBAGyMQED
BQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYMKwYBBAGyMQECAQEBMCswKQYIKwYB
BQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BTMF0GA1UdHwRWMFQwUqBQoE6GTGh0
dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcmwwgZAGCCsGAQUFBwEBBIGDMIGAMFgGCCsGAQUFBzAChkxodHRwOi8v
Y3J0LmNvbW9kb2NhLmNvbS9DT01PRE9TSEEyNTZDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0R
BBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAPgH7zYRcLWqReS84
2qYLpd82LhJzH0ed/GGtb4T/MLjpHKCXk9oBBV81TtllLnljNINPw7pp0Qed4bVf0Kv/r7C9Iumt
vojju5B4uTu22ZIG3Tb9Ldpc6Jw1B4ui02uzVI/rb/o+soVvojargtwAj9XSGR/ICZonB25Vut6k
YKesMYZ99eTCwXmr4t7okmoNnnihXj4kyMCYzdlGKupFoDy+Rv2HH/cf8TdVwU3yYlEXNBbF4awP
fFTFp7edguS6OLcYRo80yPiGYONG92A7OhO5k2G+Sipm3EGQPaa4jhQ3Y9c+VvQXVoVOiPw9D/cv
GeE6+vmbHDFFQ9Ealsti3jGCA9MwggPPAgEBMIGwMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0Eg
TGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFu
ZCBTZWN1cmUgRW1haWwgQ0ECEGoLUFiVUy0EUE3iKBH+GjAwDQYJYIZIAWUDBAIBBQCgggHzMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDQxMzEyMTg1OFowLwYJ
KoZIhvcNAQkEMSIEIF3vgEBzb/iay+wJSWIrUjdSxY9uoYq08BOq2wgX79ndMIHBBgkrBgEEAYI3
EAQxgbMwgbAwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01P
RE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQ
WJVTLQRQTeIoEf4aMDCBwwYLKoZIhvcNAQkQAgsxgbOggbAwgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQWJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQEFAASC
AQCy5/NEItuOhqt9Cz8AFS/sUZOh9nJCbzDC0L0vsmeiZj/kPYwyz5sC29A1ahsJ2cO6kdAoT50w
j7gvWM7HughhbnXRWS4t+Tgr4cqCOibNTmIWuDogupa82BavBPYYbipO9O+GAvCTQ3Aq7pWhcUCt
+WhUGTk8gsMFgm0oZ8bAsmeJ8c52RmABXtUlZeCQaeoEHBfjWEeI2/NOdDp1HPtmtJeuLVNA9wg/
p6NeGbBAJIZiRTvc4h+diSXm7wy3L2PkpNHLQF/xL1cWZixqVjVt0EFWfpG0mQ677Fgd5qGRc5Mr
W5FsQHtcYGyRmpQCpuRt4KVKzc8skG6SmmRyux+NAAAAAAAA


--=-0zDr41JbMvF84kUoeA1g--



--===============5421181353823188697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5421181353823188697==--


