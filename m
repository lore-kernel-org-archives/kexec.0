Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hu37F-0000lG-8f
	for kexec@lists.infradead.org; Fri, 01 Jun 2007 05:08:40 -0400
Subject: Re: [PATCH] [makedumpfile] Fix ELF output with overlapping sections
In-reply-to: <20070531151842.GA16961@suse.de>
Message-Id: <20070601180827oomichi@mail.jp.nec.com>
References: <20070531151842.GA16961@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 1 Jun 2007 18:08:27 +0900
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
Cc: kexec@lists.infradead.org


Hi Bernhard,

2007/05/31 17:18:42 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-31 04:26]:
>> 2007/05/18 12:47:15 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>> >I have a core dump with following program headers on IA64:
>> >
>> >  LOAD           0x0000000000001f4c 0xa000000100000000 0x0000000004000000
>> >                 0x000000000055c4a0 0x000000000055c4a0  RWE    0
>> >...
>> >  LOAD           0x00000000044fc3ec 0xe000000004000000 0x0000000004000000
>> >                 0x0000000000c92000 0x0000000000c92000  RWE    0
>> >
>> >The interesting thing is the overlap in the physical address space.
>> >write_elf_pages() assumes that there's no overlap because it looks only
>> >for the file offset according to the physical start address and silently
>> >assumes that the length matches.
>> 
>> Thank you for the patch.
>> I'm worry that the overlapping spaces may have the same p_filesz.
>> I think it is certain to check it by p_offset, and created the
>> attached patch. Please let me know your opinion.
>> 
>> 
>> BTW, I don't know the reason why your system's /proc/vmcore has the
>> overlapping physical address. If you know it, please let me know.
>
>thanks for the patch. It looks more safe than my attempt to fix it.
>I tested your patch on the machine on which I originally had my
>problem. It worked without any problems.
>
>So I vote for applying the patch to your code base. :-)

Thank you for the test !
I will merge it.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
