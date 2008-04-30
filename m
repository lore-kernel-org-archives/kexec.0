Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Jr7oG-00039q-Ch
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 08:37:04 +0000
Date: Wed, 30 Apr 2008 10:38:14 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec --real-mode
Message-ID: <20080430103814.072c9ef9@strauss.suse.de>
In-Reply-To: <m1fxt44m72.fsf@frodo.ebiederm.org>
References: <20080422151622.43c85a00@strauss.suse.de>
	<e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
	<20080423103400.6e3d9d90@strauss.suse.de>
	<m163u8oeli.fsf@frodo.ebiederm.org>
	<20080428102213.63eeaba1@strauss.suse.de>
	<m1bq3t50fq.fsf@frodo.ebiederm.org>
	<20080429175826.4a891110@strauss.suse.de>
	<m1fxt44m72.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
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
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

* Eric W. Biederman [2008-04-29 10:15]:
> 
> Ok.  I'm guessing that whatever it is immediately after
> the e820 map dump causes the box to go south.
> 
> But this is a very good clue that your BIOS just can't
> handle being run after the linux kernel has run at
> this point.  Unfortunately this is common and why
> the --real-mode switch has not been the default for several years.

Ok, thanks.

> What is your interest in getting the --real-mode option working at this
> point?

Well, the first reason was just interest.

The second reason that pointed me in that direction is that I saw that
kdump-booted kernels ignore the VGA parameter [e.g. 791] (which is
quite clear since the video mode is not set in the boot block, but that
can be easily patched) and also ignore the compiled-in VGA value (set
with rdev). Then I saw that this is not done in the real kernel but in
the 16 bit boot code which is of course only executed in real mode
booting (arch/x86/boot/video.c).

I know the 32-bit booted kernel takes the video mode from the running
kernel, but currently it's not possible to change the mode. Well, it's
not really important, it just would be nice.

The overall reason behind this is that we (SUSE) use kexec now for the
first reboot in our distribution setup which works quite well, and
that's the reason I looked into that.



	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
