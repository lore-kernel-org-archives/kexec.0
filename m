Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HtmQZ-00010G-8o
	for kexec@lists.infradead.org; Thu, 31 May 2007 11:19:07 -0400
Date: Thu, 31 May 2007 17:18:42 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Fix ELF output with overlapping sections
Message-ID: <20070531151842.GA16961@suse.de>
References: <20070518104715.GD16227@suse.de>
	<20070531112608oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070531112608oomichi@mail.jp.nec.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

Hello Ken'ichi,

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-31 04:26]:
> 2007/05/18 12:47:15 +0200, Bernhard Walle <bwalle@suse.de> wrote:
> >I have a core dump with following program headers on IA64:
> >
> >  LOAD           0x0000000000001f4c 0xa000000100000000 0x0000000004000000
> >                 0x000000000055c4a0 0x000000000055c4a0  RWE    0
> >...
> >  LOAD           0x00000000044fc3ec 0xe000000004000000 0x0000000004000000
> >                 0x0000000000c92000 0x0000000000c92000  RWE    0
> >
> >The interesting thing is the overlap in the physical address space.
> >write_elf_pages() assumes that there's no overlap because it looks only
> >for the file offset according to the physical start address and silently
> >assumes that the length matches.
> 
> Thank you for the patch.
> I'm worry that the overlapping spaces may have the same p_filesz.
> I think it is certain to check it by p_offset, and created the
> attached patch. Please let me know your opinion.
> 
> 
> BTW, I don't know the reason why your system's /proc/vmcore has the
> overlapping physical address. If you know it, please let me know.

thanks for the patch. It looks more safe than my attempt to fix it.
I tested your patch on the machine on which I originally had my
problem. It worked without any problems.

So I vote for applying the patch to your code base. :-)


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
