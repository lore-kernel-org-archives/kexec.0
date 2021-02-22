Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400075.outbound.protection.outlook.com
 ([40.107.140.75] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lE0q3-0000U1-1G
 for kexec@lists.infradead.org; Mon, 22 Feb 2021 02:20:44 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] mips64: Retrieve MAX_PHYSMEM_BITS from vmcoreinfo
Date: Mon, 22 Feb 2021 02:20:30 +0000
Message-ID: <OSBPR01MB1991B6519865CA4CC367C4C5DD819@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <1613957493-22021-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1613957493-22021-1-git-send-email-tangyouling@loongson.cn>
Content-Language: ja-JP
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: kexec-ml <kexec@lists.infradead.org>

-----Original Message-----
> Add a common feature for architectures to retrieve AX_PHYSMEM_BITS
> from vmcoreinfo, which was added by kernel commit 1d50e5d0c505 ("
> crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo").
> This makes makedumpfile adaptable for future MAX_PHYSMEM_BITS changes.
> 
> Also ensure backward compatibility for kernel versions in which
> MAX_PHYSMEM_BITS is not available in vmcoreinfo.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/mips64.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips64.c b/arch/mips64.c
> index c968082..d541c3e 100644
> --- a/arch/mips64.c
> +++ b/arch/mips64.c
> @@ -35,9 +35,14 @@ get_phys_base_mips64(void)
>  int
>  get_machdep_info_mips64(void)
>  {
> -	info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
>  	info->section_size_bits = _SECTION_SIZE_BITS;
> 
> +	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
> +	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
> +		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
> +	else
> +		info->max_physmem_bits  = _MAX_PHYSMEM_BITS;
> +
>  	DEBUG_MSG("max_physmem_bits : %lx\n", info->max_physmem_bits);
>  	DEBUG_MSG("section_size_bits: %lx\n", info->section_size_bits);
> 
> --
> 2.1.0

Thanks, I've edited the commit message a bit and applied:
https://github.com/makedumpfile/makedumpfile/commit/974a507447e8d77df3a1e759cc569768372bfb8e

Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
