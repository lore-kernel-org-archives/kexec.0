Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeovC-00088F-Kq
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 16:28:35 +0000
Date: Fri, 8 Nov 2013 17:28:02 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
Message-ID: <20131108162802.GC3439@olila.local.net-space.pl>
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <20131107211651.GC11159@olila.local.net-space.pl>
 <527CE397.10101@citrix.com>
 <527CF3050200007800101354@nat28.tlf.novell.com>
 <527CEEB8.4070609@citrix.com>
 <20131108151500.GB3439@olila.local.net-space.pl>
 <20131108154251.GC24755@phenom.dumpdata.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131108154251.GC24755@phenom.dumpdata.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Keir Fraser <keir@xen.org>, Andrew Cooper <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <JBeulich@suse.com>

On Fri, Nov 08, 2013 at 10:42:51AM -0500, Konrad Rzeszutek Wilk wrote:
> On Fri, Nov 08, 2013 at 07:15:00AM -0800, Daniel Kiper wrote:
> > On Fri, Nov 08, 2013 at 02:01:28PM +0000, Andrew Cooper wrote:
> > > On 08/11/13 13:19, Jan Beulich wrote:
> > > >>>> On 08.11.13 at 14:13, David Vrabel <david.vrabel@citrix.com> wrote:
> > > >> Keir,
> > > >>
> > > >> Sorry, forgot to CC you on this series.
> > > >>
> > > >> Can we have your opinion on whether this kexec series can be merged?
> > > >> And if not, what further work and/or testing is required?
> > > > Just to clarify - unless I missed something, there was still no
> > > > review of this from Daniel or someone else known to be
> > > > familiar with the subject. If Keir gave his ack, formally this
> > > > could go in, but I wouldn't feel too well with that (the more
> > > > that apart from not having reviewed it, Daniel seems to also
> > > > continue to have problems with it).
> > > >
> > > > Jan
> > >
> > > Can I have myself deemed to be familiar with the subject as far as this
> > > is concerned?
> > >
> > > A noticeable quantity of my contributions to Xen have been in the kexec
> > > / crash areas, and I am the author of the xen-crashdump-analyser.
> > >
> > > I do realise that I certainly not impartial as far as this series is
> > > concerned, being a co-developer.
> > >
> > > Davids statement of "the current implementation is so broken[1] and
> > > useless[2] that..." is completely accurate.  It is frankly a miracle
> > > that the current code ever worked at all (and from XenServers point of
> > > view, failed far more often than it worked).
> > >
> > >
> > > For reference, XenServer 6.2 shipped with approximately v7 of this
> > > series, and an appropriate kexec-tools and xen-crashdump-analyser.
> > > Since we put the code in, we have not had a single failure-to-kexec in
> > > automated testing (both specific crash tests, and from unexpected host
> > > crashes), whereas we were seeing reliable failures to crash on most of
> > > our test infrastructure.
> > >
> > > In stark contrast to previous versions of XenServer, we have not had a
> > > single customer reported host crash where the kexec path has failed.
> > > There was one systematic failure where the HPSA driver was unhappy with
> > > the state of the hardware, resulting in no root filesystem to write logs
> > > to, and a repeated panic and Xen deadlock in the queued invalidation
> > > codepath.
> >
> > Andrew, if it runs on all your hardware it does not mean that it runs
> > everywhere. I have discovered the problem (I hope the last one) and it
> > should be taken into consideration. Another question is what is the
> > source of this problem. Maybe QEMU but it should be checked and not
> > ignored.
>
> I think the question is that the feature freeze is the 18th - and whether
> this single bug should halt the integration of this whole patchset.
>
> Or that it is OK to put in the patchset in and deal with the bugs
> and not stall this initial patchset.

I have never stated that I would like to block this patch series
indefinitely due to this one bug (I am still not sure that this
is a bug; Currently, I feel that I am only one person who tries
to verify that). We have more then one week and I think that we
are able to discover what is going on. If not I think that we
can workout reasonable solution for this issue (as we did in other
cases). Last but not least, I would like to underline that I wish
that this patch series were included in Xen 4.4 too. However,
it must be done in sensible way.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
