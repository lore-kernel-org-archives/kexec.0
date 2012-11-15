Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYuC3-0004zj-2A
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 07:49:01 +0000
Date: Thu, 15 Nov 2012 16:47:53 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 00/10] Support free page filtering looking up mem_map array
Message-Id: <20121115164753.6144fc58cab82ecdda8dbe4d@mxc.nes.nec.co.jp>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AB0367F@G01JPEXMBYT03>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121113165608.b561e597fefb6bc3f2bbd5de@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB008A2@G01JPEXMBYT03>
 <33710E6CAA200E4583255F4FB666C4E20AB00A09@G01JPEXMBYT03>
 <20121114163106.3a5efd62d63535d078a2686d@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB0309E@G01JPEXMBYT03>
 <20121115142012.b8b58d509efbe7e2e7d995c3@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB0367F@G01JPEXMBYT03>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Thu, 15 Nov 2012 05:44:39 +0000
"Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:

> > -----Original Message-----
> > From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> > Sent: Thursday, November 15, 2012 2:20 PM
> [...]
> > On Thu, 15 Nov 2012 01:55:04 +0000
> > "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:
> [...]
> > 
> > I think it's OK on the logic of selection for page_is_buddy_vX().
> > But there remain some cases where page_is_buddy_vX() doesn't work correctly
> > because OFFSET(page.private) and OFFSET(page._mapcount) do not exist.
> > And it's difficult to hard code for them.
> > 
> > So I think setup_page_is_buddy() should be changed like below:
> > 
> >   static void
> >   setup_page_is_buddy(void)
> >   {
> >           if (OFFSET(page.private) == NOT_FOUND_STRUCTURE)
> >                   info->page_is_buddy = NULL;
> >           else if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
> >                   if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) !=
> > NOT_FOUND_NUMBER) {
> >                           if (OFFSET(page._mapcout) !=
> > NOT_FOUND_STRUCTURE) {
> >                                   info->page_is_buddy =
> > page_is_buddy_v3;
> >                                   return;
> >                           }
> >                   } else if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
> >                           info->page_is_buddy = page_is_buddy_v1;
> >                           return;
> >                   }
> >           } else {
> >                   info->page_is_buddy = page_is_buddy_v2;
> >                   return;
> >           }
> > 
> >           DEBUG_MSG("Can't select page_is_buddy handler; "
> >                     "follow freelist instead of mem_map.\n");
> > 
> >   }
> > 
> 
> Agree. I'll rewrite it.

Thanks.

> When do you plan to post v1.5.1-rc?

I will post v1.5.1-rc in Nov 16 as planned, so I would like to get
v2 patches by noon tomorrow.


Thanks
Atsushi Kumagai
 
> 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
