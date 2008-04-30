Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JrI9T-0005oF-FQ
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 19:39:40 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080422151622.43c85a00@strauss.suse.de>
	<e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
	<20080423103400.6e3d9d90@strauss.suse.de>
	<m163u8oeli.fsf@frodo.ebiederm.org>
	<20080428102213.63eeaba1@strauss.suse.de>
	<m1bq3t50fq.fsf@frodo.ebiederm.org>
	<20080429175826.4a891110@strauss.suse.de>
	<m1fxt44m72.fsf@frodo.ebiederm.org>
	<20080430103814.072c9ef9@strauss.suse.de>
Date: Wed, 30 Apr 2008 12:35:05 -0700
In-Reply-To: <20080430103814.072c9ef9@strauss.suse.de> (Bernhard Walle's
	message of "Wed, 30 Apr 2008 10:38:14 +0200")
Message-ID: <m163tzm906.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec --real-mode
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

Bernhard Walle <bwalle@suse.de> writes:

> * Eric W. Biederman [2008-04-29 10:15]:

>> What is your interest in getting the --real-mode option working at this
>> point?
>
> Well, the first reason was just interest.
>
> The second reason that pointed me in that direction is that I saw that
> kdump-booted kernels ignore the VGA parameter [e.g. 791] (which is
> quite clear since the video mode is not set in the boot block, but that
> can be easily patched) and also ignore the compiled-in VGA value (set
> with rdev). Then I saw that this is not done in the real kernel but in
> the 16 bit boot code which is of course only executed in real mode
> booting (arch/x86/boot/video.c).
>
> I know the 32-bit booted kernel takes the video mode from the running
> kernel, but currently it's not possible to change the mode. Well, it's
> not really important, it just would be nice.
>
> The overall reason behind this is that we (SUSE) use kexec now for the
> first reboot in our distribution setup which works quite well, and
> that's the reason I looked into that.

Ok.  So not critical but very useful to understand and it would be
cool to use if you could.  I wish I knew of a way to not confuse the
BIOS so we could do this more often.  I know I surprised a lot of
people with how often it worked on when I was actively pursuing it.

I have often suspected that the only way we could reliably run 16bit
code after running the linux kernel would be to load in an alternative
16bit BIOS like bochs that we could safely initialize from the state
the linux kernel left the hardware.  Although if we could ever figure
out what we are doing that confuses the hardware the other path could
be used.

For video mode changing it might be possible to just run the vga
BIOS calls and make them work.

All of which is to say there are paths forward if anyone wants to
pursue them.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
