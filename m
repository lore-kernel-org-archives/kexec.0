Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400049.outbound.protection.outlook.com
 ([40.107.140.49] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m10U3-00DZmX-2J
 for kexec@lists.infradead.org; Wed, 07 Jul 2021 05:52:33 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] makedumpfile/arm: fix page_offset determination
Date: Wed, 7 Jul 2021 05:52:25 +0000
Message-ID: <TYYPR01MB677733434BF05E88B1C84ABBDD1A9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210705123354.1173984-1-grzegorz.jaszczyk@linaro.org>
In-Reply-To: <20210705123354.1173984-1-grzegorz.jaszczyk@linaro.org>
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
To: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> When the CONFIG_STRICT_KERNEL_RWX is enabled for the armv7 kernel the
> _stext is aligned to 1<<SECTION_SHIFT, which with hitherto code causes
> wrong page_offset determination.
> 
> Suit mask used for page_offset in a way that it will allow to correctly
> determine page_offset regardless of CONFIG_STRICT_KERNEL_RWX and
> CONFIG_ARM_LPAE settings.
> 
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>

Thanks, applied.
https://github.com/makedumpfile/makedumpfile/commit/9df519d2f4d6d6362fd878a1e0f0890e73166055

Kazu

> ---
>  arch/arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm.c b/arch/arm.c
> index 33536fc..7ae9cb1 100644
> --- a/arch/arm.c
> +++ b/arch/arm.c
> @@ -80,7 +80,7 @@ get_phys_base_arm(void)
>  int
>  get_machdep_info_arm(void)
>  {
> -	info->page_offset = SYMBOL(_stext) & 0xffff0000UL;
> +	info->page_offset = SYMBOL(_stext) & 0xffc00000UL;
> 
>  	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
>  	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
> --
> 2.29.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
