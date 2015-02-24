Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YQLIr-0005oN-2l
 for kexec@lists.infradead.org; Tue, 24 Feb 2015 19:37:58 +0000
Date: Tue, 24 Feb 2015 14:37:29 -0500
From: Kyle McMartin <kmcmarti@redhat.com>
Subject: Re: Unhandled rela relocation: R_X86_64_29
Message-ID: <20150224192707.GA440@redacted.bos.redhat.com>
References: <alpine.LNX.2.11.1502021854480.10823@zinq.dscp.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.11.1502021854480.10823@zinq.dscp.org>
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
To: Ebben Aries <earies@dscp.org>
Cc: kexec@lists.infradead.org

On Mon, Feb 02, 2015 at 07:26:29PM -0800, Ebben Aries wrote:
> sym: _GLOBAL_OFFSET_TABLE_ info: 10 other: 00 shndx: 0 value: 0 size: 0
> sym: _GLOBAL_OFFSET_TABLE_ value: 4 addr: 31e5f6004
> R_X86_64_29
> Unhandled rela relocation: R_X86_64_29
> 

That's...

 59      RELOC_NUMBER (R_X86_64_GOTPC64,  29)     /* 64 bit signed pc relative
 60                                                  offset to GOT */

Which is a bit of an odd thing to see, since we don't handle anything
beyond _64, _32, _32S, and _PC32...

--Kyle

> 
> >From include/elf.h
> 
> /* AMD x86-64 relocations.  */
> #define R_X86_64_NONE           0       /* No reloc */
> #define R_X86_64_64             1       /* Direct 64 bit  */
> #define R_X86_64_PC32           2       /* PC relative 32 bit signed */
> #define R_X86_64_GOT32          3       /* 32 bit GOT entry */
> #define R_X86_64_PLT32          4       /* 32 bit PLT address */
> #define R_X86_64_COPY           5       /* Copy symbol at runtime */
> #define R_X86_64_GLOB_DAT       6       /* Create GOT entry */
> #define R_X86_64_JUMP_SLOT      7       /* Create PLT entry */
> #define R_X86_64_RELATIVE       8       /* Adjust by program base */
> #define R_X86_64_GOTPCREL       9       /* 32 bit signed PC relative
>                                             offset to GOT */
> #define R_X86_64_32             10      /* Direct 32 bit zero extended */
> #define R_X86_64_32S            11      /* Direct 32 bit sign extended */
> #define R_X86_64_16             12      /* Direct 16 bit zero extended */
> #define R_X86_64_PC16           13      /* 16 bit sign extended pc relative */
> #define R_X86_64_8              14      /* Direct 8 bit sign extended  */
> #define R_X86_64_PC8            15      /* 8 bit sign extended pc relative */
> #define R_X86_64_DTPMOD64       16      /* ID of module containing symbol */
> #define R_X86_64_DTPOFF64       17      /* Offset in module's TLS block */
> #define R_X86_64_TPOFF64        18      /* Offset in initial TLS block */
> #define R_X86_64_TLSGD          19      /* 32 bit signed PC relative offset
>                                             to two GOT entries for GD symbol */
> #define R_X86_64_TLSLD          20      /* 32 bit signed PC relative offset
>                                             to two GOT entries for LD symbol */
> #define R_X86_64_DTPOFF32       21      /* Offset in TLS block */
> #define R_X86_64_GOTTPOFF       22      /* 32 bit signed PC relative offset
>                                             to GOT entry for IE symbol */
> #define R_X86_64_TPOFF32        23      /* Offset in initial TLS block */
> 
> #define R_X86_64_NUM            24
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
