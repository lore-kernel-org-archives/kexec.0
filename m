Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.22])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYT1-009nZI-V5
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 00:05:48 +0000
Message-ID: <d725b19b4c02273eaab38a10853fa6fb6d5bc76c.camel@gmx.de>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
From: Mike Galbraith <efault@gmx.de>
Date: Sat, 17 Apr 2021 02:05:27 +0200
In-Reply-To: <87sg3puco5.ffs@nanos.tec.linutronix.de>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
 <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
 <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
 <20210416121636.GA22348@zn.tnic>
 <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
 <20210416144459.GB22348@zn.tnic>
 <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
 <87sg3puco5.ffs@nanos.tec.linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2021-04-16 at 23:44 +0200, Thomas Gleixner wrote:
>
> Can all of you involved stop this sandpit fight and do something useful
> to fix that obvious bug already?

?? We're not fighting afaik.  Boris hated my changelog enough to offer
to write a better one, and I'm fine with that.  It's a seven year old
*latent* buglet of microscopic proportions, hardly a pressing issue.

	-Mike


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
