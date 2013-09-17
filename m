Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLvG0-0005Hc-P1
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 13:24:00 +0000
Date: Tue, 17 Sep 2013 09:23:30 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <989901659.14097223.1379424210935.JavaMail.root@redhat.com>
In-Reply-To: <5238110F.9030408@hp.com>
References: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
 <5237DC38.5020505@hp.com> <5237FCEC.8000608@jp.fujitsu.com>
 <523800C4.6070809@hp.com> <523805C3.5030803@jp.fujitsu.com>
 <5238110F.9030408@hp.com>
Subject: Re: [BUG] [compressed kdump / SADUMP] makedumpfile header
 truncation error
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, usui@mxm.nes.nec.co.jp, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, WANG Chao <chaowang@redhat.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>



----- Original Message -----
> On 09/17/2013 03:33 PM, HATAYAMA Daisuke wrote:
> > (2013/09/17 16:12), Jingbai Ma wrote:
> >> On 09/17/2013 02:55 PM, HATAYAMA Daisuke wrote:
> >>
> >> int32_t, int64_t, uint64_t, etc ... are parts of C99 standard:
> >> http://en.wikipedia.org/wiki/C_data_types
> >> All there types have been supported by GCC, so them should work on all
> >> the architectures.
> >>
> >> Although change these persistent data structure will affect both
> >> makedumpfile and crash utility, but we will benefit from the
> >> consistent data structures independent from architectures. We can
> >> analyze a dumpfile on a OS with different architecture than the
> >> crashed OS.
> >>
> >>
> >
> > I know stdint.h things and usefulness if we can use crash and makedumpfile
> > for a multiple architectures on single arch. In fact, crash already supports
> > cross platform build among some architectures thanks to Dave.

But only if the host and target architectures have the same endian-ness and 
whose data type sizes match.  

The only problem that has ever been seen with the current header declarations
is if an x86 crash binary is built to support the 32-bit ARM architecture.  
For x86, the 64-bit off_t variables can start on a 4-byte boundary, but on ARM,
they have to start on an 8-byte boundary.  That being the case, the off_t
offset_vmcoreinfo is at offset 20 when built on an x86, and at offset 24
when built on ARM:

struct kdump_sub_header {
        unsigned long   phys_base;
        int             dump_level;         /* header_version 1 and later */
        int             split;              /* header_version 2 and later */
        unsigned long   start_pfn;          /* header_version 2 and later */
        unsigned long   end_pfn;            /* header_version 2 and later */
        off_t           offset_vmcoreinfo;  /* header_version 3 and later */
        unsigned long   size_vmcoreinfo;    /* header_version 3 and later */
        off_t           offset_note;        /* header_version 4 and later */
        unsigned long   size_note;          /* header_version 4 and later */
        off_t           offset_eraseinfo;   /* header_version 5 and later */
        unsigned long   size_eraseinfo;     /* header_version 5 and later */
};

So for that anomoly, crash has to support a kdump_sub_header_ARM_target
structure that has a pad integer after the end_pfn variable.

> >
> > My question came from the fact that it looks like you introduced a single
> > modified kdump_sub_header structure for all the architectures. They might
> > have different combination of length between int and long and maybe
> > also have other each architecture specific incompatibility. It wouldn't
> > work well.
> >
> > But from your reply, I think you mean a fully new header for
> > kdump-compressed
> > format, right? If so, it must work well. But of course you need to modify
> > both of makedumpfile and crash utility to support it.
> >
> 
> Yes, I would like to have a new header for kdump-compressed format. But
> I'm not sure how much code will be affected in makedumpfile and crash utility.
> I'm still under investigating, any ideas would be appreciated.

The challenging part will be the requirement to maintain backwards-compatibility,
at least in the crash utility.  And backwards-compatibility would also be required
in makedumpfile, right?  For example, if you want to re-filter an older compressed
kdump.

But if -- as has been done so far -- an increment of the header_version in the 
disk_dump_header to signal an additional field in the kdump_sub_header would be 
trivial to implement.

Dave





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
