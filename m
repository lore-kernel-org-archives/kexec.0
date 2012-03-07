Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv2.oss.ntt.co.jp ([222.151.198.100])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S5EVO-0003Y3-J9
 for kexec@lists.infradead.org; Wed, 07 Mar 2012 10:54:05 +0000
Message-ID: <4F573E1C.2060909@oss.ntt.co.jp>
Date: Wed, 07 Mar 2012 19:53:16 +0900
From: =?ISO-8859-1?Q?Fernando_Luis_V=E1zquez_Cao?=
 <fernando@oss.ntt.co.jp>
MIME-Version: 1.0
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
References: <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
 <20120216172735.GX9751@redhat.com>
 <CAE9FiQVhbAM9vjx-uFcuc0ndsUp0aez9_TsQHStje5G5iwYbag@mail.gmail.com>
 <20120216215603.GH9751@redhat.com> <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org> <20120217195430.GO9751@redhat.com>
 <m1y5s07rn3.fsf@fess.ebiederm.org> <20120220151419.GU9751@redhat.com>
 <m1obss39a4.fsf@fess.ebiederm.org> <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org>
In-Reply-To: <m1ipip6xe8.fsf@fess.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, linux-tip-commits@vger.kernel.org, torvalds@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, mingo@elte.hu, Yinghai Lu <yinghai@kernel.org>, akpm@linux-foundation.org, vgoyal@redhat.com

On 03/01/2012 08:19 AM, Eric W. Biederman wrote:

> Don Zickus<dzickus@redhat.com>  writes:
>> It probably is, except I never hacked on idt code before and my assembly
>> isn't that good.  I have been trying to find examples to copy from to give
>> it a try.  So far I was using early_idt_handlers with early_printk to see
>> if I could capture some printk messages while jumping from the first
>> kernel to the second kernel (when the other early_idt_handlers would kick
>> in for the second kernel).
>>
>> Tips?  Better examples?
> That is a particularly good example.  When I took a quick look earlier
> that is the first place we reload the idt in the kernel boot so that is
> one of two places that needs to be modified.

Hi Eric, Don

Sorry for chiming in so late.

We run into the same NMI problems and wrote some patches that tackle
the kernel boot side of things. They have been extensively tested using
qemu-kvm and things seem to be working as expected (after receiving an
early NMI the kernel continues without problem; after the iret there is no
stack corruption or register corruption).

I will be replying to this email with the patches.

Thanks,
Fernando

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
