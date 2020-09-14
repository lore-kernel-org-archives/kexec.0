Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHrdR-0005tj-RT
 for kexec@lists.infradead.org; Mon, 14 Sep 2020 16:47:22 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
 <20200907114618.GR2674@hirez.programming.kicks-ass.net>
 <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
 <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
 <5600c9f8-2c9d-7776-161a-5f5c1be62c10@jv-coder.de>
 <51f3b288-260b-a800-6a47-51d93f892c3d@jv-coder.de>
 <87sgbo3p5w.fsf@x220.int.ebiederm.org>
 <22bad750-ef5d-82a5-527c-5213346dd280@jv-coder.de>
Date: Mon, 14 Sep 2020 11:46:25 -0500
In-Reply-To: <22bad750-ef5d-82a5-527c-5213346dd280@jv-coder.de> (Joerg
 Vehlow's message of "Mon, 14 Sep 2020 08:03:27 +0200")
Message-ID: <87k0wws3vi.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Vehlow <lkml@jv-coder.de>
Cc: peterz@infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Joerg Vehlow <joerg.vehlow@aox-tech.de>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>


Adding the kexec list as well.

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi Eric,
>> What is this patch supposed to be doing?
>>
>> What bug is it fixing?
> This information is part in the first message of this mail thread.
> The patch was intendedfor the active discussion in this thread,
> not for a broad review.

> A short summary: In the rt kernel, a panic in an interrupt context does
> not start the dump-capture kernel, because there is a mutex_trylock in
> __crash_kexe. If this is called in interrupt context, it always fails.
> In the non-rt kernel calling mutex_trylock is not allowed according to
> the comment of the function, but it still works.

Thanks.  For whatever reason I did not see the rest of this thread
when I was replying to your patch.

I get the feeling the rt kernel is breaking this case deliberately.
I don't know of any reason why a trylock couldn't work.

That said I won't propose fixing up the locks that way.

>> A BUG_ON that triggers inside of BUG_ONs seems not just suspect but
>> outright impossible to make use of.
> I am not entirely sure what would happen here. But even if it gets in
> some kind ofendless loop, I guess this is ok, because it allows finding
> the problem. A piece of code in the function, that ensures the precondition
> is a lot better than relying on only a comment.
> If this was in mtex_trylock, the bug described above wouldn't have sneaked
> in 12 years ago...

BUG_ON's are more likely to hide a problem then to show it.
Sometimes they are appropriate but the should be avoided as much as
possible.


>> I get the feeling skimming this that it is time to sort out and simplify
>> the locking here, rather than make it more complex, and more likely to
>> fail.
> I would very much like that, but sadly it looks like it is not possible.
> Either it wouldrequire blocking locks, that may fail, or not locking at
> all, that may also fail.Using a different kind of lock (like spinlock)
> is also not possible, becausespinlock_trylock again uses mutex_trylock
> in the rt kernel.

I think it is possible but the locking needs to be relooked at.

>> I get the feeling that over the years somehow the assumption that the
>> rest of the kernel is broken and that we need to get out of the broken
>> kernel as fast and as simply as possible has been lost.
> Yes I also have the feeling, that the mutexes need fixing, but I wouldn't
> to post any patch for that. At the moment, given the interface of the mutex,
> this is clearly a bug in kexec, even if it works in the non-rt kernel.

Cleanups that break the code. Sigh.

The code was written correctly for this case and was fine until
8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()").

Mostly because I didn't trust locks given their comparatively high level
of abstraction and what do you know that turned out to be correct in
this case.

It definitely looks time to see how the locking can be improved on the
kexec on panic code path.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
