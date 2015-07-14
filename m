Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
 <20150714153430.GA18766@fifo99.com> <20150714154040.GA3912@redhat.com>
 <20150714154833.GA18883@fifo99.com>
 <20150714161612.GH10792@redhat.com>
 <87a8uyoeig.fsf@x220.int.ebiederm.org>
 <20150714172953.GA19135@fifo99.com>
 <20150714175527.GI10792@redhat.com>
Date: Tue, 14 Jul 2015 13:01:12 -0500
In-Reply-To: <20150714175527.GI10792@redhat.com> (Vivek Goyal's message of
 "Tue, 14 Jul 2015 13:55:27 -0400")
Message-ID: <87si8qmxef.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, dwalker@fifo99.com, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Jul 14, 2015 at 05:29:53PM +0000, dwalker@fifo99.com wrote:
>
> [..]
>> > >> > If a machine is failing, there are high chance it can't deliver you the
>> > >> > notification. Detecting that failure suing some kind of polling mechanism
>> > >> > might be more reliable. And it will make even kdump mechanism more
>> > >> > reliable so that it does not have to run panic notifiers after the crash.
>> > >> 
>> > >> I think what your suggesting is that my company should change how it's hardware works
>> > >> and that's not really an option for me. This isn't a simple thing like checking over the
>> > >> network if the machine is down or not, this is way more complex hardware design.
>> > >
>> > > That means you are ready to live with an unreliable design. There might be
>> > > cases where notifier does not get run properly and you will not do switch
>> > > despite the fact that OS has failed. I was just trying to nudge you in
>> > > a direction which could be more reliable mechanism.
>> > 
>> > Sigh I see some deep confusion going on here.
>> > 
>> > The panic notifiers are just that panic notifiers.  They have not been
>> > nor should they be tied to kexec.   If those notifiers force a switch
>> > over of between machines I fail to see why you would care if it was
>> > kexec or another panic situation that is forcing that switchover.
>> 
>> Hidehiro isn't fixing the failover situation on my side, he's fixing register
>> information collection when crash_kexec_post_notifiers is used.
>
> Sure. Given that we have created this new parameter, let us fix it so that
> we can capture the other cpu register state in crash dump.
>
> I am little disappointed that it was not tested well when this parameter was
> introuced. We should have atleast tested it to the extent to see if there
> is proper cpu state present for all cpus in the crash dump.
>
> At that point of time it looked like a simple modification
> to allow panic notifiers before crash_kexec().

Either that or we say no one cares enough, and it known broken so let's
just revert the fool thing.

I honestly can't see how to support panic notifiers, before kexec.
There is no way to tell what is being done and all of the pieces
including smp_send_stop are known to be buggy.

It isn't like this latest set of patches was reviewed/tested much
better, as the first patch was wrong.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
