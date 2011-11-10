Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ROVWP-0004Rr-S0
 for kexec@lists.infradead.org; Thu, 10 Nov 2011 14:22:30 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
 (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
 by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id pAAEMIC5027150
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2011 14:22:18 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAAEMItd2449410
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2011 14:22:18 GMT
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAAEMDHo021919
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2011 07:22:17 -0700
Message-ID: <1320934932.16425.14.camel@br98xy6r>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 10 Nov 2011 15:22:12 +0100
In-Reply-To: <20111109160400.cc2d27d9.akpm@linux-foundation.org>
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Jonas Bonn <jonas@southpole.se>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Don Zickus <dzickus@redhat.com>, linux-arch@vger.kernel.org, "Luck,
 Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, 2011-11-09 at 16:04 -0800, Andrew Morton wrote:
> On Thu, 03 Nov 2011 11:07:24 +0100
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

[snip]

> Ho hum, I guess we stick with the original patch.  It *should* work, as
> long as all archtectures are doing the expected thing.  But in this
> situation it is bad of us to just hope that the architectures are doing
> this.  We should go and find out, rather than waiting for bug reports
> to come in.  Especially because in this case, bugs will take a very
> long time indeed to even be noticed.
> 
> One way to resolve this would be to ask the various arch maintainers!

Hello arch maintainers (from scripts/get_maintainer.pl),

Andrew asked me to contact you in this case.

The main concern of the patch below is that smp_send_stop() might not be
able to stop irq-disabled CPUs. So when two CPUs enter in parallel
panic() and the 2nd one has irqs disabled, with my patch below, perhaps
the 2nd CPU can't be stopped. On s390 and also on x86 (with a patch from
Don Zickus) this is not a problem.

Could you please look at the patch and tell me, if it will work on your
architecture or not. If not, perhaps you have a better idea to solve the
problem.

Michael
---
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

When two CPUs call panic at the same time there is a
possible race condition that can stop kdump. The first
CPU calls crash_kexec() and the second CPU calls
smp_send_stop() in panic() before crash_kexec() finished
on the first CPU. So the second CPU stops the first CPU
and therefore kdump fails:

1st CPU:
panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump

2nd CPU:
panic()->crash_kexec()->kexec_mutex already held by 1st CPU
       ->smp_send_stop()-> stop 1st CPU (stop kdump)

This patch fixes the problem by introducing a spinlock in
panic that allows only one CPU to process crash_kexec() and
the subsequent panic code.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kernel/panic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -59,6 +59,7 @@ EXPORT_SYMBOL(panic_blink);
  */
 NORET_TYPE void panic(const char * fmt, ...)
 {
+	static DEFINE_SPINLOCK(panic_lock);
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0;
@@ -82,6 +83,13 @@ NORET_TYPE void panic(const char * fmt,
 #endif
 
 	/*
+	 * Only one CPU is allowed to execute the panic code from here. For
+	 * multiple parallel invocations of panic all other CPUs will wait on
+	 * the panic_lock. They are stopped afterwards by smp_send_stop().
+	 */
+	spin_lock(&panic_lock);
+
+	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
 	 * Do we want to call this before we try to display a message?






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
