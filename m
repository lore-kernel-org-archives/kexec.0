Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WL0aT-0003N3-9e
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 01:25:34 +0000
Date: Wed, 5 Mar 2014 09:24:13 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: PATCH: bug in locate_hole()
Message-ID: <20140305012413.GE27076@dhcp-16-105.nay.redhat.com>
References: <CAMBSHm_fvPTjdEwgVdyMGPi=3et+JEP-G5TNV986yXWYw35YYw@mail.gmail.com>
 <20140304040331.GG18200@verge.net.au>
 <CAMBSHm_wJw1Ghi6_vRdTF_ZkqQeg=w9zhaNWyhwJ=BNmvrLE_A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMBSHm_wJw1Ghi6_vRdTF_ZkqQeg=w9zhaNWyhwJ=BNmvrLE_A@mail.gmail.com>
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
To: Matthew Fleming <mdf356@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 03/04/14 at 06:55am, Matthew Fleming wrote:
> On Mon, Mar 3, 2014 at 8:03 PM, Simon Horman <horms@verge.net.au> wrote:
> > Thanks Matthew.
> >
> > Could you provide a signed-off-by line?
> 
> I'm not sure what that would look like.  Do I sign off on my own patch?
> 
> Thanks,
> matthew

It's a convention for submitting patch, you can refer to this doc:
https://www.kernel.org/doc/Documentation/SubmittingPatches

Abstract part of them and paste here:

12) Sign your work

To improve tracking of who did what, especially with patches that can
percolate to their final resting place in the kernel through several
layers of maintainers, we've introduced a "sign-off" procedure on
patches that are being emailed around.

The sign-off is a simple line at the end of the explanation for the
patch, which certifies that you wrote it or otherwise have the right to
pass it on as an open-source patch.  The rules are pretty simple: if you
can certify the below:


Baoquan
Thanks

> 
> 
> > On Mon, Mar 03, 2014 at 04:34:35PM -0800, Matthew Fleming wrote:
> >> In upgrading to kexec-tools 2.0.5 I first got the error "Overlapping
> >> memory segments at 0xbeff000"
> >>
> >> Adding some debugging I found locate_hole was returning incorrect
> >> values.  The below is from the debug I added:
> >>
> >> XXXMDF: look for hole size 100000, cur range [52b3000, bffffff] size 6d4cfff
> >> XXXMDF: look for hole memsz=100000, found beff000
> >>
> >> Hmm, if we wanted 0x100000 bytes ending at 0xbffffff, that should be
> >> 0xbf00000, not 0xbef000.  Continuing to the second invocation:
> >>
> >> XXXMDF: look for hole size 1000, cur range [52b3000, befefff] size 6c4bfff
> >> XXXMDF: look for hole size 1000, cur range [bfff000, bffffff] size fff
> >> XXXMDF: look for hole memsz=1000, found bffe000
> >>
> >> Now we die with overlapping ranges, since the 0x100000 bytes at
> >> 0xbeff000 overlaps 0x1000 bytes at 0xbffe000.
> >>
> >> The attached patch fixes the off-by-one that causes the later overlap.
> >>
> >> Thanks,
> >> matthew
> >
> >> --- kexec.c.orig      2014-03-03 16:08:53.289844106 -0800
> >> +++ kexec.c   2014-03-03 16:09:04.960844107 -0800
> >> @@ -272,17 +272,17 @@ unsigned long locate_hole(struct kexec_i
> >>               }
> >>               /* Is there enough space left so we can use it? */
> >>               size = end - start;
> >>               if (!hole_size || size >= hole_size - 1) {
> >>                       if (hole_end > 0) {
> >>                               hole_base = start;
> >>                               break;
> >>                       } else {
> >> -                             hole_base = _ALIGN_DOWN(end - hole_size,
> >> +                             hole_base = _ALIGN_DOWN(end - hole_size + 1,
> >>                                       hole_align);
> >>                       }
> >>               }
> >>       }
> >>       free(mem_range);
> >>       if (hole_base == ULONG_MAX) {
> >>               fprintf(stderr, "Could not find a free area of memory of "
> >>                       "0x%lx bytes...\n", hole_size);
> >
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> >
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
