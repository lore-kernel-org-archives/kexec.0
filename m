Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OjHVa-0007uN-SY
	for kexec@lists.infradead.org; Wed, 11 Aug 2010 20:02:43 +0000
Message-ID: <4C6301C2.5020808@zytor.com>
Date: Wed, 11 Aug 2010 13:02:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Question regardin intel64 arch and page table setup
References: <20100811194734.GD23317@hmsreliant.think-freely.org>
In-Reply-To: <20100811194734.GD23317@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com

On 08/11/2010 12:47 PM, Neil Horman wrote:
> Hey all-
> 	I've got a question regarding x86_64 and how linux uses the paging
> hardware.  I'm tinkering with ways to get kexec to boot a new kernel on panic
> without leaving long mode.  The idea being that if we can do that, then we don't
> need to store the new kdump kernel below the 4G physical limit for 32 bit
> systems.  In doing this though, I figured I would have to re-initalize the page
> table with an identity mapped set of page tables to cover all of ram and load
> that into cr3.  My question is, is it safe to do so while paging is enabled.
> The docs I've read are unclear on that and if I have to disable paging that
> automatically drops me out of long mode, which is bad.  I would think its safe
> to do, since I imagined we had to do on context switches in the scheduler, but
> the __switch_to implementation for x86_64 sems to do nothing but update the task
> register.  Intel vol 3a says we need to update cr3, but I don't see where that
> happens, so I'm not sure if theres some automated bit that does a cr3 update
> safely when we write tr.
> 
> 	Anywho, any guidance, clarification would be appreciated.  Thanks!
> Neil
> 

It is definitely safe to load a new CR3 while paging is done; it is done
all the time.  The currently executing page needs to be mapped to the
same physical and virtual address in most kernels.

However, there are a *LOT* of issues with having a kernel that is
completely above 4 GiB.  For one thing, a lot of device drivers simply
will not work if there is no memory below 4 GiB awavilable to the
kernel.   As such, I don't think you will be successful in this project.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
