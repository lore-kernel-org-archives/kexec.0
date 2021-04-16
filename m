Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXNOs-009Lpy-OV
 for kexec@lists.infradead.org; Fri, 16 Apr 2021 12:16:44 +0000
Date: Fri, 16 Apr 2021 14:16:36 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
Message-ID: <20210416121636.GA22348@zn.tnic>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
 <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
 <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
 <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Apr 16, 2021 at 02:02:07PM +0200, Mike Galbraith wrote:
> [   15.428011] BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap_entries+0x17e/0x3a0
> [   15.428018] Write of size 8 at addr ffffc90000426008 by task kexec/1187
> 
> (gdb) list *crash_setup_memmap_entries+0x17e
> 0xffffffff8107cafe is in crash_setup_memmap_entries (arch/x86/kernel/crash.c:322).
> 317                                      unsigned long long mend)
> 318     {
> 319             unsigned long start, end;
> 320
> 321             cmem->ranges[0].start = mstart;
> 322             cmem->ranges[0].end = mend;
> 323             cmem->nr_ranges = 1;
> 324
> 325             /* Exclude elf header region */
> 326             start = image->arch.elf_load_addr;
> (gdb)
> 
> Append missing struct crash_mem_range to cmem.

This is winning this year's contest for most laconic patch commit
message! :-)

Please be more verbose and structure your commit message like this:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
