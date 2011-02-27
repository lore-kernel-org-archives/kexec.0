Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-bw0-f49.google.com ([209.85.214.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ptgbh-0001og-Co
	for kexec@lists.infradead.org; Sun, 27 Feb 2011 13:24:18 +0000
Received: by bwz1 with SMTP id 1so3269488bwz.36
	for <kexec@lists.infradead.org>; Sun, 27 Feb 2011 05:24:15 -0800 (PST)
Date: Sun, 27 Feb 2011 15:24:09 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
Message-ID: <20110227132409.GA4036@laptop>
References: <20110226162008.GA23879@laptop> <4D6972CE.8040401@zytor.com>
	<m14o7q5m6d.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m14o7q5m6d.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On Sat, Feb 26, 2011 at 04:57:30PM -0800, Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> >
> > I can't see any sane reason to *not* make kexec purgatory
> > position-independent.  It is the obvious thing to do.
> 
> This isn't a case of the code not being position independent.  This is
> case of where the relocations are applied.
> 
> I can see a couple of handling this with different tradeoffs.
> 
> 1) We teach bootloaders how to load two kernels at once.  This
>    completely avoids the purgatory, as it is replaced by code in the
>    bootloader that already exists to load the primary kernel and setup
>    it's arguments.
> 

This is in fact my plan. Using Syslinux, I loaded 'purgatory.ro' to RAM
thinking that it will still be needed. Re-checking the purgatory code
now after reading above note, it seems it does 5 important points:

   a) reset the VGA (if instructed)
   b) reset the PIC to legacy mode (if instructed)
   c) check the overall integrity of the second kernel image (SHA-2)
   d) setup the environment for second kernel entry (switch back to
      32-bit protected mode in x86-64, reset registers, etc)
   e) saves the first 640K in a backup region

So (a) and (b) can be done elsewhere if needed; (c) isn't needed cause
if the bootloader corrupts images, we have bigger problems; (d) can be
done as a stub; (e), on the contrary of kdump, isn't critical for my
goals.

Am I missing an important detail?

> 2) We add minimal relocation processing to purgatory, allowing us to do
>    the setup for the second kernel extremely early and allow it to be
>    compiled into the first kernel.
> 
> 3) We come up with a scheme where we don't share code and the first
>    kernel copies the firmware information to place where the second
>    kernel can get at it, and uses it's own home grown stub and not
>    purgatory.
> 

Sorry, but how the third point differs from the first? I thought they
were complementary.

> I think this whole thing can be prototyped easily with a getting /sbin/kexec
> to load to a fixed address and then baking that section into the primary
> kernel. ...

I'll prototype this now by loading the second kernel (bzImage), using
syslinux, without the purgatory.  Let's hope I won't face many
surprises.

> ... I'm not convinced that directly using /sbin/kexec is the right
> way forward to handle the general case.  This is something where the
> devil is in the details.
> 

Lots of details per se; spent last week exploring Kexec user and
kernel code to understand how it does its magic.

> Eric

thanks,

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
