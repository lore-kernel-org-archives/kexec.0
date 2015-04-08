Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yfnz0-000567-UG
 for kexec@lists.infradead.org; Wed, 08 Apr 2015 11:17:24 +0000
Message-ID: <55250E2A.80106@arm.com>
Date: Wed, 08 Apr 2015 12:16:58 +0100
From: "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] arm64 kexec kernel patches V8
References: <cover.1426793116.git.geoff@infradead.org>
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 19/03/15 20:35, Geoff Levand wrote:
> Hi All,
>
> This series adds the core support for kexec re-boots on arm64.  This v8 o=
f the
> series is mainly just a rebase to Linux-4.0-rc3, and a few very minor cha=
nges
> requested for v7.
>
> To load a second stage kernel and execute a kexec re-boot on arm64 my pat=
ches to
> kexec-tools [2], which have not yet been merged upstream, are needed.
>
> I have tested with the ARM VE fast model, the ARM Base model and the ARM
> Foundation model with various kernel config options for both the first and
> second stage kernels.  Kexec on EFI systems works correctly.  With the AC=
PI
> kernel patches from [3] applied, kexec on ACPI systems seeems to work cor=
rectly.
> More ACPI + kexec testing is needed.
>
> Patch 1 here moves the macros from proc-macros.S to asm/assembler.h so th=
at the
> dcache_line_size macro it defines can be uesd by kexec's relocate kernel
> routine.
>
> Patches 2-4 rework the arm64 hcall mechanism to give the arm64 soft_resta=
rt()
> routine the ability to switch exception levels from EL1 to EL2 for kernel=
s that
> were entered in EL2.
>
> Patches 5-6 add the actual kexec support.
>
> Please consider all patches for inclusion.
>
> [1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
Btw, I get the following build failure for kexec-tools master branch, =

with Linaro tool chain (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro =

GCC 4.9-2014.09 )

  $ ./configure --host=3Daarch64-linux-gnu
  [...]
  $ make -j4
kexec/arch/arm64/kexec-arm64.c: In function =91machine_verify_elf_rel=92:
kexec/arch/arm64/kexec-arm64.c:970:29: error: =91EM_AARCH64=92 undeclared =

(first use in this function)
   return (ehdr->e_machine =3D=3D EM_AARCH64);
                              ^
kexec/arch/arm64/kexec-arm64.c:970:29: note: each undeclared identifier =

is reported only once for each function it appears in
kexec/arch/arm64/kexec-arm64.c:971:1: warning: control reaches end of =

non-void function [-Wreturn-type]
  }
  ^
make: *** [kexec/arch/arm64/kexec-arm64.o] Error 1
make: *** Waiting for unfinished jobs....
----

You may need to add the definition of EM_AARCH64 to include/elf.h and
include that instead of linux/elf.h, like the other archs.


Cheers
Suzuki



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
