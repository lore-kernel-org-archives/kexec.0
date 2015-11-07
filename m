Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x233.google.com ([2607:f8b0:400e:c03::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZuxEk-0006iU-Fc
 for kexec@lists.infradead.org; Sat, 07 Nov 2015 06:44:31 +0000
Received: by pasz6 with SMTP id z6so148691382pas.2
 for <kexec@lists.infradead.org>; Fri, 06 Nov 2015 22:44:08 -0800 (PST)
Message-ID: <563d9db7.6293420a.cdda3.ffffa5c8@mx.google.com>
Date: Fri, 06 Nov 2015 22:44:07 -0800 (PST)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
In-Reply-To: <20151104122151.GB11639@twins.programming.kicks-ass.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: peterz@infradead.org
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, arnd@arndb.de, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Wed, 04 Nov 2015 04:21:51 PST (-0800), peterz@infradead.org wrote:
> On Wed, Nov 04, 2015 at 12:41:06PM +0100, Peter Zijlstra wrote:
>> On Tue, Nov 03, 2015 at 11:46:30AM -0800, Palmer Dabbelt wrote:
>> > This has a "#ifdef CONFIG_*" that used to be exposed to userspace.
>> >
>> > The names in here are so generic that I don't think it's a good idea
>> > to expose them to userspace (or even the rest of the kernel).  Since
>> > there's only one kernel user, it's been moved to that file.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> > Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
>> > Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
>>
>> Assuming you want to keep all these patches together in a tree or so.
>> Let me know if you want me to take this patch.

Well, the plan was to try to get the whole patch set all upstream together.
I'd prefer that, because it'll be easier to make sure everything gets in before
the last checker patch.  Since it touches so many different places I'd be OK
with doing it peicemeal.

I'm kind of new to this whole process: do you think someone is likely to take
this patch set all together?

>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Ah, build-bot finds your change is broken and you didn't grep right. It
> is used in more places.

Sorry about that, I must have mis-grep'd.  I guess that's what the build-bot is
for :).

> How about moving it to include/linux/hw_breakpoint.h, instead of having
> it in the uapi crud?

Yep, that makes sense.

I'm going to re-submit a v5 of this patch set, since there was also a missing
patch for blackfin that the buildbot found.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
