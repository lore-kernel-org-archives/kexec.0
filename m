Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JgZbM-000449-PT
	for kexec@lists.infradead.org; Tue, 01 Apr 2008 06:04:09 +0000
Message-Id: <47F1D054.9080307@mxs.nes.nec.co.jp>
Date: Tue, 01 Apr 2008 15:04:04 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [Patch] fix error case of xen
References: <A7C89354154DF3takebe_akio@jp.fujitsu.com>
In-Reply-To: <A7C89354154DF3takebe_akio@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1467628874=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Akio Takebe <takebe_akio@jp.fujitsu.com>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============1467628874==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Takebe-san,

Thank you for the patch.

Akio Takebe wrote:
> Curret kdump-xen with makdumpfile always return 0.
> So if we fail to kdump, we will get $?=0.
> This patch improve it.
> 
> Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>
> 
> --- makedumpfile/makedumpfile.c	2008-03-28 11:32:51.000000000 +0900
> +++ makedumpfile.mod/makedumpfile.c	2008-04-01 02:14:12.000000000 +0900
> @@ -993,6 +993,8 @@ get_symbol_addr(char *symname)
>  		if (!strcmp(sym_name, symname)) {
>  			symbol = sym.st_value;
>  			break;
> +		} else if (i >= (shdr.sh_size/shdr.sh_entsize)-1) {
> +			DEBUG_MSG("Can't get symbol of %s.\n", symname);

This patch is for fixing error code of xen, but the above code adds
the debugging message. So the above code doesn't match its purpose.
Is it necessary ?


> -		return handle_xen();
> +		if (!handle_xen())
> +			goto out;

I guess that the above code is not enough. If handle_xen() succeeds,
it should return TRUE instead of COMPLETED like the attached patch, right ?


Thanks
Ken'ichi Ohmichi

Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>
Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -puN backup/v1.2.5/makedumpfile.c makedumpfile/makedumpfile.c
--- backup/v1.2.5/makedumpfile.c	2008-03-28 11:54:48.000000000 +0900
+++ makedumpfile/makedumpfile.c	2008-04-01 14:32:03.000000000 +0900
@@ -5855,7 +5855,7 @@ handle_xen()
 	MSG("\n");
 	MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
 
-	return COMPLETED;
+	return TRUE;
 out:
 	return FALSE;
 #endif
@@ -6146,7 +6146,8 @@ main(int argc, char *argv[])
 			goto out;
 		}
 		info->dump_level |= DL_EXCLUDE_XEN;
-		return handle_xen();
+		if (!handle_xen())
+			goto out;
 
 	} else if (info->flag_rearrange) {
 		if (!open_files_for_rearranging_dumpdata())



--===============1467628874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1467628874==--
