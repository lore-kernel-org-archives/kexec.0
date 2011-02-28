Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pts4K-0005X7-1Q
	for kexec@lists.infradead.org; Mon, 28 Feb 2011 01:38:38 +0000
Date: Mon, 28 Feb 2011 10:38:29 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
Message-ID: <20110228013828.GR19589@verge.net.au>
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
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Haren Myneni <hbabu@us.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On Sat, Feb 26, 2011 at 04:57:30PM -0800, Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > On 02/26/2011 08:20 AM, Ahmed S. Darwish wrote:
> >> Hi,
> >> 
> >> I'm continuing work on 'Saveoops', saving both early and normal Linux
> >> oops log to disk upon panic [*], using Kexec and bootloaders this time.
> >> 
> >> Purgatory, the transitional mini-kernel used by kexec, is a relocatable
> >> ELF file. Userspace kexec-tools finds the final load address of such
> >> code (by parsing /proc/iomem, etc) and then applies the relocations
> >> itself before passing the now-ready executable image to kernel.
> >> 
> >> Since capturing early oopses is the major goal, doing such relocation
> >> in userspace won't fit my purposes. Two options remain:
> >>    - relocate purgatory entries in the kernel early boot path
> >>    - or compile purgatory as position-independent, thus simplifying
> >>      the kernel load logic
> >> 
> >> The former will add extra logic in a sensitive path (early boot), while
> >> the latter will require changes inside the purgatory code itself,
> >> especially i386 assembly files.
> >> 
> >> Any preferable option from our kexec and x86 maintainers?
> >> 
> >> thanks!
> >> 
> >> [*] http://news.gmane.org/find-root.php?message_id=<20110125134748.GA10051@laptop>
> >>     http://news.gmane.org/find-root.php?message_id=<20110126124954.GC24527@laptop>
> >> 
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

I can think of plenty of scenarios where that isn't entirely useful.
For example using kexec as a boot loader and as such not necessarily having
any idea what the second kernel will look like at the time that the first
kernel is built. Am I missing something?

> 
> 2) We add minimal relocation processing to purgatory, allowing us to do
>    the setup for the second kernel extremely early and allow it to be
>    compiled into the first kernel.
> 
> 3) We come up with a scheme where we don't share code and the first
>    kernel copies the firmware information to place where the second
>    kernel can get at it, and uses it's own home grown stub and not
>    purgatory.
> 
> I think this whole thing can be prototyped easily with a getting /sbin/kexec
> to load to a fixed address and then baking that section into the primary
> kernel.  I'm not convinced that directly using /sbin/kexec is the right
> way forward to handle the general case.  This is something where the
> devil is in the details.
> 
> Eric
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
