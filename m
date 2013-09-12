Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJwDz-00007f-NH
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 02:01:41 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EA66E3EE1A3
 for <kexec@lists.infradead.org>; Thu, 12 Sep 2013 11:01:09 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id DCB8545DE4F
 for <kexec@lists.infradead.org>; Thu, 12 Sep 2013 11:01:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B849945DE53
 for <kexec@lists.infradead.org>; Thu, 12 Sep 2013 11:01:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 284FE1DB803B
 for <kexec@lists.infradead.org>; Thu, 12 Sep 2013 11:01:09 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C6B39E18003
 for <kexec@lists.infradead.org>; Thu, 12 Sep 2013 11:01:08 +0900 (JST)
Message-ID: <52312047.2010701@jp.fujitsu.com>
Date: Thu, 12 Sep 2013 11:00:39 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 10/10] Warn cyclic buffer overrun and correct it if
 possible
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
 <20121116050223.8280.12865.stgit@localhost6.localdomain6>
 <52302103.5000304@mxc.nes.nec.co.jp> <52302B6D.8060103@jp.fujitsu.com>
In-Reply-To: <52302B6D.8060103@jp.fujitsu.com>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

(2013/09/11 17:35), HATAYAMA Daisuke wrote:
> (2013/09/11 16:51), Atsushi Kumagai wrote:
>> Hello HATAYAMA-san,
>>
>> (2012/11/16 14:02), HATAYAMA Daisuke wrote:
>>> Clearling bits on cyclic buffer can overrun the cyclic buffer
>>> according to some combination of MAX_ORDER and cyclic buffer size.
>>>
>>> The cyclic buffer size is corrected if possible.
>>>
>>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>>
>> I know it's so late, I found that updating pfn_cyclic is missing.
>> It can cause memory corruption.
>>
>
> Hello Kumagai-san,
>
> Reviewed-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>
> It might be even better to introduce some kind of helper function that
> sets up these cyclic-mode-related parameters and then to use it in
> initial() and check_cyclic_buffer_overrun().
>

Hello Kumaga-san,

I found one more bug. Could you review it?

 From c98375b9af6c19dff88823166eaf13674b4a47ec Mon Sep 17 00:00:00 2001
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Thu, 12 Sep 2013 10:35:17 +0900
Subject: [PATCH] Use divideup() to calculate maximum required bitmap size

Currently, check_cyclic_buffer_overrun() wrongly calculates maximum
bitmap size required to represent maximum block size managed by buddy
allocator with roundup(). Then, max_block_size is BITPERBYTE-time
larger than its correct size. As a result, although the bug never
affect free-page filtering since roundup(max_order_nr_pages,
BITPERBYTE) is a multiple of divideup(max_order_nr_pages, BITPERBYTE),
the following sanity check, (max_block_size > info->bufsize_cyclic),
and recalculation of info->bufsize_cyclic becomes BITPERBYTE-time
conservative and inefficient.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
  makedumpfile.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 164b3f1..e66c494 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4078,10 +4078,10 @@ check_cyclic_buffer_overrun(void)
  {
  	int max_order = ARRAY_LENGTH(zone.free_area);
  	int max_order_nr_pages = 1 << (max_order - 1);
-	unsigned long max_block_size = roundup(max_order_nr_pages, BITPERBYTE);
+	unsigned long max_block_size = divideup(max_order_nr_pages,
+						BITPERBYTE);
  
-	if (info->bufsize_cyclic %
-	    roundup(max_order_nr_pages, BITPERBYTE)) {
+	if (info->bufsize_cyclic % max_block_size) {
  		unsigned long bufsize;
  
  		if (max_block_size > info->bufsize_cyclic) {
-- 
1.8.3.1



-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
