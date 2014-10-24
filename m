Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XhbEg-0007i1-El
 for kexec@lists.infradead.org; Fri, 24 Oct 2014 09:32:43 +0000
Date: Fri, 24 Oct 2014 11:32:19 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Kernel dump file access library (repost)
Message-ID: <20141024113219.2bb5eeef@hananiah.suse.cz>
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
To: kexec@lists.infradead.org, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

[Seems, I used the wrong address; sorry for possible double posting.]

Hi all,

during this year's SUSE HackWeek, my colleague started work on enabling
kernel core files in gdb. I realized that there would be at least four
different programs implementing read access to kernel dump files:

  1. the crash utility
  2. makedumpfile (when re-filtering)
  3. kdumpid (my project to get kernel version from a dump file)
  4. gdb-kdump (started by my colleague during HackWeek)

At this point, I felt that's too much re-inventing the wheel again and
again, so I took my current code from kdumpid and adapted it as a
library that can be used by everybody:

    https://github.com/ptesarik/libkdumpfile

In its current shape, it's usable, but far from complete.

Things that work already:
   - identify kdump file format
   - parsed meta-information from the header
   - open ELF, diskdump, makedumpfile, LKCD
   - read data by physical address (incl. Xen Dom0)
   - read data by Xen machine address

Things still on my TODO list:
   - more formats: sadump, kvmdump, libvirt, xc_core, xc_save
   - determine phys_base in ELF files
   - determine kernel release if not found in headers

Ideally, I would like to replace all current implementations with this
library, so if a new file format appears, or a new feature is added to
one of the files, it can be immediately used by all kdump-related tools.

Please let me know what you think.
Oh, and if you're developing such a tool, let me know which features
should be added.

Regards,
Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
