Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NxjHW-0003mt-I9
	for kexec@lists.infradead.org; Fri, 02 Apr 2010 15:59:39 +0000
Date: Fri, 2 Apr 2010 11:59:32 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/2] x86/amd-iommu: enable iommu before attaching devices
Message-ID: <20100402155932.GA3516@redhat.com>
References: <m1sk7guv5u.fsf@fess.ebiederm.org>
	<20100331202745.GE13406@hmsreliant.think-freely.org>
	<20100401142902.GF24846@8bytes.org>
	<20100401144736.GA14069@shamino.rdu.redhat.com>
	<20100401155643.GG24846@8bytes.org>
	<20100401171149.GH13603@shamino.rdu.redhat.com>
	<20100401201433.GK24846@8bytes.org>
	<20100402000012.GA8930@hmsreliant.think-freely.org>
	<20100402003034.GX29241@sequoia.sous-sol.org>
	<20100402012353.GY29241@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100402012353.GY29241@sequoia.sous-sol.org>
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
To: Chris Wright <chrisw@sous-sol.org>
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>

On Thu, Apr 01, 2010 at 06:23:53PM -0700, Chris Wright wrote:
> Hit another kdump problem as reported by Neil Horman.  When initializaing
> the IOMMU, we attach devices to their domains before the IOMMU is
> fully (re)initialized.  Attaching a device will issue some important
> invalidations.  In the context of the newly kexec'd kdump kernel, the
> IOMMU may have stale cached data from the original kernel.  Because we
> do the attach too early, the invalidation commands are placed in the new
> command buffer before the IOMMU is updated w/ that buffer.  This leaves
> the stale entries in the kdump context and can renders device unusable.
> Simply enable the IOMMU before we do the attach.
> 
> Cc: Neil Horman <nhorman@tuxdriver.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  arch/x86/kernel/amd_iommu_init.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/amd_iommu_init.c
> +++ b/arch/x86/kernel/amd_iommu_init.c
> @@ -1288,6 +1288,8 @@ static int __init amd_iommu_init(void)
>  	if (ret)
>  		goto free;
>  
> +	enable_iommus();
> +
>  	if (iommu_pass_through)
>  		ret = amd_iommu_init_passthrough();
>  	else
> @@ -1300,8 +1302,6 @@ static int __init amd_iommu_init(void)
>  
>  	amd_iommu_init_notifier();
>  
> -	enable_iommus();
> -

Ok, so now we do enable_iommu() before we attach devices and flush DTE and
domain PDE, IO TLB. That makes sense.

Following is just for my education purposes. Trying to understand better
the impact of in-flight DMAs. So IIUC, in kudmp context following seems to be
sequence of events.

1. kernel crashes, we leave IOMMU enabled.

2. boot into capture kernel and we call enable_iommus(). This function
   first disables iommu, sets up new device table and enables iommus
   again.
	a. So during this small window when iommu is disabled and we enable
	   it back, any inflight DMA will passthrough possibly to an
	   unintended physical address as translation is disabled and it
	   can corrupt the kdump kenrel.

	b. Even after enabling the iommu, I guess we will continue to
	   use cached DTE, and translation information to handle any
	   in-flight DMA. The difference is that now iommus are enabled
	   so any in-flight DMA should go to the address as intended in
	   first kenrel and should not corrupt anything.

3. Once iommus are enabled again, we allocated and initilize protection
   domains. We attach devices to domains. In the process we flush the
   DTE, PDE and IO TLBs.

	c. Looks like do_attach->set_dte_entry(), by default gives write
	   permission (IW) to all the devices. I am assuming that at
	   this point of time translation is enabled and possibly unity
	   mapped. If that's the case, any in-flight DMA will not be
	   allowed to happen at unity mapped address and this can possibly
	   corrupt the kernel? 

I understand this patch should fix the case when in second kernel a 
device is not doing DMA because of possibly cached DTE, and translation
information. But looks like in-flight DMA issues will still need a closer
look. But that is a separate issue and needs to be addressed in separate
set of patches.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
