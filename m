Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TgzX5-0007zi-AQ
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 15:08:07 +0000
Date: Fri, 7 Dec 2012 10:08:05 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Add the values related to buddy system for filtering
 free pages
Message-ID: <20121207150805.GC4928@redhat.com>
References: <20121121170247.6b57465f2fc1d7f91cd1cddf@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121121170247.6b57465f2fc1d7f91cd1cddf@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Nov 21, 2012 at 05:02:47PM +0900, Atsushi Kumagai wrote:
> This patch adds the values related to buddy system to vmcoreinfo data
> so that makedumpfile (dump filtering command) can filter out all free
> pages with the new logic.
> It's faster than the current logic because it can distinguish free page
> by analyzing page structure at the same time as filtering for other
> unnecessary pages (e.g. anonymous page).
> OTOH, the current logic has to trace free_list to distinguish free 
> pages while analyzing page structure to filter out other unnecessary
> pages.
> 
> The new logic uses the fact that buddy page is marked by _mapcount == 
> PAGE_BUDDY_MAPCOUNT_VALUE. The values below are required to distinguish
> it.
> 
> Required values:
>   - OFFSET(page._mapcount)
>   - OFFSET(page.private)
>   - SIZE(pageflags)
>   - NUMBER(PG_slab)
>   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
>   

As per your explanation, you should just need to export page._mapcount
offset and PAGE_BUDDY_MAPCOUNT_VALUE value so that you can figure out
if a page is free or not.

Why do we need rest of the three fields.

- OFFSET(page.private)
- SIZE(pageflags)
- NUMBER(PG_slab)

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
