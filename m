Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RyTtN-00072M-Hd
 for kexec@lists.infradead.org; Fri, 17 Feb 2012 19:54:55 +0000
Date: Fri, 17 Feb 2012 14:54:30 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
Message-ID: <20120217195430.GO9751@redhat.com>
References: <m1ipjc3fsk.fsf@fess.ebiederm.org>
 <CAE9FiQVLnyRB+pAqi22C5mCbHOOVKxsBhQKaB6P0p9f2LBL8bA@mail.gmail.com>
 <m1zkcmyjyd.fsf@fess.ebiederm.org>
 <CAE9FiQVj12UCGbOe4wZfx-L8tdab-1si-RA=vBnNeZ7cUNqyyg@mail.gmail.com>
 <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
 <20120216172735.GX9751@redhat.com>
 <CAE9FiQVhbAM9vjx-uFcuc0ndsUp0aez9_TsQHStje5G5iwYbag@mail.gmail.com>
 <20120216215603.GH9751@redhat.com>
 <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1fwe9bpk2.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

On Fri, Feb 17, 2012 at 04:41:01AM -0800, Eric W. Biederman wrote:
> 
> The fix with a guarantee of no more scope creep is to just disable the
> nmi watchdog on the kexec on panic path.
> 
> Don if you have time please figure out is needed to ignore nmi's and
> possible record and/or report them while we boot, otherwise please cook
> up a patch that just disables the nmi watchdog wherever we are sending
> it from (the local apic or the ioapic).

Can I keep things even simpler?  The original problem was the deadlock
with the ioapic lock.  We fixed that by removing the call to
disable_IO_APIC().  Can we just leave the disable_local_APIC calls in
there for now?  Is there any real harm?

All this rewrite is going to take time which will delay fixing a current
problem with kexec on panic, the ioapic deadlock.

Thoughts?

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
