Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOk2v-0007UL-28
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 08:02:05 +0000
Message-ID: <52429860.3040009@hp.com>
Date: Wed, 25 Sep 2013 16:01:36 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH] crash utility: fix max_mapnr issue on system has over
 44-bit addressing
References: <20130924125008.14740.98019.stgit@k.asiapacific.hpqcorp.net>
 <774037499.1295674.1380031111483.JavaMail.root@redhat.com>
In-Reply-To: <774037499.1295674.1380031111483.JavaMail.root@redhat.com>
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
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, d hatayama <d.hatayama@jp.fujitsu.com>, lisa mitchell <lisa.mitchell@hp.com>, vgoyal@redhat.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, chaowang@redhat.com, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, crash-utility@redhat.com

On 09/24/2013 09:58 PM, Dave Anderson wrote:
>
>
> ----- Original Message -----
>> The patch will add support for new compressed dumpfile header_version 6.
>>
>> This bug was posted here:
>> http://lists.infradead.org/pipermail/kexec/2013-September/009587.html
>>
>> This patch will add a new field in struct kdump_sub_header.
>> unsigned long   max_mapnr;
>>
>> And the old "unsigned int max_mapnr" in struct disk_dump_header will
>> not be used anymore. But still be there for compatibility purpose.
>>
>> Signed-off-by: Jingbai Ma<jingbai.ma@hp.com>
>
> Hello Jingbai,
>
> This patch needs to be backwards-compatible with respect
> to diskdump dumpfiles.  Your patch presumes that it's always
> dealing with a compressed kdump, and as a result it immediately
> generates a SIGSEGV when presented with a diskdump dumpfile:
>
>   $ crash vmcore vmlinux.gz
>
>   crash 7.0.3rc5
>   Copyright (C) 2002-2013  Red Hat, Inc.
>   Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
>   Copyright (C) 1999-2006  Hewlett-Packard Co
>   Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
>   Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
>   Copyright (C) 2005, 2011  NEC Corporation
>   Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
>   Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
>   This program is free software, covered by the GNU General Public License,
>   and you are welcome to change it and/or distribute copies of it under
>   certain conditions.  Enter "help copying" to see the conditions.
>   This program has absolutely no warranty.  Enter "help warranty" for details.
>
>   Segmentation fault (core dumped)
>   $
>
> The SIGSEGV is generated from this patch to read_dump_header():
>
> +       if (header->header_version<  6)
> +               sub_header_kdump->max_mapnr = header->max_mapnr;
>
> because the sub_header_kdump pointer is only malloc'd if the
> dumpfile is a compressed kdump.
>
> And after that, all of the presumptive usages of the kdump_sub_header
> must be handled differently, e.g., this will fail:
>
>   static inline int
> -dump_is_partial(const struct disk_dump_header *header)
> +dump_is_partial(const struct disk_dump_header *header,
> +       const struct kdump_sub_header *sub_header)
>   {
>          return header->bitmap_blocks>=
> -           divideup(divideup(header->max_mapnr, 8), dd->block_size) * 2;
> +           divideup(divideup(sub_header->max_mapnr, 8), dd->block_size) * 2;
>   }
>
> So pretty much everywhere that you've replaced "dd->header->max_mapnr"
> with either "sub_header_kdump->max_mapnr" or "dd->sub_header_kdump->max_mapnr"
> needs to be changed to use something like a pre-initialized local variable
> "max_mapnr" that gets set appropriately to the dumpfile type.
>
> Thanks,
>    Dave
>

Got it, I will fix all these issues and submit a new patch.
Thanks!

>
>
-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
