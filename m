Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOZC3-0007lD-1I
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 21:31:19 +0000
Date: Mon, 1 Sep 2014 23:30:49 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 3/4] makedumpfile/xen: Fail immediately on every
 architecture if dump level is invalid
Message-ID: <20140901213049.GB3459@olila.local.net-space.pl>
References: <1385993804-27721-1-git-send-email-daniel.kiper@oracle.com>
 <1385993804-27721-4-git-send-email-daniel.kiper@oracle.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C9FF0@BPXM01GP.gisp.nec.co.jp>
 <20131203194501.GD21544@olila.local.net-space.pl>
 <0910DD04CBD6DE4193FCF86B9C00BE971CCA93@BPXM01GP.gisp.nec.co.jp>
 <20131210103949.GJ3916@olila.local.net-space.pl>
 <0910DD04CBD6DE4193FCF86B9C00BE971D10DF@BPXM01GP.gisp.nec.co.jp>
 <0910DD04CBD6DE4193FCF86B9C00BE97250CE3@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97250CE3@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, Aug 29, 2014 at 06:42:18AM +0000, Atsushi Kumagai wrote:
> Hello Daniel,
>
> >On 2013/12/10 19:41:54, kexec <kexec-bounces@lists.infradead.org> wrote:
> >> > > > Did you say that dump level 2 or larger are no longer effective even for x86_64 ?
> >> > > > I thought it works by the patch below, but I'm not sure about Xen.
> >> > > > So I would like to know why you sent this patch.
> >> > > >
> >> > > >
> >> > > > commit ec5b5835a113cf62a168d4a7354564a38de6b52c
> >> > > > Author: ken1_ohmichi <ken1_ohmichi>
> >> > > > Date:   Fri Oct 9 03:05:41 2009 +0000
> >> > > >
> >> > > >     [v1.3.4-10] Add dump filtering on an x86_64 xen domain-0.
> >> > > >
> >> > > >     This patch adds the dump filtering for excluding unnecessary pages (cache
> >> > > >     pages, user process data pages, and free pages) on on x86_64 xen domain-0.
> >> > > >
> >> > > >     On the existing makedumpfile (v1.3.3 or former), a user could specify 0
> >> > > >     or 1 only as a dump_level. By this patch, he/she can specify 2 or larger
> >> > > >     also as a dump_level.
> >> > > >
> >> > > >     Now, this feature is effective on x86_64 machine only.
> >> > >
> >> > > Hmmm... Thanks for this. I missed this patch. However, it looks that I
> >> > > do not understand something. AIUI, from Xen point of view we are not able
> >> > > to use dump level higher than 1 because there is no e.g. cache pages (it
> >> > > looks that we could also skip free pages but this stuff is not implemented).
> >> > > Above mentioned patch suggest that there is a way to extract just only Dom0
> >> > > stuff taking into account Linux internals only. If my reasoning is true
> >> > > then dump level higher than 1 is possible only if we look at Dom0 from Linux
> >> > > point of view.
> >> >
> >> > I've reviewed the code for Xen, my understanding is the same as yours.
> >> > The memory regions corresponding to hypervisor and DomU will remain even if
> >> > specifying the dump level higher than 1.
> >> >
> >> > > However, I can not find any description how to do that.
> >> > > So I am CC-ing Ken'ichi as author of this patch but I do not know that
> >> > > he works for NEC still.
> >> >
> >> > I'm sorry but I missed your point. Did you mention a lack of description
> >> > in man page about an effect when specifying the dump level higher than 1
> >> > for Xen's memory ?
> >> > At least, I still think this patch is wrong because any dump level is
> >> > effective for x86_64.
> >>
> >> Docs are not consistent because man and help displayed from makedumpfile
> >> are different. Additionally, even man says nothing how to use this feature
> >> on Xen vmcore file. If you use makedumpfile e.g.
> >>
> >> makedumpfile -Ed 2 /proc/vmcore vmcore
> >>
> >> it will not work because it uses VMCOREINFO_XEN instead of VMCOREINFO.
> >> I discovered that if you would like to use feature from above mentioned
> >> patch you must run makedumpfile in following way:
> >>
> >> makedumpfile -Ed 2 -x vmlinux /proc/vmcore vmcore
> >>
> >> Then makedumpfile will get info about dom0 directly from vmlinux.
> >
> >Certainly the documents should be fixed as you said, I'll do it.
>
> Sorry for my too late job, how about this fix ?

No problem. I am busy too. I still have patch fixing this
feature for new Xen versions on my long todo list. I hope that
I will be able to work on it at the beginning of next year.

> I'll merge it into v1.5.7 if you have no objection.

Great! Thanks!

> Thanks
> Atsushi Kumagai
>
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Date: Fri, 29 Aug 2014 15:11:27 +0900
> Subject: [PATCH] Fix description about filtering for Xen.
>
> Correct the following points for Xen dump:
>
>   - Add how to filter the pages of domain-0.
>   - Fix the difference between man and help.
>
> Reported-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
