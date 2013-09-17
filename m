Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLn1n-00036M-Oz
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 04:36:44 +0000
Message-ID: <5237DC38.5020505@hp.com>
Date: Tue, 17 Sep 2013 12:36:08 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [BUG] [compressed kdump / SADUMP] makedumpfile header truncation
 error
References: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
In-Reply-To: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, jingbai.ma@hp.com, usui@mxm.nes.nec.co.jp, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

On 09/17/2013 03:45 AM, Dave Anderson wrote:
> Recent testing on very large memory systems dictates that an
> update is required for the compressed kdump header generated
> by makedumpfile.
>
> The dumpfile header has this field, which was inherited from
> the old "diskdump" facility:
>
>   struct disk_dump_header {
>   ...
>          unsigned int            max_mapnr;      /* = max_mapnr */
>   ...
>
> and which, among other things, is used by the crash utility as a
> delimiter to determine whether a physical address read request is
> legitimate.  And obviously the field cannot handle PFN values greater
> than 32-bits.
>
> The makedumpfile source code does have its own max_mapnr representation
> in its DumpInfo structure in "makedumpfile.h":
>
>   struct DumpInfo {
>   ...
>          unsigned long long      max_mapnr;   /* number of page descriptor */
>   ...
>
> But in its "diskdump_mod.h" file, it carries forward the old diskdump
> header format, which has the 32-bit field:
>
>   struct disk_dump_header {
>   ...
>          unsigned int            max_mapnr;      /* = max_mapnr */
>   ...
>
> And here in "makedumpfile.c", the inadvertent truncation occurs
> when the PFN is greater than 32-bits:
>
>   int
>   write_kdump_header(void)
>   {
>   ...
>          dh->max_mapnr      = info->max_mapnr;
>   ...
>
> The 32-bit field has also been carried forward into the SADUMP header
> as well, which has this in "sadump_mod.h":
>
>   struct sadump_header {
> 	...
>          uint32_t max_mapnr;     /* = max_mapnr */	
> 	...
>
> And when these header structures change, the crash utility will need
> to be changed accordingly.
>
> Preferably for backwards-compatibility, a new header_version can be
> created, with the new expanded field located in the kdump_sub_header
> so that the original base structure can remain as-is.  But I leave that
> up to the maintainers.
>
> Thanks,
>    Dave
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

For the persistent data structures, we should use more precision 
declaration int32_t, int64_t, uint64_t instead of ambiguous int, long 
int, long long int.
For example, we can change structure disk_dump_header as below:
struct disk_dump_header {
         char                    signature[SIG_LEN];     /* = "KDUMP   " */
         int32_t                 header_version; /* Dump header version */
         struct new_utsname      utsname;        /* copy of 
system_utsname */
         struct timeval          timestamp;      /* Time stamp */
         uint32_t                status;         /* Above flags */
         int32_t                 block_size;     /* Size of a block in 
byte */
         int32_t                 sub_hdr_size;   /* Size of arch dependent
                                                    header in blocks */
         uint32_t                bitmap_blocks;  /* Size of Memory bitmap in
                                                    block */
         uint64_t                max_mapnr;      /* = max_mapnr */
         uint32_t                total_ram_blocks;/* Number of blocks 
should be
                                                    written */
         uint32_t                device_blocks;  /* Number of total 
blocks in
                                                  * the dump device */
         uint32_t                written_blocks; /* Number of written 
blocks */
         uint32_t                current_cpu;    /* CPU# which handles 
dump */
         int32_t                 nr_cpus;        /* Number of CPUs */
         struct task_struct      *tasks[0];
};


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
