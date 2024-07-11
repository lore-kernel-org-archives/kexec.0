Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCFDC3DA45
	for <kexec@archiver.kernel.org>; Thu, 11 Jul 2024 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:Date:Reply-To:To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SSIxcu2tUHjSzztPDTt8zw18O5Fk7SBeMSDST7exoHs=; b=CjSAusFemGOeGX
	HiGsiYLWbHtFHHVxoueYfgE0D0Gv/tjJZToFZy8aoys8uOjq8/XC2jRBDu7zbqbcVKXAnm6vY/l56
	7ZadZn2rFjdRaT714RN+KYsTrtR3bon2Zm6p7Mg25X0Cor72a+TvrEZO9H5ii5HD3M8BqdRTW+uSU
	JsmAQMtQ33vq8MfYEfGNszPmKUwTgAxdZTrPEIA4++N+vetpFcis2eMVYtdHLsjtjDer0lHGeXHYe
	pnFTtqSKTUVJ6l40vGwvAqC1LGY7BiAwXmDkTLQ18EDnxftFjJ4eJ1DbsymQUC93pb0N/CPx8HZOy
	1xgm2IOmOD8WyyrFgnxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRxXc-0000000EqvB-0unn;
	Thu, 11 Jul 2024 17:25:12 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRxXZ-0000000Equm-2Nb6
	for kexec@lists.infradead.org;
	Thu, 11 Jul 2024 17:25:11 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0DB041E2566;
	Thu, 11 Jul 2024 19:25:07 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720718707; bh=opUZKth04MCmXdZHYRgcCgzPDGwTyJQH2sR/7o05GAg=;
	h=Date:From:Cc:Subject:In-Reply-To:References:From;
	b=MqCEzQVgQcCxDeeCGwG1wAKtFq4UhG9vPLXz3CUrNFdt5fXGJ070oGtOsQ3HXMyx9
	 /bb54U8R3KNlx9YBvpY6c7X6RhRgmKTAxK32j38CojZjsSi7nL4jlVqDstm8dX7NkP
	 EDvUGZ+ssjmWgNrN81oyatA1yoRUJ9H3Bh5xommojTx1p8lZ+/uOCgb6VkJhCBhL9R
	 RbrFYCRgyQ9dmtHaaXhbMjrnFPa92azQ+aVL/tnhPtWfZwBXdifYca/g1UCb7O3anX
	 7iRGy8m0dOdWPz/NIOkGUG/7/mxktslFKf4N5pvck79FNk/DRiIr9IXrmXJcplOEW+
	 jV6cz5UHVL0Gw==
Date: Thu, 11 Jul 2024 19:25:06 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Petr Tesarik
 <ptesarik@suse.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <20240711192506.266cfbbe@meshulam.tesarici.cz>
In-Reply-To: <20240711103409.319673-1-petr.tesarik@suse.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_102509_785932_D618AE41 
X-CRM114-Status: GOOD (  16.53  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Forgot to Cc Sourabh Jain.

On Thu, 11 Jul 2024 12:34:09 +0200
Petr Tesarik <petr.tesarik@suse.com> wrote:

> From: Petr Tesarik <ptesarik@suse.com>
> 
> There is no reason to restrict access to this attribute, as it merely
> reports whether crash elfcorehdr is automatically updated on CPU hot
> plug/unplug and/or online/offline events.
> 
> Note that since commit 79365026f8694 ("crash: add a new kexec flag for
> hotplug support"), this maps to the same flag which is world-accessible
> through /sys/devices/system/memory/crash_hotplug.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  drivers/base/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c61ecb0c2ae2..73d69791d0d3 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device *dev,
>  {
>  	return sysfs_emit(buf, "%d\n", crash_check_hotplug_support());
>  }
> -static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +static DEVICE_ATTR_RO(crash_hotplug);
>  #endif
>  
>  static void cpu_device_release(struct device *dev)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
