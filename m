Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OjJDf-0006M5-C5
	for kexec@lists.infradead.org; Wed, 11 Aug 2010 21:52:20 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20100811194734.GD23317@hmsreliant.think-freely.org>
	<4C6301C2.5020808@zytor.com>
Date: Wed, 11 Aug 2010 14:51:39 -0700
In-Reply-To: <4C6301C2.5020808@zytor.com> (H. Peter Anvin's message of "Wed,
	11 Aug 2010 13:02:10 -0700")
Message-ID: <m1zkwsn7h0.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Question regardin intel64 arch and page table setup
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
Cc: kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 08/11/2010 12:47 PM, Neil Horman wrote:
>> Hey all-
>> 	I've got a question regarding x86_64 and how linux uses the paging
>> hardware.  I'm tinkering with ways to get kexec to boot a new kernel on panic
>> without leaving long mode.  The idea being that if we can do that, then we don't
>> need to store the new kdump kernel below the 4G physical limit for 32 bit
>> systems.  In doing this though, I figured I would have to re-initalize the page
>> table with an identity mapped set of page tables to cover all of ram and load
>> that into cr3.  My question is, is it safe to do so while paging is enabled.
>> The docs I've read are unclear on that and if I have to disable paging that
>> automatically drops me out of long mode, which is bad.  I would think its safe
>> to do, since I imagined we had to do on context switches in the scheduler, but
>> the __switch_to implementation for x86_64 sems to do nothing but update the task
>> register.  Intel vol 3a says we need to update cr3, but I don't see where that
>> happens, so I'm not sure if theres some automated bit that does a cr3 update
>> safely when we write tr.
>> 
>> 	Anywho, any guidance, clarification would be appreciated.  Thanks!
>> Neil
>> 
>
> It is definitely safe to load a new CR3 while paging is done; it is done
> all the time.  The currently executing page needs to be mapped to the
> same physical and virtual address in most kernels.
>
> However, there are a *LOT* of issues with having a kernel that is
> completely above 4 GiB.  For one thing, a lot of device drivers simply
> will not work if there is no memory below 4 GiB awavilable to the
> kernel.   As such, I don't think you will be successful in this
> project.

A couple of pieces.
1) The kernel side of kexec and kexec on panic does not leave long mode.
   Long mode is left by the glue code in /sbin/kexec.

2) I agree about the DMA limitation however there are enough systems
   with iommu's these days you may be able to get it to work.

3) I would start just getting the normal kexec case to work.
   The 64bit kernel does support starting at the 64bit entry point,
   but I don't think it has been tested if loaded above 4G.

   It certainly should work and as time goes by I expect running
   a kernel above 4G to become an increasingly interesting use case.
   So it is certainly worth play with.

   But as Peter says having a kernel completely above 4GiB has is likely
   to uncover a lot of baked in assumptions so we real problems might
   result.

   Hmm.  On the normal kexec side you don't loose the low 4GiB so that
   case should be a lot easier to bootstrap with.  Once it works with
   the low 4GiB you can add a mem= or whatever to disable using the low
   4GiB and see what happens.

Have fun.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
