Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usmamail.tilera.com ([206.83.70.75])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ROWNc-00077m-GH
 for kexec@lists.infradead.org; Thu, 10 Nov 2011 15:17:29 +0000
Message-ID: <4EBBE9B4.3040009@tilera.com>
Date: Thu, 10 Nov 2011 10:11:48 -0500
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
 <1320934932.16425.14.camel@br98xy6r>
In-Reply-To: <1320934932.16425.14.camel@br98xy6r>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Howells <dhowells@redhat.com>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, "James E.J.
 Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, Matt Turner <mattst88@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Don Zickus <dzickus@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Hirokazu Takata <takata@linux-m32r.org>

On 11/10/2011 9:22 AM, Michael Holzheu wrote:
> On Wed, 2011-11-09 at 16:04 -0800, Andrew Morton wrote:
>> On Thu, 03 Nov 2011 11:07:24 +0100
>> Michael Holzheu<holzheu@linux.vnet.ibm.com>  wrote:
> [snip]
>
>> Ho hum, I guess we stick with the original patch.  It *should* work, as
>> long as all archtectures are doing the expected thing.  But in this
>> situation it is bad of us to just hope that the architectures are doing
>> this.  We should go and find out, rather than waiting for bug reports
>> to come in.  Especially because in this case, bugs will take a very
>> long time indeed to even be noticed.
>>
>> One way to resolve this would be to ask the various arch maintainers!
> Hello arch maintainers (from scripts/get_maintainer.pl),
>
> Andrew asked me to contact you in this case.
>
> The main concern of the patch below is that smp_send_stop() might not be
> able to stop irq-disabled CPUs. So when two CPUs enter in parallel
> panic() and the 2nd one has irqs disabled, with my patch below, perhaps
> the 2nd CPU can't be stopped. On s390 and also on x86 (with a patch from
> Don Zickus) this is not a problem.

On tile the smp_send_stop() is delivered via IPIs that respect irq 
disabling, i.e. we wouldn't handle the message on the 2nd cpu in your 
scenario above.

This may not be a problem on many architectures, though.  If one or more 
cpus is blocked in spin_lock(), that may be just as effective from a 
"machine halt" point of view as if those cpus had handled the smp_stop_cpu 
interrupt, which on tile just leaves the cpu with interrupts disabled 
anyway, though sitting on a lower-power "nap" instruction rather than 
spinning trying to acquire the lock.  (It may also be the case that on some 
architectures you need to have shepherded all the cpus into the "machine 
halt" state before you can reboot them, though that's not true on tile.)

If a cleaner API seems useful (either for power reasons or restartability 
or whatever), I suppose a standard global function name could be specified 
that's the thing you execute when you get an smp_send_stop IPI (in tile's 
case it's "smp_stop_cpu_interrupt()") and the panic() code could instead 
just do an atomic_inc_return() of a global panic counter, and if it wasn't 
the first panicking cpu, call directly into the smp_stop handler routine to 
quiesce itself.  Then the panicking cpu could finish whatever it needs to 
do and then halt, reboot, etc., all the cpus.

For what it's worth we do see the condition sometimes when a bunch of cpus 
try to panic near-simultaneously and you get crazy interleaved panic 
output, so I'd certainly support some patch of this nature.
-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
