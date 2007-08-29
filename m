Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IQDUr-00081D-On
	for kexec@lists.infradead.org; Tue, 28 Aug 2007 22:41:41 -0400
Message-ID: <46D4DCD5.4030601@yahoo.com.au>
Date: Wed, 29 Aug 2007 12:41:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [linux-pm] [RFC][PATCH 0/2 -mm] kexec based hibernation
References: <9D7649D18729DE4BB2BD7B494F7FEDC257EA60@pdsmsx415.ccr.corp.intel.com>
	<1188180997.3247.68.camel@caritas-dev.intel.com>
In-Reply-To: <1188180997.3247.68.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, "Hu,
	Fenghua" <fenghua.hu@intel.com>, Jeremy Maitin-Shepard <jbms@cmu.edu>

Huang, Ying wrote:
> On Mon, 2007-08-27 at 09:28 +0800, Hu, Fenghua wrote:
> 
>>One quick question is, can it improve hiberation/wakeup time?
> 
> 
> In general, for kexec based hibernation, what increases
> hibernation/wakeup time:
> 
> - One extra Linux boot is needed to hibernate and wakeup.
> 
> 
> What decreases hibernation/wakeup time:
> 
> - Most hibernation/wakeup work is done in full functional user space
> program, so it is possible to do some optimization, such as parallel
> compression.

- It does not have to reclaim pagecache before suspend?

- It does not have to restore working set afterwards?

(You could do this to reduce image size, of course, but it can
be optional which is nice).


> So, I think the kexec based hibernation may be slower than original
> implementation in general. In this prototype implementation, the
> hibernation/wakeup time is much longer than original hibernation/wakeup
> implementation. But it has much to be optimized and I think it can
> approach the speed of the original implementation after optimization.

Also, don't just look at the time to do a simple suspend/resume cycle,
but the full cost of going from working state to working state (eg.
grep a kernel tree or two!).

Although the kexec details are out of my league, I really like
everything about the concept :) Nice work.

-- 
SUSE Labs, Novell Inc.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
