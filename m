Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBoEn-0007kg-MS
 for kexec@lists.infradead.org; Fri, 07 Feb 2014 16:25:11 +0000
Date: Fri, 7 Feb 2014 11:24:09 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [GIT PULL] x86/kaslr for v3.14
Message-ID: <20140207162408.GD6967@redhat.com>
References: <201401201647.s0KGlZdh004167@tazenda.hos.anvin.org>
 <CAFLxGvxO1MPDDjEh3FU5Gv2-eb6zBJxYtTnKdABDTTpbMxxYAw@mail.gmail.com>
 <52E5EFAF.3060609@linux.intel.com>
 <CAFLxGvxJ0A6hZ52RWffkg_zXXScyPn10P4HcKvdAXfE43h32Eg@mail.gmail.com>
 <52E601DA.7010605@zytor.com> <20140130220708.GP9951@redhat.com>
 <CAGXu5jKp0j71ucE7uOWRa+gQM1Wzp=_KdByJK4XnACTwiCW4ow@mail.gmail.com>
 <20140207144914.GA5949@redhat.com>
 <52F503FD.8080607@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52F503FD.8080607@linux.intel.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>, Cong Ding <dinggnu@gmail.com>, Richard Weinberger <richard.weinberger@gmail.com>, Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mathias Krause <minipli@googlemail.com>, Michael Davidson <md@google.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

On Fri, Feb 07, 2014 at 08:04:13AM -0800, H. Peter Anvin wrote:
> On 02/07/2014 06:49 AM, Vivek Goyal wrote:
> > 
> > Hi Kees,
> > 
> > Dave Young is testing kdump with kaslr enabled. He is facing some issues.
> > 
> > One issue he mentioned is that when second kernel boots, it might be
> > placed in an area which is outside the reserved area for second kernel.
> > 
> > We reserve a certain memory for second kernel. And modify memory map of
> > second kernel using memmap=exactmap parameter. Looks like kernel placement
> > is happening before memmap=exactmap takes effect. And that seems to be
> > the reason that second kernel can be placed outside the reserved memory.
> > 
> > IOW, memmap=exactmap and kaslr don't work together. Is it possible to
> > first let memmap=exactmap take affect and then kaslr does its job. Or it
> > is too late by the time memmap=exactmap is parsed.
> > 
> > As a workaround, Dave is currently using "nokaslr" command line parameter
> > for second kernel. He is still facing issues where makedumpfile segment
> > faults. He is looking into it further.
> > 
> > I thought I will atleast bring up with issue of memmap=exactmap and kaslr
> > being incompatible.
> > 
> 
> Yes, because memmap=exactmap gets parsed too late; kaslr assumes that
> the e820 information passed to it is actually correct.
> 
> Yet another cause of breakage caused by the decision on the part of
> kdump to rely on command-line options.

[CC kexec mailing list]

Ok, I think this is high time we change kexec-tools to not use
memmap=exactmap and start passing modified memory map in bootparams. I
think only concern with that change was backward compatibility of
kexec-tools with older kernels.

IIUC, only thing which will be impacted by this change is users of
saved_max_pfn which determine the highest accessible pfn in first
kernel. Some calgary IOMMU code seems to be the only user of it now.

So may be we can create a new command line option say --pass-memmap-cmdline
to kexec-tools which forces old behavior and by default we pass memmap
in bootparams.

Or create --do-not-pass-memmap-cmdline and new users will use it. Default
will be old behavior.

Thansk
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
