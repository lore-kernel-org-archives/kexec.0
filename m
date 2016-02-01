Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aQDAJ-0002mh-Bv
 for kexec@lists.infradead.org; Mon, 01 Feb 2016 12:01:09 +0000
Date: Mon, 1 Feb 2016 13:00:42 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: readpage_elf: handle 0-pages not stored
 in the ELF file
Message-ID: <20160201130042.5c83f7ae@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E1B252@BPXM01GP.gisp.nec.co.jp>
References: <20160122233514.GA25777@ycc.fr>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E19AFB@BPXM01GP.gisp.nec.co.jp>
 <20160127085821.3be424e1@hananiah.suse.cz>
 <20160127103741.0e4fec81@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E1B252@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Ivan Delalande <colona@arista.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Atsushi,

On Mon, 1 Feb 2016 06:48:13 +0000
Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:

>[...]
> >Originally, makedumpfile was designed to read from /proc/vmcore, where
> >each segment's p_memsz is equal to its p_filesz. However, makedumpfile
> >can also be used to re-filter an already filtered ELF dump file, where
> >memory size may be larger than file size. In that case the memory size
> >should be used as the size of the segment. This affects:
> 
> Does this problem occur only if makedumpfile has done filtering ?

Indeed, I have only seen it in a previously filtered dump file, but see
below.

> According to the man 5 elf, even the original ELF file can have
> "unstored zero pages".
> 
> [...]

I'm aware of that.

> If unstored pages will be made only by makedumpfile, what I said
> Below has no meaning.

So, I had a look at the kernel code for /proc/vmcore, and it turns out
that the p_memsz and p_filesz fields for PT_LOAD segments are not
changed at all. This means they are prepared by:

  a. kexec(8) or
  b. kexec_file_load(2) in the old kernel, or
  c. elfcorehdr_alloc() in the new kernel (s390).

For option a, kexec/crashdump-elf.c says:

		phdr->p_filesz  = phdr->p_memsz = elf_info->kern_size;

and:
		phdr->p_filesz  = phdr->p_memsz = mend - mstart + 1;

For option b, arch/x86/kernel/crash.c says:

		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;

and:
		phdr->p_filesz = phdr->p_memsz = _end - _text;

For option c, arch/s390/kernel/crash_dump.c says:

		phdr->p_filesz = end - start;
		phdr->p_memsz = end - start;

To sum it up, both fields (p_filesz and p_memsz) may originate outside
the dump kernel (except s390), hence they cannot be fully trusted.
Theoretically, you can write a custom tool which creates ELF segments
with p_memsz greater than p_filesz and pass it to the secondary kernel.
However, I'm not sure how it should be interpreted in a kernel dump
file: The "file" is in fact physical RAM, so such a segment would in
effect forcibly replace existing RAM content with zeros.

OTOH another tool may post-process /proc/vmcore, translating
zero-filled pages to more segments with a smaller p_filesz (just like
makedumpfile does). If makedumpfile is supposed to interpret the output
of such a (hypothetical) tool correctly, then yes, you must follow the
ELF specification and treat the pages as zero.

>[...]
> >3. memory holes in KDUMP dumps
> >   Pages excluded in the original ELF dump will be appear as memory
> >   holes in the resulting KDUMP file's first bitmap.
> 
>  a. If an unstored page is a just zero page, it is neither on a memory hole
>     nor a filtered page. 
>  b. If an unstored page is the result of makedumpfile filtering, it should be
>     handled as a filtered page. 
> 
> However, I think it's impossible to distinguish whether former or latter
> after filtering.

Correct.

A clean solution would be to store this information in the filtered ELF
file, e.g. with a ELF note or with an OS-specific program header flag.

>[...]
> As I said above, I suspect not all of unstored pages are filtered pages,
> I'm not sure exclude_nodata_pages() does right things.
> As Ivan's patch does, I guess reading them as zero pages fits ELF's format
> specification.

That's right. It follows the ELF specification.

It may replace filtered out pages with zero-filled pages when
converting an already-filtered ELF file to the compressed format; but
they may be filtered again if bit 0 is set in the dump level, so Ivan's
approach is cleaner, in fact. If you ever find a way to mark filtered
out pages in an ELF file, then this behaviour can be improved later.

Anyway, are you going to take the patch by Ivan, or my patch (after I
remove exclude_nodata_pages)?

Regards,
Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
