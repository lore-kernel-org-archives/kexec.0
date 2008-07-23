Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KLfZ3-0006de-95
	for kexec@lists.infradead.org; Wed, 23 Jul 2008 14:43:38 +0000
Message-ID: <48874394.6090602@suse.de>
Date: Wed, 23 Jul 2008 16:43:32 +0200
From: Stefan Assmann <sassmann@suse.de>
MIME-Version: 1.0
Subject: Re: ps3-kernel hang at kexec caused by usb
References: <4886EC22.3040805@suse.de>
In-Reply-To: <4886EC22.3040805@suse.de>
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
To: Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>
Cc: kexec@lists.infradead.org, Masakazu Mokuno <mokuno@sm.sony.co.jp>, Geoff Levand <geoffrey.levand@am.sony.com>

Stefan Assmann wrote:
> Hey all,
> 
> I'm having troubles to kexec recent kernels on Playstation 3.
> After issuing
> kexec -l <vmlinux> --initrd=<initrd>
> kexec -e
> the screen stays black.
> 
> I tracked this down in the suse kernel and it seems related to a patch
> with the Subject: USB: fix interrupt disabling for HCDs with shared
> interrupt handlers.

I forgot the git commit ID from mainline, sorry.
linux-2.6 bf9127c36341573dc47a9c2fc003dcf13bbbf246

> 
> This patch went mainline with 2.6.26 and the most likely reason why
> it has not been discovered yet may be because USB is compiled
> as a module in most cases. However the suse config has it compiled
> into the kernel and this causes some mischief.
> 
> It would be nice if somebody could try this on other distros as well.
> I'm attaching an altered ps3_defconfig (from geoffs git) that has
> USB compiled in. So all you need to do is compile a recent kernel
> (2.6.26) with that config and it should hang right after kexec.

  Stefan

-- 
Stefan Assmann          | SUSE LINUX Products GmbH
Software Engineer       | Maxfeldstr. 5, D-90409 Nuernberg
Mail : sassmann@suse.de | GF: Markus Rex, HRB 16746 (AG Nuernberg)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
