Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JlP1W-00012J-7S
	for kexec@lists.infradead.org; Mon, 14 Apr 2008 13:47:07 +0000
Date: Mon, 14 Apr 2008 09:46:22 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] add new notifier function ,take3
Message-ID: <20080414134622.GB6941@redhat.com>
References: <47FF190B.6030406@ah.jp.nec.com>
	<20080411210751.e4a468b2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080411210751.e4a468b2.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nickpiggin@yahoo.com.au, k-miyoshi@cb.jp.nec.com, greg@kroah.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>

On Fri, Apr 11, 2008 at 09:07:51PM -0700, Andrew Morton wrote:

[..]
> > Kernel panic - not syncing: Panic by panic_module.
> > __tunable_atomic_notifier_call_chain enter
> > msg_handler:panic_event was called.
> > ipmi_wdog:wdog_panic_handler was called.
> > notifier_test: notifier_test_panic() is called.
> > notifier_test: notifier_test_panic2() is called.
> 
> OK.  But I don't see anywhere in here the most important piece of
> information: why do we need this feature in Linux?
> 
> What are the use-cases?  What is the value?  etc.
> 
> Often I can guess (but I like the originator to remove the guesswork).  In
> this case I'm stumped - I can't see any reason why anyone would want this.
> 

Hi Andrew,

To begin with, he wants kdb, kgdb etc to co-exist with kdump. He wants
to put all the RAS tools (who are interested in panic event) on a list
and export it to user space and let user decide in what order do the tool get
executed at panic time (based on priority).

This brings in little bit reliability concerns for kdump due to notifier
code being run after panic.

I think people want to use this infrastrutucure beyond RAS tools. I
remember somebody wanting to send a message to remote node after a
panic (before kdump kicks in)  so that remote node can initiate failover
etc.

Ideally, doing any operation after panic is not safe and one should avoid
such things and any action required should be done in next kernel (like
sending messages to remote nodes etc). Having said that, it makes the
job harder as one needs to pass all the required data to second kernel.

So it will not left to user whether he should execute the code after
panic in first kernel or create required bits to execute code in second
kernel. Things should be more reliable in second kernel. 

I am not very sure how paranoid one should be about this additional bit of
notifier code being executed after panic. Probably we can take this in
to make user's life easier.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
