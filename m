Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf3eN-0001Eh-4o
 for kexec@lists.infradead.org; Wed, 22 May 2013 07:39:56 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D0C0F3EE0AE
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 16:39:29 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C0EDA45DE52
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 16:39:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AAC6D45DDCF
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 16:39:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9B6DC1DB8043
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 16:39:29 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5331B1DB803E
 for <kexec@lists.infradead.org>; Wed, 22 May 2013 16:39:29 +0900 (JST)
Message-ID: <519C7610.6090709@jp.fujitsu.com>
Date: Wed, 22 May 2013 16:38:56 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: turn off mmap for free page scan
References: <E1UcggB-0005hJ-E0@eag09.americas.sgi.com>
 <20130522155712.0940be98ced5e3bcfde55acd@mxc.nes.nec.co.jp>
In-Reply-To: <20130522155712.0940be98ced5e3bcfde55acd@mxc.nes.nec.co.jp>
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
To: cpw@sgi.com
Cc: kexec@lists.infradead.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

(2013/05/22 15:57), Atsushi Kumagai wrote:
> On Wed, 15 May 2013 13:43:59 -0500
> Cliff Wickman <cpw@sgi.com> wrote:
>
>> From: Cliff Wickman <cpw@sgi.com>
>>
>> Because addresses of each successive page structure are often descending
>> it is much faster to use read()'s, so set off info->flag_usemmap
>> while doing exclude_free_page().
>>
>> Signed-off-by: Cliff Wickman <cpw@sgi.com>
>
> Sounds good.
> BTW, do you have a speed measurement like your another patch ?
>

Also how about keeping mmap mode and reducing mapping size temporarily 
to 4KiB?

>> I find this to speed the scan of page structures for a 1TB system from
>> 60sec to 30sec.

I don't know which this measured time indicates. Only free pages 
filtering or free pages filtering plus unnecessary pages filtering?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
