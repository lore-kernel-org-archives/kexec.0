Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LMlZ8-0003fT-Ih
	for kexec@lists.infradead.org; Tue, 13 Jan 2009 15:52:33 +0000
In-Reply-To: <20090112062359.GK7337@verge.net.au>
References: <kexec-29-1.miltonm@bga.com> <20090112062359.GK7337@verge.net.au>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <db22d11838af3c43c4624a8d2f0b0883@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 0/5 + 2] kexec updates
Date: Tue, 13 Jan 2009 09:59:08 -0600
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, "M. Mohan Kumar" <mohan@in.ibm.com>, kexec@lists.infradead.org

On Jan 12, 2009, at 12:24 AM, Simon Horman wrote:
> On Fri, Jan 02, 2009 at 02:42:38PM -0600, Milton Miller wrote:
>> Follwing this mail are 5 patches for kexec userspace and two for the
>> kernel.  The first fixes an array overflow and the second updates
>> userspace to the merged 2.6.28 kdump support.  The remaining are
>> cleanups and warning fixes, including one for the common code.
>>
>> The two patchs for the kernel are independent.
>
> Hi all,
>
> sorry to be a bit slow in responding, this email landed just
> as I was leaving for a weeks holiday.
>

No problem, I figured as much.

> The kexec-tools patches seem reasonable to me and I'm happy to merge 
> what I
> think are the latest versions - thanks Michael for your review.
>
> Milton, here are the Subjects, Dates and Message-Ids of what I have in 
> my
> queue.  If you could confirm this or repost that would be great.
>
> #1
> Subject: [PATCH kexec-tools v2] ppc64: always check number of ranges 
> when adding them
> Date: Thu, 08 Jan 2009 06:33:50 -0600
> Message-ID: <1231418030_141769@mercury.realtime.net>
>
> #2
> Subject: [PATCH kexec-tools 2/5] ppc64: update kdump for 2.6.28 
> relocatable kernel
> Date: Fri, 02 Jan 2009 15:04:42 -0600
> Message-Id: <kexec-29-1-2r.miltonm@bga.com>
>
> #3
> Subject: [PATCH kexec-tools 3/5] ppc64: segments may be reordered
> Date: Fri, 02 Jan 2009 15:04:45 -0600
> Message-Id: <kexec-29-1-3r.miltonm@bga.com>
>
> #4
> Subject: [PATCH kexec-tools 4/5] ppc64: cleanups
> Date: Fri, 02 Jan 2009 15:04:48 -0600
> Message-Id: <kexec-29-1-4r.miltonm@bga.com>
>
> #5
> Subject: [PATCH kexec-tools 5/5] entry wants to be void *
> Date: Fri, 02 Jan 2009 15:04:51 -0600
> Message-Id: <kexec-29-1-5r.miltonm@bga.com>

Based on the subjects, yes, those are the lastest versions.

And I assume you saw Mohan's tested message.

Thanks,
milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
