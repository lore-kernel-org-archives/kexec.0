Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWGq-009ioq-1r
 for kexec@lists.infradead.org; Fri, 16 Apr 2021 21:45:02 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries() out-of-bounds
 access
In-Reply-To: <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
 <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
 <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
 <20210416121636.GA22348@zn.tnic>
 <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
 <20210416144459.GB22348@zn.tnic>
 <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
Date: Fri, 16 Apr 2021 23:44:58 +0200
Message-ID: <87sg3puco5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
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
To: Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Apr 16 2021 at 17:13, Mike Galbraith wrote:
> On Fri, 2021-04-16 at 16:44 +0200, Borislav Petkov wrote:
>> On Fri, Apr 16, 2021 at 03:16:07PM +0200, Mike Galbraith wrote:
>> > On Fri, 2021-04-16 at 14:16 +0200, Borislav Petkov wrote:
>> > >
>> > > Please be more verbose and structure your commit message like this:
>> >
>> > Hrmph, I thought it was too verbose for dinky one-liner if anything.
>>
>> Please look at how other commit messages in tip have free text - not
>> only tools output.
>>
>> Also, this looks like a fix for some previous commit. Please dig out
>> which commit introduced the issue and put its commit ID in a Fixes: tag
>> above your S-o-B.
>>
>> If you don't have time or desire to do that, you can say so and I'll do
>> it myself when I get a chance.
>
> Ok, bin it for the nonce.

Can all of you involved stop this sandpit fight and do something useful
to fix that obvious bug already?

OMG



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
