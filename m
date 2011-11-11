Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1ROqFP-0003ym-Gp
 for kexec@lists.infradead.org; Fri, 11 Nov 2011 12:30:20 +0000
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1321014494.2745.7.camel@br98xy6r>
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
 <1320934932.16425.14.camel@br98xy6r> <4EBBE9B4.3040009@tilera.com>
 <1321014494.2745.7.camel@br98xy6r>
Date: Fri, 11 Nov 2011 06:30:08 -0600
Message-ID: <1321014608.5161.11.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Howells <dhowells@redhat.com>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S.
 Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, "James E.J.
 Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, Matt Turner <mattst88@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Don Zickus <dzickus@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Helge Deller <deller@gmx.de>

On Fri, 2011-11-11 at 13:28 +0100, Michael Holzheu wrote:
> Hello Chris,
> 
> On Thu, 2011-11-10 at 10:11 -0500, Chris Metcalf wrote:
> > On 11/10/2011 9:22 AM, Michael Holzheu wrote:
> 
> [snip]
> 
> > If a cleaner API seems useful (either for power reasons or restartability 
> > or whatever), I suppose a standard global function name could be specified 
> > that's the thing you execute when you get an smp_send_stop IPI (in tile's 
> > case it's "smp_stop_cpu_interrupt()") and the panic() code could instead 
> > just do an atomic_inc_return() of a global panic counter, and if it wasn't 
> > the first panicking cpu, call directly into the smp_stop handler routine to 
> > quiesce itself.  Then the panicking cpu could finish whatever it needs to 
> > do and then halt, reboot, etc., all the cpus.
> 
> Thanks for the info. So introducing a "weak" function that can stop the
> CPU it is running on could solve the problem. Every architecture can
> override the function with something appropriate. E.g. "tile" can use
> the lower-power "nap" instruction there.
> 
> What about the following patch.

Since we're discussing architecture stuff, could we move back to the
architecture list?  This thread keeps moving off it and it's not
helping.

James



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
