Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SFhmR-00028f-W0
 for kexec@lists.infradead.org; Thu, 05 Apr 2012 08:10:57 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 57CB03EE0BD
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 17:10:51 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3E45645DE7E
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 17:10:51 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 26AF045DEB4
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 17:10:51 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1AEAB1DB803E
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 17:10:51 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C8CFC1DB803C
 for <kexec@lists.infradead.org>; Thu,  5 Apr 2012 17:10:50 +0900 (JST)
Date: Thu, 05 Apr 2012 17:10:41 +0900 (   )
Message-Id: <20120405.171041.183021247.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH][makedumpfile] sadump: check if given cpu is online in
 per-cpu related helper functions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120405162320.e69b3447.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120220170253.e79219aa.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120220.181740.278734450.d.hatayama@jp.fujitsu.com>
 <20120405162320.e69b3447.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH][makedumpfile] sadump: check if given cpu is online in per-cpu related helper functions
Date: Thu, 5 Apr 2012 16:23:20 +0900

> Hello Hatayama-san,
> 
> On Mon, 20 Feb 2012 18:17:40 +0900 (   )
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> > On Mon, 20 Feb 2012 11:19:15 +0900 (   )
>> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> > 
>> >> Per-cpu helper functions sanity check given cpu ids if they are
>> >> not-minus and less than the maximal but it should have checked if they
>> >> are online. By this mistake, one cannot see generated vmcore correctly
>> >> if sadump collects vmcore when some cpus are offline e.g. using cpu
>> >> hotplug or panic and so all the cpus except for a unique CPU halting.
>> >> 
>> >> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> >> ---
>> >>  sadump_info.c |   18 ++++++++++++++----
>> >>  1 files changed, 14 insertions(+), 4 deletions(-)
>> > 
>> > Thank you for your patch. 
>> > I will review it and it will be merged into v1.4.4
>> > because I'm preparing the release of v1.4.3 now.
>> > 
>> > Thanks
>> > Atsushi Kumagai
>> > 
>> 
>> I see. Thanks.
> 
> Sorry for late reply.
> 
> I reviewed your patch and it looks good.
> I will merge it into v1.4.4 as planned.
> 

I see. Thanks for your review.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
