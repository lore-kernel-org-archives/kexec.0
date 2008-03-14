Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.4pi.com ([24.172.19.59])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JaCut-0007C6-Th
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 16:38:02 +0000
Mime-Version: 1.0
Message-Id: <p06230906c40052848728@[192.168.9.5]>
In-Reply-To: <m11w6ew61g.fsf@ebiederm.dsl.xmission.com>
References: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
	<20080305092731.GB3979@verge.net.au>
	<p06230913c3f4655358a8@[192.168.9.5]>
	<m163vrxs7l.fsf@ebiederm.dsl.xmission.com>
	<p06230945c3fe58749010@[192.168.9.5]>
	<m1ve3qwnzv.fsf@ebiederm.dsl.xmission.com>
	<p06230901c3ff1ebd0cfe@[192.168.9.5]>
	<m11w6ew61g.fsf@ebiederm.dsl.xmission.com>
Date: Fri, 14 Mar 2008 12:36:12 -0400
From: "Scott D. Davilla" <davilla@4pi.com>
Subject: Re: bug/patch for i386 EFI boot
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

>  > I agree, first thing it to get a patch that just report the framebuffer
>>  assumption when the kernel is loaded using kexec. 
>>setup_linux_vesafb already has
>>  a fprintf that reports some basic info when "VESA VGA" and with my 
>>patch "EFI
>>  VGA" is detected. Mod that to include which one is detected and 
>>add change in
>>  setup_linux_system_parameters the call to something like this;
>>
>  > if (setup_linux_vesafb(real_mode) != 0) {
>  >	fprintf(stderr, "%s: Assuming orig_video_isVGA = 1\n", __FUNCTION__,
>>		var.xres, var.yres, var.bits_per_pixel,
>>		fix.smem_start, fix.smem_len);
>>  }
>
>Yes a patch to do something like that seems sane.

I'll prepare a patch as outline above and submit it in a few days, 
I'm juggling a lot right now.



>
>However I think your patch may have broken the case of framebuffers for modern
>cards like the ATI radeon.  Where the driver knows how to program 
>the registers.
>
>The code looked like it could handle the case where atifb was in the first
>kernel and only vesafb was in the second kernel.
>
>That case is worth an examination.
>

I'd like more information about possible breakage of atifb. My patch 
just adds "EFI VGA" to the check for "VESA VGA". As long as atifb 
reports it's a "VESA VGA" then the code behavior is identical to the 
previous. If it does not indicate "VESA VGA" then it takes the 
default setup previous to the call to setup_linux_vesafb which sets 
orig_video_isVGA = 1.

>  > The differences in platform screen hardware is to large to
>>  generalize in screen_info.
>
>Ok.  I guess I should look to see what it provides.  My impression was that
>all we need to know is.  Layout of the framebuffer, location of the 
>framebuffer,
>and size of the frame buffer.

For a linear framebuffer, yes. For others, maybe yes, maybe no. The 
current screen_info/boot params has info describing the layout of a 
text console (logical description) and the possible layout of a 
linear/segmented framebuffer (physical description). Beyond that gets 
into how orig_video_isVGA was set. And of course, kernel command-line 
params can over-ride some settings.

>  > Think of the kernel as a middle man between the bootloader and framebuffer
>>  modules. The kernel does not want to know about screen hardware, that a
>>  framebuffers job but somehow the correct framebuffer needs to get 
>>selected. You
>>  can't just try everyone available, potential for side effects.
>
>Sort of.  Most devices these days can be auto-detected because they are pci
>devices.  At least on pc's only legacy devices can't be detected.  Things
>like the VESA frame buffer report to the kernel that they have place the
>framebuffer in a specific state, and ask that the kernel use that without
>attempting to change the mode of the frame buffer.
>

pci probes only indicate presence/absence of a VGA compatible video 
device. There is no information other than base memory addresses 
present and one cannot assume that the a pci base memory address == 
framebuffer base. It depends on the actual hardware implementation.

VESA framebuffer (vesafb) actually uses the screen_info params that 
were setup by a bootloader which the bootloader got from BIOS or 
other entity link EFI. vesafb does have the capability to set/get 
through BIOS the video configuration but it does not do this unless 
requested from userland. vesafs never decide where the framebuffer is 
place, It can ask, though video bios, "I want this setting", and 
video bios returns the physical configuration.

With my "EFI" hardware, I can actually use vesafb instead of efifb 
provided I don't trigger any video bios calls. vesafb and efifb (and 
imac_fb) are very similar in that they are all just simple linear 
framebuffers and depend on a base address, h/v size and pixel 
packing. They just setup fb structures and map memory, fbcon does the 
work of actually writing data into the linear memory.

Scott



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
