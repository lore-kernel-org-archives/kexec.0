Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]
	helo=outbound3-va3-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JzHXW-0005A4-1N
	for kexec@lists.infradead.org; Thu, 22 May 2008 20:37:30 +0000
Message-ID: <4835D8F1.3040901@am.sony.com>
Date: Thu, 22 May 2008 13:34:57 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Runnix: another kexec based bootloader
References: <2d9149cd0805220007xfa06f4ar451b41c272455e3@mail.gmail.com>
In-Reply-To: <2d9149cd0805220007xfa06f4ar451b41c272455e3@mail.gmail.com>
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
To: Kristian Kielhofner <kkielhofner@star2star.com>
Cc: kexec@lists.infradead.org

Kristian Kielhofner wrote:
> Hello everyone,
> 
>   I"m not sure if this is the proper forum for these types of posts
> but I've been working on a kexec-based "bootloader" to meet my needs
> over the last year or so.  It's called Runnix.  Here's what I needed
> (Runnix current features - some in progress):
> 
> -  Small.  Runnix is currently about 2.7MB on disk with (very generic)
> Linux 2.6.20, busybox, uclibc, kexec-tools, and dropbear for SSH
> -  Download and verification (currently SHA1) of Linux images, both
> for download and boot.  If an on disk image fails SHA1, a new image
> can be downloaded.  If a download fails, a different on disk image can
> be used.

> -  Run time configuration using a simple ASCII text file (default.conf
> for runnix, .conf files for squashfs/ext2 filesystem images)
> -  Configuration, support, debugging from windows, mac, linux, etc
> (using FAT16 filesystem + syslinux)
> -  Automatic failover of images (should upgrade fail)
> -  Automatic network based debugging using SSH (remote logins via SSH
> upon boot/image failure)
> -  Runnix compilation and expansion via buildroot2 based build system

Just FYI, for the PS3 bootloader we now use OpenWRT, which has kexec.
It is quite easy to use, and I think better than a custom config like
you have.

Jeremy Kerr has ported libtwin and his petitbooot to OpenWRT, which we
use, but those are not yet merged in.  We have some local fixups we
plan to merge also.

  http://openwrt.org/
  http://ozlabs.org/~jk/projects/petitboot/
  http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-petitboot/

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
