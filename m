Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzPNZ-00089r-83
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 09:17:57 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 48B0E3EE0B5
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:17:51 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2D26545DE5B
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:17:51 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 143FD45DE58
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:17:51 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id F12E31DB8051
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:17:50 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 963DF1DB8044
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:17:50 +0900 (JST)
Date: Mon, 20 Feb 2012 18:17:40 +0900 (   )
Message-Id: <20120220.181740.278734450.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH][makedumpfile] sadump: check if given cpu is online in
 per-cpu related helper functions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120220170253.e79219aa.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120220.111915.28783507.d.hatayama@jp.fujitsu.com>
 <20120220170253.e79219aa.kumagai-atsushi@mxc.nes.nec.co.jp>
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

Hello Kumagai-san,

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH][makedumpfile] sadump: check if given cpu is online in per-cpu related helper functions
Date: Mon, 20 Feb 2012 17:02:53 +0900

> Hi Hatayama-san,
> 
> On Mon, 20 Feb 2012 11:19:15 +0900 (   )
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> Per-cpu helper functions sanity check given cpu ids if they are
>> not-minus and less than the maximal but it should have checked if they
>> are online. By this mistake, one cannot see generated vmcore correctly
>> if sadump collects vmcore when some cpus are offline e.g. using cpu
>> hotplug or panic and so all the cpus except for a unique CPU halting.
>> 
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> ---
>>  sadump_info.c |   18 ++++++++++++++----
>>  1 files changed, 14 insertions(+), 4 deletions(-)
> 
> Thank you for your patch. 
> I will review it and it will be merged into v1.4.4
> because I'm preparing the release of v1.4.3 now.
> 
> Thanks
> Atsushi Kumagai
> 

I see. Thanks.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
