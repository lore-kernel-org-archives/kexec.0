Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PiU58-0003N2-La
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 15:48:23 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop> <20110126125813.GA26952@elte.hu>
	<20110126133400.GA3399@laptop> <20110126140030.GB30064@elte.hu>
	<4D40F5FD.6090507@zytor.com> <20110127114113.GB20279@elte.hu>
Date: Thu, 27 Jan 2011 07:47:54 -0800
In-Reply-To: <20110127114113.GB20279@elte.hu> (Ingo Molnar's message of "Thu, 
	27 Jan 2011 12:41:13 +0100")
Message-ID: <m1aaimxs9h.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk upon
	panic
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, X86-ML <x86@kernel.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Lord <kernel@teksavvy.com>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

Ingo Molnar <mingo@elte.hu> writes:

> * H. Peter Anvin <hpa@zytor.com> wrote:
>
>> On 01/26/2011 06:00 AM, Ingo Molnar wrote:
>> >
>> >I mean, use the warm reset vector to truly reset the box.
>> >
>> >Then, once a stable known-good kernel boots, *that* kernel can then recover all the
>> >log data which is sitting in a well-known place in RAM, automatically and
>> >transparently.
>> >
>> >Basically a bit like kexec, just more convenient and it also goes through the BIOS
>> >warm reset, so it might work better than kexec ...
>> >
>> 
>> The problem is that the BIOS will often wipe memory.
>
> Yes - but at least a long time ago there used to be modi of reboot when the BIOS did 
> not do this. Whether that's possible at all with modern BIOSen is a
> big question ...

As I recall that was how you went from 32bit mode to 16bit real mode.
The issue is that mode never reset the hardware it simply changed the
cpu mode.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
