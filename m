Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OeUej-0006fB-Mq
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 15:04:25 +0000
Message-ID: <4C519853.2040206@zytor.com>
Date: Thu, 29 Jul 2010 08:03:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>
	<20100729134343.GA31490@shamino.rdu.redhat.com>
In-Reply-To: <20100729134343.GA31490@shamino.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On 07/29/2010 06:43 AM, Neil Horman wrote:
> On Wed, Jul 28, 2010 at 03:02:19PM -0700, Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>>
>>> We are getting a claim that the qla driver corrupts memory after a
>>> kexec, apparently due to a DMA engine left running in the before-kernel.
>>>
>>> For an in-place kexec (as opposed to a crash dump kexec, where we switch
>>> into dedicated memory), what shutdown paths get executed?
>>
>> It is the normal reboot path, so the device shutdown method gets
>> executed.
>>
>> Eric
>>
> Check your iommu.  We've had lots of problems with them in the past, and in the
> crash path we explicity leave the iommu on now, whereas the normal shutdown path
> turns it off.  If some other dma-capable device doesn't shut down properly and
> keeps dma operations going, you're liable to get memory corruption when the
> iommu re-initalizes.  
> 

Sorry, can we keep the discussions of kexec-on-crash and kexec-in-place
clearly separated, please?  The qla driver issue is supposed to be
kexec-in-place, and it sounds like you're talking about kexec-on-crash.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
