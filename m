Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pi5Vi-0001GL-Uv
	for kexec@lists.infradead.org; Wed, 26 Jan 2011 13:34:11 +0000
Received: by wwi18 with SMTP id 18so5284600wwi.0
	for <kexec@lists.infradead.org>; Wed, 26 Jan 2011 05:34:09 -0800 (PST)
Date: Wed, 26 Jan 2011 15:34:00 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk
	upon panic
Message-ID: <20110126133400.GA3399@laptop>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop> <20110126125813.GA26952@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110126125813.GA26952@elte.hu>
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
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, X86-ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Mark Lord <kernel@teksavvy.com>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

On Wed, Jan 26, 2011 at 01:58:13PM +0100, Ingo Molnar wrote:
> 
> * Ahmed S. Darwish <darwish.07@gmail.com> wrote:
> 
> > - The latest approach (proposed by Linus) is to forget the disk: jump to
> >   real-mode, but display the kernel log in a fancy format (with scroll
> >   ups and downs) instead.
> > 
> >   Will re-initializing the VGA registers to their POST state be possible?
> >   If not, what about a "fail-safe" VGA driver?
> > 
> > I'm most likely going to implement either the second or the third point,
> > so I'd really appreciate some input.
> 
> The third one suggested by Linus is the most useful and most direct one IMO. Such a 
> 'oops mode' screen would be useful for regular kernel crashes as well.
> 

Yes, it is the safest approach.

If I can make kexec and kdump work on early panics using some help from
bootloaders though, that can possibly give us the feature of saving kernel
logs to disk upon panics _without_ danger. I did not look at the kexec and
kdump code bases yet, so this might be a pipe dream (respective developers
are CCed -- input appreciated).

>
> Also, have you tried BIOS warm reset vector, which is supposed to reboot without 
> clearing RAM contents - how well does it work in practice on typical laptops? If on 
> crash we could reboot without memory getting cleared that would open up a vast area 
> of space to store the kernel log into (RAM).
> 

AFAIK, the lmode->rmode transition is more forward-compatible.

It seems the only place warm boot was documented is in the Intel MP spec,
a 12-years old document long obsoleted by ACPI. Meanwhile, the real-mode
transition is rigorously documented in the current Intel and AMD manuals,
albeit in kind of a holier-than-thou approach.

I'll investigate this further though.

thanks,

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
