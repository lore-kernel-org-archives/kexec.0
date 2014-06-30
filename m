Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X1Wyv-0007LC-Pg
 for kexec@lists.infradead.org; Mon, 30 Jun 2014 08:30:34 +0000
Date: Mon, 30 Jun 2014 16:29:06 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 0/3] makedumpfile: Reduce the risk of OOM.
Message-ID: <20140630082906.GB1704@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE972196B4@BPXM01GP.gisp.nec.co.jp>
 <20140630054847.GA1704@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723A590@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9723A590@BPXM01GP.gisp.nec.co.jp>
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

On 06/30/14 at 07:45am, Atsushi Kumagai wrote:
> >Hi Atsushi,
> >
> >Since complaint has been got from our user about the oom issue, and it's
> >still a little longer time to get to 1.5.7, could you please merge this
> >patchset firstly to devel branch, then we can back port it with a valid
> >commit id which will be consistent?
> 
> I've done it, here you are:
> 
> http://git.code.sf.net/p/makedumpfile/code
>     - [PATCH 3/3] Stop maximizing the bitmap buffer to reduce the risk of OOM. (by Atsushi Kumagai) 0b73282
>     - [PATCH 2/3] Move counting pfn_memhole for cyclic mode. (by Atsushi Kumagai) 2648a8f
>     - [PATCH 1/3] Remove the 1st bitmap buffer from the ELF path in cyclic mode. (by Atsushi Kumagai) 16b94ab

Got it!  Thanks a lot, Atsushi!

> 
> 
> Thanks
> Atsushi Kumagai
> 
> 
> >Thanks
> >Baoquan
> >
> >On 06/10/14 at 04:51am, Atsushi Kumagai wrote:
> >> Hello,
> >>
> >> makedumpfile tries maximizing the bitmap buffer size to get the
> >> best performance, but it occasionally cause OOM because the safe
> >> limit is variable and it can be too aggressive depending on the
> >> situation.
> >>
> >> I think reliability is more important than performance for dump
> >> tools, so I decided to remove the maximization. I don't worry
> >> about performance degradation, please see [PATCH 3/3].
> >>
> >> If there is no objection, I'll merge this patch into v1.5.7.
> >>
> >> BTW, an expert user still can try to maximize the bitmap buffer with
> >> --cyclic-buffer option.
> >>
> >> Atsushi Kumagai (3):
> >>       Remove the 1st bitmap buffer from the ELF path in cyclic mode.
> >>       Move counting pfn_memhole for cyclic mode.
> >>       Stop maximizing the bitmap buffer to reduce the risk of OOM.
> >>
> >>  makedumpfile.8 |   1 -
> >>  makedumpfile.c | 117
> >++++++++++++++++++++------------------------------------------------------------------------------
> >>  print_info.c   |   1 -
> >>  3 files changed, 24 insertions(+), 95 deletions(-)
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> >
> >_______________________________________________
> >kexec mailing list
> >kexec@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
