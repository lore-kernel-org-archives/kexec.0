Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUySQ-00021B-VB
 for kexec@lists.infradead.org; Wed, 13 Nov 2019 19:37:41 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide
 by zero in print_report())
Date: Wed, 13 Nov 2019 19:36:01 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03595014@BPXM09GP.gisp.nec.co.jp>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
 <20191009213855.GA14574@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03593DA7@BPXM09GP.gisp.nec.co.jp>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035949A4@BPXM09GP.gisp.nec.co.jp>
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035949A4@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Dave,

I think I've fixed the ELF issues which I could reproduce:
- wrong statistics
- e_phnum overflow

If you still see any problems with the latest makedumpfile,
please let me know.

Thanks,
Kazu

> -----Original Message-----
> > -----Original Message-----
> > >  > > There are some other failure cases with non-null data, so maybe there's >1 bug here.
> > >  > > I've not seen an obvious pattern to this. eg...
> > >  > >
> > >  > > https://pastebin.com/2uM4sBCF
> > >  > >
> > >  >
> > >  > As for this case, I suspect that Elf64_Ehdr.e_phnum overflows
> > >  > (i.e. num_loads_dumpfile > 65535):
> > >
> > > Oh, good catch.  These are 256GB machines, so after discarding
> > > everything, that explains why we end up with so many sections.
> > > This also explains why it sometimes works I think, when the discarding
> > > manages to get the total nr headers <64k.
> 
> I also could reproduce this issue on a system with 192GB memory.
> The note was actually overwritten by the following program headers.
> -----
> num_loads_dumpfile=76318                # more than 64k
> ehdr64.e_phnum=10783                    # overflowed
> note.p_offset=0x93708 .p_filesz=0x2958  # The note data is at 0x93708
> note cd_header->offset=0x40
> ...
>     head->off=     90040 load.p_addr= 44552e000 .p_off=  ed270060 ...
>                    ^^^^^ # these headers overwrote the note data.
>     head->off=     a0040 load.p_addr= 445630000 .p_off=  ed272060 ...
> ...
> The dumpfile is saved to dump.Ed25.devel.
> 
> makedumpfile Completed.
> 
> # readelf -a dump.Ed25.devel
> ...
>   Number of program headers:         10783
> ...
> Displaying notes found at file offset 0x00093708 with length 0x00002958:
>   Owner                 Data size       Description
>                        0x00000007       Unknown note type: (0xdbce6060)
>    description data: 00 00 7a 39 fffffff2 ffffff8a ffffffff
> # ../crash vmlinux dump.Ed25.devel
> 
> WARNING: possibly corrupt Elf64_Nhdr: n_namesz: 4185522176 n_descsz: 3 n_type: f4000
> ...
> WARNING: cannot read linux_banner string
> crash: vmlinux and dump.Ed25.devel do not match!
> -----
> 
> > I think this will be the one of the causes, and had a look at how
> > we can fix it.  If you get a vmcore where this pattern occurs,
> > you can try this tree:
> > https://github.com/k-hagio/makedumpfile/tree/support-extended-elf
> >
> > Then, the crash utility also needs a patch to support a dumpfile
> > that has more than 64k program headers:
> > https://github.com/k-hagio/crash/tree/support-extended-elf
> 
> These trees look to work well, though need more tests and tweaks.
> -----
> # readelf -a dump.Ed25.test
> ...
>   Number of program headers:         65535 (76319)  <<-- note + loads
> ...
> Displaying notes found at file offset 0x00413748 with length 0x00002958:
>   Owner                 Data size       Description
>   CORE                 0x00000150       NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150       NT_PRSTATUS (prstatus structure)
>   CORE                 0x00000150       NT_PRSTATUS (prstatus structure)
> ...
> # ../crash-test vmlinux dump.Ed25.test
> 
> crash-test> help -D
> vmcore_data:
>                   flags: c0 (KDUMP_LOCAL|KDUMP_ELF64)
>                    ndfd: 3
>                     ofp: 3141560
>             header_size: 4284576
>    num_pt_load_segments: 76318   <<-- loads
>      pt_load_segment[0]:
> -----
> 
> It is possible that the issue occurs on general systems if they have
> large memory, so I'm going to proceed with those patches.
> 
> Thanks,
> Kazu
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
