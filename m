Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLpCu-00051V-Hy
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 06:56:21 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 9CE133EE0BB
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:55:58 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C33345DE54
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:55:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 71D4245DE4E
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:55:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5E2B81DB8043
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:55:58 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 016001DB803F
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:55:58 +0900 (JST)
Message-ID: <5237FCEC.8000608@jp.fujitsu.com>
Date: Tue, 17 Sep 2013 15:55:40 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [BUG] [compressed kdump / SADUMP] makedumpfile header truncation
 error
References: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
 <5237DC38.5020505@hp.com>
In-Reply-To: <5237DC38.5020505@hp.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, usui@mxm.nes.nec.co.jp, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, WANG Chao <chaowang@redhat.com>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

(2013/09/17 13:36), Jingbai Ma wrote:
<cut>
>>
>> And when these header structures change, the crash utility will need
>> to be changed accordingly.
>>
>> Preferably for backwards-compatibility, a new header_version can be
>> created, with the new expanded field located in the kdump_sub_header
>> so that the original base structure can remain as-is.  But I leave that
>> up to the maintainers.
>>
>> Thanks,
>>    Dave
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>
> For the persistent data structures, we should use more precision declaration int32_t, int64_t, uint64_t instead of ambiguous int, long int, long long int.
> For example, we can change structure disk_dump_header as below:
> struct disk_dump_header {
>          char                    signature[SIG_LEN];     /* = "KDUMP   " */
>          int32_t                 header_version; /* Dump header version */
>          struct new_utsname      utsname;        /* copy of system_utsname */
>          struct timeval          timestamp;      /* Time stamp */
>          uint32_t                status;         /* Above flags */
>          int32_t                 block_size;     /* Size of a block in byte */
>          int32_t                 sub_hdr_size;   /* Size of arch dependent
>                                                     header in blocks */
>          uint32_t                bitmap_blocks;  /* Size of Memory bitmap in
>                                                     block */
>          uint64_t                max_mapnr;      /* = max_mapnr */
>          uint32_t                total_ram_blocks;/* Number of blocks should be
>                                                     written */
>          uint32_t                device_blocks;  /* Number of total blocks in
>                                                   * the dump device */
>          uint32_t                written_blocks; /* Number of written blocks */
>          uint32_t                current_cpu;    /* CPU# which handles dump */
>          int32_t                 nr_cpus;        /* Number of CPUs */
>          struct task_struct      *tasks[0];
> };
>
>

Looking at arch directory, this structure is used on x86, x86_64, ppc, ppc64, s390
and ia64. Does this definition work well on all the architectures?

tasks member has obviously different length in each architecture but this member
is never used now.

More worse is kdump_sub_header structure. Obviously, unsigned long has different
length on x86 and x86_64, though you have already noticed this. I don't know ABI on
other architectures. Sorry.

/*
  * Sub header for KDUMP
  * But Common header of KDUMP is disk_dump_header of diskdump.
  */
struct kdump_sub_header {
         unsigned long   phys_base;
         int             dump_level;     /* header_version 1 and later */
         int             split;          /* header_version 2 and later */
         unsigned long   start_pfn;      /* header_version 2 and later */
         unsigned long   end_pfn;        /* header_version 2 and later */
         off_t           offset_vmcoreinfo;/* header_version 3 and later */
         unsigned long   size_vmcoreinfo;  /* header_version 3 and later */
         off_t           offset_note;      /* header_version 4 and later */
         unsigned long   size_note;        /* header_version 4 and later */
         off_t           offset_eraseinfo; /* header_version 5 and later */
         unsigned long   size_eraseinfo;   /* header_version 5 and later */
};

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
