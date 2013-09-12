Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VK0ME-0004OU-Bk
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 06:26:28 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 10/10] Warn cyclic buffer overrun and correct it if
 possible
Date: Thu, 12 Sep 2013 06:17:11 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B1087@BPXM01GP.gisp.nec.co.jp>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
 <20121116050223.8280.12865.stgit@localhost6.localdomain6>
 <52302103.5000304@mxc.nes.nec.co.jp> <52302B6D.8060103@jp.fujitsu.com>
 <52312047.2010701@jp.fujitsu.com>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello HATAYAMA-san,

(2013/09/12 11:01), HATAYAMA Daisuke wrote:
> (2013/09/11 17:35), HATAYAMA Daisuke wrote:
>> (2013/09/11 16:51), Atsushi Kumagai wrote:
>>> Hello HATAYAMA-san,
>>>
>>> (2012/11/16 14:02), HATAYAMA Daisuke wrote:
>>>> Clearling bits on cyclic buffer can overrun the cyclic buffer
>>>> according to some combination of MAX_ORDER and cyclic buffer size.
>>>>
>>>> The cyclic buffer size is corrected if possible.
>>>>
>>>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>>>
>>> I know it's so late, I found that updating pfn_cyclic is missing.
>>> It can cause memory corruption.
>>>
>>
>> Hello Kumagai-san,
>>
>> Reviewed-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>>
>> It might be even better to introduce some kind of helper function that
>> sets up these cyclic-mode-related parameters and then to use it in
>> initial() and check_cyclic_buffer_overrun().
>>
>
> Hello Kumaga-san,
>
> I found one more bug. Could you review it?

Thanks, acked and pushed to devel branch.


Atsushi Kumagai

>
>  From c98375b9af6c19dff88823166eaf13674b4a47ec Mon Sep 17 00:00:00 2001
> From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Date: Thu, 12 Sep 2013 10:35:17 +0900
> Subject: [PATCH] Use divideup() to calculate maximum required bitmap size
>
> Currently, check_cyclic_buffer_overrun() wrongly calculates maximum
> bitmap size required to represent maximum block size managed by buddy
> allocator with roundup(). Then, max_block_size is BITPERBYTE-time
> larger than its correct size. As a result, although the bug never
> affect free-page filtering since roundup(max_order_nr_pages,
> BITPERBYTE) is a multiple of divideup(max_order_nr_pages, BITPERBYTE),
> the following sanity check, (max_block_size > info->bufsize_cyclic),
> and recalculation of info->bufsize_cyclic becomes BITPERBYTE-time
> conservative and inefficient.
>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>   makedumpfile.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 164b3f1..e66c494 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4078,10 +4078,10 @@ check_cyclic_buffer_overrun(void)
>   {
>       int max_order = ARRAY_LENGTH(zone.free_area);
>       int max_order_nr_pages = 1 << (max_order - 1);
> -    unsigned long max_block_size = roundup(max_order_nr_pages, BITPERBYTE);
> +    unsigned long max_block_size = divideup(max_order_nr_pages,
> +                        BITPERBYTE);
>
> -    if (info->bufsize_cyclic %
> -        roundup(max_order_nr_pages, BITPERBYTE)) {
> +    if (info->bufsize_cyclic % max_block_size) {
>           unsigned long bufsize;
>
>           if (max_block_size > info->bufsize_cyclic) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
