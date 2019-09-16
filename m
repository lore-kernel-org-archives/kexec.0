Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9rlD-0003zv-PA
 for kexec@lists.infradead.org; Mon, 16 Sep 2019 14:13:49 +0000
Date: Mon, 16 Sep 2019 16:13:42 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: Fix PAGE_OFFSET for kernels since 4.20
Message-ID: <20190916141342.7zlqivdz4ljigplq@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpOnsY6T6GrDn7mFkGSRR4KCjveuE=a=f928ahMuG26n1g@mail.gmail.com>
 <1d8f474a-4ed1-4b83-7e70-36504dfa6f69@molgen.mpg.de>
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
To: Donald Buczek <buczek@molgen.mpg.de>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

On Mon, Sep 16, 2019 at 12:47:00PM +0200, Donald Buczek wrote:
> On 9/16/19 9:23 AM, Simon Horman wrote:
> > On Mon, Sep 09, 2019 at 10:33:11AM +0530, Bhupesh Sharma wrote:
> > > Sorry Guys,
> > > 
> > > On Tue, Sep 3, 2019 at 11:36 PM Donald Buczek <buczek@molgen.mpg.de> wrote:
> > > > 
> > > > Dear Simon,
> > > > 
> > > > On 03.09.19 16:41, Simon Horman wrote:
> > > > > On Fri, Aug 30, 2019 at 11:12:58AM +0200, Donald Buczek wrote:
> > > > > > Linux kernel commit d52888aa2753 ("x86/mm: Move LDT remap out of KASLR
> > > > > > region on 5-level paging") changed the base of the direct mapping
> > > > > > from 0xffff880000000000 to 0xffff888000000000. This was merged
> > > > > > into v4.20-rc2.
> > > > > > 
> > > > > > Update to new address accordingly.
> > > > > 
> > > > > Thanks, applied for inclusion in v2.0.20.
> > > > 
> > > > I must admit, that I overlooked that d52888aa2753 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging") was backported to 4.19.5 as 4074ca7d8a18 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging").
> > > > 
> > > > Bhupesh Sharma wanted to look into a a dynamic solution, which, of course, would be better. But if you still want to include this (e.g. as the fallback for the dynamic solution), you might want to replace the patch with the following one, which selects the new PAGE_OFFSET starting from kernel version 4.19.5 instead of 4.20.0.
> > > 
> > > I was in a conference last week and was not able to connect to my test
> > > machine(s) to develop and test a more generic fix, as I suggested in
> > > my earlier message.
> > > 
> > > I will try to work on and send a generic fix in a couple of days.
> > 
> > Thanks,
> > 
> > I think it would be best if this patch,
> > 23b67f048dde ("x86: Fix PAGE_OFFSET for kernels since 4.20"),
> > was reverted.
> > 
> > Donald, Bhupesh, what do you think?
> 
> The original patch is technically correct and fixes the problem for 4.20 kernels, so I don't know, why it should be reverted.
> 
> My replacement patch was to address 4.19 kernels as well. But if the original patch has already been comitted and published, it should not be replaced of course. 4.20 kernels should be addressed by a separate patch on top of it instead.
> 
> As I'm not subscribed to the kexec list, I may have missed the latest news, however.

On Mon, Sep 16, 2019 at 04:21:20PM +0530, Bhupesh Sharma wrote:
> Hi Simon,
> 
> On Mon, Sep 16, 2019 at 12:53 PM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Mon, Sep 09, 2019 at 10:33:11AM +0530, Bhupesh Sharma wrote:

...

> > Thanks,
> >
> > I think it would be best if this patch,
> > 23b67f048dde ("x86: Fix PAGE_OFFSET for kernels since 4.20"),
> > was reverted.
> >
> > Donald, Bhupesh, what do you think?
> 
> I am still working on a correct fix for this issue, so I would think
> we can keep Donald' patch for now.
> Once my fix is ready and it is accepted after reviews, I think we can
> revert Donald's patch.
> 
> Thanks,
> Bhupesh
> 

Thanks Donald, thanks Bhupesh.

I will leave 23b67f048dde ("x86: Fix PAGE_OFFSET for kernels since 4.20")
in the tree and look forward to the follow-up work from Bhupesh.

Kind regards,
Simon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
