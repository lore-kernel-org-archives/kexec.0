Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RxrTl-0007VI-SJ
 for kexec@lists.infradead.org; Thu, 16 Feb 2012 02:53:55 +0000
Date: Wed, 15 Feb 2012 21:53:31 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
Message-ID: <20120216025331.GT9751@redhat.com>
References: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
 <CAE9FiQWRjvu_uNcx_bJXYHeg4D4k6YzHHmSudsq7EyubLi7+nw@mail.gmail.com>
 <20120213152808.GD9751@redhat.com>
 <CAE9FiQXX7BXKuVHZ9NRCEmeTnPj4zVJL5gf5eSp6b+4e3jN3EA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE9FiQXX7BXKuVHZ9NRCEmeTnPj4zVJL5gf5eSp6b+4e3jN3EA@mail.gmail.com>
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

On Mon, Feb 13, 2012 at 08:52:19AM -0800, Yinghai Lu wrote:
> On Mon, Feb 13, 2012 at 7:28 AM, Don Zickus <dzickus@redhat.com> wrote:
> > On Sat, Feb 11, 2012 at 05:04:15PM -0800, Yinghai Lu wrote:
> >> >
> >> > v2: removed the disable lapic code too
> >>
> >> with this commit, kdump is not working anymore on my setups with
> >> Nehalem, Westmere, sandbridge.
> >> these setup all have VT-d enabled.
> >
> > Hi Yinghai,
> >
> > Thanks for the report. =A0Can you attach the .config you were using and=
 what
> > vendor you were using for Nehalem, Westmere and Sandybridge. =A0I'll tr=
y to
> > reproduce it in my lab.
> =

> Sure, please check attached one

For some reason using gzip instead of xz makes things work for me with
your config.

CONFIG_KERNEL_GZIP=3Dy
CONFIG_KERNEL_XZ=3Dn

Do you see the same thing?

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
