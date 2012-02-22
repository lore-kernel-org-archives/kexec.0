Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S03yC-0002th-Dp
 for kexec@lists.infradead.org; Wed, 22 Feb 2012 04:38:26 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C6D5B3EE081
 for <kexec@lists.infradead.org>; Wed, 22 Feb 2012 13:38:19 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AED8145DD78
 for <kexec@lists.infradead.org>; Wed, 22 Feb 2012 13:38:19 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 98B1245DD74
 for <kexec@lists.infradead.org>; Wed, 22 Feb 2012 13:38:19 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8BD791DB803A
 for <kexec@lists.infradead.org>; Wed, 22 Feb 2012 13:38:19 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4852B1DB8038
 for <kexec@lists.infradead.org>; Wed, 22 Feb 2012 13:38:19 +0900 (JST)
Date: Wed, 22 Feb 2012 13:38:05 +0900 (   )
Message-Id: <20120222.133805.28788070.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH makedumpfile 0/2] LZO Compression Support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120222114209.d22e2e34.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120221165041.5ebd8a15.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120221.170125.347143815.d.hatayama@jp.fujitsu.com>
 <20120222114209.d22e2e34.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile 0/2] LZO Compression Support
Date: Wed, 22 Feb 2012 11:42:09 +0900

> Hello Hatayama-san,
> 
> On Tue, 21 Feb 2012 17:01:25 +0900 (   )
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>  
>> > Thank you for your patches.
>> > 
>> > I'll review and merge them into v1.4.4 with making LZO support optional.
>> > I'll post the patch to make it optional after v1.4.3 is released.
>> > 
>> > Please wait for a while.
>> > 
>> > Thanks
>> > Atsushi Kumagai
>> > 
>> 
>> Thanks. But I'm OK if I'll repost the patch after you have decided how
>> you change Makefile to support optional building. Or is it more
>> effective for you to do them by yourself at the same time?
> 
> I wonder if you could repost the patch with implementing my idea.
> My idea is that using build option (like "LINKTYPE" at v1.4.2).
> 
>  Example)
>    1. enable lzo support
>      $ make USELZO=on
> 
>    2. disable lzo support (default)
>      $ make
> 
> In future, I would like to use automake but don't worry
> about it now.

I see. I'll repost the patch soon.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
