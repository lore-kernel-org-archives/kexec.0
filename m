Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R0NSx-0006Jl-Oj
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 00:55:17 +0000
Date: Mon, 5 Sep 2011 08:56:27 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: omit those section has 0 size
Message-Id: <20110905085627.149add04.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <1315152159-15362-1-git-send-email-leiwen@marvell.com>
References: <1315152159-15362-1-git-send-email-leiwen@marvell.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Lei Wen <leiwen@marvell.com>
Cc: kexec@lists.infradead.org


Hi Lei,

Thank you for the patch.

The almost same patch has been merged into the devel git-tree,
does the following patch fix the prblem you said ?

http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=commit;h=63f720a7784debce82c8942970d5c0d8412f209f


Thanks
Ken'ichi Ohmichi

On Sun,  4 Sep 2011 09:02:39 -0700
Lei Wen <leiwen@marvell.com> wrote:
>
> If the area reserved for the kdump is at the end of system memory, then
> it would occur such case that the second sector is turly 0 size. And as
> the beginnig of the second sector is already out of system memory range.
> Try to access this range, would cause makedumpfile failed.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>
> ---
>  makedumpfile.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 7d0c663..3f8d9af 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1336,6 +1336,8 @@ get_elf_info(void)
>  		}
>  		if (phdr.p_type != PT_LOAD)
>  			continue;
> +		if (phdr.p_filesz == 0)
> +			continue;
>  
>  		if (j == 0) {
>  			info->offset_load_memory = phdr.p_offset;
> @@ -5756,6 +5758,8 @@ write_elf_pages(struct cache_data *cd_header, struct cache_data *cd_page)
>  
>  		if (load.p_type != PT_LOAD)
>  			continue;
> +		if (load.p_filesz == 0)
> +			continue;
>  
>  		off_memory= load.p_offset;
>  		paddr     = load.p_paddr;
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
