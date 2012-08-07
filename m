Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SyeKs-0002A7-6K
 for kexec@lists.infradead.org; Tue, 07 Aug 2012 07:36:15 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id AAA983EE0B5
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:36:09 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 93B0F45DE59
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:36:09 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 758B945DE55
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:36:09 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 675501DB8050
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:36:09 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1BEEE1DB8053
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:36:09 +0900 (JST)
Date: Tue, 07 Aug 2012 16:36:00 +0900 (JST)
Message-Id: <20120807.163600.302188331.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile -g with recent kernels
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120807152409.07d5767955d7bc77dcce05d2@mxc.nes.nec.co.jp>
References: <20120802150429.37c6a87dd922cef0abb44310@mxc.nes.nec.co.jp>
 <20120802.172305.442170409.d.hatayama@jp.fujitsu.com>
 <20120807152409.07d5767955d7bc77dcce05d2@mxc.nes.nec.co.jp>
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
Date: Tue, 7 Aug 2012 15:24:09 +0900

> Hello HATAYAMA-san,
> 
> On Thu, 02 Aug 2012 17:23:05 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> Subject: Re: makedumpfile -g with recent kernels
>> Date: Thu, 2 Aug 2012 15:04:29 +0900
>> 
>> > Hello HATAYAMA-san,
>> > 
>> > On Thu, 02 Aug 2012 14:47:14 +0900 (JST)
>> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> > 
>> >> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> >> Subject: Re: makedumpfile -g with recent kernels
>> >> Date: Thu, 2 Aug 2012 14:12:51 +0900
>> >> 
>> >> > Hello Stefan,
>> >> > 
>> >> > On Mon, 09 Jul 2012 11:17:13 +0200
>> >> > Stefan Bader <stefan.bader@canonical.com> wrote:
>> >> > 
>> >> >> Hi,
>> >> >> 
>> >> >> I am not sure whether this really is the preferred way as I heard the required
>> >> >> info now is in vmcore and vmcoreinfo would not be needed anymore. But just to
>> >> >> have it produce some output I noticed that it trips again over some member of
>> >> >> struct page that moved into some anonymous structure/union combo.
>> >> >> There was some code that was quite specific for the page.mapping case (which now
>> >> >> seems to be outside again). I changed the code to be more generic. It did fix my
>> >> >> _count problem and should also handle the mapping case (though I could not test).
>> >> >> So maybe this would be worth adding to the upstream code.
>> >> >> 
>> >> >> -Stefan
>> >> >> 
>> >> >> Please include me in cc's as I am not subscribed to this ml.
>> >> > 
>> >> > Thank you for your nice work!
>> >> > 
>> >> 
>> >> Hello Kumagai-san,
>> >> 
>> >> I want to see a whole part of Stefan's patch. Could you post it on the
>> >> ml?
>> > 
>> > This is the Stefan's patch. 
>> > 
>> 
>> Thanks, and this patch helps a lot.
>> 
>> BTW, I think we can get rid of DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION
>> path, too.
>> 
>> Thanks.
>> HATAYAMA, Daisuke
> 
> At first, I thought so. But DWARF_INFO_GET_MEMBER_OFFSET doesn't work for
> kernel 2.6.16 and 2.6.17 even after applying Stefan's patch.
> Additionally, I couldn't find the Die of page.mapping with dwarfdump in that
> case. 
> I don't know why the Die isn't included in some vmlinuxs, anyway, it seems
> that the comment below is true.
> 
>     832         /*
>     833          * Some vmlinux(s) don't have debugging information about
>     834          * page.mapping. Then, makedumpfile assumes that there is
>     835          * "mapping" next to "private(unsigned long)" in the first
>     836          * union.
>     837          */
>     838         if (OFFSET(page.mapping) == NOT_FOUND_STRUCTURE) {
>     839                 OFFSET(page.mapping) = get_member_offset("page", NULL,
>     840                     DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION);
> 
> So DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION is still necessary for some kernels.
> 

Thanks for your explanation. I understand it. I have similar
experience where pt_regs sturcture information is missing for some
kernel debuginfo files.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
