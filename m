Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RLAzH-0000t2-Ct
	for kexec@lists.infradead.org; Tue, 01 Nov 2011 09:50:32 +0000
Message-ID: <4EAFC15C.7010601@redhat.com>
Date: Tue, 01 Nov 2011 17:52:28 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH retry] intel-iommu:make identity_map default for crash dump
References: <20111101091939.GA8985@darkstar.nay.redhat.com>
	<1320140052.2089.5.camel@shinybook.infradead.org>
In-Reply-To: <1320140052.2089.5.camel@shinybook.infradead.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: luyu@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, horms@verge.net.au, vgoyal@redhat.com

On 11/01/2011 05:34 PM, David Woodhouse wrote:

> On Tue, 2011-11-01 at 17:19 +0800, Dave Young wrote:
>> kdump kernel sometimes will get DMAR faults which
>> is caused by random in-flight dma from 1st kernel
>>
>> Here make the identity_mapping as default for this case
> 
> So you want to *allow* the random in-flight DMA? And with an identity
> mapping it's really going to random addresses, since it'll be
> untranslated and won't even go to the physical addresses which it was
> originally intended for?
> 
> This seems entirely broken to me.
> 
> If there is "random in-flight dma" from the first kernel, the correct
> thing to do is *block* it. Which is what we do.
> 


This patch works for me for several cases. For kdump It can be seen a
workaround. But yes blocking the 1st kernel dma is ideal.

Glad to hear that you are working on this.

-- 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
