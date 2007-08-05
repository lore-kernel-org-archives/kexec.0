Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.ocs.com.au ([203.34.248.175])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IHVox-0005lF-EX
	for kexec@lists.infradead.org; Sat, 04 Aug 2007 22:26:21 -0400
From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [RFC] Handling kernel stack overflows 
In-reply-to: Your message of "Fri, 03 Aug 2007 06:36:23 CST."
	<m11wekn6bc.fsf@ebiederm.dsl.xmission.com> 
Mime-Version: 1.0
Date: Sun, 05 Aug 2007 12:25:11 +1000
Message-ID: <32465.1186280711@ocs10w.ocs.com.au>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>

Eric W. Biederman (on Fri, 03 Aug 2007 06:36:23 -0600) wrote:
>
>Well we currently keep a struct thread_info on the stack
>which while not as bad as task_struct has it's own uses
>and implications which may limit what you are trying
>to do.

Not an issue.  We already copy struct thread_info when switching stacks
on i386 with 4K stacks.  x86_64 always has multiple stacks, but uses
thread_info in the first stack, even on a stack switch.

>That said a function like:
>
>int call_on_new_stack(int (*continuation)(void *), void *closure)
>{
>	struct task_struct *tsk;
>	struct thread_info *ti;
>
>	if (plenty_of_stack_space())
>		return continuation(closure);
>
>	tsk = current();
>	ti = alloc_thread_info(tsk);
>	if (!ti)
>		return -ENOMEM;
>
>	setup_extra_thread_info(tsk, ti, continuation, closure);
>	schedule();
>}
>
>Might make sense.  Last I heard the block layer and xfs seemed
>to have largely solved their problems with running short on stack
>space, so I don't know if it is necessary but it certainly sounds
>relatively simple and interesting.

Solved for simple configurations.  But when you start nesting
flesystems, especially if a network filesystem is involved, then the
small amounts of stack used by each subsystem add up fast.

>Running short on stack space is a recurring theme so a function that
>allows us to have a little more when we really need it and be able to
>switch even x86_64 to 4K stacks would be interesting.

4K stacks on x86_64 are not a real option.  If i386 needs 4K then
x86_64 needs twice as much just to handle the doubling of pointers and
saved arguments.

>I'm not quite certain where we could insert calls to call_on_new_stack,

It has to be at a point that can return an error.  The best place is at
the start of the block and VFS layers, if those layers can detect that
they are about to do a nested call.  For example, crypto over loopback
over ext3 over NFS over software raid over SCSI.  The loopback, ext3
and NFS layers are nested filesystems calls, crypto is not.  The SCSI
layer is a nested block layer call, software raid is not.  So loopback,
ext3, NFS and SCSI would switch to a new stack if necessary.

>but it looks simple enough that it is worth coding up and playing
>with.

I have just resigned and will be taking a long break away from
computers.  Feel free to play with the idea, otherwise I will look at
it again sometime in October.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
