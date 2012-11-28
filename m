Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdcKE-0007X1-OE
 for kexec@lists.infradead.org; Wed, 28 Nov 2012 07:44:57 +0000
Date: Wed, 28 Nov 2012 16:42:31 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 08/10] Add page_is_buddy for PG_buddy
Message-Id: <20121128164231.0aa94c96245a9de386e13601@mxc.nes.nec.co.jp>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AB10B04@G01JPEXMBYT03>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
 <20121116050213.8280.73020.stgit@localhost6.localdomain6>
 <20121127150048.f84d125d86e404c5b177cd58@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB10B04@G01JPEXMBYT03>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Tue, 27 Nov 2012 08:53:00 +0000
"Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:

> > From: kexec-bounces@lists.infradead.org
> > [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Atsushi Kumagai
> > Sent: Tuesday, November 27, 2012 3:01 PM
> > Subject: Re: [PATCH v2 08/10] Add page_is_buddy for PG_buddy
> > 
> > Hello HATAYAMA-san,
> > 
> > On Fri, 16 Nov 2012 14:02:13 +0900
> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> > 
> > > On kernels from v2.6.18 to v2.6.37, buddy page is marked by the
> > > PG_buddy flag.
> > >
> > >   kernel version     | PG_buddy
> > >   ------------------ +---------------------------------
> > >   v2.6.17 to v2.6.26 | 19
> > >   v2.6.27 to v2.6.37 | 19 if CONFIG_PAGEFLAGS_EXTEND=y
> > >                      | 18 otherwise
> > >
> > > We don't need to care about CONFIG_PAGEFLAGS_EXTEND because the
> > > architectures specifying this as y are um and xtensa only. They are
> > > not included in the supported architectures of makedumpfile.
> > 
> > Sorry for too late point out.
> > 
> > I did regression test for v1.5.1 on x86_64 machine in the last weekend
> > and found the issue that page_is_buddy_v2() can't exclude free pages
> > correctly for kernel 2.6.30 to 2.6.37.
> > I checked the configuration of these kernels, I made sure that
> > CONFIG_PAGEFLAGS_EXTENDED was set as y, so PG_buddy=18 is invalid for them.
> > 
> > According to this fact, PG_buddy is variable for the supported architectures
> > of makedumpfile, too.
> > So, how did you confirm that CONFIG_PAGEFLAGS_EXTENDED is only related with
> > um and xtensa ?
> > 
> 
> I guess I used git grep on different kernel source tree.
> 
> > And why did you test with PG_buddy=19 for 2.6.32 when you posted this patch
> > set?
> > 
> > >  - 2.6.32
> > >  NUMBER(PG_slab)=7
> > >  NUMBER(PG_buddy)=19
> > >  OFFSET(page._mapcount)=12
> > >  OFFSET(page.private)=16
> > >  SIZE(pageflags)=4
> > 
> 
> Sorry, I was not aware of this.

OK, I see.
 
> Anyway, the current hard-coded values doesn't work at all since before talking
> about PG_buddy, we cannot get values of page structure's members, such as offset
> value of private member, so non-cyclic is always used instead.
> 
> How about dropping hard-coded values?

It seems better to drop hard-coded values.
vmlinux (or vmcoreinfo) is necessary to get values of page structure's
members and we can get NUMBER(PG_buddy) from vmlinux as well.
So, I think the hard-coding for PG_buddy brings few benefits.

I misunderstood that enumeration values can't be gotten from vmlinux,
so I thought the hard-coding is reasonable.
(I seem to just faced the gcc bug below.)

  http://gcc.gnu.org/bugzilla/show_bug.cgi?id=41065


Anyway, to sum it up:

   1. If vmlinux or vmcoreinfo is prepared and running on cyclic mode,
      page_is_buddy_v2() works correctly for v2.6.18 to v2.6.37.

   2. Otherwise, free list logic is used.
   
I think it's good policy for current kernels.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
