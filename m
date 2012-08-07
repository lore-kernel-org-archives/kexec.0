Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SydFa-0000Hm-RU
 for kexec@lists.infradead.org; Tue, 07 Aug 2012 06:26:45 +0000
Date: Tue, 7 Aug 2012 15:23:56 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile -g with recent kernels
Message-Id: <20120807152356.1c2dbacbe323c2706cc6e6e8@mxc.nes.nec.co.jp>
In-Reply-To: <501F74C9.9070508@canonical.com>
References: <4FFAA199.5040608@canonical.com>
 <20120802141251.2efc0e407259254e6ef60586@mxc.nes.nec.co.jp>
 <501A38F1.8030801@canonical.com>
 <20120806145418.5fc2e5473aeb94f0348b023e@mxc.nes.nec.co.jp>
 <501F74C9.9070508@canonical.com>
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
To: stefan.bader@canonical.com
Cc: kexec@lists.infradead.org

Hello Stefan,

On Mon, 06 Aug 2012 09:39:53 +0200
Stefan Bader <stefan.bader@canonical.com> wrote:

> On 06.08.2012 07:54, Atsushi Kumagai wrote:
> > Hello Stefan,
> > 
> > On Thu, 02 Aug 2012 10:23:13 +0200
> > Stefan Bader <stefan.bader@canonical.com> wrote:
> > 
> >>>   static void
> >>>   adjust_member_offset(Dwarf_Die *die)
> >>>   {
> >>>           long offset;
> >>>
> >>>           if (dwarf_info.member_offset == NOT_FOUND_STRUCTURE)     // this comparison is always true
> >>>                   return;
> >>>           if (!get_data_member_location(die, &offset))
> >>>                   return;
> >>>           dwarf_info.member_offset += offset;
> >>>   }
> >>>
> >>> At least, the change below works fine without regression.
> >>>
> >>>
> >>> diff --git a/dwarf_info.c b/dwarf_info.c
> >>> index 583df53..03e4c90 100644
> >>> --- a/dwarf_info.c
> >>> +++ b/dwarf_info.c
> >>> @@ -520,7 +520,9 @@ search_member(Dwarf_Die *die)
> >>>                         /*
> >>>                          * Get the member offset.
> >>>                          */
> >>> -                       if (!get_data_member_location(walker, &offset))
> >>> +                       if (dwarf_tag(die) == DW_TAG_union_type)
> >>
> >> Hm, should that not be die_type to check what the walker is on? And in that case
> >> it seems that check was made just before... So maybe it would be ok to assume 0
> >> as the offset when getting here...?
> > 
> > As you said, the walker will be a member of union or struct when reaching here,
> > because is_anonymous_container() already checked the walker.
> > 
> > However, get_data_member_location() must succeed if the walker is a member of struct
> > while it doesn't succeed if the walker is a member of union.
> > That's why I added the code to check whether the walker is a member of union or not.
> 
> Right, I was just wondering whether that would allow to simplify even more. Like
> this:

It seems we misunderstood each other, I talked about DWARF_INFO_GET_MEMBER_OFFSET:

         case DWARF_INFO_GET_MEMBER_OFFSET:
                 if ((!name) || strcmp(name, dwarf_info.member_name))
                         continue;
                 /*
                  * Get the member offset.
                  */
                 if (dwarf_tag(die) == DW_TAG_union_type)
                         offset = 0;
                 else if (!get_data_member_location(walker, &offset))
                         continue;
                 dwarf_info.member_offset = offset;
                 return TRUE;

And about your code:

>        case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
>                 if (!get_die_type(walker, &die_type))
>                         continue;
>                 if (dwarf_tag(&die_type) != DW_TAG_union_type)
>                         continue;
> 
>                 /*
>                  * At this point it is clear that this is a union.
>                  * Though unions have no offset elements (the offset
>                  * is always 0. So get_data_member_location would fail.
>                  */
>                  dwarf_info.member_offset = 0;
>                  return TRUE;

It's wrong that unions have no offset elements.
Correctly, members of union have no offset elements.

So, I'll fix it similarly to DWARF_INFO_GET_MEMBER_OFFSET:

        case DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION:
                if (!get_die_type(walker, &die_type))
                        continue;
                if (dwarf_tag(&die_type) != DW_TAG_union_type)
                        continue;
                /*
                 * Get the member offset.
                 */
                 if (dwarf_tag(die) == DW_TAG_union_type)
                         offset = 0;
                 else if (!get_data_member_location(walker, &offset))
                         continue;
                 dwarf_info.member_offset = offset;
                 return TRUE;

 
Thanks
Atsushi Kumagai

> > 
> > 
> > Thanks
> > Atsushi Kumagai
> > 
> >>> +                               offset = 0;
> >>> +                       else if (!get_data_member_location(walker, &offset))
> >>>                                 continue;
> >>>                         dwarf_info.member_offset = offset;
> >>>                         return TRUE;
> >>>
> >>>
> >>> Unless you have better way to fix this issue, I'll merge your patch into
> >>> the next version with the change above.
> >>>
> >>> By the way, this fix enable us also to get the offset of page._mapcount and
> >>> page.private, it's very helpful for the new method of free page filtering.
> >>>
> >>>   http://lists.infradead.org/pipermail/kexec/2012-June/006441.html
> >>>
> >>>
> >>> Thanks
> >>> Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
