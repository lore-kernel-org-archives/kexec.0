Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SwnkE-0008RA-Ny
 for kexec@lists.infradead.org; Thu, 02 Aug 2012 05:14:48 +0000
Date: Thu, 2 Aug 2012 14:12:51 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile -g with recent kernels
Message-Id: <20120802141251.2efc0e407259254e6ef60586@mxc.nes.nec.co.jp>
In-Reply-To: <4FFAA199.5040608@canonical.com>
References: <4FFAA199.5040608@canonical.com>
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

On Mon, 09 Jul 2012 11:17:13 +0200
Stefan Bader <stefan.bader@canonical.com> wrote:

> Hi,
> 
> I am not sure whether this really is the preferred way as I heard the required
> info now is in vmcore and vmcoreinfo would not be needed anymore. But just to
> have it produce some output I noticed that it trips again over some member of
> struct page that moved into some anonymous structure/union combo.
> There was some code that was quite specific for the page.mapping case (which now
> seems to be outside again). I changed the code to be more generic. It did fix my
> _count problem and should also handle the mapping case (though I could not test).
> So maybe this would be worth adding to the upstream code.
> 
> -Stefan
> 
> Please include me in cc's as I am not subscribed to this ml.

Thank you for your nice work!

I think your idea is basically good, however your patch can't take care of
the member of union (e.g. page.lru in kernel 3.2). 
Because the member of union hasn't DW_AT_data_member_location and dwarf_info.member_offset
isn't be initialized. Therefore, adjust_member_offset() doesn't work for the member of union.

  static void
  adjust_member_offset(Dwarf_Die *die)
  {
          long offset;

          if (dwarf_info.member_offset == NOT_FOUND_STRUCTURE)     // this comparison is always true
                  return;
          if (!get_data_member_location(die, &offset))
                  return;
          dwarf_info.member_offset += offset;
  }

At least, the change below works fine without regression.


diff --git a/dwarf_info.c b/dwarf_info.c
index 583df53..03e4c90 100644
--- a/dwarf_info.c
+++ b/dwarf_info.c
@@ -520,7 +520,9 @@ search_member(Dwarf_Die *die)
                        /*
                         * Get the member offset.
                         */
-                       if (!get_data_member_location(walker, &offset))
+                       if (dwarf_tag(die) == DW_TAG_union_type)
+                               offset = 0;
+                       else if (!get_data_member_location(walker, &offset))
                                continue;
                        dwarf_info.member_offset = offset;
                        return TRUE;


Unless you have better way to fix this issue, I'll merge your patch into
the next version with the change above.

By the way, this fix enable us also to get the offset of page._mapcount and
page.private, it's very helpful for the new method of free page filtering.

  http://lists.infradead.org/pipermail/kexec/2012-June/006441.html


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
