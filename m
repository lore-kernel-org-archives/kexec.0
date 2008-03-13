Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZx1L-0002Is-GD
	for kexec@lists.infradead.org; Thu, 13 Mar 2008 23:39:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: bug/patch for i386 EFI boot
References: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
	<20080305092731.GB3979@verge.net.au>
	<p06230913c3f4655358a8@[192.168.9.5]>
	<m163vrxs7l.fsf@ebiederm.dsl.xmission.com>
	<p06230945c3fe58749010@[192.168.9.5]>
	<m1ve3qwnzv.fsf@ebiederm.dsl.xmission.com>
	<p06230901c3ff1ebd0cfe@[192.168.9.5]>
Date: Thu, 13 Mar 2008 17:36:11 -0600
In-Reply-To: <p06230901c3ff1ebd0cfe@[192.168.9.5]> (Scott D. Davilla's message
	of "Thu, 13 Mar 2008 15:46:43 -0400")
Message-ID: <m11w6ew61g.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Scott D. Davilla" <davilla@4pi.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

"Scott D. Davilla" <davilla@4pi.com> writes:

> I'm not familiar about policy on trimming email replies, this is starting to get
> long but I don't care, so feel free to trim the reply if you want.

I was in a rush and failed to trim out the irrelevant pats last round.

> I agree, first thing it to get a patch that just report the framebuffer
> assumption when the kernel is loaded using kexec. setup_linux_vesafb already has
> a fprintf that reports some basic info when "VESA VGA" and with my patch "EFI
> VGA" is detected. Mod that to include which one is detected and add change in
> setup_linux_system_parameters the call to something like this;
>
> if (setup_linux_vesafb(real_mode) != 0) {
> 	fprintf(stderr, "%s: Assuming orig_video_isVGA = 1\n", __FUNCTION__,
> 		var.xres, var.yres, var.bits_per_pixel,
> 		fix.smem_start, fix.smem_len);
> }

Yes a patch to do something like that seems sane.

> This at least informs the user of kexec which setting the kexec'd kernel is
> going to get. The actual text output is difficult because orig_video_isVGA means
> difference things under different archs and framebuffers. For example, can't say
> it's VGA with video bios because that's not true for arm. The best one can do it
> report what happened if orig_video_isVGA gets set to one and hope for the
> best. If I has seen this on my first kexec attempt, it would have saved a lot of
> time vectoring in on the problem.

Right.  It appears the handling of orig_video_isVGA needs to be clarified.

> The cases get worse because not only is one concerned with the current
> configuration but also the capabilities of the kernel/initrd which is being
> loaded. For example, current kernel does not have video but kexec'ing kernel
> does. This creates an expanding set of checks and cross-check that's impossible
> to fully solve. I'm not sure we want to go there.

Best effort certainly.  Each architecture in general has it's own set of options
so we should be able to ignore cases for other arches here.  Which means we really
only need to sort out EFI.

> One has to have a level of trust that starts somewhere. If you are going kexec
> to another kernel, the only thing you can assume is the presence/absence of a
> framebuffer and if present, pass it's settings like a good bootloader
> should. 

Yes.  

> Then kexec at least properly presents the current settings to the
> kexec'd kernel and then it's the kexec'd kernels job of using it properly. These
> settings can always be over-ridden by kernel command-line params. It's not a
> responsibility of kexec to check kernel command-line params, it must trust that
> someone knows what they are doing.

Yes.

However I think your patch may have broken the case of framebuffers for modern
cards like the ATI radeon.  Where the driver knows how to program the registers.

The code looked like it could handle the case where atifb was in the first
kernel and only vesafb was in the second kernel.

That case is worth an examination.

> EFI and sp3 don't do anything strange with screen_info or bootparms. It's just
> that orig_video_isVGA is fuzzy and it can be used to indicate a requested
> framebuffer.

Ok.  Which is what I meant by weird.

> The differences in platform screen hardware is to large to
> generalize in screen_info.

Ok.  I guess I should look to see what it provides.  My impression was that
all we need to know is.  Layout of the framebuffer, location of the framebuffer,
and size of the frame buffer.

If orig_video_isVGA is interpreted as a kind of layout that may make sense.
I know we don't make EFI calls in the efifb so it must be indicating a specific
kind of layout as well.  At least we shouldn't be making EFI calls as none of
the code I reviewed when the last round of merging was taking place had efi
calls.

>   And besides, a patch that changes screen_info
> greatly will never get accepted. It would touch a very sensitive area and the
> risk of far reaching breakage is large.

Agreed.  I'm just doing what I can to understand the issue and give good advice.

> Think of the kernel as a middle man between the bootloader and framebuffer
> modules. The kernel does not want to know about screen hardware, that a
> framebuffers job but somehow the correct framebuffer needs to get selected. You
> can't just try everyone available, potential for side effects. 

Sort of.  Most devices these days can be auto-detected because they are pci
devices.  At least on pc's only legacy devices can't be detected.  Things
like the VESA frame buffer report to the kernel that they have place the
framebuffer in a specific state, and ask that the kernel use that without
attempting to change the mode of the frame buffer.

> So the kernel
> needs to a) use the requested framebuffer, 

Sort of.  It was my impression the intention was to report the current state
of the frame buffer not to request a specific frame buffer.  Our video
card support is sufficiently poor at the moment we could be in a strange
state though.

> b) permit a command-line override or
Yes.

> c) default to no framebuffer which is safe. Maybe also d) safe to probe (insert
> arch dependencies here).


> On x86, orig_video_isVGA = 1, seems to indicate safe to probe although with
> recent kernels passing orig_video_isVGA = VIDEO_TYPE_EFI gets translated into
> "safe to probe" when efifb is not a compiled-in module, which is crash and burn
> for me. This seems to indicate a serious examination of the usage of
> orig_video_isVGA by all. The dual definition of orig_video_isVGA is not good.

So far it seems EFI is the weird piece of code here, and that is the only case
I was advocating fixing if things are sufficiently strange that we can't make
it work well with the current definitions.

> I also note that Ubuntu has taken to blacklisting most all framebuffers in
> userland and their x86 initramfs only has vga16fb. They also have their own
> command-line parms for disabling framebuffer at the initramfs level.

Which may mean something, or may simply reflect the sorry state of frame buffers
in linux today.

> I think if something like the above is added to kexec, then at least we can
> present information to a user of kexec that might be helpful when bad things
> happen.

Agreed.

> Expanding beyond that takes us into touching framebuffers and other
> areas. For that I really need to become more familiar with the different
> framebuffer and the actual usage of orig_video_isVGA across the kernel.

Yes.  Going beyond that takes some more understanding.  But let's see if
we can get a reasonable print statement about framebuffer detection,
which makes the thing visible to users and then we can figure out how
to progress from there.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
