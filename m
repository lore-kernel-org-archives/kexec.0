Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rwz7F-0003OS-SR
 for kexec@lists.infradead.org; Mon, 13 Feb 2012 16:51:03 +0000
Received: by yhjj56 with SMTP id j56so2683772yhj.36
 for <kexec@lists.infradead.org>; Mon, 13 Feb 2012 08:51:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m1zkcmyjyd.fsf@fess.ebiederm.org>
References: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
 <CAE9FiQWRjvu_uNcx_bJXYHeg4D4k6YzHHmSudsq7EyubLi7+nw@mail.gmail.com>
 <m1ipjc3fsk.fsf@fess.ebiederm.org>
 <CAE9FiQVLnyRB+pAqi22C5mCbHOOVKxsBhQKaB6P0p9f2LBL8bA@mail.gmail.com>
 <m1zkcmyjyd.fsf@fess.ebiederm.org>
Date: Mon, 13 Feb 2012 08:51:00 -0800
Message-ID: <CAE9FiQVj12UCGbOe4wZfx-L8tdab-1si-RA=vBnNeZ7cUNqyyg@mail.gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dzickus@redhat.com, linux-tip-commits@vger.kernel.org, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

On Mon, Feb 13, 2012 at 4:52 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Yinghai Lu <yinghai@kernel.org> writes:
>
>> On Sat, Feb 11, 2012 at 7:13 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Yinghai Lu <yinghai@kernel.org> writes:
>>>> After reverting this commit, kdump is working again.
>>>>
>>>> So assume you need to drop this patch.
>>>
>>> It sounds like there is a bug in ioapic initialization in the context of
>>> VT-d. =A0Where do you fail?
>>>
>> before get debug print out from second kernel, the system get reset.
>
> Ouch.
>
> Don can you work with with Yinghai to figure out what is different
> between your test configuration and his?
>
> YH did you have early printk enabled?

yes.

I always have "console=3Duart8250,io,0x3f8,115200n8" appended.

also i have local patches that print info from
arch/x86/boot/compressed/misc.c::decompress_kernel()
and
arch/x86/kernel/head64.c::x86_64_start_kernel()

>
> YH Did I understand you properly that things work if you don't enable
> VT-d?

that is default setting for BIOS and OS.

will check if disable that will help.

> By VT-d are you referring to interrupt remapping?

yes, include interrupt rempapping and dma remapping.

>
> For anyone watching. =A0The premise of this patch was that we can boot
> the kernel without resorting to legacy tricks that require us to
> put the interrupt controllers in PIT mode.
>
> Apparently there is some weird corner case that YH can reproduce that
> Don did not have in his test set that YH does that causes things to
> fail.
>
> I really don't see any likely candidates when looking at the code. =A0The
> most I can see is some code that we don't run when interrupt remapping
> is enabled in disable_IO_APIC.
>
> So I suspect we have a bug in our apic initialization somewhere, but
> apic initialization should happen after printk are enabled. =A0Or at least
> after early printks so the reset YH is reporting doesn't make much sense.

will try Don's first version patch that only removing disable_IO_APIC.

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
