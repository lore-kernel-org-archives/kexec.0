Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S779V-0004P8-Fb
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 15:27:15 +0000
Date: Mon, 12 Mar 2012 10:41:40 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 1/2] boot: ignore early NMIs
Message-ID: <20120312144140.GU24378@redhat.com>
References: <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
 <4F573E74.5040504@oss.ntt.co.jp> <m1eht31z8e.fsf@fess.ebiederm.org>
 <4F58495B.5080308@oss.ntt.co.jp> <m1r4x3yrsv.fsf@fess.ebiederm.org>
 <4F5A6D87.4050809@zytor.com> <4F5D8D0E.8060702@oss.ntt.co.jp>
 <4F5D8E63.60606@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F5D8E63.60606@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, vgoyal@redhat.com

On Sun, Mar 11, 2012 at 10:49:23PM -0700, H. Peter Anvin wrote:
> On 03/11/2012 10:43 PM, Fernando Luis V=E1zquez Cao wrote:
> =

> > =

> > To tackle this issue we can either stop the hardlockup detector
> > or disable the LAPIC (the NMIs needed by x86's hardlockup detector
> > are generated using performance counters in the LAPIC), leaving
> > the I/O APICs untouched. The second is simpler and I think it
> > is the approach Don took to fix this issue in RHEL kernels.
> > =

> > Unfortunately, this is not enough, we are still exposed to external
> > NMIs not routed through the LAPIC. In other words, we have to make
> > sure that we always have and IDT that is able to handle NMIs without
> > seemingly random reboots and lockups. To achieve this goal we need
> > to fix machine_kexec() and the early IDT handlers. The current patch
> > set takes care of the latter.
> > =

> =

> The only source of NMIs other than the LAPIC should be the system error
> which can be disabled through the RTC port, so I think your second
> paragraph here is way more mechanism than you need for very little gain.

I forgot about the RTC port.  I can't seem to find the documentation for
it, but I believe it was port 0x70?  That would cover external NMIs I
believe.  Leaving the disable_lapic would cover internal NMIs.

I don't know how far do we want to go with installing stub idt handlers
and such.  Honestly, I just wanted to i/o apic race condition fixed.

http://lkml.indiana.edu/hypermail/linux/kernel/1202.3/02533.html

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
