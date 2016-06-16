Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDXg5-0007DD-Ui
 for kexec@lists.infradead.org; Thu, 16 Jun 2016 13:49:50 +0000
Date: Thu, 16 Jun 2016 09:49:28 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1366043437.15957172.1466084968204.JavaMail.zimbra@redhat.com>
In-Reply-To: <1466084029-22290-1-git-send-email-vkuznets@redhat.com>
References: <1466084029-22290-1-git-send-email-vkuznets@redhat.com>
Subject: Re: [PATCH] makedumpfile: support _count -> _refcount rename in
 struct page
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Minoru Usui <min-usui@ti.jp.nec.com>, kexec@lists.infradead.org, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>



----- Original Message -----
> _count member was renamed to _refcount in linux commit commit 0139aa7b7fa12
> ("mm: rename _count, field of the struct page, to _refcount") and this
> broke makedumpfile. The reason for making the change was to find all users
> accessing it directly and not through the recommended API. I tried
> suggesting to revert the change but failed, I see no other choice than to
> start supporting both _count and _refcount in makedumpfile.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - 'crash' tool is now broken as well.

FYI, crash was fixed upstream a few weeks ago:

  commit 8ceb1ac628bf6a0a7f0bbfff030ec93081bca4cd
  Author: Dave Anderson <anderson@redhat.com>
  Date:   Mon May 23 11:23:01 2016 -0400

    Fix for Linux commit 0139aa7b7fa12ceef095d99dc36606a5b10ab83a, which
    renamed the page._count member to page._refcount.  Without the patch,
    certain "kmem" commands fail with the "kmem: invalid structure member
    offset: page_count".
    (anderson@redhat.com)

Dave


> ---
>  makedumpfile.c | 18 +++++++++++++++++-
>  makedumpfile.h |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 853b999..96dfe39 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1580,6 +1580,13 @@ get_structure_info(void)
>  	SIZE_INIT(page, "page");
>  	OFFSET_INIT(page.flags, "page", "flags");
>  	OFFSET_INIT(page._count, "page", "_count");
> +	if (OFFSET(page._count) == NOT_FOUND_STRUCTURE) {
> +		info->flag_refcount = TRUE;
> +		OFFSET_INIT(page._count, "page", "_refcount");
> +	} else {
> +		info->flag_refcount = FALSE;
> +	}
> +
>  	OFFSET_INIT(page.mapping, "page", "mapping");
>  	OFFSET_INIT(page._mapcount, "page", "_mapcount");
>  	OFFSET_INIT(page.private, "page", "private");
> @@ -2151,7 +2158,10 @@ write_vmcoreinfo_data(void)
>  	 * write the member offset of 1st kernel
>  	 */
>  	WRITE_MEMBER_OFFSET("page.flags", page.flags);
> -	WRITE_MEMBER_OFFSET("page._count", page._count);
> +	if (info->flag_refcount)
> +		WRITE_MEMBER_OFFSET("page._refcount", page._count);
> +	else
> +		WRITE_MEMBER_OFFSET("page._count", page._count);
>  	WRITE_MEMBER_OFFSET("page.mapping", page.mapping);
>  	WRITE_MEMBER_OFFSET("page.lru", page.lru);
>  	WRITE_MEMBER_OFFSET("page._mapcount", page._mapcount);
> @@ -2492,6 +2502,12 @@ read_vmcoreinfo(void)
>  
>  	READ_MEMBER_OFFSET("page.flags", page.flags);
>  	READ_MEMBER_OFFSET("page._count", page._count);
> +	if (OFFSET(page._count) == NOT_FOUND_STRUCTURE) {
> +		info->flag_refcount = TRUE;
> +		READ_MEMBER_OFFSET("page._refcount", page._count);
> +	} else {
> +		info->flag_refcount = FALSE;
> +	}
>  	READ_MEMBER_OFFSET("page.mapping", page.mapping);
>  	READ_MEMBER_OFFSET("page.lru", page.lru);
>  	READ_MEMBER_OFFSET("page._mapcount", page._mapcount);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 251d4bf..3742389 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1100,6 +1100,7 @@ struct DumpInfo {
>  	int		flag_nospace;	     /* the flag of "No space on device" error */
>  	int		flag_vmemmap;        /* kernel supports vmemmap address space */
>  	int		flag_excludevm;      /* -e - excluding unused vmemmap pages */
> +	int		flag_refcount;       /* _count is renamed to _refcount */
>  	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
>  	long		page_size;           /* size of page */
>  	long		page_shift;
> --
> 2.5.5
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
