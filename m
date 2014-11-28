Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XuH1C-00082F-BT
 for kexec@lists.infradead.org; Fri, 28 Nov 2014 08:35:12 +0000
Date: Fri, 28 Nov 2014 09:34:42 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: Kernel dump file access library (repost)
Message-ID: <20141128093442.11aaf41a@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D724DE@BPXM01GP.gisp.nec.co.jp>
References: <20141024113219.2bb5eeef@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D724DE@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "crash-utility@redhat.com" <crash-utility@redhat.com>

On Thu, 27 Nov 2014 08:09:57 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello Petr,
> 
> >Hi all,
> >
> >during this year's SUSE HackWeek, my colleague started work on enabling
> >kernel core files in gdb. I realized that there would be at least four
> >different programs implementing read access to kernel dump files:
> >
> >  1. the crash utility
> >  2. makedumpfile (when re-filtering)
> >  3. kdumpid (my project to get kernel version from a dump file)
> >  4. gdb-kdump (started by my colleague during HackWeek)
> >
> >At this point, I felt that's too much re-inventing the wheel again and
> >again, so I took my current code from kdumpid and adapted it as a
> >library that can be used by everybody:
> >
> >    https://github.com/ptesarik/libkdumpfile
> 
> I agree with you, your idea sounds reasonable.
> 
> >In its current shape, it's usable, but far from complete.
> >
> >Things that work already:
> >   - identify kdump file format
> >   - parsed meta-information from the header
> >   - open ELF, diskdump, makedumpfile, LKCD
> >   - read data by physical address (incl. Xen Dom0)
> >   - read data by Xen machine address
> >
> >Things still on my TODO list:
> >   - more formats: sadump, kvmdump, libvirt, xc_core, xc_save
> >   - determine phys_base in ELF files
> >   - determine kernel release if not found in headers
> 
> Aren't you going to make writer methods ?

I thought about it, not the least because there are already at least
three potential users of that functionality (makedumpfile, libvirt, and
crash gcore extension). However, I probably need some help designing
the API. Take makedumpfile as an example: the required actions depend on
the output format (ELF header allocation), cyclic/non-cyclic, single
file/multiple files, Xen/non-Xen... Streaming output should be possible
somehow...

Also, different output formats may offer different configurable
options. This is not an issue when reading (the library hides these
implementation details from the user), but there must be some API to
specify the desired output format. I prefer a generic API, so that when
more options are added, existing application continue to work, ideally
even without recompiling.

I'm sure all of the above can be done, but I haven't had enough time
even to gather all requirements.

In short, at this point, I welcome all ideas on how the writing API
should look like.

> If makedumpfile uses the library, I want to get rid of the dump format
> specific codes completely from makedumpfile, otherwise "re-inventing"
> will still occur.

Agreed. On the other hand, drawing the line between filtering and
writing is going to be a challenge.

> I suppose that other tools don't need writer methods, so I think
> it would be better if I make them.

See above. Crash "gcore" extension writes dump files, libvirt has some
support for writing dump files, and I'm sure there are quite a few
other tools that generate a kernel/VM dump of some sort, and all of
them might benefit from a standard API that allows them to use a wide
range of output formats without additional effort.

> >Ideally, I would like to replace all current implementations with
> >this library, so if a new file format appears, or a new feature is
> >added to one of the files, it can be immediately used by all
> >kdump-related tools.
> >
> >Please let me know what you think.
> >Oh, and if you're developing such a tool, let me know which features
> >should be added.
> 
> I've started an experiment to find out practical problems in switching
> to using the library. I'll let you know if I find any problems.

I'm curious.

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
