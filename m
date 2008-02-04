Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from web26703.mail.ukl.yahoo.com ([217.146.176.66])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JM5GQ-0002g5-OP
	for kexec@lists.infradead.org; Mon, 04 Feb 2008 17:37:59 +0000
Date: Mon, 4 Feb 2008 18:37:47 +0100 (CET)
From: Matteo Pampolini <matteo_pampolini@yahoo.it>
Subject: Re: Still on kexec for SH4 architecture, please help
In-Reply-To: <20080204042932.GA27300@linux-sh.org>
MIME-Version: 1.0
Message-ID: <307949.69021.qm@web26703.mail.ukl.yahoo.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: kexec@lists.infradead.org

Hello Paul,

many thanks for your help, we investigated on memory
addresses and fixed some issues. Things do not work,
yet but we hope to see the light soon.

In case we get in trouble again we'll surely let you
know.

Regards,

Matteo.

--- Paul Mundt <lethal@linux-sh.org> ha scritto:

> On Fri, Feb 01, 2008 at 02:35:57PM +0100, Matteo
> Pampolini wrote:
> > ./kexec --load --type=zImage-sh
> > --append="console=ttyAS1,115200"
> --empty-zero=84401000
> > 
> [snip]
> 
> > Starting new kernel
> > kexec information
> >   segment[0]: 0x0c001000 - 0x0c002000 (0x00001000)
> >   segment[1]: 0x0c210000 - 0x0c387000 (0x00177000)
> >   start     : 0x8c210000
> > 
> > illegal slot instruction: 01a0 [#1]
> > 
> > Pid : 92, Comm:                kexec
> > PC is at 0x8c210008
> > PC  : 8c210008 SP  : 8a710000 SR  : 400080f0 TEA :
> > 2966e480    Not tainted
> > R0  : 00000004 R1  : fffffff0 R2  : a0000000 R3  :
> > 00000000
> > R4  : aa7105ec R5  : ac387000 R6  : 8c210000 R7  :
> > 80000000
> > R8  : 00001000 R9  : a0000000 R10 : 8a89c600 R11 :
> > 8a70f000
> > R12 : 8441ab00 R13 : 0a710002 R14 : 00000000
> > MACH: 00000000 MACL: 00000000 GBR : 29573b18 PR  :
> > 84411b02
> > 
> Yes, that's fairly obvious. kexec is trying to load
> the zImage in to RAM
> which simply doesn't exist at this location on your
> platform. The
> original kexec/SH port was done on a landisk, if you
> take a look at
> arch/sh/configs/landisk_defconfig in the kernel you
> can see where these
> values come from.
> 
> kexec/arch/sh/kexec-zImage-sh.c is pretty sparse at
> the moment, and only
> factors in the empty zero page. You likely want to
> extend this for things
> like the boot link offset and other values specific
> to your platform.
> 
> > The empty_zero value is grabbed from System.map,
> but
> > please tell me, why start is 8c210000? I had a
> look at
> 
> P1 (0x80000000) + memory start (0x0c000000) +
> 0x00210000 which is or'ed
> in in zImage_sh_load().
> 
> > kexec sources for SH, saw that some masks are
> applied
> > to addresses, but did not understand why.
> > 
> Mostly because it was written with one target in
> mind, and is in need of
> some hacking so it's more generally useful. I
> suggest you follow the
> approach that the empty zero page definition uses,
> and apply that for
> things like the boot link offset and the other
> relevant values.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 



      ___________________________________ 
L'email della prossima generazione? Puoi averla con la nuova Yahoo! Mail: http://it.docs.yahoo.com/nowyoucan.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
