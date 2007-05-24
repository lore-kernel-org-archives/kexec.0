Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hr7EL-0004mr-7b
	for kexec@lists.infradead.org; Thu, 24 May 2007 02:55:26 -0400
Date: Thu, 24 May 2007 08:54:59 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
Message-ID: <20070524065459.GB15395@suse.de>
References: <20070501133912.GA8247@suse.de>
	<20070524093556oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070524093556oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-24 02:35]:
> 2007/05/01 15:39:12 +0200, Bernhard Walle <bwalle@suse.de> wrote:
> >This patch implements support for following the debug information link i=
n the
> >.gnu_debuginfo section if the specified binary contains one. That makes =
it
> >possible to call makedumpfile with -x /boot/vmlinux-<version> on distrib=
utions
> >that ship extra -debuginfo packages for the kernel.
> =

> Isn't it good to specify the debuginfo file directly instead of your patc=
h ?
> I confirmed that makedumpfile without your patch can run by specifying the
> debuginfo file directly.

But it needs program headers, right? Very new versions of the binutils
don't add the program headers to the debug info file any more
(currently only in binutils CVS), so we need gnu_debuglink support
anyway. Of course my patch cannot handle this yet. I'll test this
after we have the binutils version in our distribution which will be
very soon ;-(.


Thanks,
   Bernhard
-- =

SUSE LINUX Products GmbH          Tel. +49 (911) 74053-0
Maxfeldstr. 5                     GF: Markus Rex
90409 N=FCrnberg, Germany           HRB 16746 (AG N=FCrnberg)
OpenPGP DDAF6454: F61F 34CC 09CA FB82 C9F6  BA4B 8865 3696 DDAF 6454

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
