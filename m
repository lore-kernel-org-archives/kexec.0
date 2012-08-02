Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SwqhR-0007mx-1V
 for kexec@lists.infradead.org; Thu, 02 Aug 2012 08:24:06 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1149F3EE0AE
 for <kexec@lists.infradead.org>; Thu,  2 Aug 2012 17:24:01 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E4DF645DE7E
 for <kexec@lists.infradead.org>; Thu,  2 Aug 2012 17:24:00 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D041045DEA6
 for <kexec@lists.infradead.org>; Thu,  2 Aug 2012 17:24:00 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C443D1DB803B
 for <kexec@lists.infradead.org>; Thu,  2 Aug 2012 17:24:00 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 827021DB803C
 for <kexec@lists.infradead.org>; Thu,  2 Aug 2012 17:24:00 +0900 (JST)
Date: Thu, 02 Aug 2012 17:23:05 +0900 (JST)
Message-Id: <20120802.172305.442170409.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile -g with recent kernels
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120802150429.37c6a87dd922cef0abb44310@mxc.nes.nec.co.jp>
References: <20120802141251.2efc0e407259254e6ef60586@mxc.nes.nec.co.jp>
 <20120802.144714.166856684.d.hatayama@jp.fujitsu.com>
 <20120802150429.37c6a87dd922cef0abb44310@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, stefan.bader@canonical.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile -g with recent kernels
Date: Thu, 2 Aug 2012 15:04:29 +0900

> Hello HATAYAMA-san,
> 
> On Thu, 02 Aug 2012 14:47:14 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> Subject: Re: makedumpfile -g with recent kernels
>> Date: Thu, 2 Aug 2012 14:12:51 +0900
>> 
>> > Hello Stefan,
>> > 
>> > On Mon, 09 Jul 2012 11:17:13 +0200
>> > Stefan Bader <stefan.bader@canonical.com> wrote:
>> > 
>> >> Hi,
>> >> 
>> >> I am not sure whether this really is the preferred way as I heard the required
>> >> info now is in vmcore and vmcoreinfo would not be needed anymore. But just to
>> >> have it produce some output I noticed that it trips again over some member of
>> >> struct page that moved into some anonymous structure/union combo.
>> >> There was some code that was quite specific for the page.mapping case (which now
>> >> seems to be outside again). I changed the code to be more generic. It did fix my
>> >> _count problem and should also handle the mapping case (though I could not test).
>> >> So maybe this would be worth adding to the upstream code.
>> >> 
>> >> -Stefan
>> >> 
>> >> Please include me in cc's as I am not subscribed to this ml.
>> > 
>> > Thank you for your nice work!
>> > 
>> 
>> Hello Kumagai-san,
>> 
>> I want to see a whole part of Stefan's patch. Could you post it on the
>> ml?
> 
> This is the Stefan's patch. 
> 

Thanks, and this patch helps a lot.

BTW, I think we can get rid of DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION
path, too.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
