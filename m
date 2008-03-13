Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx.4pi.com ([24.172.19.59])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZoZ1-0000P1-ON
	for kexec@lists.infradead.org; Thu, 13 Mar 2008 14:37:48 +0000
Mime-Version: 1.0
Message-Id: <p06230945c3fe58749010@[192.168.9.5]>
In-Reply-To: <m163vrxs7l.fsf@ebiederm.dsl.xmission.com>
References: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
	<20080305092731.GB3979@verge.net.au>
	<p06230913c3f4655358a8@[192.168.9.5]>
	<m163vrxs7l.fsf@ebiederm.dsl.xmission.com>
Date: Thu, 13 Mar 2008 10:36:44 -0400
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

>"Scott D. Davilla" <davilla@4pi.com> writes:
>>  Done and resubmitted with a proper subject line with commented out
>>  lines removed. VMware was mangling the leading tabs on the drag and
>>  drop from Linux to OS X ???
>>
>>  And as follow up question. It there any access to
>  > screen_info.orig_video_isVGA besides linking to the kernel? If there
>>  is access to orig_video_isVGA then kexec can setup the screen boot
>>  params as the bootloader intended instead of assuming a default VGA
>>  config. The orig_video_isVGA is the only parameter missing to clone
>>  the initial screen_info information.
>
>Let me take a stab at answering part of this.
>
>Originally I recall kexec passed a configuration for no screen at all.
>
>I think that is still the default of how we setup the data
>structures.  Then I merged a patch that detected which
>type of screen there is (which you have recently amended).
>
>The goal in kexec in this area has always been to use the user space
>APIs and generate the data a normal bootloader or the 16bit setup code
>would, without performing the BIOS calls.
>
>If you can see a better way to do this we should go for it.
>
>What we want is not so much the screen layout that the bootloader
>provided but the current video mode.  In frame buffer consoles
>generally this can not change so it is a pass through.
>

Thanks for the reply, understanding the history of kexec is important 
as I'm looking at it with fresh eyes.  My primary use is as a 
secondary bootloader in a similar fashion how the ps3 boots. Rather 
than invent yet another full blown bootloader with full device 
access, it was much simpler to boot a Linux kernel that has the 
required resources already. kexec was the perfect solution that would 
allow booting the "real" kernel without having the perils of creating 
and debugging real bootloader.

Where I ran into problems was in kexec setting orig_video_isVGA = 1, 
which resulted in the side effect of causing the kexec'd kernel to 
assume it was ok default to a frambuffer that tried to probe/setup 
the video using x86 video bios. Well, I don't have a x86 video bios 
so crash and burn.

So here we have a case of a bootloader that understands the hardware, 
carefully setting up screen_info and orig_video_isVGA to indicate 
that the hardware requires a specific console framebuffer and then 
kexec goes and thinks it knows better. Not picking on kexec here, the 
real fault was assuming that all x86 platforms have a vga/vesa bios. 
This might have been the case in the past but it's not today.

Now the ideal case is to have the kexec'd kernel come back with the 
same video modes.  This means that a) screen_info has to be loaded 
with the current settings and b) the same console framebufer has to 
be selected.  It's the b) that exists for vesafb and I added for 
efifb. If you don't also do b) then you risk not only possibly 
inadvertently changing the video mode anyway but a kernel crash as 
the kernel might pick what looks correct from screen_info but is 
actually the wrong framebuffer choice.

Side Bar here: orig_video_isVGA seems to be a historical variable. 
 From what I can grep into current and past kernels/framebuffers, it 
originally has just a "I'm a VGA" or "I'm not VGA", then it was 
extended to optionally indicate what type of VGA, then into a 
specific framebuffer module request. I see a lot of orig_video_isVGA 
= 0 and orig_video_isVGA = 1, yet these are the only two values for 
orig_video_isVGA that is NOT documented anywhere. The standard x86 
bootloaders seems to pick 0, 1 or VIDEO_TYPE_VLFB. Other hardware 
specific (sp3, mac efi, etc) will set orig_video_isVGA to indicate 
the requested framebuffer module. So orig_video_isVGA really has an 
usage dependent definition -- that's not good for a boot parameter.

So, now we have a situation where a bootloader picks the best 
framebuffer for the hardware (also assuming that any overrides passed 
to the bootloader are also correct) but kexec only knows about 
detecting certain framebuffers (vesabf and not efifb).

This could be fixed by adding more patches like mine but that's 
really asking for continual patching as console framebuffers evolve 
over time. The perfect example is the efifb. The efifb author created 
it to solve a framebuffer need that was lacking but was unaware that 
kexec made assumptions about framebuffer choice. I bet it happened to 
work because their efi hardware has a tradition vga bios. I, a 
bootloader author comes along, picks efifb as the best fit for my 
hardware, also unaware of kexec dependencies but opps, no vga bios, 
and two weeks thinking I had a bootloader/harwdare problem. I made 
the mistake in assuming that since kexec loaded a kernel for booting 
that it or the kernel propagated the previous boot params, duh, it's 
a bootlaoder after all.

Current video settings/mode are not enough, kexec need to also pass 
the current framebuffer or the video state continuity is potentially 
lost when kexec'ing. And it's not just to just to enable console 
assess, the kernel cannot be trusted to pick a correct one without 
requiring assess to BIOS or the risk of a kernel crash is greatly 
increased.

I've thought a bit on how to solve this for good. Access to 
screen_info orig_video_isVGA is not possible without linking to 
kernel symbols and that's not good. Adding more patches to kexec to 
correctly decode which framebuffer is better but now it's a code 
maintenance problem. Could add a command-line parm to kexec that 
indicates which framebuffer to pick and pass, at least that's a hint 
to someone using kexec that they should pay attention to framebuffer 
choice.

One does not really want access to the kernels screen_info anyway, 
the original framebuffer might have been unloaded and replaced. The 
orig_video_isVGA or  equivalent should be accessed through a ioctl 
call to the framebuffer module itself just like the ioctl(fd, 
FBIOGET_VSCREENINFO, &var). It's a simple addition to each console 
framebuffer and it will also have to become a "required" ioctl call 
for console framebuffer authors in order to really fix this once and 
for all.

It's unfortunate that a framebuffer identifier is a numeric in the 
boot parms (0x23) but a string in userland ("VESA VGA") and an even 
different string as a kernel command-line param (video=vesafb). This 
is a perfect example of why numeric identifiers can be good in 
userland, less code maintenance as linkage is automatic. But I 
certainly don't want to see "video=0x23" as a command-line param. 
Yuck.

Adding a method to access the orig_video_isVGA or equivalent from the 
framebuffer module is really the best way to preserve the video state 
linkage for a userland bootloader like kexec.

I need to poke around some more inside more framebuffer code and see 
what else might be possible.


Scott



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
