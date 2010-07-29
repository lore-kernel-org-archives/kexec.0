Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OeXGz-0002HZ-HX
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 17:52:07 +0000
Message-ID: <4C51BFA5.60507@zytor.com>
Date: Thu, 29 Jul 2010 10:51:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>
	<20100729134343.GA31490@shamino.rdu.redhat.com>
	<4C519853.2040206@zytor.com>
	<20100729150640.GF31490@shamino.rdu.redhat.com>
In-Reply-To: <20100729150640.GF31490@shamino.rdu.redhat.com>
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

On 07/29/2010 08:06 AM, Neil Horman wrote:
>>
>> Sorry, can we keep the discussions of kexec-on-crash and kexec-in-place
>> clearly separated, please?  The qla driver issue is supposed to be
>> kexec-in-place, and it sounds like you're talking about kexec-on-crash.
>>
> No, I'm just indicating a difference between the two paths, and I'm doing so
> because we used to have simmilar dma problems in the crash path, which we
> resolved by not turning of the iommu during shutdown, which is different from
> the in-place path.  Just trying to give you some thoughts about where to look

Fair enough... just wanted to flag this as a problem, because it has
already been the source of a lot of confusion.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
