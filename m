Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JK4Rg-0005mX-IK
	for kexec@lists.infradead.org; Wed, 30 Jan 2008 04:21:15 +0000
Message-Id: <479FFB5C.7080904@mxs.nes.nec.co.jp>
Date: Wed, 30 Jan 2008 13:21:48 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [Patch] makedumpfile: support -F option on xen
References: <94C86279ACDA80takebe_akio@jp.fujitsu.com>
In-Reply-To: <94C86279ACDA80takebe_akio@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0773406856=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Akio Takebe <takebe_akio@jp.fujitsu.com>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============0773406856==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Takebe-san,

Thank you for the patch.
I confirmed that your patch is right on x86_64 xen machine.
I will merge your patch into the next release.


Thanks
Ken'ichi Ohmichi 


Akio Takebe wrote:
> Hi,
> 
> makdumpfile doesn't support -F option on xen.
> The following patch support it.
> 
> Signed-off-by: Akio Takebe <takebe_akio@jp.fujitsu.com>
> 
> Best Regards,
> 
> Akio Takebe
> 
> --- makedumpfile/makedumpfile.c.orig	2007-11-14 20:34:36.000000000 +0900
> +++ makedumpfile/makedumpfile.c	2008-01-28 13:50:34.000000000 +0900
> @@ -5803,12 +5803,22 @@ handle_xen()
>  	if (!create_dump_bitmap_xen())
>  		goto out;
>  
> +	if (info->flag_flatten) {
> +		if (!write_start_flat_header())
> +			goto out;
> +	}
> +
>  	if (!write_elf_header())
>  		goto out;
>  
>  	if (!write_elf_pages())
>  		goto out;
>  
> +	if (info->flag_flatten) {
> +		if (!write_end_flat_header())
> +			goto out;
> +	}
> +
>  	if (!close_files_for_creating_dumpfile())
>  		goto out;
>  
> 


--===============0773406856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0773406856==--
