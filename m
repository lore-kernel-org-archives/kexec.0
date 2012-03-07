Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S5J8T-0006Hl-H9
 for kexec@lists.infradead.org; Wed, 07 Mar 2012 15:50:43 +0000
Date: Wed, 7 Mar 2012 10:50:18 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
Message-ID: <20120307155018.GA13430@redhat.com>
References: <20120216215603.GH9751@redhat.com>
 <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org>
 <20120217195430.GO9751@redhat.com>
 <m1y5s07rn3.fsf@fess.ebiederm.org>
 <20120220151419.GU9751@redhat.com>
 <m1obss39a4.fsf@fess.ebiederm.org>
 <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F573E1C.2060909@oss.ntt.co.jp>
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
To: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, linux-tip-commits@vger.kernel.org, torvalds@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, mingo@elte.hu, Yinghai Lu <yinghai@kernel.org>, akpm@linux-foundation.org

On Wed, Mar 07, 2012 at 07:53:16PM +0900, Fernando Luis V=E1zquez Cao wrote:
> On 03/01/2012 08:19 AM, Eric W. Biederman wrote:
> =

> >Don Zickus<dzickus@redhat.com>  writes:
> >>It probably is, except I never hacked on idt code before and my assembly
> >>isn't that good.  I have been trying to find examples to copy from to g=
ive
> >>it a try.  So far I was using early_idt_handlers with early_printk to s=
ee
> >>if I could capture some printk messages while jumping from the first
> >>kernel to the second kernel (when the other early_idt_handlers would ki=
ck
> >>in for the second kernel).
> >>
> >>Tips?  Better examples?
> >That is a particularly good example.  When I took a quick look earlier
> >that is the first place we reload the idt in the kernel boot so that is
> >one of two places that needs to be modified.
> =

> Hi Eric, Don
> =

> Sorry for chiming in so late.
> =

> We run into the same NMI problems and wrote some patches that tackle
> the kernel boot side of things. They have been extensively tested using
> qemu-kvm and things seem to be working as expected (after receiving an
> early NMI the kernel continues without problem; after the iret there is no
> stack corruption or register corruption).

What happens if NMI happens while we are still in purgatory code?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
