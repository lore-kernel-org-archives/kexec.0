Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqx3o-00082d-4X
 for kexec@lists.infradead.org; Wed, 28 Feb 2018 08:26:02 +0000
Date: Wed, 28 Feb 2018 16:25:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [RESEND makedumpfile PATCH 0/2] Add 5-level paging support
Message-ID: <20180228082545.GC30207@localhost.localdomain>
References: <20180228071308.17854-1-douly.fnst@cn.fujitsu.com>
 <20180228080012.GB30207@localhost.localdomain>
 <1dd96fc3-0ad0-e028-e5f5-900ce2824034@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1dd96fc3-0ad0-e028-e5f5-900ce2824034@cn.fujitsu.com>
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
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: mas-tachibana@vf.jp.nec.com, indou.takao@jp.fujitsu.com, kexec@lists.infradead.org, mas-hayashi@tg.jp.nec.com

On 02/28/18 at 04:12pm, Dou Liyang wrote:
> Hi Baoquan,
> 
> At 02/28/2018 04:00 PM, Baoquan He wrote:
> > Hi dou,
> > 
> > On 02/28/18 at 03:13pm, Dou Liyang wrote:
> > > this patchset adds 5-level paging support in makedumpfile
> > > 
> > >   -the 1th patch does some cleanup for the preparation of 5-level page tables support
> > >   -the 2th patch add the 5-level page tables support
> > > 
> > > Dou Liyang (2):
> > >    arch/x86_64: Cleanup the address translation of the 4-level page
> > >      tables
> > >    arch/x86_64: Add 5-level paging support
> > 
> > It doesn't work on my qemu+la57, kernel 4.16-rc1+. Not sure what kernel
> > you are testing, it truly works on kernel 4.16-rc1+ when cpu la57 is not
> 
> I tested in Linux v4.15+ and v4.16-rc2+.
> 
> The following commits in linux kernel changed mem_section array and
> it causes this problem in makedumpfile.
> 
> commit 83e3c48729d9ebb7af5a31a504f3fd6aff0348c4
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Fri Sep 29 17:08:16 2017 +0300
> 
> commit 629a359bdb0e0652a8227b4ff3125431995fec6e
> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Date:   Tue Nov 7 11:33:37 2017 +0300
> 
> So when I tested makedumpfile, I reverted these commits from kernel
> temporarily.

Hmm, how much memory do you reserve for crashkernel? I am afraid both of
them need be kept in kernel, since makedumpfile need be adapted to kernel,
might be not the opposite. My personal opinion.

So what's your plan about these two reverted commits? Will you change
it in kernel, or just leave it as is and may post another patch to fix
it?

I will take time to check this issue, maybe later. Not sure what
makedumpfile maintainers plan to do about these?

Thanks
Baoquan

> 
> > supported?
> > 
> > Thanks
> > Baoquan
> > 
> > > 
> > >   arch/x86_64.c  | 131 +++++++++++++++++++++++++++++++++++++++++----------------
> > >   makedumpfile.h |  38 +++++++++++------
> > >   2 files changed, 120 insertions(+), 49 deletions(-)
> > > 
> > > -- 
> > > 2.14.3
> > > 
> > > 
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > 
> > 
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
