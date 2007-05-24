Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HrIsl-0000g0-4X
	for kexec@lists.infradead.org; Thu, 24 May 2007 15:21:57 -0400
Date: Thu, 24 May 2007 21:21:39 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
Message-ID: <20070524192139.GA4160@suse.de>
References: <20070501133912.GA8247@suse.de>
	<20070524093556oomichi@mail.jp.nec.com>
	<4655C9B3.7060903@sgi.com> <4655D9EA.8020601@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4655D9EA.8020601@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

Hello,

* Dave Anderson <anderson@redhat.com> [2007-05-24 20:31]:
> The crash utility hides the details of there being a separate debug
> file in the same way the gdb does when working with a binary executable
> that has a separate debuginfo file.  It tries *not* to be ambiguous,
> i.e., the point is to stay true to the "crash vmlinux vmcore" model.

It's documented in the GDB documentation:
http://sourceware.org/gdb/current/onlinedocs/gdb_16.html#SEC154

> That being said, does any other distro besides RHEL3 actually use
> the split vmlinux/vmlinux.debug format?  Thankfully Red Hat came
> to its senses in RHEL4 and beyond...

SUSE uses the split out debug information, starting from SLES 10 (also
openSUSE).  It makes sense on architectures that don't need a
separate, bootable kernel image (like x86_64 and i586) but can boot
the ELF file directly such as PPC and IA64.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
