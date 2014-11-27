Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XtuBL-0007oM-HO
 for kexec@lists.infradead.org; Thu, 27 Nov 2014 08:12:08 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: Kernel dump file access library (repost)
Date: Thu, 27 Nov 2014 08:09:57 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D724DE@BPXM01GP.gisp.nec.co.jp>
References: <20141024113219.2bb5eeef@hananiah.suse.cz>
In-Reply-To: <20141024113219.2bb5eeef@hananiah.suse.cz>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "crash-utility@redhat.com" <crash-utility@redhat.com>

Hello Petr,

>Hi all,
>
>during this year's SUSE HackWeek, my colleague started work on enabling
>kernel core files in gdb. I realized that there would be at least four
>different programs implementing read access to kernel dump files:
>
>  1. the crash utility
>  2. makedumpfile (when re-filtering)
>  3. kdumpid (my project to get kernel version from a dump file)
>  4. gdb-kdump (started by my colleague during HackWeek)
>
>At this point, I felt that's too much re-inventing the wheel again and
>again, so I took my current code from kdumpid and adapted it as a
>library that can be used by everybody:
>
>    https://github.com/ptesarik/libkdumpfile

I agree with you, your idea sounds reasonable.

>In its current shape, it's usable, but far from complete.
>
>Things that work already:
>   - identify kdump file format
>   - parsed meta-information from the header
>   - open ELF, diskdump, makedumpfile, LKCD
>   - read data by physical address (incl. Xen Dom0)
>   - read data by Xen machine address
>
>Things still on my TODO list:
>   - more formats: sadump, kvmdump, libvirt, xc_core, xc_save
>   - determine phys_base in ELF files
>   - determine kernel release if not found in headers

Aren't you going to make writer methods ?
If makedumpfile uses the library, I want to get rid of the dump format
specific codes completely from makedumpfile, otherwise "re-inventing"
will still occur.
I suppose that other tools don't need writer methods, so I think
it would be better if I make them.

>Ideally, I would like to replace all current implementations with this
>library, so if a new file format appears, or a new feature is added to
>one of the files, it can be immediately used by all kdump-related tools.
>
>Please let me know what you think.
>Oh, and if you're developing such a tool, let me know which features
>should be added.

I've started an experiment to find out practical problems in switching
to using the library. I'll let you know if I find any problems.


Thanks
Atsushi Kumagai

>
>Regards,
>Petr Tesarik
>
>--
>Crash-utility mailing list
>Crash-utility@redhat.com
>https://www.redhat.com/mailman/listinfo/crash-utility

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
