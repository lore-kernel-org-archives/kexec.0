Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLoz1-0004qT-Dr
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 06:42:00 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 24D803EE1A3
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:41:37 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 10A6145DE55
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:41:37 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DD74A45DE54
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:41:36 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CA7251DB803A
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:41:36 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7FC551DB8038
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:41:36 +0900 (JST)
Message-ID: <5237F981.9060305@jp.fujitsu.com>
Date: Tue, 17 Sep 2013 15:41:05 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
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
Cc: Baoquan He <bhe@redhat.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, usui@mxm.nes.nec.co.jp, lisa mitchell <lisa.mitchell@hp.com>, RuiRui Yang <ruyang@redhat.com>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kumagai-atsushi <kumagai-atsushi@mxc.nes.nec.co.jp>, WANG Chao <chaowang@redhat.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

(2013/09/17 4:45), Dave Anderson wrote:
<cut>
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

Thanks for pointing out that, Dave.

In fact, I've already noticed that. However, 32 bit unsigned integer can
still represent at most 16 TiB memory and FJ doesn't have system with more
than 16 TiB memory.

However, some FJ system will soon have larger memory and then sadump
will and must have new format that contains the corresponding improvement.
Then, I post the corresponding patch to crash utility and makedumpfile.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
