Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OjMEP-00075o-Av
	for kexec@lists.infradead.org; Thu, 12 Aug 2010 01:05:18 +0000
Date: Wed, 11 Aug 2010 21:05:06 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Question regardin intel64 arch and page table setup
Message-ID: <20100812010506.GB2258@localhost.localdomain>
References: <20100811194734.GD23317@hmsreliant.think-freely.org>
	<4C6301C2.5020808@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4C6301C2.5020808@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, Neil Horman <nhorman@tuxdriver.com>

On Wed, Aug 11, 2010 at 01:02:10PM -0700, H. Peter Anvin wrote:
> On 08/11/2010 12:47 PM, Neil Horman wrote:
> > Hey all-
> > 	I've got a question regarding x86_64 and how linux uses the paging
> > hardware.  I'm tinkering with ways to get kexec to boot a new kernel on panic
> > without leaving long mode.  The idea being that if we can do that, then we don't
> > need to store the new kdump kernel below the 4G physical limit for 32 bit
> > systems.  In doing this though, I figured I would have to re-initalize the page
> > table with an identity mapped set of page tables to cover all of ram and load
> > that into cr3.  My question is, is it safe to do so while paging is enabled.
> > The docs I've read are unclear on that and if I have to disable paging that
> > automatically drops me out of long mode, which is bad.  I would think its safe
> > to do, since I imagined we had to do on context switches in the scheduler, but
> > the __switch_to implementation for x86_64 sems to do nothing but update the task
> > register.  Intel vol 3a says we need to update cr3, but I don't see where that
> > happens, so I'm not sure if theres some automated bit that does a cr3 update
> > safely when we write tr.
> > 
> > 	Anywho, any guidance, clarification would be appreciated.  Thanks!
> > Neil
> > 
> 
> It is definitely safe to load a new CR3 while paging is done; it is done
> all the time.  The currently executing page needs to be mapped to the
> same physical and virtual address in most kernels.
> 
> However, there are a *LOT* of issues with having a kernel that is
> completely above 4 GiB.  For one thing, a lot of device drivers simply
> will not work if there is no memory below 4 GiB awavilable to the
> kernel.   As such, I don't think you will be successful in this project.
> 
> 	-hpa
> 
> 
Thanks for all the info, guys.  I hadn't considered that we couldn't access the
64 bit startup point for the bzImage.  I just figured we could jump to
startup_32 + 0x200 in the bzImage header once I had the page table bit set up
properly.

I hadn't considered the problems we might encounter with driver issues loading
above 4gb and what have you, nor the starting of AP's.  

Regardless, I'll keep tinkering.  One more question.  When setting up the page
table in the panic boot case, is it sufficient to setup an identity map for the
pages in the reserved crashkernel range, or do we need to identity map the
entire range of ram?

Best
Neil

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
