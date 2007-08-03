Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IGwQu-00046H-2V
	for kexec@lists.infradead.org; Fri, 03 Aug 2007 08:39:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC] Handling kernel stack overflows
References: <31700.1186113953@kao2.melbourne.sgi.com>
Date: Fri, 03 Aug 2007 06:36:23 -0600
In-Reply-To: <31700.1186113953@kao2.melbourne.sgi.com> (Keith Owens's message
	of "Fri, 03 Aug 2007 14:05:53 +1000")
Message-ID: <m11wekn6bc.fsf@ebiederm.dsl.xmission.com>
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
To: Keith Owens <kaos@ocs.com.au>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Takenori Nagano <t-nagano@ah.jp.nec.com>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>


Well we currently keep a struct thread_info on the stack
which while not as bad as task_struct has it's own uses
and implications which may limit what you are trying
to do.

That said a function like:

int call_on_new_stack(int (*continuation)(void *), void *closure)
{
	struct task_struct *tsk;
	struct thread_info *ti;

	if (plenty_of_stack_space())
		return continuation(closure);

	tsk = current();
	ti = alloc_thread_info(tsk);
	if (!ti)
		return -ENOMEM;

	setup_extra_thread_info(tsk, ti, continuation, closure);
	schedule();
}

Might make sense.  Last I heard the block layer and xfs seemed
to have largely solved their problems with running short on stack
space, so I don't know if it is necessary but it certainly sounds
relatively simple and interesting.

Running short on stack space is a recurring theme so a function that
allows us to have a little more when we really need it and be able to
switch even x86_64 to 4K stacks would be interesting.

I'm not quite certain where we could insert calls to call_on_new_stack,
but it looks simple enough that it is worth coding up and playing
with.  If the results are good it could be worth merging.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
