Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XP5pj-000561-Bw
 for kexec@lists.infradead.org; Wed, 03 Sep 2014 08:22:27 +0000
Date: Wed, 3 Sep 2014 16:21:59 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v6 8/8] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140903082159.GF31855@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <1409541340-2719-9-git-send-email-bhe@redhat.com>
 <20140902115230.GA2181@redhat.com>
 <20140902131519.GD31855@dhcp-16-116.nay.redhat.com>
 <20140902132454.GE31855@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97252195@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97252195@BPXM01GP.gisp.nec.co.jp>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 09/03/14 at 08:18am, Atsushi Kumagai wrote:
> >On 09/02/14 at 09:15pm, Baoquan He wrote:
> >> On 09/02/14 at 07:52am, Vivek Goyal wrote:
> >> > On Mon, Sep 01, 2014 at 11:15:40AM +0800, Baoquan He wrote:
> >>
> >> > > ----------------------------------------------------------------------
> >> > ^^^^^
> >> >
> >> > Why this line is there?
> >>
> >> Oh, I thought you just meant the header, not including this line.
> >
> >Since Atsushi has decided to merge it, I would like to adjust this later
> >after v1.5.7.
> >
> >Maybe we can talk about this and the message issue later.
> 
> v1.5.7 will be released within a week, but I'm still receiving 
> such small fix for it.
> 
> >Thanks
> >Baoquan
> >>
> >> >
> >> > > TYPE		PAGES			EXCLUDABLE	DESCRIPTION
> >> > > ZERO		28823           	yes		Pages filled with zero
> >> > > CACHE		197932          	yes		Cache pages
> >> > > CACHE_PRIVATE	15862           	yes		Cache pages + private
> >> > > USER		30778           	yes		User process pages
> >> > > FREE		3671105         	yes		Free pages
> >> > > KERN_DATA	105168          	no		Dumpable kernel data
> >> > >
> >> > > Total pages on system:	4049668
> >> >
> >> > So this is assuming page size 4K? If some arch is using 16K or 64K,
> >> > will it still work correctly.
> >>
> >> This patchset is only for x86_64. Let's firstly introduce this new
> >> feature, if user like it, it can be extended to more ARCHs.
> 
> I've remembered that your patch set doesn't mention the target
> architecture, it's better to update the man page and the help
> message to note that this feature is only for x86_64 for now.
> So could you post an additional patch to do it? I want to merge
> it into v1.5.7 at least.

Sure, right away. Will post soon.

> 
> 
> Thanks
> Atsushi Kumagai
> 
> 
> >>
> >> >
> >> > Thanks
> >> > Vivek
> >> >
> >> > _______________________________________________
> >> > kexec mailing list
> >> > kexec@lists.infradead.org
> >> > http://lists.infradead.org/mailman/listinfo/kexec
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
