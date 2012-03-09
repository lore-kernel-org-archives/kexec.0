Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S5oB6-0004J6-Ij
 for kexec@lists.infradead.org; Fri, 09 Mar 2012 00:59:30 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7C29C3EE0B6
 for <kexec@lists.infradead.org>; Fri,  9 Mar 2012 09:59:22 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5EC0F45DEB3
 for <kexec@lists.infradead.org>; Fri,  9 Mar 2012 09:59:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 454D745DEA6
 for <kexec@lists.infradead.org>; Fri,  9 Mar 2012 09:59:22 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3571C1DB803F
 for <kexec@lists.infradead.org>; Fri,  9 Mar 2012 09:59:22 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E20C41DB803C
 for <kexec@lists.infradead.org>; Fri,  9 Mar 2012 09:59:21 +0900 (JST)
Date: Fri, 09 Mar 2012 09:59:02 +0900 (   )
Message-Id: <20120309.095902.310070570.d.hatayama@jp.fujitsu.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4F573E1C.2060909@oss.ntt.co.jp>
References: <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: fernando@oss.ntt.co.jp
Cc: dzickus@redhat.com, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, yinghai@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, vgoyal@redhat.com

From: Fernando Luis V=E1zquez Cao <fernando@oss.ntt.co.jp>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in=
 crash path
Date: Wed, 07 Mar 2012 19:53:16 +0900

> On 03/01/2012 08:19 AM, Eric W. Biederman wrote:
> =

>> Don Zickus<dzickus@redhat.com>  writes:
>>> It probably is, except I never hacked on idt code before and my
>>> assembly
>>> isn't that good.  I have been trying to find examples to copy from to
>>> give
>>> it a try.  So far I was using early_idt_handlers with early_printk to
>>> see
>>> if I could capture some printk messages while jumping from the first
>>> kernel to the second kernel (when the other early_idt_handlers would
>>> kick
>>> in for the second kernel).
>>>
>>> Tips?  Better examples?
>> That is a particularly good example.  When I took a quick look earlier
>> that is the first place we reload the idt in the kernel boot so that
>> is
>> one of two places that needs to be modified.
> =

> Hi Eric, Don
> =

> Sorry for chiming in so late.
> =

> We run into the same NMI problems and wrote some patches that tackle
> the kernel boot side of things. They have been extensively tested
> using
> qemu-kvm and things seem to be working as expected (after receiving an
> early NMI the kernel continues without problem; after the iret there
> is no
> stack corruption or register corruption).
> =

> I will be replying to this email with the patches.
> =


Should the following also be fixed?

/*
 * Do not allocate memory (or fail in any way) in machine_kexec().
 * We are past the point of no return, committed to rebooting now.
 */
void machine_kexec(struct kimage *image)
{
        unsigned long page_list[PAGES_NR];
        void *control_page;
        int save_ftrace_enabled;
<cut>
        /*
         * The gdt & idt are now invalid.
         * If you want to load them you must set up your own idt & gdt.
         */
        set_gdt(phys_to_virt(0), 0);
        set_idt(phys_to_virt(0), 0);    <--- This

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
