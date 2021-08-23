Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 23 Aug 2021 13:55:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 7/9] arm64: kdump: Remove custom linux,elfcorehdr
 handling
Message-ID: <20210823125519.GD8603@arm.com>
References: <cover.1628670468.git.geert+renesas@glider.be>
 <3b8f801f9b92066855e87f3079fafc153ab20f69.1628670468.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b8f801f9b92066855e87f3079fafc153ab20f69.1628670468.git.geert+renesas@glider.be>
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
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Mike Rapoport <rppt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:51:05AM +0200, Geert Uytterhoeven wrote:
> Remove the architecture-specific code for handling the
> "linux,elfcorehdr" property under the "/chosen" node in DT, as the
> platform-agnostic handling in the FDT core code already takes care of
> this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
