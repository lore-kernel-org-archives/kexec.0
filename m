Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ww0-f49.google.com ([74.125.82.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pi4p6-0000um-Qe
	for kexec@lists.infradead.org; Wed, 26 Jan 2011 12:50:09 +0000
Received: by wwb17 with SMTP id 17so920004wwb.18
	for <kexec@lists.infradead.org>; Wed, 26 Jan 2011 04:50:06 -0800 (PST)
Date: Wed, 26 Jan 2011 14:49:54 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk
	upon panic
Message-ID: <20110126124954.GC24527@laptop>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, X86-ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Lord <kernel@teksavvy.com>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

Hi,

On Wed, Jan 26, 2011 at 06:25:19AM +1000, Linus Torvalds wrote:
> On Tue, Jan 25, 2011 at 11:47 PM, Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> >
> > As a possible solution, below patches prototypes the idea of persistently
> > storing the kernel log ring to a hard disk partition using the enhanced BIOS
> > 0x13 services.
> >
>
> Quite frankly, I'm not likely to _ever_ merge anything like this.
> 
> Over the years, many people have tried to write things to disk on
> oops. I refuse to take it. No way in hell do I want the situation of
> "the system is screwed, so let's overwrite the disk" to be something
> the kernel I release might do. It's crazy. That disk is a lot more
> important than the kernel, and overwriting it when we might have
> serious memory corruption issues or something is not a thing I feel is
> appropriate.
> 

OK, I've carefully read all the criticism posted here and in the other
replies. A short summary:

- It will be _too_ much to restore the PIC, IO-APIC, PCI configuration,
  and disk controllers to the BIOS Power-on self-test (POST) state. The
  solution will not be guaranteed to work on all machines.

- The write path of the BIOS INT 0x13 services is not tested enough by
  contemporary x86 kernels (Windows and Linux). Thus, that part of the
  BIOS is probably not as stable as I originally claimed.

Possible solutions:

- Having a minimal "fail-safe" disk controller driver to access the
  disk. This can't be made "perfect" enough to work on all combinations
  of machines (Though it can work on a small subset, e.g. the usual lot
  of x86 laptops with Intel chipsets). Linus is not OK with the _whole_
  idea of doing _any_ disk write on panic.

- Use kexec/kdump. I wonder though, can kexec work on early panics? The
  kind where the disk itself might not yet be initialized?

  If not, can kexec be modified to do so? That possibly needs the help
  of a a bootloader extension.

- The latest approach (proposed by Linus) is to forget the disk: jump to
  real-mode, but display the kernel log in a fancy format (with scroll
  ups and downs) instead.

  Will re-initializing the VGA registers to their POST state be possible?
  If not, what about a "fail-safe" VGA driver?

I'm most likely going to implement either the second or the third point,
so I'd really appreciate some input.

thanks,

> 
> If you want to do the BIOS services thing, do it for video: copy the
> oops to low RAM, return to real mode, re-run the graphics card POST
> routines to initialize text-mode, and use the BIOS to print out the
> oops.  That is WAY less scary than writing to disk.
> 
>                               Linus

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
