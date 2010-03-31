Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nx3wr-0007hQ-Qf
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 19:51:35 +0000
Subject: Re: [PATCH] amd iommu: force flush of iommu prior during shutdown
References: <20100331152417.GB13406@hmsreliant.think-freely.org>
	<20100331155430.GF14011@redhat.com>
	<20100331182824.GC13406@hmsreliant.think-freely.org>
	<m1wrwsuxn9.fsf@fess.ebiederm.org>
	<20100331191811.GD13406@hmsreliant.think-freely.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 31 Mar 2010 12:51:25 -0700
In-Reply-To: <20100331191811.GD13406@hmsreliant.think-freely.org> (Neil
	Horman's message of "Wed\, 31 Mar 2010 15\:18\:11 -0400")
Message-ID: <m1sk7guv5u.fsf@fess.ebiederm.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: joerg.roedel@amd.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Neil Horman <nhorman@tuxdriver.com> writes:

> On Wed, Mar 31, 2010 at 11:57:46AM -0700, Eric W. Biederman wrote:
>> Neil Horman <nhorman@tuxdriver.com> writes:
>> 
>> > On Wed, Mar 31, 2010 at 11:54:30AM -0400, Vivek Goyal wrote:
>> 
>> >> So this call amd_iommu_flush_all_devices() will be able to tell devices
>> >> that don't do any more DMAs and hence it is safe to reprogram iommu
>> >> mapping entries.
>> >> 
>> > It blocks the cpu until any pending DMA operations are complete.  Hmm, as I
>> > think about it, there is still a small possibility that a device like a NIC
>> > which has several buffers pre-dma-mapped could start a new dma before we
>> > completely disabled the iommu, althought thats small.  I never saw that in my
>> > testing, but hitting that would be fairly difficult I think, since its literally
>> > just a few hundred cycles between the flush and the actual hardware disable
>> > operation.
>> >
>> > According to this though:
>> > http://support.amd.com/us/Processor_TechDocs/34434-IOMMU-Rev_1.26_2-11-09.pdf
>> > That window could be closed fairly easily, but simply disabling read and write
>> > permissions for each device table entry prior to calling flush.  If we do that,
>> > then flush the device table, any subsequently started dma operation would just
>> > get noted in the error log, which we could ignore, since we're abot to boot to
>> > the kdump kernel anyway.
>> >
>> > Would you like me to respin w/ that modification?
>> 
>> Disabling permissions on all devices sounds good for the new virtualization
>> capable iommus.  I think older iommus will still be challenged.  I think
>> on x86 we have simply been able to avoid using those older iommus.
>> 
>> I like the direction you are going but please let's put this in a
>> paranoid iommu enable routine.
>> 
> You mean like initialize the device table so that all devices are default
> disabled on boot, and then selectively enable them (perhaps during a
> device_attach)?  I can give that a spin.

That sounds good.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
