Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IFVZR-0003Sb-UZ
	for kexec@lists.infradead.org; Mon, 30 Jul 2007 09:46:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [patch] add kdump_after_notifier
References: <469F55D0.4050203@ah.jp.nec.com> <20070726140702.GA8949@suse.de>
	<20070726153240.GA15969@in.ibm.com> <20070726153440.GA19095@suse.de>
	<20070726154415.GB15969@in.ibm.com> <20070726154718.GA25561@suse.de>
	<20070726155444.GC15969@in.ibm.com> <46A92E30.8070703@ah.jp.nec.com>
	<20070730091624.GB6071@in.ibm.com>
Date: Mon, 30 Jul 2007 07:42:59 -0600
In-Reply-To: <20070730091624.GB6071@in.ibm.com> (Vivek Goyal's message of
	"Mon, 30 Jul 2007 14:46:24 +0530")
Message-ID: <m16442vwgs.fsf@ebiederm.dsl.xmission.com>
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
To: vgoyal@in.ibm.com
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal <vgoyal@in.ibm.com> writes:

>> Bernhard's idea (kdump uses panic_notifier) is very good for me. But it isn't
>> good for kdump user, because they want to take a dump ASAP when panicked.
>> 
>
> This one is better than registering kdump as one of the users of a
> panic_notifier() list. 
>
> I think if there are any crash specific actions, they should be taken care
> in next kernel while it is booting.
>
> If something is really very time critical, and has to be done immediately
> after panic (I am not sure how can one ensure that given the fact any number
> of users can register on panic_notifier_list and you are not sure about your
> order in the list and when one will get the control), then probably that
> piece of code should be in kernel and called before crash_kexec().
>
> What is that specific piece of action which you can't do in second kernel?
>
> Eric, do you have any thoughts on this. I think these guys are referring
> to failover problem where immediately after panic() they want to send
> message to other node.

My thoughts are roughly the same as they were last time this was suggested.
I think adding a notifier to the kexec on panic path is a bad idea.
This functionality  sounds wrong, because it makes it hard to ensure
reliability of the kexec on panic code path.  We are still doing to
much on it as it stands. The working assumption on that code path
needs to be the kernel is broken. Anything else is just asking for
trouble.

Currently we do have a hook in place for code to be called. It is called
the purgatory section of /sbin/kexec.  And it's user space so you can
do whatever you want there.  Or you can wait until the second kernel
gets more fully booted.

If we really need to do something in the kernel we can patch the kernel
to make a function call from crash_kexec.  We don't need any notifiers
to do this.

A further problem with notifiers is they mess up the state we would
like to debug.  Which again makes them a problem.


So at least until a specific case is made for a specific piece of code
to get in I am totally opposed to the idea.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
