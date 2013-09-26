Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VPBgA-0007FG-VT
 for kexec@lists.infradead.org; Thu, 26 Sep 2013 13:32:27 +0000
Date: Thu, 26 Sep 2013 15:31:53 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH / RFC] makedumpfile header to show LZO/snappy/zlib
Message-ID: <20130926153153.34c86e19@hananiah.suse.cz>
In-Reply-To: <408026044.15752698.1379682280786.JavaMail.root@redhat.com>
References: <1099586971.12086400.1378996512279.JavaMail.root@redhat.com>
 <523BCD38.4020702@mxc.nes.nec.co.jp>
 <408026044.15752698.1379682280786.JavaMail.root@redhat.com>
Mime-Version: 1.0
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

On Fri, 20 Sep 2013 09:04:40 -0400 (EDT)
Dave Anderson <anderson@redhat.com> wrote:

> 
> 
> ----- Original Message -----
> > Hello Dave,
> > 
> > (2013/09/16 0:56), Dave Anderson wrote:
> > >
> > > With the advent of LZO and snappy compression support, it would be
> > > helpful if it could be readily determined which type of compression
> > > was used to create the dumpfile.
> > >
> > > The zlib/LZO/snappy indicator is only found down in the bowels of each
> > > page_desc structure:
> > >
> > >    /* page flags */
> > >    #define DUMP_DH_COMPRESSED_ZLIB 0x1     /* page is compressed with zlib
> > >    */
> > >    #define DUMP_DH_COMPRESSED_LZO  0x2     /* paged is compressed with lzo
> > >    */
> > >    #define DUMP_DH_COMPRESSED_SNAPPY       0x4
> > >                                            /* paged is compressed with
> > >                                            snappy */
> > >
> > >    /* descriptor of each page for vmcore */
> > >    typedef struct page_desc {
> > >            off_t                   offset;         /* the offset of the
> > >            page data*/
> > >            unsigned int            size;           /* the size of this dump
> > >            page */
> > >            unsigned int            flags;          /* flags */
> > >            unsigned long long      page_flags;     /* page flags */
> > >    } page_desc_t;
> > >
> > > The compressed kdump's header does contain a "status" flag:
> > >
> > >    struct disk_dump_header {
> > >            char                    signature[SIG_LEN];     /* = "KDUMP   "
> > >            */
> > >            int                     header_version; /* Dump header version
> > >            */
> > >            struct new_utsname      utsname;        /* copy of
> > >            system_utsname */
> > >            struct timeval          timestamp;      /* Time stamp */
> > >            unsigned int            status;         /* Above flags */
> > >    ...
> > >
> > > which has these 3 flags:
> > >
> > >    #define DUMP_HEADER_COMPLETED   0
> > >    #define DUMP_HEADER_INCOMPLETED 1
> > >    #define DUMP_HEADER_COMPRESSED  8
> > >
> > > But they are all remnants of the old "diskdump" facility, and none of them
> > > are ever used by makedumpfile.
> > >
> > > Any chance that the LZO/snappy/zlib method could also be put up in
> > > the disk_dump_header?
> > >
> > > Dave
> > >
> > > --- makedumpfile-1.5.4/makedumpfile.c.orig
> > > +++ makedumpfile-1.5.4/makedumpfile.c
> > > @@ -5162,6 +5162,16 @@ write_kdump_header(void)
> > >      dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
> > >      memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
> > >      memcpy(&dh->utsname, &info->system_utsname, sizeof(dh->utsname));
> > > +    if (info->flag_compress & DUMP_DH_COMPRESSED_ZLIB)
> > > +        dh->status |= DUMP_DH_COMPRESSED_ZLIB;
> > > +#ifdef USELZO
> > > +    else if (info->flag_compress & DUMP_DH_COMPRESSED_LZO)
> > > +        dh->status |= DUMP_DH_COMPRESSED_LZO)
> > > +#endif
> > > +#ifdef USESNAPPY
> > > +    else if (info->flag_compress & DUMP_DH_COMPRESSED_SNAPPY)
> > > +        dh->status |= DUMP_DH_COMPRESSED_SNAPPY)
> > > +#endif
> > 
> > dh->status will not guarantee that *all pages* are compressed
> > by the check below:
> > 
> > >  #ifdef USELZO
> > >                  } else if (info->flag_lzo_support
> > >                             && (info->flag_compress &
> > >                             DUMP_DH_COMPRESSED_LZO)
> > >                             && ((size_out = info->page_size),
> > >                                 lzo1x_1_compress(buf, info->page_size,
> > >                                 buf_out,
> > >                                                  &size_out, wrkmem) ==
> > >                                                  LZO_E_OK)
> > >                             && (size_out < info->page_size)) {
> >                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > When there is no effect of compression, the page will not be compressed.
> > 
> > >                          pd.flags = DUMP_DH_COMPRESSED_LZO;
> > >                          pd.size  = size_out;
> > >                          memcpy(buf, buf_out, pd.size);
> > >  #endif
> > 
> > If we are on the same page, I'll accept your patch.
> 
> Right, I understand.

I think the primary intention is to let crash determine early if it is
able to open a given dump or not. And that's a good idea!

From a semantic point of view, the status field in the header should be
a logical OR of all compression methods used in the coredump. AFAICS,
Dave's patch would actually work for the current implementation.

Did I miss something?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
