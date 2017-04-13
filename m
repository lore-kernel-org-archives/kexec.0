Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1492085867.20068.4.camel@infradead.org>
Subject: [PATCH 1/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 user-visible messages
From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 13 Apr 2017 13:17:47 +0100
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
Content-Type: multipart/mixed; boundary="===============3813173204466620315=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: mark.rutland@arm.com, panand@redhat.com, ard.biesheuvel@linaro.org, geoff@infradead.org, catalin.marinas@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, sgoel@codeaurora.org, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org


--===============3813173204466620315==
Content-Type: multipart/signed; micalg="sha-256";
	protocol="application/x-pkcs7-signature";
	boundary="=-6x2OegFjYST/PzmBNKUN"


--=-6x2OegFjYST/PzmBNKUN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The IEC binary prefixes (Ki, Mi, Gi, etc.) were published over twenty
years ago. We should use them consistently, especially in user-visible
messages.

Sure, it doesn't often matter, just as *most* typos and spelling or
grammar mistakes don't often matter. But sometimes, such misuse really
do actually introduce ambiguity, and we should avoid that.

Conversely, there is absolutely no good reason *not* to be using the
binary prefixes. Some people once claimed to find them "ugly", or that
they would cause confusion. But those are purely down to unfamiliarity.

The perceived ugliness, and the alleged confusion, will pass with use.

The correctness, and the lack of ambiguity, will not.

ARM64 in particular, as a new platform, has no excuse for not using the
IEC prefixes which predate its existence by a decade and a half.

What's worse is that some people are pointing at the existing errors and
actually claiming that they want their *new* code to be deliberately
wrong in order to be "consistent" with what's there.

So let's fix the user-visible messages in all of arch/arm64 and nip
*that* particular stupidity in the bud...

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/Kconfig        | 22 +++++++++++-----------
 arch/arm64/kernel/efi.c   |  2 +-
 arch/arm64/kernel/setup.c |  2 +-
 arch/arm64/mm/init.c      | 36 ++++++++++++++++++------------------
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3741859..9643223 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -442,7 +442,7 @@ config CAVIUM_ERRATUM_22375
 	  This implements two gicv3-its errata workarounds for ThunderX. Both
 	  with small impact affecting only ITS table allocation.
=20
-	    erratum 22375: only alloc 8MB table size
+	    erratum 22375: only alloc 8MiB table size
 	    erratum 24313: ignore memory access type
=20
 	  The fixes are in ITS initialization and basically ignore memory access
@@ -528,21 +528,21 @@ choice
 	  Page size (translation granule) configuration.
=20
 config ARM64_4K_PAGES
-	bool "4KB"
+	bool "4KiB"
 	help
-	  This feature enables 4KB pages support.
+	  This feature enables 4KiB pages support.
=20
 config ARM64_16K_PAGES
-	bool "16KB"
+	bool "16KiB"
 	help
-	  The system will use 16KB pages support. AArch32 emulation
-	  requires applications compiled with 16K (or a multiple of 16K)
+	  The system will use 16KiB pages support. AArch32 emulation
+	  requires applications compiled with 16KiB (or a multiple of 16KiB)
 	  aligned segments.
=20
 config ARM64_64K_PAGES
-	bool "64KB"
+	bool "64KiB"
 	help
-	  This feature enables 64KB pages support (4KB by default)
+	  This feature enables 64KiB pages support (4KiB by default)
 	  allowing only two levels of page tables and faster TLB
 	  look-up. AArch32 emulation requires applications compiled
 	  with 64K aligned segments.
@@ -1063,9 +1063,9 @@ config COMPAT
 	  the user helper functions, VFP support and the ptrace interface are
 	  handled appropriately by the kernel.
=20
-	  If you use a page size other than 4KB (i.e, 16KB or 64KB), please be aw=
are
-	  that you will only be able to execute AArch32 binaries that were compil=
ed
-	  with page size aligned segments.
+	  If you use a page size other than 4KiB (i.e, 16KiB or 64KiB), please be
+	  aware that you will only be able to execute AArch32 binaries that were
+	  compiled with page size aligned segments.
=20
 	  If you want to execute 32-bit userspace applications, say Y.
=20
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 5d17f37..d80c11f 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -31,7 +31,7 @@ static __init pteval_t create_mapping_protection(efi_memo=
ry_desc_t *md)
 		return PROT_DEVICE_nGnRE;
=20
 	if (WARN_ONCE(!PAGE_ALIGNED(md->phys_addr),
-		      "UEFI Runtime regions are not aligned to 64 KB -- buggy firmware?"=
))
+		      "UEFI Runtime regions are not aligned to 64 KiB -- buggy firmware?=
"))
 		/*
 		 * If the region is not aligned to the page size of the OS, we
 		 * can not use strict permissions, since that would also affect
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42274bd..86de05d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -185,7 +185,7 @@ static void __init setup_machine_fdt(phys_addr_t dt_phy=
s)
 	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
 		pr_crit("\n"
 			"Error: invalid device tree blob at physical address %pa (virtual addre=
ss 0x%p)\n"
-			"The dtb must be 8-byte aligned and must not exceed 2 MB in size\n"
+			"The dtb must be 8-byte aligned and must not exceed 2 MiB in size\n"
 			"\nPlease check your bootloader.",
 			&dt_phys, dt_virt);
=20
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e19e065..85481b9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -111,7 +111,7 @@ static void __init zone_sizes_init(unsigned long min, u=
nsigned long max)
=20
 	memset(zone_size, 0, sizeof(zone_size));
=20
-	/* 4GB maximum for 32-bit only capable devices */
+	/* 4GiB maximum for 32-bit only capable devices */
 #ifdef CONFIG_ZONE_DMA
 	max_dma =3D PFN_DOWN(arm64_dma_phys_limit);
 	zone_size[ZONE_DMA] =3D max_dma - min;
@@ -182,7 +182,7 @@ static int __init early_mem(char *p)
 		return 1;
=20
 	memory_limit =3D memparse(p, &p) & PAGE_MASK;
-	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
+	pr_notice("Memory limited to %lldMiB\n", memory_limit >> 20);
=20
 	return 0;
 }
@@ -242,7 +242,7 @@ void __init arm64_memblock_init(void)
 		 * We can only add back the initrd memory if we don't end up
 		 * with more memory than we can address via the linear mapping.
 		 * It is up to the bootloader to position the kernel and the
-		 * initrd reasonably close to each other (i.e., within 32 GB of
+		 * initrd reasonably close to each other (i.e., within 32 GiB of
 		 * each other) so that all granule/#levels combinations can
 		 * always access both.
 		 */
@@ -292,7 +292,7 @@ void __init arm64_memblock_init(void)
=20
 	early_init_fdt_scan_reserved_mem();
=20
-	/* 4GB maximum for 32-bit only capable devices */
+	/* 4GiB maximum for 32-bit only capable devices */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		arm64_dma_phys_limit =3D max_zone_dma_phys();
 	else
@@ -425,35 +425,35 @@ void __init mem_init(void)
=20
 	pr_notice("Virtual kernel memory layout:\n");
 #ifdef CONFIG_KASAN
-	pr_notice("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+	pr_notice("    kasan   : 0x%16lx - 0x%16lx   (%6ld GiB)\n",
 		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
 #endif
-	pr_notice("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    modules : 0x%16lx - 0x%16lx   (%6ld MiB)\n",
 		MLM(MODULES_VADDR, MODULES_END));
-	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
+	pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GiB)\n",
 		MLG(VMALLOC_START, VMALLOC_END));
-	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .text : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(_text, _etext));
-	pr_notice("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("    .rodata : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(__start_rodata, __init_begin));
-	pr_notice("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .init : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(__init_begin, __init_end));
-	pr_notice("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("      .data : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(_sdata, _edata));
-	pr_notice("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
+	pr_notice("       .bss : 0x%p" " - 0x%p" "   (%6ld KiB)\n",
 		MLK_ROUNDUP(__bss_start, __bss_stop));
-	pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
+	pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KiB)\n",
 		MLK(FIXADDR_START, FIXADDR_TOP));
-	pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MiB)\n",
 		MLM(PCI_IO_START, PCI_IO_END));
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
+	pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GiB maximum)\n",
 		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
-	pr_notice("              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
+	pr_notice("              0x%16lx - 0x%16lx   (%6ld MiB actual)\n",
 		MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
 		    (unsigned long)virt_to_page(high_memory)));
 #endif
-	pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
+	pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MiB)\n",
 		MLM(__phys_to_virt(memblock_start_of_DRAM()),
 		    (unsigned long)high_memory));
=20
@@ -523,7 +523,7 @@ __setup("keepinitrd", keepinitrd_setup);
 static int dump_mem_limit(struct notifier_block *self, unsigned long v, vo=
id *p)
 {
 	if (memory_limit !=3D (phys_addr_t)ULLONG_MAX) {
-		pr_emerg("Memory Limit: %llu MB\n", memory_limit >> 20);
+		pr_emerg("Memory Limit: %llu MiB\n", memory_limit >> 20);
 	} else {
 		pr_emerg("Memory Limit: none\n");
 	}
--=20
2.9.3

--=20
dwmw2
--=-6x2OegFjYST/PzmBNKUN
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
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDQxMzEyMTc0N1owLwYJ
KoZIhvcNAQkEMSIEINBzduCXqC0Zdh99jfgmiDgk7QVif401qMowZa/9tlXQMIHBBgkrBgEEAYI3
EAQxgbMwgbAwgZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAO
BgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01P
RE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQ
WJVTLQRQTeIoEf4aMDCBwwYLKoZIhvcNAQkQAgsxgbOggbAwgZsxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9E
TyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQagtQWJVTLQRQTeIoEf4aMDANBgkqhkiG9w0BAQEFAASC
AQBNIvH2TZmtVADFtKj/eBGz4JDi5RF0S4GI10me3z5FVxlKveDhEzeHubi0qqXiKQ+GQAX+ED7Z
WG6YbL+6tpUUHP5rt0dTuxG/UtA2qC2U5C+dbbaX8kLDTbATawDqsr1P+OP6DaKuEkATrKbPyhNq
0o0hIKC9TvdyMxwD7x+22Fzs140NW7FQKzEYoue8Vy043WE3D2Rlk+SVh42tjykV5EObxT444Kkj
0Q6035K9dX1znDrN1UUyJW0f2YfSbK4EpRpfLW4vMeHhdY0M10Xfd4378GW2u69YLSdme+YXQcO3
aNCbNgKjg/kqG63ml8Wv7LNUGa2Xe9dvYOPOaaLEAAAAAAAA


--=-6x2OegFjYST/PzmBNKUN--



--===============3813173204466620315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3813173204466620315==--


