Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLpSb-0005PD-Mx
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 07:12:34 +0000
Message-ID: <523800C4.6070809@hp.com>
Date: Tue, 17 Sep 2013 15:12:04 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [BUG] [compressed kdump / SADUMP] makedumpfile header truncation
 error
References: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
 <5237DC38.5020505@hp.com> <5237FCEC.8000608@jp.fujitsu.com>
In-Reply-To: <5237FCEC.8000608@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, usui@mxm.nes.nec.co.jp, WANG Chao <chaowang@redhat.com>, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

On 09/17/2013 02:55 PM, HATAYAMA Daisuke wrote:
> (2013/09/17 13:36), Jingbai Ma wrote:
> <cut>
>>>
>>> And when these header structures change, the crash utility will need
>>> to be changed accordingly.
>>>
>>> Preferably for backwards-compatibility, a new header_version can be
>>> created, with the new expanded field located in the kdump_sub_header
>>> so that the original base structure can remain as-is. But I leave that
>>> up to the maintainers.
>>>
>>> Thanks,
>>> Dave
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>>
>>
>> For the persistent data structures, we should use more precision
>> declaration int32_t, int64_t, uint64_t instead of ambiguous int, long
>> int, long long int.
>> For example, we can change structure disk_dump_header as below:
>> struct disk_dump_header {
>> char signature[SIG_LEN]; /* = "KDUMP " */
>> int32_t header_version; /* Dump header version */
>> struct new_utsname utsname; /* copy of system_utsname */
>> struct timeval timestamp; /* Time stamp */
>> uint32_t status; /* Above flags */
>> int32_t block_size; /* Size of a block in byte */
>> int32_t sub_hdr_size; /* Size of arch dependent
>> header in blocks */
>> uint32_t bitmap_blocks; /* Size of Memory bitmap in
>> block */
>> uint64_t max_mapnr; /* = max_mapnr */
>> uint32_t total_ram_blocks;/* Number of blocks should be
>> written */
>> uint32_t device_blocks; /* Number of total blocks in
>> * the dump device */
>> uint32_t written_blocks; /* Number of written blocks */
>> uint32_t current_cpu; /* CPU# which handles dump */
>> int32_t nr_cpus; /* Number of CPUs */
>> struct task_struct *tasks[0];
>> };
>>
>>
>
> Looking at arch directory, this structure is used on x86, x86_64, ppc,
> ppc64, s390
> and ia64. Does this definition work well on all the architectures?
>
> tasks member has obviously different length in each architecture but
> this member
> is never used now.
>
> More worse is kdump_sub_header structure. Obviously, unsigned long has
> different
> length on x86 and x86_64, though you have already noticed this. I don't
> know ABI on
> other architectures. Sorry.
>
> /*
> * Sub header for KDUMP
> * But Common header of KDUMP is disk_dump_header of diskdump.
> */
> struct kdump_sub_header {
> unsigned long phys_base;
> int dump_level; /* header_version 1 and later */
> int split; /* header_version 2 and later */
> unsigned long start_pfn; /* header_version 2 and later */
> unsigned long end_pfn; /* header_version 2 and later */
> off_t offset_vmcoreinfo;/* header_version 3 and later */
> unsigned long size_vmcoreinfo; /* header_version 3 and later */
> off_t offset_note; /* header_version 4 and later */
> unsigned long size_note; /* header_version 4 and later */
> off_t offset_eraseinfo; /* header_version 5 and later */
> unsigned long size_eraseinfo; /* header_version 5 and later */
> };
>

int32_t, int64_t, uint64_t, etc ... are parts of C99 standard:
http://en.wikipedia.org/wiki/C_data_types
All there types have been supported by GCC, so them should work on all 
the architectures.

Although change these persistent data structure will affect both 
makedumpfile and crash utility, but we will benefit from the consistent 
data structures independent from architectures. We can analyze a 
dumpfile on a OS with different architecture than the crashed OS.


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
