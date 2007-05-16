Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HoHXx-00038r-6k
	for kexec@lists.infradead.org; Wed, 16 May 2007 07:20:41 -0400
Subject: Re: [PATCH] [makedumpfile] Implement memory regions on IA64
In-reply-to: <20070515220845.GB823@suse.de>
Message-Id: <20070516202000oomichi@mail.jp.nec.com>
References: <20070515220845.GB823@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Wed, 16 May 2007 20:20:00 +0900
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, Kexec Mailing List <kexec@lists.infradead.org>


Hi Bernhard,

2007/05/16 00:08:45 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>Hello,
>
>* Bernhard Walle <bwalle@suse.de> [2007-05-14 23:49]:
>> 
>> I'm working on support for the 4 layer pagetable.
>
>Here's my first attempt. It works with SLES 10, SP1 on a Tiger4
>machine with 16 GiB of memory. (I had still problems with a big
>SGI machine when creating the bitmap. I'm investigating this, too.)
>
>The problem is not to implement the 4 layer page table, but to
>*detect* it. crash uses the built-in configuration data in the kernel
>image, and that's what I used in my patch. If you have a better and
>still reliable method, I'm open to suggestions. :-)

Thank you for the patch.
I tested makedumpfile with your patch on linux-2.6.18 ia64,
and it output the following message and failed.

Error message:
  $ makedumpfile -cd 31 -x vmlinux vmcore dumpfile
  Can't read kernel cofiguration from kernel binary
  makedumpfile Failed.
  $

The reason was that kernel binary file didn't have "kernel_config_data" 
because CONFIG_IKCONFIG was not set in my .config.
It is uncertain that "kernel_config_data" exists in a kernel binary.

I propose that makedumpfile distinguishes the page table (3L or 4L)
by checking the defined file name of pud_t.
I'm trying for the above implementation.
I will send you the patch when it is complete.

All the pud_t(s) of linux-2.6.16 - 2.6.21 are defined in the following files:

CONFIG_PGTABLE_4
  include/asm-ia64/page.h

!CONFIG_PGTABLE_4
  include/asm-generic/pgtable-nopud.h


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
