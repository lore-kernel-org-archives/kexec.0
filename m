Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410040.outbound.protection.outlook.com
 ([40.107.141.40] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUFw0-0008SH-H7
 for kexec@lists.infradead.org; Thu, 30 Apr 2020 20:37:30 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] makedumpfile: cope with not-present mem section
Date: Thu, 30 Apr 2020 20:37:25 +0000
Message-ID: <OSBPR01MB1991F08479EF2475E323D7FFDDAA0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <1579487124-28426-1-git-send-email-piliu@redhat.com>
 <2AA47CAB-ED13-4A0A-9288-063832158203@redhat.com>
 <20200120085919.GB16539@MiWiFi-R3L-srv>
 <44958c3d-c861-8eb0-5713-50c36c7cfc6e@redhat.com>
 <TY2PR01MB5210FAB04501E6C59AAB2B06DD0F0@TY2PR01MB5210.jpnprd01.prod.outlook.com>
 <20200127170447.GA4080@calabresa> <20200127180627.GB4080@calabresa>
 <TY2PR01MB521005B2E72D78C4561C0562DD0A0@TY2PR01MB5210.jpnprd01.prod.outlook.com>
 <20200128193302.GC4080@calabresa>
 <769ddb8a-c845-04a6-0064-d674bbd04ae3@redhat.com>
 <OSBPR01MB1991FEF11882F89353E6B342DDAD0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <e487a969-7660-bea8-405f-59f1aab426f5@redhat.com>
In-Reply-To: <e487a969-7660-bea8-405f-59f1aab426f5@redhat.com>
Content-Language: en-US
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: piliu <piliu@redhat.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Michal Hocko <mhocko@kernel.org>, Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>

> -----Original Message-----
> On 04/29/2020 10:27 PM, HAGIO KAZUHITO wrote:
> > Hi Pingfan,
> >
> >> -----Original Message-----
> >> Hi Kazu and Cascardo,
> >>
> >> I encounter a weird problem when running makedumpfile on a s390 machine.
> >>
> >> Our production kernel uses extreme sparse memory model, and has the
> >> following:
> >>
> >> in mm/sparse.c
> >>
> >> #ifdef CONFIG_SPARSEMEM_EXTREME
> >> struct mem_section **mem_section;
> >> #else
> >> struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> >>         ____cacheline_internodealigned_in_smp;
> >> #endif
> >>
> >> So in makedumpfile.c, get_mem_section(), it got a failed result when the
> >> first call site to validate_mem_section(), then it should success at the
> >> second call site to validate_mem_section(), which is inside if
> >> (is_sparsemem_extreme()) condition.
> >
> > I think your production kernel should have kernel commit a0b1280368d1
> > ("kdump: write correct address of mem_section into vmcoreinfo"), so the
> > first call should return TRUE and the second one should return FALSE.
> Yes, it is.
> >
> >>
> >> But the actual result is not like expected.
> >>
> >> After introducing
> >> commit e113f1c974c820f9633dc0073eda525d7575f365    [PATCH] cope with
> >> not-present mem section
> >>
> >> I got two successful calls to validate_mem_section(), and finally failed
> >> at the condition
> >> 		ret = symbol_valid ^ pointer_valid;
> >> 		if (!ret) {
> >> 			ERRMSG("Could not validate mem_section.\n");
> >> 		}
> >>
> >>
> >> Do you have any idea?
> >
> > Presumably this will be what I expected that it might be possible.
> > I can apply the patch below this time, what about this?
> > https://github.com/k-hagio/makedumpfile-old/commit/ce883df3864a5744ac0f1eff47de06b5074edb5f.patch
> looks good.

Thanks.

> >
> > or, we can also investigate why the second call returns TRUE, and
> > fix the conditions in the validate_mem_section()..
> This is due to the relaxed condition check after applying my commit
> commit e113f1c974("[PATCH] cope with not-present mem section")
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ae7336a..607e07f 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3406,8 +3406,6 @@ section_mem_map_addr(unsigned long addr, unsigned
> long *map_mask)
>         map = ULONG(mem_section + OFFSET(mem_section.section_mem_map));
>         mask = SECTION_MAP_MASK;
>         *map_mask = map & ~mask;
> -       if (map == 0x0)
> -               *map_mask |= SECTION_MARKED_PRESENT;
>         map &= mask;
>         free(mem_section);
> 
> @@ -3453,10 +3451,8 @@ validate_mem_section(unsigned long *mem_sec,
>                         mem_map = NOT_MEMMAP_ADDR;
>                 } else {
>                         mem_map = section_mem_map_addr(section, &map_mask);
> +                       /* for either no mem_map or hot-removed */
>                         if (!(map_mask & SECTION_MARKED_PRESENT)) {
> -                               return FALSE; ------> a strict check
> -                       }
> -                       if (mem_map == 0) {
>                                 mem_map = NOT_MEMMAP_ADDR;
>                         } else {
>                                 mem_map = sparse_decode_mem_map(mem_map,
> 
> 
> Before my patch, it return FALSE for any non NULL value without
> SECTION_MARKED_PRESENT. But my patch relaxes the restriction and
> consider it as hot-removed mem_section and keeps the parsing on.

Yes, so I meant that we might add some conditions so that the second call
could return FALSE for your vmcore as expected.  But I decided to apply
the patch I wrote before.. and applied:
https://github.com/makedumpfile/makedumpfile/commit/81b79c514ff6fc881f1df4cb04ecb2d7cb22badc

I deferred merging this at that time because it might not be needed
actually and I didn't want to change the behavior if possible.
But it happened.

Thank you for the report.

Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
