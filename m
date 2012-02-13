Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rx4k7-0006dK-J3
 for kexec@lists.infradead.org; Mon, 13 Feb 2012 22:51:33 +0000
Date: Mon, 13 Feb 2012 17:51:15 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
Message-ID: <20120213225115.GT9751@redhat.com>
References: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
 <CAE9FiQWRjvu_uNcx_bJXYHeg4D4k6YzHHmSudsq7EyubLi7+nw@mail.gmail.com>
 <20120213152808.GD9751@redhat.com>
 <CAE9FiQXX7BXKuVHZ9NRCEmeTnPj4zVJL5gf5eSp6b+4e3jN3EA@mail.gmail.com>
 <20120213221258.GP9751@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120213221258.GP9751@redhat.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-tip-commits@vger.kernel.org, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

On Mon, Feb 13, 2012 at 05:12:58PM -0500, Don Zickus wrote:
> On Mon, Feb 13, 2012 at 08:52:19AM -0800, Yinghai Lu wrote:
> > On Mon, Feb 13, 2012 at 7:28 AM, Don Zickus <dzickus@redhat.com> wrote:
> > > On Sat, Feb 11, 2012 at 05:04:15PM -0800, Yinghai Lu wrote:
> > >> >
> > >> > v2: removed the disable lapic code too
> > >>
> > >> with this commit, kdump is not working anymore on my setups with
> > >> Nehalem, Westmere, sandbridge.
> > >> these setup all have VT-d enabled.
> > >
> > > Hi Yinghai,
> > >
> > > Thanks for the report. =A0Can you attach the .config you were using a=
nd what
> > > vendor you were using for Nehalem, Westmere and Sandybridge. =A0I'll =
try to
> > > reproduce it in my lab.
> > =

> > Sure, please check attached one
> =

> Looks like I can reproduce the hang with my original patch and things work
> when we stick the disable_local_APIC() back in there.  I'll keep poking.

Hmm, my config worked fine in both cases, hence why I didn't catch it (its
based on a bloated Fedora config).  I'll look at the differences to see if
something pops out.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
