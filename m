Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HtpIO-0002Ad-C2
	for kexec@lists.infradead.org; Thu, 31 May 2007 14:23:06 -0400
Date: Thu, 31 May 2007 20:22:17 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Fix ELF output with overlapping sections
Message-ID: <20070531182217.GA25532@suse.de>
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

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-31 04:26]:
> 
> BTW, I don't know the reason why your system's /proc/vmcore has the
> overlapping physical address. If you know it, please let me know.

  /*
   * Certain architectures such as x86_64 and ia64 require a separate
   * PT_LOAD program header for the kernel. This is controlled through
   * info->kern_size.
   *
   * The separate PT_LOAD program header is required either because the
   * kernel is mapped at a different location than the rest of the
   * physical memory or because we need to support relocatable kernels.
   * Or both as on x86_64.
   *
   * In the relocatable kernel case this PT_LOAD segment is used to tell
   * where the kernel was actually loaded which may be different from
   * the load address present in the vmlinux file.
   *
   * The extra kernel PT_LOAD program header results in a vmcore file
   * which is larger than the size of the physical memory. This is
   * because the memory for the kernel is present both in the kernel
   * PT_LOAD program header and in the physical RAM program headers.
   */


Thanks,
   Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
