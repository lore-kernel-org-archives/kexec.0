Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from static-213-198-238-194.adsl.eunet.rs ([213.198.238.194]
 helo=fx.arvanta.net)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLv41-0007u6-58
 for kexec@lists.infradead.org; Sat, 19 Oct 2019 20:11:05 +0000
Received: from arya.arvanta.net (arya.arvanta.net [10.5.1.6])
 by fx.arvanta.net (Postfix) with ESMTP id 8150E257E3
 for <kexec@lists.infradead.org>; Sat, 19 Oct 2019 22:10:57 +0200 (CEST)
Date: Sat, 19 Oct 2019 22:10:57 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
Subject: Build failed on Alpine Linux for x86 arch
Message-ID: <20191019201057.GA21551@arya.arvanta.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I'm trying to upgrade kexec-tools to version 2.0.20 on Alpine Linux
(musl libc based) and got error:
kexec/arch/i386/kexec-x86.c:40:4: error: 'multiboot2_x86_usage' undeclared here (not in a function); did you mean 'multiboot_x86_usage'?

Excerpt from build log is attached to this mail.

I changed kexec/arch/i386/kexec-x86.c file with patch attached to this
mail, and then it builds fine but I'm not sure if that patch is correct.

Would anyone review patch and issue, and post comment or fix.

-- 
Tia

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kexec-build.log"

gcc -Os -fomit-frame-pointer -fno-strict-aliasing -Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I./include -I./util_lib/include -Iinclude/  -I./kexec/arch/i386/include  -c -MD -o kexec/arch/i386/kexec-elf-x86.o kexec/arch/i386/kexec-elf-x86.c
gcc -Os -fomit-frame-pointer -fno-strict-aliasing -Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I./include -I./util_lib/include -Iinclude/  -I./kexec/arch/i386/include  -c -MD -o kexec/arch/i386/kexec-elf-rel-x86.o kexec/arch/i386/kexec-elf-rel-x86.c
kexec/arch/i386/kexec-x86.c:39:22: error: 'multiboot2_x86_probe' undeclared here (not in a function); did you mean 'multiboot_x86_probe'?
   39 |  { "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
      |                      ^~~~~~~~~~~~~~~~~~~~
      |                      multiboot_x86_probe
kexec/arch/i386/kexec-x86.c:39:44: error: 'multiboot2_x86_load' undeclared here (not in a function); did you mean 'multiboot_x86_load'?
   39 |  { "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
      |                                            ^~~~~~~~~~~~~~~~~~~
      |                                            multiboot_x86_load
kexec/arch/i386/kexec-x86.c:40:4: error: 'multiboot2_x86_usage' undeclared here (not in a function); did you mean 'multiboot_x86_usage'?
   40 |    multiboot2_x86_usage },
      |    ^~~~~~~~~~~~~~~~~~~~
      |    multiboot_x86_usage
make: *** [Makefile:113: kexec/arch/i386/kexec-x86.o] Error 1
make: *** Waiting for unfinished jobs....
kexec/arch/i386/kexec-x86-common.c: In function 'efi_get_acpi_rsdp':
kexec/arch/i386/kexec-x86-common.c:419:19: warning: format '%lx' expects argument of type 'long unsigned int *', but argument 3 has type 'uint64_t *' {aka 'long long unsigned int *'} [-Wformat=]
  419 |    sscanf(s, "0x%lx", &acpi_rsdp);
      |                 ~~^   ~~~~~~~~~~
      |                   |   |
      |                   |   uint64_t * {aka long long unsigned int *}
      |                   long unsigned int *
      |                 %llx
>>> ERROR: kexec-tools: build failed

--u3/rZRmxL6MmkK24
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="fix-build-on-Alpine-linux.patch"
Content-Transfer-Encoding: quoted-printable

=46rom d390f1f873fa42fa5791ba48f9acf0f41da33632 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Milan=3D20P=3D2E=3D20Stani=3DC4=3D87?=3D <mps@arvanta.n=
et>
Date: Sat, 19 Oct 2019 17:10:16 +0000
Subject: [PATCH] kexec/arch/i386/kexec-x86.c: fix build on Alpine linux x86
 arch

---
 kexec/arch/i386/kexec-x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 444cb69..6001e76 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -36,8 +36,8 @@
 struct file_type file_type[] =3D {
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
-	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
-	  multiboot2_x86_usage },
+	{ "multiboot2-x86", multiboot_x86_probe, multiboot_x86_load,
+	  multiboot_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
 	{ "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
 	{ "beoboot-x86", beoboot_probe, beoboot_load, beoboot_usage },
--=20
2.23.0


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--u3/rZRmxL6MmkK24--

