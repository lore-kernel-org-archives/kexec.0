Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TDsCd-0000vp-5z
 for kexec@lists.infradead.org; Tue, 18 Sep 2012 07:26:41 +0000
Date: Tue, 18 Sep 2012 15:38:03 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCHv3 0/9] Support Xen versions up to xen-4.1
Message-Id: <20120918153803.dab06b1f45551ac81ddbbf83@mxc.nes.nec.co.jp>
In-Reply-To: <0E9227E8EFCFF54EA493F6C0399C015D39C1018D5B@ABGEX70E.FSC.NET>
References: <201208241741.27573.petr@tesarici.cz>
 <0E9227E8EFCFF54EA493F6C0399C015D39BFC5A112@ABGEX70E.FSC.NET>
 <20120903140100.ac4dbf21401ace0e24a442d9@mxc.nes.nec.co.jp>
 <0E9227E8EFCFF54EA493F6C0399C015D39C0F0F687@ABGEX70E.FSC.NET>
 <505719BD.6080608@canonical.com>
 <0E9227E8EFCFF54EA493F6C0399C015D39C1018D5B@ABGEX70E.FSC.NET>
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
To: norbert.trapp@ts.fujitsu.com
Cc: petr@tesarici.cz, kexec@lists.infradead.org, stefan.bader@canonical.com

Hello Norbert,

On Mon, 17 Sep 2012 18:52:57 +0200
"Trapp, Norbert" <norbert.trapp@ts.fujitsu.com> wrote:

> > Hi Norbert,
> > 
> > > When applying the makedumpfile Xen4 patches to the makedumpfile 1.5.0
> > > version and using it for a crash file to save just the dom0 and xen pages
> > > it again worked splendid in that makedumpfile was much faster than without
> > > the Xen4 patches. Alas I had to remove the OFFSET_IN_UNION_INIT(page._domain,
> > > "page_info", "domain") call because OFFSET_IN_UNION_INIT was no longer present.
> > > It didn't matter much because the call is only needed for makedumpfile -g or when
> > > using the /boot/xen-syms file. In the current 1.5.0  makedumpfile.c version you
> > > see
> > >
> > >     OFFSET_INIT(page_info._domain, "page_info", "u").
> > >
> > > The Xen4 patch modified this because the _domain structure member is in different
> > > unions for different version (x86, ia64) and may also not be the first entry in
> > > the union depending on the Xen version.
> > >
> > >     OFFSET_IN_UNION_INIT(page_info._domain, "page_info", "_domain");
> > >
> > > As an experiment I tried to use
> > >
> > 
> > >     OFFSET_INIT(page_info._domain, "page_info", "domain")

Sorry for my carelessness.
However, I still think that to integrate OFFSET_IN_UNION_INIT into OFFSET_INIT
is reasonable. So, please use OFFSET_INIT in v1.5.0 or later.

> > 
> > Just to make sure and since I am a bit lazy: with the Xen patch the page_info
> > structure has a member (somewhere) named domain? (or _domain)?
> > 
> 
> Just to get you on the right track, the struct page_info in the Xen code is meant.
> Not the one in the makedumpfile code.
> 
> For example in xen-4.1.3/xen/common/kexec.c:
> #ifdef __ia64__
>     VMCOREINFO_OFFSET_SUB(page_info, u.inuse, _domain);
> #else
>     VMCOREINFO_OFFSET_SUB(page_info, v.inuse, _domain);
> #endif
> 
> And the different page_info structures you find in:
> xen-4.1.3/xen/include/asm-ia64/mm.h
> xen-4.1.3/xen/include/asm-x86/mm.h
> 
> And also the structures can be different depending on the Xen version.
> 
> > >
> > > with makedumpfile 1.5.0. To get the correct offset I had to
> > > modify the dwarf_info.c code:
> > >
> > > --- ../makedumpfile-1.5.0/dwarf_info.c  2012-09-06 07:30:23.000000000 +0200
> > > +++ dwarf_info.c        2012-09-12 15:49:23.000000000 +0200
> > > @@ -449,8 +449,8 @@
> > >  static int
> > >  is_anonymous_container(Dwarf_Die *die)
> > >  {
> > > -       if (dwarf_diename(die))
> > > -               return FALSE;
> > > +       //if (dwarf_diename(die))
> > > +       //      return FALSE;
> > >         if (dwarf_tag(die) == DW_TAG_structure_type)
> > >                 return TRUE;
> > >         if (dwarf_info.cmd != DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION
> > > @@ -495,7 +495,7 @@
> > >                  * Descend into anonymous members and search for member
> > >                  * there.
> > >                  */
> > > -               if (!name) {
> > > +               if ((!name) || (strcmp(name, dwarf_info.member_name) != 0)) {
> > >                         if (!get_die_type(walker, &die_type))
> > >                                 continue;
> > >                         if (is_anonymous_container(&die_type))
> > >
> > >
> > > This is not a patch but just a description of what I modified for a test.
> > > The underlying question is why only the anonymous unions are used and not the
> > > ones with a name.
> > 
> > I made the patch because one element in some anonymous structure/union combo was
> > not found in newer kernels and the previous exceptions for such a thing were
> > hard coded. But as far as the dwarf info I was looking at the named
> > structures/unions were handled and I did not want to modify that case without a
> > way to test.

As for getting the offset, it is necessary to descend into structures/unions even
which are named.
So, I'll modify dwarf_info.c as below in the next version.


diff --git a/dwarf_info.c b/dwarf_info.c
index fb11e49..0c18dd1 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -447,10 +447,8 @@ get_dwarf_base_type(Dwarf_Die *die)
 }

 static int
-is_anonymous_container(Dwarf_Die *die)
+is_container(Dwarf_Die *die)
 {
-       if (dwarf_diename(die))
-               return FALSE;
        if (dwarf_tag(die) == DW_TAG_structure_type)
                return TRUE;
        if (dwarf_info.cmd != DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION
@@ -492,13 +490,13 @@ search_member(Dwarf_Die *die)
                        continue;

                /*
-                * Descend into anonymous members and search for member
+                * Descend into structures/unions and search for member
                 * there.
                 */
-               if (!name) {
+               if ((!name) || (strcmp(name, dwarf_info.member_name) != 0)) {
                        if (!get_die_type(walker, &die_type))
                                continue;
-                       if (is_anonymous_container(&die_type))
+                       if (is_container(&die_type))
                                if (search_member(&die_type)) {
                                        adjust_member_offset(walker);
                                        return TRUE;
@@ -1047,9 +1045,13 @@ get_member_offset(char *structname, char *membername, int cmd)
        dwarf_info.cmd = cmd;
        dwarf_info.struct_name = structname;
        dwarf_info.struct_size = NOT_FOUND_STRUCTURE;
-       dwarf_info.member_name = membername;
        dwarf_info.member_offset = NOT_FOUND_STRUCTURE;

+       if (dwarf_info.cmd == DWARF_INFO_GET_MEMBER_OFFSET_1ST_UNION)
+               dwarf_info.member_name = "";
+       else
+               dwarf_info.member_name = membername;
+
        if (!get_debug_info())
                return FAILED_DWARFINFO;

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
