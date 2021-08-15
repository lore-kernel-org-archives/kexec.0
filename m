Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Sun, 15 Aug 2021 10:25:03 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 0/9] Add generic support for kdump DT properties
Message-ID: <YRkxzx/1XM3r64Ee@robh.at.kernel.org>
References: <cover.1628670468.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1628670468.git.geert+renesas@glider.be>
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
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Mike Rapoport <rppt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:50:58AM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds generic support for parsing DT properties related
> to crash dump kernels ("linux,elfcorehdr" and "linux,elfcorehdr" under
> the "/chosen" node), makes use of it on arm32, and performs a few
> cleanups.  It is an evolution of the combination of [1] and [2].

The DT bits look fine to me. How do you expect this to be merged? I'm 
happy to take it if arch maintainers can ack it.

> 
> The series consists of 6 parts:
>   1. Patch 1 prepares architecture-specific code (needed for MIPS only)
>      to avoid duplicating elf core header reservation later.
>   2. Patch 2 prepares the visibility of variables used to hold
>      information retrieved from the DT properties.
>   3. Patches 3-5 add support to the FDT core for handling the
>      properties.
>      This can co-exist safely with architecture-specific handling, until
>      the latter has been removed.

Looks like patch 5 doesn't have any dependencies with the series?

>   4. Patch 6 removes the non-standard handling of "linux,elfcorehdr" on
>      riscv.

I thought this should be applied for 5.14?

>   5. Patches 7-8 convert arm64 to use the generic handling instead of
>      its own implementation.
>   6. Patch 9 adds support for kdump properties to arm32.
>      The corresponding patch for kexec-tools is "[PATCH] arm: kdump: Add
>      DT properties to crash dump kernel's DTB"[3], which is still valid.

This one can be applied on its own, right?

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
