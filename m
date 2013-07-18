Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzjGr-0003sV-76
 for kexec@lists.infradead.org; Thu, 18 Jul 2013 08:09:06 +0000
Date: Thu, 18 Jul 2013 17:03:22 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 7/7] Use elf_getshdrstrndx() instead of
 elf_getshstrndx()
Message-Id: <20130718170322.ea01294e20c9cdc810b40eb9@mxc.nes.nec.co.jp>
In-Reply-To: <1373977929-4253-8-git-send-email-daniel.kiper@oracle.com>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-8-git-send-email-daniel.kiper@oracle.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: daniel.kiper@oracle.com
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Tue, 16 Jul 2013 14:32:09 +0200
Daniel Kiper <daniel.kiper@oracle.com> wrote:

> Use elf_getshdrstrndx() instead of elf_getshstrndx()
> because later is marked as deprecated.
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

Good, I'll merge this patch into v1.5.5.


Thanks
Atsushi Kumagai

> ---
>  dwarf_info.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dwarf_info.c b/dwarf_info.c
> index 85c116e..c5752c9 100644
> --- a/dwarf_info.c
> +++ b/dwarf_info.c
> @@ -944,7 +944,7 @@ get_debug_info(void)
>  	elfd = dwarf_info.elfd;
>  	dwarfd = dwarf_info.dwarfd;
>  
> -	if (elf_getshstrndx(elfd, &shstrndx) < 0) {
> +	if (elf_getshdrstrndx(elfd, &shstrndx) < 0) {
>  		ERRMSG("Can't get the section index of the string table.\n");
>  		goto out;
>  	}
> -- 
> 1.7.10.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
