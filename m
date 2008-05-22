Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wa-out-1112.google.com ([209.85.146.176])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jz4tu-0008FI-M4
	for kexec@lists.infradead.org; Thu, 22 May 2008 07:07:47 +0000
Received: by wa-out-1112.google.com with SMTP id v33so2826676wah.2
	for <kexec@lists.infradead.org>; Thu, 22 May 2008 00:07:44 -0700 (PDT)
Message-ID: <2d9149cd0805220007xfa06f4ar451b41c272455e3@mail.gmail.com>
Date: Thu, 22 May 2008 03:07:42 -0400
From: "Kristian Kielhofner" <kkielhofner@star2star.com>
Subject: Runnix: another kexec based bootloader
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

Hello everyone,

  I"m not sure if this is the proper forum for these types of posts
but I've been working on a kexec-based "bootloader" to meet my needs
over the last year or so.  It's called Runnix.  Here's what I needed
(Runnix current features - some in progress):

-  Small.  Runnix is currently about 2.7MB on disk with (very generic)
Linux 2.6.20, busybox, uclibc, kexec-tools, and dropbear for SSH
-  Download and verification (currently SHA1) of Linux images, both
for download and boot.  If an on disk image fails SHA1, a new image
can be downloaded.  If a download fails, a different on disk image can
be used.
-  Run time configuration using a simple ASCII text file (default.conf
for runnix, .conf files for squashfs/ext2 filesystem images)
-  Configuration, support, debugging from windows, mac, linux, etc
(using FAT16 filesystem + syslinux)
-  Automatic failover of images (should upgrade fail)
-  Automatic network based debugging using SSH (remote logins via SSH
upon boot/image failure)
-  Runnix compilation and expansion via buildroot2 based build system

  There are some random ancillary features to support these goals but
it's late and I'm probably forgetting them.  Anyway, I've been using
it for quite some time with no major problems.  It's been up on
SourceForge for a while but I haven't had as much time to work on it
for my needs, let alone anyone else's. :)

  While we've been using it with AstLinux for quite some time it
occurred to me I might want to expose it to the community at large
(especially kexec folks).  There's a lot to be improved upon - better
error handling, better handling of filesystems, upgrades, downgrades
kernel panics/kdump, etc.  I also don't like how squash/ext2 images
are handled.  Unionfs needs some work too, but that's not really a
runnix problem...

  If you're interested take a look and let me know what you think!

Runnix project page:
http://sourceforge.net/projects/runnix/

VmWare image with Runnix and AstLinux, built from SVN trunk:

http://admin.star2star.com/Runnix_Test-run84-ast1786.tar.bz2

Thanks!

-- 
Kristian Kielhofner
NOT sent from my iPhone or Blackberry

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
