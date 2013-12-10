Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqKjo-0003tO-SN
 for kexec@lists.infradead.org; Tue, 10 Dec 2013 10:40:25 +0000
Date: Tue, 10 Dec 2013 11:39:49 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 3/4] makedumpfile/xen: Fail immediately on every
 architecture if dump level is invalid
Message-ID: <20131210103949.GJ3916@olila.local.net-space.pl>
References: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
 <1385993804-27721-4-git-send-email-daniel.kiper@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C9FF0@BPXM01GP.gisp.nec.co.jp>
 <20131203194501.GD21544@olila.local.net-space.pl>
 <0910DD04CBD6DE4193FCF86B9C00BE971CCA93@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971CCA93@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Kenichi Oomichi <oomichi@mxs.nes.nec.co.jp>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "david.vrabel@citrix.com" <david.vrabel@citrix.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>

On Mon, Dec 09, 2013 at 02:45:21AM +0000, Atsushi Kumagai wrote:
> On 2013/12/04 4:45:42, kexec <kexec-bounces@lists.infradead.org> wrote:
> > On Tue, Dec 03, 2013 at 05:27:03AM +0000, Atsushi Kumagai wrote:
> > > On 2013/12/02 23:17:59, kexec <kexec-bounces@lists.infradead.org> wrote:
> > > > Do not try to process Xen crash dump on every architecture if dump level
> > > > is invalid. Fail immediately and print relevant error message.
> > > >
> > > > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> > > > ---
> > > >  makedumpfile.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > > index 5a378d1..45f96aa 100644
> > > > --- a/makedumpfile.c
> > > > +++ b/makedumpfile.c
> > > > @@ -7637,14 +7637,14 @@ initial_xen(void)
> > > >  		MSG("Try `makedumpfile --help' for more information.\n");
> > > >  		return FALSE;
> > > >  	}
> > > > -#ifndef __x86_64__
> > > > +
> > > >  	if (DL_EXCLUDE_ZERO < info->max_dump_level) {
> > > >  		MSG("Dump_level is invalid. It should be 0 or 1.\n");
> > > >  		MSG("Commandline parameter is invalid.\n");
> > > >  		MSG("Try `makedumpfile --help' for more information.\n");
> > > >  		return FALSE;
> > > >  	}
> > > > -#endif
> > > > +
> > >
> > > Did you say that dump level 2 or larger are no longer effective even for x86_64 ?
> > > I thought it works by the patch below, but I'm not sure about Xen.
> > > So I would like to know why you sent this patch.
> > >
> > >
> > > commit ec5b5835a113cf62a168d4a7354564a38de6b52c
> > > Author: ken1_ohmichi <ken1_ohmichi>
> > > Date:   Fri Oct 9 03:05:41 2009 +0000
> > >
> > >     [v1.3.4-10] Add dump filtering on an x86_64 xen domain-0.
> > >
> > >     This patch adds the dump filtering for excluding unnecessary pages (cache
> > >     pages, user process data pages, and free pages) on on x86_64 xen domain-0.
> > >
> > >     On the existing makedumpfile (v1.3.3 or former), a user could specify 0
> > >     or 1 only as a dump_level. By this patch, he/she can specify 2 or larger
> > >     also as a dump_level.
> > >
> > >     Now, this feature is effective on x86_64 machine only.
> >
> > Hmmm... Thanks for this. I missed this patch. However, it looks that I
> > do not understand something. AIUI, from Xen point of view we are not able
> > to use dump level higher than 1 because there is no e.g. cache pages (it
> > looks that we could also skip free pages but this stuff is not implemented).
> > Above mentioned patch suggest that there is a way to extract just only Dom0
> > stuff taking into account Linux internals only. If my reasoning is true
> > then dump level higher than 1 is possible only if we look at Dom0 from Linux
> > point of view.
>
> I've reviewed the code for Xen, my understanding is the same as yours.
> The memory regions corresponding to hypervisor and DomU will remain even if
> specifying the dump level higher than 1.
>
> > However, I can not find any description how to do that.
> > So I am CC-ing Ken'ichi as author of this patch but I do not know that
> > he works for NEC still.
>
> I'm sorry but I missed your point. Did you mention a lack of description
> in man page about an effect when specifying the dump level higher than 1
> for Xen's memory ?
> At least, I still think this patch is wrong because any dump level is
> effective for x86_64.

Docs are not consistent because man and help displayed from makedumpfile
are different. Additionally, even man says nothing how to use this feature
on Xen vmcore file. If you use makedumpfile e.g.

makedumpfile -Ed 2 /proc/vmcore vmcore

it will not work because it uses VMCOREINFO_XEN instead of VMCOREINFO.
I discovered that if you would like to use feature from above mentioned
patch you must run makedumpfile in following way:

makedumpfile -Ed 2 -x vmlinux /proc/vmcore vmcore

Then makedumpfile will get info about dom0 directly from vmlinux.
However, It looks that there is another bug which prevents usage
of this feature. It looks it is related to change in P2M tree Linux
code. Once P2M levels where changed from 2 to 3. I fixed similar
issue in crash tool once.

When are you going to make a new makedumpfile release? I am going
to fix this issue before next release but now I am quite busy
with other stuff.

Could you apply patches 1, 2 and 4 from this patch series?
It looks that they are not controversial.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
