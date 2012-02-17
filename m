Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RyUGl-0007nl-F1
 for kexec@lists.infradead.org; Fri, 17 Feb 2012 20:19:04 +0000
Date: Fri, 17 Feb 2012 15:18:42 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
Message-ID: <20120217201842.GP9751@redhat.com>
References: <CAE9FiQVLnyRB+pAqi22C5mCbHOOVKxsBhQKaB6P0p9f2LBL8bA@mail.gmail.com>
 <m1zkcmyjyd.fsf@fess.ebiederm.org>
 <CAE9FiQVj12UCGbOe4wZfx-L8tdab-1si-RA=vBnNeZ7cUNqyyg@mail.gmail.com>
 <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
 <20120216172735.GX9751@redhat.com>
 <CAE9FiQVhbAM9vjx-uFcuc0ndsUp0aez9_TsQHStje5G5iwYbag@mail.gmail.com>
 <20120216215603.GH9751@redhat.com>
 <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org>
 <CABOkKT21zhyMwMmbR9WTipk5e=y_qMZ8ByG=njatjKbFLZW+xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABOkKT21zhyMwMmbR9WTipk5e=y_qMZ8ByG=njatjKbFLZW+xQ@mail.gmail.com>
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
To: HATAYAMA Daisuke <d.hatayama@gmail.com>
Cc: linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "d.hatayama" <d.hatayama@jp.fujitsu.com>, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

On Sat, Feb 18, 2012 at 12:49:16AM +0900, HATAYAMA Daisuke wrote:
> A few days ago I investigted the case where system is reseted due to
> triple fault caused by the NMI after idt is disabled in
> machine_kexec. I didn't see the reset when trigering the kdump with
> NMI since the NMI is masked until next iret instruction executed as
> described in 6.7.2. Handling Multiple NMIs of Intel Manual Vol.3A.
> The NMI mask remains untill the first iret execution on the 2nd
> kernel: just the return path of the first kernel_thread invocation for
> init process. The exact path is:

hmm.  So even though the local apic was disabled you still got an NMI?
That could have been from an external NMI.  I forget how that is wired up,
if it goes through the IOAPIC to the Local APIC or directly to the NMI pin
on the cpu.

> 
>   switch_to
>   -> ret_from_fork
>      -> int_ret_from_sys_call
>         -> retint_restore_args
>            -> irq_return
> 
> At that phase idt is already set up and kdump works.
> 
> From the discussion I interpret kdump doesn't assume this behaviour,
> right?

probably not.

> 
> BTW, does anyone know the detail of the NMI mask? I couldn't figure
> out about it from the Intel spec more than ``certain hardware
> conditions''... I expect those who look at here are x86 NMI experts.

I don't understand the question.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
