Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.176])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JrJXb-0006Zj-Mo
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 21:08:39 +0000
Received: by py-out-1112.google.com with SMTP id a73so887279pye.2
	for <kexec@lists.infradead.org>; Wed, 30 Apr 2008 14:08:37 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.69)
	(envelope-from <jamey@oh.minilop.net>) id 1JrJXe-0006aa-4x
	for kexec@lists.infradead.org; Wed, 30 Apr 2008 14:08:42 -0700
Date: Wed, 30 Apr 2008 14:08:42 -0700
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: Re: kexec --real-mode
Message-ID: <20080430210842.GA25309@oh.minilop.net>
References: <20080422151622.43c85a00@strauss.suse.de>
	<e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
	<20080423103400.6e3d9d90@strauss.suse.de>
	<m163u8oeli.fsf@frodo.ebiederm.org>
	<20080428102213.63eeaba1@strauss.suse.de>
	<m1bq3t50fq.fsf@frodo.ebiederm.org>
	<20080429175826.4a891110@strauss.suse.de>
	<m1fxt44m72.fsf@frodo.ebiederm.org>
	<20080430103814.072c9ef9@strauss.suse.de>
	<m163tzm906.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m163tzm906.fsf@frodo.ebiederm.org>
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

On Wed, Apr 30, 2008 at 12:35:05PM -0700, Eric W. Biederman wrote:
> ... if we could ever figure out what we are doing that confuses the
> hardware the other path could be used.

In principle, purgatory could load GDB stubs and keep them around at
least long enough to debug code running in 16-bit mode, right? It would
be nice if somebody would do that. :-)

For a lot of my recent kexec work, I found it very helpful to use the
gdbserver in qemu, though I had to abandon it eventually due to
emulation bugs.

> For video mode changing it might be possible to just run the vga
> BIOS calls and make them work.

I was relying on vesafb in the kernel I wanted to boot. It turns out
that --real-mode works great on every machine I have handy, but doesn't
work for one of my co-workers. So I'm going to see if uvesafb works
better, in the next day or two hopefully.

http://dev.gentoo.org/~spock/projects/uvesafb/

I'm hoping that running the video BIOS in an x86 emulator works
reliably, and that that's the only boot failure I encounter. :-)

Jamey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
