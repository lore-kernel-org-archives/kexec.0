Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S7BOS-0002uz-Ub
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 19:58:58 +0000
Date: Mon, 12 Mar 2012 15:58:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/2] boot: ignore early NMIs
Message-ID: <20120312195842.GF17288@redhat.com>
References: <4F573E74.5040504@oss.ntt.co.jp> <m1eht31z8e.fsf@fess.ebiederm.org>
 <4F58495B.5080308@oss.ntt.co.jp> <m1r4x3yrsv.fsf@fess.ebiederm.org>
 <4F5A6D87.4050809@zytor.com> <4F5D8D0E.8060702@oss.ntt.co.jp>
 <4F5D8E63.60606@zytor.com> <4F5D943C.5020403@oss.ntt.co.jp>
 <20120312133619.GB17288@redhat.com>
 <m1ipi9prrl.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1ipi9prrl.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu

On Mon, Mar 12, 2012 at 12:02:06PM -0700, Eric W. Biederman wrote:
[..]
> 
> > I personally think that disabling LAPIC is reasonably practical solution
> > to the problem until and unless somebody shows that it deadlocks
> > easily.
> 
> Disabling NMI generation in the LAPIC is fine, and for the short term
> I don't even have a problem with disabling the entire LAPIC as all of
> our platforms seem to have code for completely reprogramming it.
> 
> At the same time there have been cases like the i8259 routed through
> the ExtInt pin of the lapci that we haven't been given programming
> information about and that if we want to work we should avoid touching.
> 
> Furthermore we have two reported cases of people experiencing real NMIs
> on the kdump path.  So we have to assume the presence of the CMOS nmi
> disable as well if we are going to unequivocally disable NMIs.

So Don reported NMI problem only after he stopped disable_local_APIC().
His NMIs were being generated from Local APIC. The only question left
is what kind of NMIs Fernando was seeing.

> 
> Given the variety of x86 hardware today and the growing variety of x86
> hardware tomorrow we are going to be fixing this until we can actually
> handle the NMIs.  Hardware designers are unfortunately creative enough
> that we aren't going to think of everything.  Given that it is has taken
> us almost a decade to realize that there actually is a real world
> problem  I'm not too keen on a solution that is just good enough to
> fix a small problem.

Problem might be small but it has been noticed and fix is simple. That's
a different thing that it might not cover all other cases you mention.

And to begin with problem was with ioapic lock and we are blocking the
that fix because we want NMI handling to be cleaned up too.

So atleast Don's ioapic locking fix should be allowed to go in and then
debate can continue that what's the best fix to handle NMIs from all
sort of situations.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
