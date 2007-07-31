Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IFjd9-0004P6-EC
	for kexec@lists.infradead.org; Tue, 31 Jul 2007 00:46:48 -0400
Date: Mon, 30 Jul 2007 21:46:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] Debug handling of early spurious interrupts
Message-Id: <20070730214610.9868cbe3.akpm@linux-foundation.org>
In-Reply-To: <1185848726.23316.50.camel@sebastian.kern.oss.ntt.co.jp>
References: <1184666997.5271.5.camel@sebastian.kern.oss.ntt.co.jp>
	<20070718154659.c8b5ffea.akpm@linux-foundation.org>
	<1184896459.27369.36.camel@sebastian.kern.oss.ntt.co.jp>
	<1184896944.27369.50.camel@sebastian.kern.oss.ntt.co.jp>
	<1184898043.28418.3.camel@sebastian.kern.oss.ntt.co.jp>
	<20070720144302.2785e961.akpm@linux-foundation.org>
	<1185789494.9831.107.camel@sebastian.kern.oss.ntt.co.jp>
	<20070730112223.7b52cf63.akpm@linux-foundation.org>
	<1185848726.23316.50.camel@sebastian.kern.oss.ntt.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Fernando Luis =?ISO-8859-1?B?VuF6cXVleg==?= Cao <fernando@oss.ntt.co.jp>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, 31 Jul 2007 11:25:26 +0900 Fernando Luis V=E1zquez Cao <fernando@os=
s.ntt.co.jp> wrote:

> > runtime.  Some drivers don't get used by many people and users of some
> > architectures (esp embedded) tend to lag kernel.org by a long time.  So=
 it
> > could be years before all the fallout from this change is finally wrapp=
ed
> > up.
> Yes, that is a big concern. However, the same embedded people is
> starting to use both kexec and kdump, so they may suffer the issues we
> are trying to weed out anyway, even if these patches are not applied.
> The difference is that with this new functionality it is possible to
> catch potential problems relatively easily, because any incorrect
> behaviour this may cause will be easily reproducible and, in most cases,
> will reveal itself early at boot time.
> =

> As things stand now, I guess we will keep seeing occasional crashes and
> strange behaviour in kexec-booted kernels, which in some cases will be
> due to incorrect handling of spurious interrupts. Besides, such problems
> are really difficult to reproduce because, commonly, we would need to
> hit an obscure corner case.

Please have a think about what we can do to aid this debugging.  For
example, add an uncondtional printk into request_irq() for now which tells
us what irq is being registered - a print_symbol() of the irq_handler_t
would be pretty good, although I suspect there are a lot of interrupt
handlers with the same name..



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
