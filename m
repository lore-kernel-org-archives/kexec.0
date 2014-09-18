Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUcCD-0005us-Jb
 for kexec@lists.infradead.org; Thu, 18 Sep 2014 13:56:30 +0000
Date: Thu, 18 Sep 2014 09:56:06 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <113939398.18102616.1411048566302.JavaMail.zimbra@redhat.com>
In-Reply-To: <541A8769.1070604@cn.fujitsu.com>
References: <mailman.12983.1410860958.22890.kexec@lists.infradead.org>
 <1344663963.15300444.1410873613602.JavaMail.zimbra@redhat.com>
 <5418F4D8.2070301@cn.fujitsu.com>
 <56999675.16763362.1410962144335.JavaMail.zimbra@redhat.com>
 <541A8769.1070604@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] makedumpfile: make the incomplete vmcore generated
 by ENOSPC error analyzable
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
To: Xiao Wang/Wang Xiao <wangx.fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> >
> > For compressed kdumps, the disk_dump_header.status field currently uses these
> > three bits:
> >
> >   #define DUMP_DH_COMPRESSED_ZLIB    0x1   /* page is compressed with zlib */
> >   #define DUMP_DH_COMPRESSED_LZO     0x2   /* page is compressed with lzo */
> >   #define DUMP_DH_COMPRESSED_SNAPPY  0x4   /* page is compressed with snappy */
> >
> > Can you please simply add a DUMP_DH_COMPRESSED_INCOMPLETE flag?
> 
> OK, I'll add this flag.
> 
> >
> > With respect to ELF vmcores, the processor-specific e_flags field is unused by the
> > crash utility, and it appears that makedumpfile always sets it to zero.  But
> > I'm not sure what the kernel does when /proc/vmcore is created?  Could there
> > be e_flags bits set there that a direct-copy of /proc/vmcore might contain?
> > That's why I suggested a unique ELF note.
> 
> Add a unique ELF note is OK, and I thought it must need to allocate some diskspace
> first to store this ELF note and its data, for if the dumpfile has been modified,
> it must write a flag in this place to indicate it's an incomplete dumpfile. But
> this may waste a bit of diskspace when the dumpfile is generated with no error.
 
Looking at "kexec/crashdump-elf.c" in the kexec-tools package, it should be safe
to use the e_flags field, because even if /proc/vmcore were copied unmodified
(without makedumpfile), the crash_create_elf32_headers()/crash_create_elf64_headers()
functions would always set it to 0:

       /* Setup ELF Header*/
        elf = (EHDR *) bufp;
        bufp += sizeof(EHDR);
        memcpy(elf->e_ident, ELFMAG, SELFMAG);
        elf->e_ident[EI_CLASS]  = elf_info->class;
        elf->e_ident[EI_DATA]   = elf_info->data;
        elf->e_ident[EI_VERSION]= EV_CURRENT;
        elf->e_ident[EI_OSABI] = ELFOSABI_NONE;
        memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
        elf->e_type     = ET_CORE;
        elf->e_machine  = crash_architecture(elf_info);
        elf->e_version  = EV_CURRENT;
        elf->e_entry    = 0;
        elf->e_phoff    = sizeof(EHDR);
        elf->e_shoff    = 0;
        elf->e_flags    = 0;
        elf->e_ehsize   = sizeof(EHDR);
        elf->e_phentsize= sizeof(PHDR);
        elf->e_phnum    = 0;
        elf->e_shentsize= 0;
        elf->e_shnum    = 0;
        elf->e_shstrndx = 0;

> I thought it will confuse a user when makedumpfile automatically modified the
> dumpfile name, so I'll keep the dumpfile name unchanged and use the above two
> flags in the dumpfile to indicate that it has been modified.

OK good -- thanks!

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
