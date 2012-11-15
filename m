Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYsFr-0006Jh-8n
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 05:44:49 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 77B733EE0AE
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 14:44:42 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5EA8B45DE4D
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 14:44:42 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 396BC45DE52
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 14:44:42 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2584B1DB802F
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 14:44:42 +0900 (JST)
Received: from g01jpexchyt02.g01.fujitsu.local
 (g01jpexchyt02.g01.fujitsu.local [10.128.194.41])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C880C1DB803B
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 14:44:41 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 00/10] Support free page filtering looking up mem_map array
Date: Thu, 15 Nov 2012 05:44:39 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AB0367F@G01JPEXMBYT03>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121113165608.b561e597fefb6bc3f2bbd5de@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB008A2@G01JPEXMBYT03>
 <33710E6CAA200E4583255F4FB666C4E20AB00A09@G01JPEXMBYT03>
 <20121114163106.3a5efd62d63535d078a2686d@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB0309E@G01JPEXMBYT03>
 <20121115142012.b8b58d509efbe7e2e7d995c3@mxc.nes.nec.co.jp>
In-Reply-To: <20121115142012.b8b58d509efbe7e2e7d995c3@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> Sent: Thursday, November 15, 2012 2:20 PM
[...]
> On Thu, 15 Nov 2012 01:55:04 +0000
> "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:
[...]
> 
> I think it's OK on the logic of selection for page_is_buddy_vX().
> But there remain some cases where page_is_buddy_vX() doesn't work correctly
> because OFFSET(page.private) and OFFSET(page._mapcount) do not exist.
> And it's difficult to hard code for them.
> 
> So I think setup_page_is_buddy() should be changed like below:
> 
>   static void
>   setup_page_is_buddy(void)
>   {
>           if (OFFSET(page.private) == NOT_FOUND_STRUCTURE)
>                   info->page_is_buddy = NULL;
>           else if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
>                   if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) !=
> NOT_FOUND_NUMBER) {
>                           if (OFFSET(page._mapcout) !=
> NOT_FOUND_STRUCTURE) {
>                                   info->page_is_buddy =
> page_is_buddy_v3;
>                                   return;
>                           }
>                   } else if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
>                           info->page_is_buddy = page_is_buddy_v1;
>                           return;
>                   }
>           } else {
>                   info->page_is_buddy = page_is_buddy_v2;
>                   return;
>           }
> 
>           DEBUG_MSG("Can't select page_is_buddy handler; "
>                     "follow freelist instead of mem_map.\n");
> 
>   }
> 

Agree. I'll rewrite it.

When do you plan to post v1.5.1-rc?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
