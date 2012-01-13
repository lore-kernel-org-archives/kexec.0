Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RlfwP-0000cT-UT
 for kexec@lists.infradead.org; Fri, 13 Jan 2012 12:09:06 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [Crash-utility] x86 remap allocator in kernel 3.0
Date: Fri, 13 Jan 2012 13:06:56 +0100
References: <201201121140.09221.ptesarik@suse.cz>
 <20120113122250tachibana@mail.jp.nec.com>
In-Reply-To: <20120113122250tachibana@mail.jp.nec.com>
MIME-Version: 1.0
Message-Id: <201201131306.56772.ptesarik@suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

Dne P=E1 13. ledna 2012 04:22:50 tachibana@mxm.nes.nec.co.jp napsal(a):
> Hi Petr,
> =

> On 2012/01/12 11:40:08 +0100, Petr Tesarik <ptesarik@suse.cz> wrote:
> > Dne ?t 12. ledna 2012 09:16:06 Atsushi Kumagai napsal(a):
> > > Hello Petr,
> > > =

> > > On Tue, 10 Jan 2012 19:14:32 +0100
> > > =

> > > Petr Tesarik <ptesarik@suse.cz> wrote:
> > > > Ken'ichi Ohmichi, please note that makedumpfile is also affected by
> > > > this deficiency. On my test system, it will fail to produce any
> > > > output if I set dump level to anything greater than zero:
> > > > =

> > > > makedumpfile -c -d 31 -x vmlinux-3.0.13-0.5-pae.debug vmcore kdump.=
31
> > > > readmem: Can't convert a physical address(34a012b4) to offset.
> > > > readmem: type_addr: 0, addr:f4a012b4, size:4
> > > > get_mm_discontigmem: Can't get node_start_pfn.
> > > > =

> > > > makedumpfile Failed.
> > > > =

> > > > However, fixing this for makedumpfile is harder, and it will most
> > > > likely require a few more lines in VMCOREINFO, because debug symbols
> > > > may not be available at dump time, and I can't see any alternative
> > > > method to locate the remapped regions.
> > > =

> > > Thank you for your indication.
> > > =

> > > Could you send me your kernel configuration so that I can reproduce t=
he
> > > issue ?
> > =

> > Attached. The most important settings are:
> > =

> > CONFIG_X86_32=3Dy
> > CONFIG_DISCONTIGMEM_MANUAL=3Dy
> > =

> > This also depends on CONFIG_NUMA=3Dy
> > =

> > FYI my test system runs 3.0.15 (because that's used for SLES11 SP2), but
> > the same issue also exists in any later version.
> > =

> > Petr Tesarik
> > SUSE Linux
> =

> Thank you for the config. I will fix makedumpfile. However it will take
> time to solve various issues because I've never run makedumpfile on 3.0.X.

(crash-utility ML removed from CC.)

I should add something here. I wondered why makedumpfile didn't failed whil=
e =

saving /proc/vmcore. After some futile attempts to recreate the failure, I =

realized that the ELF dump above had been saved with "makedumpfile -d 1" by =

mistake. Now, since the remapped area was unused by the kernel, it was all =

zeroes, so makedumpfile created a hole in the ELF dump.

Under normal conditions, it won't fail to read node_start_pfn, but it will =

incorrectly read it as zero, so no filtering will take place.

Petr Tesarik
SUSE Linux

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
