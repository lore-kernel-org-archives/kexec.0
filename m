Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <cover.1628670468.git.geert+renesas@glider.be>
 <YRkxzx/1XM3r64Ee@robh.at.kernel.org>
 <CAMuHMdXs0+7K4N0mg6qX6X1cr_8dBr_HdTahdfORMk76wCJcEA@mail.gmail.com>
 <CAL_JsqK63hoEMafLP+5eeQR1qrhOO76J4KEQG_By6QnLfhF=dw@mail.gmail.com>
 <CAMuHMdVNi4bh0Kp43BrVVKD8YY5ac4yi9=W3QZmw=stmwwtuiQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVNi4bh0Kp43BrVVKD8YY5ac4yi9=W3QZmw=stmwwtuiQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 24 Aug 2021 17:43:48 -0500
Message-ID: <CAL_JsqL_D85DWrbOEghNqbqdMaCabSJ5X7zKKJjn2uoB7=XN6g@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Add generic support for kdump DT properties
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Kossifidis <mick@ics.forth.gr>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Frank Rowand <frowand.list@gmail.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Mike Rapoport <rppt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, kexec@lists.infradead.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Aug 24, 2021 at 6:55 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, Aug 23, 2021 at 4:52 PM Rob Herring <robh@kernel.org> wrote:
> > On Mon, Aug 23, 2021 at 5:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sun, Aug 15, 2021 at 5:25 PM Rob Herring <robh@kernel.org> wrote:
> > > > On Wed, Aug 11, 2021 at 10:50:58AM +0200, Geert Uytterhoeven wrote:
> > > > > This patch series adds generic support for parsing DT properties related
> > > > > to crash dump kernels ("linux,elfcorehdr" and "linux,elfcorehdr" under
> > > > > the "/chosen" node), makes use of it on arm32, and performs a few
> > > > > cleanups.  It is an evolution of the combination of [1] and [2].
> > > >
> > > > The DT bits look fine to me. How do you expect this to be merged? I'm
> > > > happy to take it if arch maintainers can ack it.
> > >
> > > I had hoped you could take the series...
> >
> > My current thought is I'll take 2-5, 7 and 8 given that's what I have
> > acks for and the others can be applied independently.
>
> Note that Palmer did ack patch 6, so you can include it.

Right, but Palmer should have taken it if it's for 5.14.

Anyways, I've now applied patches 2-8. If we want to improve the
handling over what arm64 code did as discussed, I think that's a
separate patch anyways.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
