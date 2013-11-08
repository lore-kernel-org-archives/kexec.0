Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VenmX-0006oo-A7
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 15:15:33 +0000
Date: Fri, 8 Nov 2013 16:15:00 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
Message-ID: <20131108151500.GB3439@olila.local.net-space.pl>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527CE397.10101@citrix.com>
 <527CF3050200007800101354@nat28.tlf.novell.com>
 <527CEEB8.4070609@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <527CEEB8.4070609@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: kexec@lists.infradead.org, Keir Fraser <keir@xen.org>, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <JBeulich@suse.com>, xen-devel@lists.xen.org

On Fri, Nov 08, 2013 at 02:01:28PM +0000, Andrew Cooper wrote:
> On 08/11/13 13:19, Jan Beulich wrote:
> >>>> On 08.11.13 at 14:13, David Vrabel <david.vrabel@citrix.com> wrote:
> >> Keir,
> >>
> >> Sorry, forgot to CC you on this series.
> >>
> >> Can we have your opinion on whether this kexec series can be merged?
> >> And if not, what further work and/or testing is required?
> > Just to clarify - unless I missed something, there was still no
> > review of this from Daniel or someone else known to be
> > familiar with the subject. If Keir gave his ack, formally this
> > could go in, but I wouldn't feel too well with that (the more
> > that apart from not having reviewed it, Daniel seems to also
> > continue to have problems with it).
> >
> > Jan
>
> Can I have myself deemed to be familiar with the subject as far as this
> is concerned?
>
> A noticeable quantity of my contributions to Xen have been in the kexec
> / crash areas, and I am the author of the xen-crashdump-analyser.
>
> I do realise that I certainly not impartial as far as this series is
> concerned, being a co-developer.
>
> Davids statement of "the current implementation is so broken[1] and
> useless[2] that..." is completely accurate.  It is frankly a miracle
> that the current code ever worked at all (and from XenServers point of
> view, failed far more often than it worked).
>
>
> For reference, XenServer 6.2 shipped with approximately v7 of this
> series, and an appropriate kexec-tools and xen-crashdump-analyser.
> Since we put the code in, we have not had a single failure-to-kexec in
> automated testing (both specific crash tests, and from unexpected host
> crashes), whereas we were seeing reliable failures to crash on most of
> our test infrastructure.
>
> In stark contrast to previous versions of XenServer, we have not had a
> single customer reported host crash where the kexec path has failed.
> There was one systematic failure where the HPSA driver was unhappy with
> the state of the hardware, resulting in no root filesystem to write logs
> to, and a repeated panic and Xen deadlock in the queued invalidation
> codepath.

Andrew, if it runs on all your hardware it does not mean that it runs
everywhere. I have discovered the problem (I hope the last one) and it
should be taken into consideration. Another question is what is the
source of this problem. Maybe QEMU but it should be checked and not
ignored.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
