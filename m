Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OeXVU-00068p-TK
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 18:07:05 +0000
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>
	<20100729134343.GA31490@shamino.rdu.redhat.com>
	<4C519853.2040206@zytor.com>
	<20100729150640.GF31490@shamino.rdu.redhat.com>
	<4C51BFA5.60507@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 29 Jul 2010 11:06:50 -0700
In-Reply-To: <4C51BFA5.60507@zytor.com> (H. Peter Anvin's message of "Thu\,
	29 Jul 2010 10\:51\:33 -0700")
Message-ID: <m1k4oe88n9.fsf@fess.ebiederm.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Horman <nhorman@redhat.com>, Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 07/29/2010 08:06 AM, Neil Horman wrote:
>>>
>>> Sorry, can we keep the discussions of kexec-on-crash and kexec-in-place
>>> clearly separated, please?  The qla driver issue is supposed to be
>>> kexec-in-place, and it sounds like you're talking about kexec-on-crash.
>>>
>> No, I'm just indicating a difference between the two paths, and I'm doing so
>> because we used to have simmilar dma problems in the crash path, which we
>> resolved by not turning of the iommu during shutdown, which is different from
>> the in-place path.  Just trying to give you some thoughts about where to look
>
> Fair enough... just wanted to flag this as a problem, because it has
> already been the source of a lot of confusion.

Thinking about this I am a bit surprised that you would find
DMA left on from a disk driver.  Historically disks have been
pretty good about shutting off in this scenario.

Added to that typically we unmount all filesystems.

Calling rmmod on the driver before the final kexec --exec
could be interesting, and drivers much more reliably implement
.remove than .shutdown.

Network drivers are more likely to be a problem, but we should be
downing all of the network interfaces before something happens.

All of which is to say kexec-in-place has generally been a lot
less hassle, because it is so similar to the normal case.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
