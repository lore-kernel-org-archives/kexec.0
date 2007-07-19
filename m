Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]
	helo=bifrost.lang.hm)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IBMpk-0006NG-8n
	for kexec@lists.infradead.org; Thu, 19 Jul 2007 04:37:45 +0100
Date: Wed, 18 Jul 2007 20:30:47 -0700 (PDT)
From: david@lang.hm
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
In-Reply-To: <200707191215.05245.nigel@nigel.suspend2.net>
Message-ID: <Pine.LNX.4.64.0707182026130.19248@asgard.lang.hm>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070718180420.02352d4f.akpm@linux-foundation.org>
	<200707191215.05245.nigel@nigel.suspend2.net>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: nigel@suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thu, 19 Jul 2007, Nigel Cunningham wrote:

> Hi.
>
> On Thursday 19 July 2007 11:04:20 Andrew Morton wrote:
>> On Sun, 15 Jul 2007 15:13:13 +0800
>> "Huang, Ying" <ying.huang@intel.com> wrote:
>>
>>>
>>> The changelog between v1 and v2
>>>
>>> 1. The kexec jump implementation is put into the kexec/kdump
>>>    framework instead of software suspend framework. The device
>>>    and CPU state save/restore code of software suspend is called
>>>    when needed.
>>>
>>> 2. The same code path is used for both kexec a new kernel and jump
>>>    back to original kernel.
>>
>> I like the idea but I think I'll let people chat about it a bit more
>> before looking at merging the patches, OK?
>
> Please wait until you see a complete implementation that actually works. I'm
> sitting here quietly, following (and now breaking) the "If you can't say
> anything positive, don't say anything at all" line because I think that the
> more into the implementation details people get, the uglier this is going to
> show itself to be. I'm perfectly willing to be proven wrong, but haven't seen
> anything so far that's even begun to convince me otherwise.

as someone who's eager to have this work, I have to agree with Nigel that 
it's premature to talk about merging anything.

the only exception I could see is if there are other uses for this 
functionality. but even then, let things settle out a little bit.

David Lang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
