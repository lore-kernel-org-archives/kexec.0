Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nxpm4-0002y0-91
	for kexec@lists.infradead.org; Fri, 02 Apr 2010 22:55:37 +0000
Subject: Re: [PATCH 1/2] x86/amd-iommu: enable iommu before attaching devices
References: <20100331202745.GE13406@hmsreliant.think-freely.org>
	<20100401142902.GF24846@8bytes.org>
	<20100401144736.GA14069@shamino.rdu.redhat.com>
	<20100401155643.GG24846@8bytes.org>
	<20100401171149.GH13603@shamino.rdu.redhat.com>
	<20100401201433.GK24846@8bytes.org>
	<20100402000012.GA8930@hmsreliant.think-freely.org>
	<20100402003034.GX29241@sequoia.sous-sol.org>
	<20100402012353.GY29241@sequoia.sous-sol.org>
	<20100402155932.GA3516@redhat.com>
	<20100402223809.GB29241@sequoia.sous-sol.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 02 Apr 2010 15:55:25 -0700
In-Reply-To: <20100402223809.GB29241@sequoia.sous-sol.org> (Chris Wright's
	message of "Fri\, 2 Apr 2010 15\:38\:09 -0700")
Message-ID: <m1pr2hmplu.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Chris Wright <chrisw@sous-sol.org> writes:

> * Vivek Goyal (vgoyal@redhat.com) wrote:
>> Following is just for my education purposes. Trying to understand better
>> the impact of in-flight DMAs. So IIUC, in kudmp context following seems to be
>> sequence of events.
>> 
>> 1. kernel crashes, we leave IOMMU enabled.
>
> No, we actually disable the IOMMU
>
> panic()
>   crash_exec()
>     machine_crash_shutdown()
>       native_machine_crash_shutdown()
>         x86_platform.iommu_shutdown() == amd_iommu_init.c::disable_iommus()

That call exists but is there any good reason for it?
Nothing should be on that can be reasonably done anywhere else.
This round of bug fixing and testing would be a good time to remove
that extraneous call.

>> 2. boot into capture kernel and we call enable_iommus(). This function
>>    first disables iommu, sets up new device table and enables iommus
>>    again.
>> 	a. So during this small window when iommu is disabled and we enable
>> 	   it back, any inflight DMA will passthrough possibly to an
>> 	   unintended physical address as translation is disabled and it
>> 	   can corrupt the kdump kenrel.
>
> Yes, should be possible.
>
>> 	b. Even after enabling the iommu, I guess we will continue to
>> 	   use cached DTE, and translation information to handle any
>> 	   in-flight DMA. The difference is that now iommus are enabled
>> 	   so any in-flight DMA should go to the address as intended in
>> 	   first kenrel and should not corrupt anything.
>
> Cached DTE only gets you domainID and pt root, so results depend upon
> other caches too.
>
>> 3. Once iommus are enabled again, we allocated and initilize protection
>>    domains. We attach devices to domains. In the process we flush the
>>    DTE, PDE and IO TLBs.
>
> Yes, but this is immediately after 2b above.  We can't send the invalidate
> commands until the iommu is enabled.
>
>> 	c. Looks like do_attach->set_dte_entry(), by default gives write
>> 	   permission (IW) to all the devices. I am assuming that at
>> 	   this point of time translation is enabled and possibly unity
>> 	   mapped.
>
> Unlikely to have full unity map, it's typically just for a range,
> and this is also typically for devices that have interaction w/ BIOS
> (typical examples are usb/SMM for keyboard and integrated graphics).
> And the mapping is to reserved memory areas (BIOS regions).  On my test
> box, for example, there are none of the BIOS specified ranges.
>
>>	   If that's the case, any in-flight DMA will not be
>> 	   allowed to happen at unity mapped address and this can possibly
>> 	   corrupt the kernel? 
>
> I don't understand what you mean there.
>
>> I understand this patch should fix the case when in second kernel a 
>> device is not doing DMA because of possibly cached DTE, and translation
>> information. But looks like in-flight DMA issues will still need a closer
>> look. But that is a separate issue and needs to be addressed in separate
>> set of patches.
>
> All of the in-flight DMA corrupts kdump kernel memory issues can exist
> w/out an IOMMU.  On the one hand, the IOMMU actually reduces the window
> of opportunity, but on the other it adds possible translation issue.

?
If disabling the IOMMU changes the destination in RAM of in-flight DMA
the issues are not at all the same.

> About the only thing we can do here is modify the crashing kernel to
> update the DTE to disable dma, invalidate, and leave IOMMU enabled.
> This is all in the context of crashing, so any further errors here mean
> we probably won't get to kdump kernel.

Why even touch the IOMMU?

> The kexec'd kernel will still need to defensively prepare things as it
> always does since it can't trust anything that came before it.


Yes.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
