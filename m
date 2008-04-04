Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jhinj-0001BB-6q
	for kexec@lists.infradead.org; Fri, 04 Apr 2008 10:05:40 +0000
Message-Id: <47F5FD6C.50702@mxs.nes.nec.co.jp>
Date: Fri, 04 Apr 2008 19:05:32 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [Patch][RFC] makedumpfile: fix for xen-3.1.2
References: <D4C895FC097B62takebe_akio@jp.fujitsu.com>
In-Reply-To: <D4C895FC097B62takebe_akio@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1477362151=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Akio Takebe <takebe_akio@jp.fujitsu.com>
Cc: Itsuro ODA <oda@valinux.co.jp>, xen-devel <xen-devel@lists.xensource.com>, kexec-ml <kexec@lists.infradead.org>

--===============1477362151==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Takebe-san,

Akio Takebe wrote:
> This patch fixes makedumpfile for xen-3.1.
> xen-3.1.2+ hypervisor doesn't have idle_pg_table_l3,
> we need to find a symbole of idle_pg_table.

Thank you for the patch !
I tested your patch with RHEL5.2-beta, and it worked fine on i386 machine.
But it doesn't work on x86_64 machine. makedumpfile went to the loop in
kvtop_xen_x86_64(), and it failed with a segmentation fault:

makedumpfile/x86_64.c
 196         if ((dirp = kvtop_xen_x86_64(SYMBOL(pgd_l4))) == NOT_PADDR) <- *HERE*
 197                 return NOT_PADDR;


If you know, please teach me. Should this patch fix the problem for
not only the upstream but also RHEL5.2 ?
Unfortunately I don't know the detail of xen, and I haven't used the
upstream xen yet. 


Thanks
Ken'ichi Ohmichi


> --- makedumpfile/makedumpfile.c	2008-03-28 11:32:51.000000000 +0900
> +++ makedumpfile.mod/makedumpfile.c	2008-04-03 14:58:11.000000000 +0900
> @@ -5298,7 +5298,12 @@ get_symbol_info_xen()
>  	 */
>  	SYMBOL_INIT(pgd_l2, "idle_pg_table_l2");	/* x86 */
>  	SYMBOL_INIT(pgd_l3, "idle_pg_table_l3");	/* x86-PAE */
> +	if (SYMBOL(pgd_l3) == NOT_FOUND_SYMBOL)
> +		SYMBOL_INIT(pgd_l3, "idle_pg_table");	/* x86-PAE */
>  	SYMBOL_INIT(pgd_l4, "idle_pg_table_4");		/* x86_64 */
> +	if (SYMBOL(pgd_l4) == NOT_FOUND_SYMBOL)
> +		SYMBOL_INIT(pgd_l4, "idle_pg_table");		/* x86_64 */
> +
>  	SYMBOL_INIT(xen_heap_start, "xen_heap_start");	/* ia64 */
>  	SYMBOL_INIT(xen_pstart, "xen_pstart");		/* ia64 */
>  	SYMBOL_INIT(frametable_pg_dir, "frametable_pg_dir");	/* ia64 */



--===============1477362151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1477362151==--
