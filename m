Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KQFvY-0008Mv-P8
	for kexec@lists.infradead.org; Tue, 05 Aug 2008 06:21:49 +0000
Message-Id: <4897F177.2060106@mxs.nes.nec.co.jp>
Date: Tue, 05 Aug 2008 15:21:43 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: Kdump compressed format
References: <20080804135309.4ef6f33b@halley.suse.de>
In-Reply-To: <20080804135309.4ef6f33b@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0950628088=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

--===============0950628088==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> is there any documentation how the kdump compressed format (or the
> diskdump format, from what it is derived) looks like? Beside of the
> source code of the tools that support it. ;-)

The kdump compressed format is supported by only the crash utility
and makedumpfile command. gdb does not support it. I think that
there is not any documentation about the kdump compressed format,
then I wrote it. Is it enough ?

----------------------------------------------------------------------------
* The kdump compressed format
                                               File offset
  +------------------------------------------+ 0x0
  |    main header (struct disk_dump_header) |
  |------------------------------------------+ block 1
  |    sub header (struct kdump_sub_header)  |
  |------------------------------------------+ block 2
  |            1st-bitmap                    |
  |------------------------------------------+ block 2 + X blocks (aligned by block)
  |            2nd-bitmap                    |
  |------------------------------------------+ block 2 + 2 * X blocks (aligned by block)
  | page header for pfn 0 (struct page_desc) |
  | page header for pfn 1 (struct page_desc) |
  |                     :                    |
  | page header for pfn Z (struct page_desc) |
  |------------------------------------------| (not aligned by block)
  |         page data (pfn 0)                |
  |         page data (pfn 1)                |
  |                        :                 |
  |         page data (pfn Z)                |
  +------------------------------------------+


* main header
  The main header of the kdump compressed format is the almost same as the one
  of diskdump. This header has the following members, and the member signature
  and header_version are different from diskdump.

  struct disk_dump_header {
        char                    signature[SIG_LEN];     /* = "KDUMP   " */
        int                     header_version; /* Dump header version */
        struct new_utsname      utsname;        /* copy of system_utsname */
        struct timeval          timestamp;      /* Time stamp */
        unsigned int            status;         /* Above flags */
        int                     block_size;     /* Size of a block in byte */
        int                     sub_hdr_size;   /* Size of arch dependent
                                                   header in blocks */
        unsigned int            bitmap_blocks;  /* Size of Memory bitmap in
                                                   block */
        unsigned int            max_mapnr;      /* = max_mapnr */
        unsigned int            total_ram_blocks;/* Number of blocks should be
                                                   written */
        unsigned int            device_blocks;  /* Number of total blocks in
                                                 * the dump device */
        unsigned int            written_blocks; /* Number of written blocks */
        unsigned int            current_cpu;    /* CPU# which handles dump */
        int                     nr_cpus;        /* Number of CPUs */
        struct task_struct      *tasks[0];
  };

* sub header
  The sub header of the kdump compressed format is orignal. This header
  has the member phys_base and dump_level. The member phys_base is for
  an x86_64 relocatable kernel, and the member dump_level has '-d' option's
  value of makedumpfile command.

  struct kdump_sub_header {
        unsigned long   phys_base;
        int             dump_level;     /* header_version 1 and later */
  };


* 1st-bitmap
  The bit of 1st-bitmap presents either a page on memory hole, or not.
  If a page is on memory hole, the corresponding bit is off. Otherwise,
  it is on.


* 2nd-bitmap
  The bit of 2nd-bitmap presents either a dumpable page, or not.
  If a page is on memory hole or excluded by makedumpfile command, the
  corresponding bit is off. Otherwise, it is on.


* page header
  There are page headers corresponding to dumpable pages.
  This header presents the corresponding page information (compressed, or not. etc.)

  typedef struct page_desc {
        off_t                   offset;         /* the offset of the page data*/
        unsigned int            size;           /* the size of this dump page */
        unsigned int            flags;          /* flags */
        unsigned long long      page_flags;     /* page flags */
  } page_desc_t;


Thanks
Ken'ichi Ohmichi



--===============0950628088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0950628088==--
