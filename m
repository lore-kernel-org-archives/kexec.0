Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E6606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ARieG812;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Xkyr5AjL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zYiGSF0ZZ4GiiESqs52zyLdAhl05Iuf9955b3bBWHVk=; b=ARieG812FLfIUf
	445Z1eyHVEGs9oZm0Z/RKUxMRqR6GjPzzNscmqLW8ZF2jheS77JqVs956e6VdwFQ2nTtpR2oAFw4B
	687X8u7+NsRuTshxqUQ+w+GbjhFSln0j99QHu8oAnWl/6PH6YHldAO6wMQu8jfxDJpCoa/7PXhAbc
	6a3/bmcT4z0niD0OQ3USEMHEvZ6iqLBQX64Ou4NzchrBd4xqGrYKnnpQkG579gdjzWeCqYjRCOeMh
	U5AX1g0tlV6l6Ykl6euGgY90CsOYc6ifUGFPVV0OSYQkyEi/9zbEsyDSSQy0PL1+38dnA7u6cUGBT
	HC9OxoBKEaK/P3unZclw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRL2e-00000008ZpY-092z;
	Thu, 12 Nov 2026 03:00:00 +0000
Received: from m16.mail.163.com ([117.135.210.3])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRL2Y-00000008Zo0-3gyw
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 02:59:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zYiGSF0ZZ4GiiESqs52zyLdAhl05Iuf9955b3bBWHVk=;
	b=Xkyr5AjLUa+Y2ROZqvr+CuhethrbpdBDV1SLKzPeegs2Iscaw4xmuxXBMP0jL3
	gb2YkC5MNxouMZBE2fryECP/pwuQqsBv67zTrZ7X8QMjVQG8cNaOEYHsPx6+hU7K
	IJnm9ep0d25Yyq6nZU65H6EunR1hdi1fvYic62HIFEofs=
Message-ID: <63d0fb19-b1cb-4729-839a-b9e1f1379473@163.com>
Date: Thu, 12 Nov 2026 10:57:05 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: efibc: Optionally report panic as a reboot reason
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-efi@vger.kernel.org
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org,
 jeremy.compostella@intel.com, matthew.k.gumbel@intel.com,
 kernel-dev@igalia.com, kernel@gpiccoli.net, kexec@lists.infradead.org
References: <20261108003549.745697-1-gpiccoli@igalia.com>
Content-Language: en-US, en-GB
From: Dave Young <hidave@163.com>
In-Reply-To: <20261108003549.745697-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wDXHyh4K_VqvdTrGw--.58296S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWDJr43GFyrJw45Zr4rGrg_yoWrXF43pa
	y8GrZ8GF4kJa4xWayfZF4UZFyYvw4xJryUuFy3C34UAr4qkr9rtrW0kw4Y9FyxJa4xGryr
	Kw4jqa4kCa1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIdgtUUUUU=
X-CM-SenderInfo: pklgt4rh6rljoofrz/xtbC7hkBw2r1K3mDxwAA38
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_185955_493193_094B927A 
X-CRM114-Status: GOOD (  30.19  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cc kexec list

On 11/8/26 8:34 AM, Guilherme G. Piccoli wrote:
> The small efibc driver can be used to determine the cause of a reboot,
> in addition to controlling bootloader behavior. Currently, this driver
> reports "shutdown" or "reboot" as possible reasons for a system restart.
>
> Add support for panic reporting, gated by a module parameter. If users
> set the parameter, a panic notifier is registered and tries to save
> "panic" as the reboot reason, if the kernel is configured to reboot on
> panic. Note that it is a best-effort approach, relying on the nonblocking
> version of the EFI variable setter.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>
>
> Hi folks, this is a 2nd attempt to make the kernel notify UEFI about
> a panic. The first proposal was a new (small) driver, sent here:
> https://lore.kernel.org/r/20220729194532.228403-1-gpiccoli@igalia.com/
>
> The idea is to have a simple mechanism, independent of efi-pstore (since
> users could be using other pstore backends, or do not wish to collect
> logs for privacy), to let UEFI know a panic happened. Using efibc seems
> to be a reasonable and simple approach.
>
> The option is gated by a parameter; this could be removed in case it's
> considered unnecessary. I think a parameter is less invasive than just
> changing the default.
>
> Feedback / reviews are greatly appreciated.
> Thanks in advance,
>
> Guilherme
>
>
>  drivers/firmware/efi/efibc.c | 46 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
> index 345a10aa7086..b4014500513f 100644
> --- a/drivers/firmware/efi/efibc.c
> +++ b/drivers/firmware/efi/efibc.c
> @@ -11,9 +11,14 @@
>  #include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/ucs2_string.h>
> +#include <linux/panic_notifier.h>
>  
>  #define MAX_DATA_LEN	512
>  
> +static bool report_panic;
> +module_param(report_panic, bool, 0444);
> +MODULE_PARM_DESC(report_panic, "Report kernel panic as a reboot reason too (default N)");
> +
>  static int efibc_set_variable(efi_char16_t *name, efi_char16_t *value,
>  			      unsigned long len)
>  {
> @@ -65,6 +70,30 @@ static struct notifier_block efibc_reboot_notifier = {
>  	.notifier_call = efibc_reboot_notifier_call,
>  };
>  
> +static int efibc_panic_notifier_call(struct notifier_block *notifier,
> +				     unsigned long event, void *data)
> +{
> +	efi_char16_t *reason = L"panic";
> +
> +	/* Skip if we aren't rebooting on panic. */
> +	if (!panic_timeout)
> +		return NOTIFY_DONE;
> +
> +	efi.set_variable_nonblocking(L"LoaderEntryRebootReason",
> +				&LINUX_EFI_LOADER_ENTRY_GUID,
> +				EFI_VARIABLE_NON_VOLATILE
> +				| EFI_VARIABLE_BOOTSERVICE_ACCESS
> +				| EFI_VARIABLE_RUNTIME_ACCESS,
> +				ucs2_strlen(reason) * sizeof(efi_char16_t),
> +				reason);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block efibc_panic_nb = {
> +	.notifier_call	= efibc_panic_notifier_call,
> +	.priority	= INT_MIN,
> +};
> +
>  static int __init efibc_init(void)
>  {
>  	int ret;
> @@ -73,16 +102,29 @@ static int __init efibc_init(void)
>  		return -ENODEV;
>  
>  	ret = register_reboot_notifier(&efibc_reboot_notifier);
> -	if (ret)
> +	if (ret) {
>  		pr_err("unable to register reboot notifier\n");
> +		return ret;
> +	}
>  
> -	return ret;
> +	if (report_panic && efi.set_variable_nonblocking) {
> +		ret = atomic_notifier_chain_register(&panic_notifier_list,
> +							&efibc_panic_nb);
> +		if (ret)
> +			pr_err("unable to register panic notifier\n");
> +	}
> +
> +	return 0;
>  }
>  module_init(efibc_init);
>  
>  static void __exit efibc_exit(void)
>  {
>  	unregister_reboot_notifier(&efibc_reboot_notifier);
> +
> +	if (report_panic && efi.set_variable_nonblocking)
> +		atomic_notifier_chain_unregister(&panic_notifier_list,
> +							&efibc_panic_nb);
>  }
>  module_exit(efibc_exit);
>  


