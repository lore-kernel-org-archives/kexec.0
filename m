Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOd67-0006xT-Mf
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 00:36:57 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 41DC83EE1D7
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 09:36:26 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3310F45DE4E
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 09:36:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1251345DDCF
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 09:36:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EFCA01DB803A
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 09:36:25 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 906D51DB8038
 for <kexec@lists.infradead.org>; Wed, 25 Sep 2013 09:36:25 +0900 (JST)
Message-ID: <52422FCF.1030206@jp.fujitsu.com>
Date: Wed, 25 Sep 2013 09:35:27 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
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
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, lisa.mitchell@hp.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com, crash-utility@redhat.com

(2013/09/24 21:49), Jingbai Ma wrote:
> This patch will fix a bug of makedumpfile doesn't work correctly on system
> has over 44-bit addressing in compression dump mode.
> This bug was posted here:
> http://lists.infradead.org/pipermail/kexec/2013-September/009587.html
>
> This patch will add a new field in struct kdump_sub_header.
> unsigned long   max_mapnr;
>
> And the old "unsigned int max_mapnr" in struct disk_dump_header will
> not be used anymore. But still be there for compatibility purpose.
>
> This patch will change the header_version to 6.
>
> The corresponding patch for crash utility will be sent out separately.
>
> This patch doesn't change sadump_header.
> Because of in sadump file, there is no any sub-header, it has to change
> the sadump_header itself.
> And if do so, will cause backwards-compatibility issue.
> So it could be a separate patch if needed.
>
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
> ---
>   IMPLEMENTATION |    1 +
>   diskdump_mod.h |    5 ++++-
>   makedumpfile.c |   28 ++++++++++++++++++++++------
>   3 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/IMPLEMENTATION b/IMPLEMENTATION
> index f0f3135..d576811 100644
> --- a/IMPLEMENTATION
> +++ b/IMPLEMENTATION
> @@ -77,6 +77,7 @@
>   	unsigned long	size_note;        /* header_version 4 and later */
>   	off_t		offset_eraseinfo; /* header_version 5 and later */
>   	unsigned long	size_eraseinfo;   /* header_version 5 and later */
> +	unsigned long	max_mapnr;        /* header_version 6 and later */

x86 PAE mode can represents 52-bit physical addresses and so 40-bit physical
page frames. On x86_32 unsigned long has 32-bit length only. So, you should
define max_mapnr as unsigned long long.

>       };
>
>     - 1st-bitmap
> diff --git a/diskdump_mod.h b/diskdump_mod.h
> index af060b6..30306a5 100644
> --- a/diskdump_mod.h
> +++ b/diskdump_mod.h
> @@ -48,7 +48,9 @@ struct disk_dump_header {
>   						   header in blocks */
>   	unsigned int		bitmap_blocks;	/* Size of Memory bitmap in
>   						   block */
> -	unsigned int		max_mapnr;	/* = max_mapnr */
> +	unsigned int		max_mapnr;	/* = max_mapnr, 32bit only,
> +						   full 64bit in sub header.
> +						   Do not use this anymore! */
>   	unsigned int		total_ram_blocks;/* Number of blocks should be
>   						   written */
>   	unsigned int		device_blocks;	/* Number of total blocks in
> @@ -75,6 +77,7 @@ struct kdump_sub_header {
>   	unsigned long	size_note;        /* header_version 4 and later */
>   	off_t		offset_eraseinfo; /* header_version 5 and later */
>   	unsigned long	size_eraseinfo;   /* header_version 5 and later */
> +	unsigned long	max_mapnr;        /* header_version 6 and later */

This, too.

> @@ -5153,10 +5160,11 @@ write_kdump_header(void)
>   	 * Write common header
>   	 */
>   	strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
> -	dh->header_version = 5;
> +	dh->header_version = 6;
>   	dh->block_size     = info->page_size;
>   	dh->sub_hdr_size   = sizeof(kh) + size_note;
>   	dh->sub_hdr_size   = divideup(dh->sub_hdr_size, dh->block_size);
> +	/* dh->max_mapnr may be truncated here, full 64bit in kh.max_mapnr */
>   	dh->max_mapnr      = info->max_mapnr;

dh->max_mapnr = MIN(info->max_mapnr, UINT_MAX) seems better for old versions of crash utitlity.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
