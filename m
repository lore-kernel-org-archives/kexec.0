Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S5LZu-0005JB-D9
 for kexec@lists.infradead.org; Wed, 07 Mar 2012 18:27:11 +0000
Received: by yhjj52 with SMTP id j52so3432532yhj.36
 for <kexec@lists.infradead.org>; Wed, 07 Mar 2012 10:27:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307155018.GA13430@redhat.com>
References: <20120216215603.GH9751@redhat.com>
 <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org>
 <20120217195430.GO9751@redhat.com>
 <m1y5s07rn3.fsf@fess.ebiederm.org>
 <20120220151419.GU9751@redhat.com>
 <m1obss39a4.fsf@fess.ebiederm.org>
 <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
 <20120307155018.GA13430@redhat.com>
Date: Wed, 7 Mar 2012 10:27:07 -0800
Message-ID: <CAE9FiQXLMzVLH7MW2OXFCpBU+5RRN-EnshGYhkj_3sO36c1Mkg@mail.gmail.com>
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
From: Yinghai Lu <yinghai@kernel.org>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>, linux-tip-commits@vger.kernel.org, =?ISO-8859-1?Q?Fernando_Luis_V=E1zquez_Cao?= <fernando@oss.ntt.co.jp>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, mingo@elte.hu, torvalds@linux-foundation.org, akpm@linux-foundation.org

2012/3/7 Vivek Goyal <vgoyal@redhat.com>:
> On Wed, Mar 07, 2012 at 07:53:16PM +0900, Fernando Luis V=E1zquez Cao wro=
te:
>> On 03/01/2012 08:19 AM, Eric W. Biederman wrote:
>>
>> >Don Zickus<dzickus@redhat.com> =A0writes:
>> >>It probably is, except I never hacked on idt code before and my assemb=
ly
>> >>isn't that good. =A0I have been trying to find examples to copy from t=
o give
>> >>it a try. =A0So far I was using early_idt_handlers with early_printk t=
o see
>> >>if I could capture some printk messages while jumping from the first
>> >>kernel to the second kernel (when the other early_idt_handlers would k=
ick
>> >>in for the second kernel).
>> >>
>> >>Tips? =A0Better examples?
>> >That is a particularly good example. =A0When I took a quick look earlier
>> >that is the first place we reload the idt in the kernel boot so that is
>> >one of two places that needs to be modified.
>>
>> Hi Eric, Don
>>
>> Sorry for chiming in so late.
>>
>> We run into the same NMI problems and wrote some patches that tackle
>> the kernel boot side of things. They have been extensively tested using
>> qemu-kvm and things seem to be working as expected (after receiving an
>> early NMI the kernel continues without problem; after the iret there is =
no
>> stack corruption or register corruption).
>
> What happens if NMI happens while we are still in purgatory code?
>
yes, you are right. that is too late to set that in arch/x86/kernel/head64.c

i even not get print out "early console in decompress_kernel"
from arch/x86/boot/compressed/misc.c::decompress_kernel()

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
