Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMF2f-0004me-Vs
 for kexec@lists.infradead.org; Wed, 18 Sep 2013 10:31:31 +0000
Message-ID: <523980C7.8060907@hp.com>
Date: Wed, 18 Sep 2013 18:30:31 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [BUG] [compressed kdump / SADUMP] makedumpfile header truncation
 error
References: <131560856.13730586.1379360704169.JavaMail.root@redhat.com>
 <5237DC38.5020505@hp.com> <5237FCEC.8000608@jp.fujitsu.com>
 <523800C4.6070809@hp.com> <523805C3.5030803@jp.fujitsu.com>
 <5238110F.9030408@hp.com>
 <989901659.14097223.1379424210935.JavaMail.root@redhat.com>
In-Reply-To: <989901659.14097223.1379424210935.JavaMail.root@redhat.com>
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
Cc: WANG Chao <chaowang@redhat.com>, Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, usui@mxm.nes.nec.co.jp, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

On 09/17/2013 09:23 PM, Dave Anderson wrote:
>
>
> ----- Original Message -----
>> On 09/17/2013 03:33 PM, HATAYAMA Daisuke wrote:
>>> (2013/09/17 16:12), Jingbai Ma wrote:
>>>> On 09/17/2013 02:55 PM, HATAYAMA Daisuke wrote:
>>>>
>>>> int32_t, int64_t, uint64_t, etc ... are parts of C99 standard:
>>>> http://en.wikipedia.org/wiki/C_data_types
>>>> All there types have been supported by GCC, so them should work on all
>>>> the architectures.
>>>>
>>>> Although change these persistent data structure will affect both
>>>> makedumpfile and crash utility, but we will benefit from the
>>>> consistent data structures independent from architectures. We can
>>>> analyze a dumpfile on a OS with different architecture than the
>>>> crashed OS.
>>>>
>>>>
>>>
>>> I know stdint.h things and usefulness if we can use crash and makedumpfile
>>> for a multiple architectures on single arch. In fact, crash already supports
>>> cross platform build among some architectures thanks to Dave.
>
> But only if the host and target architectures have the same endian-ness and
> whose data type sizes match.
>

If we have a standard for the dump file format, we can handle all the 
endian-ness issues.
I know it may affect the dumping speed on the platform that has to 
convert the byte order. But at least we can specify the byte order for 
dump file header. It won't cost too much.

> The only problem that has ever been seen with the current header declarations
> is if an x86 crash binary is built to support the 32-bit ARM architecture.
> For x86, the 64-bit off_t variables can start on a 4-byte boundary, but on ARM,
> they have to start on an 8-byte boundary.  That being the case, the off_t
> offset_vmcoreinfo is at offset 20 when built on an x86, and at offset 24
> when built on ARM:

This could be addressed through compiler attributes:
	off_t	offset_vmcoreinfo __atttribute__ ((aligned(8));
offset_vmcoreinfo will be the same 8-byte boundary on x86 as same as ARM

>
> struct kdump_sub_header {
>          unsigned long   phys_base;
>          int             dump_level;         /* header_version 1 and later */
>          int             split;              /* header_version 2 and later */
>          unsigned long   start_pfn;          /* header_version 2 and later */
>          unsigned long   end_pfn;            /* header_version 2 and later */
>          off_t           offset_vmcoreinfo;  /* header_version 3 and later */
>          unsigned long   size_vmcoreinfo;    /* header_version 3 and later */
>          off_t           offset_note;        /* header_version 4 and later */
>          unsigned long   size_note;          /* header_version 4 and later */
>          off_t           offset_eraseinfo;   /* header_version 5 and later */
>          unsigned long   size_eraseinfo;     /* header_version 5 and later */
> };
>

Do you like this change?
struct kdump_sub_header {
         unsigned long	phys_base;
         int		dump_level;
         int		split;
         unsigned long	start_pfn;
         unsigned long	end_pfn;
         off_t		offset_vmcoreinfo __atttribute__ ((aligned(8));
         unsigned long	size_vmcoreinfo;
         off_t		offset_note __atttribute__ ((aligned(8));
         unsigned long	size_note;
         off_t		offset_eraseinfo __atttribute__ ((aligned(8));
         unsigned long	size_eraseinfo;
};

Then you can get rid of the padded struct kdump_sub_header_ARM_target in 
crash utility.

Or we can go further, redefine whole structure and set all fields with 
specific bit width.

struct kdump_sub_header {
         uint64_t	phys_base;
         int32_t		dump_level;
         int32_t		split;
         uint64_t	start_pfn;
         uint64_t	end_pfn;
         uint64_t	offset_vmcoreinfo;
         uint64_t	size_vmcoreinfo;
         uint64_t	offset_note;
         uint64_t	size_note;
         uint64_t	offset_eraseinfo;
         uint64_t	size_eraseinfo;
};

I have checked the code of crash utility, it shouldn't affect too much, 
only in diskdump.c and diskdump.h.

> So for that anomoly, crash has to support a kdump_sub_header_ARM_target
> structure that has a pad integer after the end_pfn variable.
>
>>>
>>> My question came from the fact that it looks like you introduced a single
>>> modified kdump_sub_header structure for all the architectures. They might
>>> have different combination of length between int and long and maybe
>>> also have other each architecture specific incompatibility. It wouldn't
>>> work well.
>>>
>>> But from your reply, I think you mean a fully new header for
>>> kdump-compressed
>>> format, right? If so, it must work well. But of course you need to modify
>>> both of makedumpfile and crash utility to support it.
>>>
>>
>> Yes, I would like to have a new header for kdump-compressed format. But
>> I'm not sure how much code will be affected in makedumpfile and crash utility.
>> I'm still under investigating, any ideas would be appreciated.
>
> The challenging part will be the requirement to maintain backwards-compatibility,
> at least in the crash utility.  And backwards-compatibility would also be required
> in makedumpfile, right?  For example, if you want to re-filter an older compressed
> kdump.
>

It's not a big deal, we can check the header_version to decide treat it 
as traditional format or new format.
We can preserve the current structures as kdump_sub_header_v5 , 
kdump_sub_header_v5, etc... in both makedumpfile and crash utility.

> But if -- as has been done so far -- an increment of the header_version in the
> disk_dump_header to signal an additional field in the kdump_sub_header would be
> trivial to implement.

Yes, this approach is more simpler, but the drawback is we have to add a 
new 64bit max_mapnr_64 to disk_dump_header, then we will have two 
max_mapnr* fields, not very nice. And when we add more platforms, we 
still have to take care of the bit width and alignment.
Should we fix it in this version or just leave it as it used to be?

>
> Dave
>
>
>
>

-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
