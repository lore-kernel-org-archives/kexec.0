Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F98CD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XXg+GT95yYO4T14XPgWTJKtcxJfATzJGx0/pfKwDeqA=; b=uNTm4RUidCR3MMFe3hxLaXf4np
	Jjb8fsAMi3gllLHYSLP1XEOysFjR2f7aGrRah7zLE8NRs2M6w1yNWiPD5GY2rBNcKqTwUiGOcaDc9
	TzOTEwdRz/wkwcxcRFg/RbBE0Uq9Hy1sXwQayI+rGdy04tD4YzDXrfuFnqGaLLeMeX2AMP5MuJIJY
	Ml6Y5n8FZ0wwuGnC8WtUXcoAmg0DMTVtw5vkj4clF0drgvQxvLYOON0tL5wI3IeGUguNzc+s/jB1A
	z0njL25i2o/4wrsezr6zGu5o+WeBxqatf6llZpcXxHgfHoi3R2Lk1Zm7Zsc9q0gMAicgnv2wMQ8Ts
	+Ar4/a6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYl36-0000000D2yy-2bJb;
	Sun, 14 Jun 2026 13:38:52 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYl33-0000000D2yU-1AM7
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 13:38:51 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-51764768c36so35958021cf.0
        for <kexec@lists.infradead.org>; Sun, 14 Jun 2026 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781444328; x=1782049128; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXg+GT95yYO4T14XPgWTJKtcxJfATzJGx0/pfKwDeqA=;
        b=eUfrhLUij31SWTlQFRy+1QRSbvugAZJppiHmOs8fxonGBKCjZLecK4bXl/2DhHCr0h
         buwo4Spuchxv2S6XX+XVAL64d87BF6BA07vQln4HBuMdGu/hRZkLjvvF6n0UxW7+Y3UH
         FHIhqm9TWyn/y3aTTiQxf80Gusvt2zVm6gHhx5t1SKdL3BSearyBi/WpZkjuQasJcWzp
         SKsN9oNF7CLliDZXWxIBNF0/87EQ4IE8HX1VWqhmN9JQ0j8NmOtS7ytLUD/wKZB9Kf+j
         kfXgK1762DgMf2wyYfulbkSOJRz/SeDUyHt4HCk89L41LUD2acgnU+XQZH1TOyH24seO
         PgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781444328; x=1782049128;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXg+GT95yYO4T14XPgWTJKtcxJfATzJGx0/pfKwDeqA=;
        b=D7y+yKCEK2VzdpuBIE94TkkHUXYSq8VoXimW4It/NBZrIfLt8rOG/kjFWsIgqilW0W
         MSOfNk/tMRUbRWyuXxdJnnfuyL36xo/Lgl1rudgjcUHGhnTAxt5TNaOPW0fyOK9IxQ4Z
         WlFIE8PTEGlLL2h7xk9ArXVFDsr/TsM692ymcFtdmUxqGF5xoa33E5aLVXfv16HpOTMx
         XOct96zTBMUoHDLyVKZm+gYIP62TFSkvqd+FmXXBgxqQBPjanm75y6KJVzfGvQvu9sg8
         MZm2ZqeJgSpIFn/bO+Ss28WY09UKY9HCPKwGax3XNgGMh/zROm1eiIDTWjUa6HQd90uc
         BvhA==
X-Gm-Message-State: AOJu0YzTxq2I8ERbRtZETdwkCgLJqjS9VBA+fI1PnCI+RytoDkTHuzfR
	X3YHgz2TyFDqBuysbq1qqbgov1FRMdvMWtr3GcmgkyIi3gsWI9wFAiK3VF2RxbHlNdM=
X-Gm-Gg: Acq92OFIkAhbLaqBFKgQdHGYnjPvSOFhxdmv8S3EOa0QysZKlJnFLSXR8aS+/7/R/hB
	zbsn92ti11dT4q9XyOlgLRnuVOCDL/B632WE09E7UGVy1/LMfZ+6yw5Mj9GpPSNRl40oalWV2Ui
	c5otX4eQqSbypQoQep3rrA3WF7fvArsthYkqfwnWAQ4AX2RumzpnzJP5lY6I1UMhvtyHxgCUj/I
	jr5ZPFxIoz8awPWTNQzPAX93VeaSLKr/+y/OshQlrWW86cEB+2UVR5zRf4YHlLgOb5JNIkIFMek
	tZyiZRyD49Z66h2PL5SP6gZJRkxzzTxOgKbPmODCjx4vGKIZOOi6zCoS3gRKBPgyWKgSDmRwsI5
	c9R5eM3MEfKXECXMwKlzrPu+qMG+2mKRUwIjou8wRNWC313hO3RBz4nxWqMYd8GdNzB/3rVGEr6
	zb8FLSjc/Mp6e5ZHC6KOJCuqB8sc31TsvJCtu9Mh7iPz43moENBY2zc9gtdJCN
X-Received: by 2002:a05:622a:8387:b0:50d:66b6:1564 with SMTP id d75a77b69052e-51953503dcbmr85951991cf.14.1781444327877;
        Sun, 14 Jun 2026 06:38:47 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dad16sm73669631cf.21.2026.06.14.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:38:47 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260522202410.3104264-4-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
Date: Sun, 14 Jun 2026 13:38:40 +0000
Message-Id: <178144432039.1257322.9644414453415904478.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=imkMf1LWuc5WHnOYfzLBjY+C/lZku32PXLp//Z5mGeY=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLq7l1REohFN/W+c/zZvmZsiNBGib+GmmJ98Xn
 Q+7rb16wzOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai6u5QAKCRC7dyhM23N6
 3kxIEADBd+AmGBTMM3+Eeu1O0iFW2mY7VSiDXVMIuYE2Aff07zDsPuFqh4iaxqw5y6yQq1RDRS9
 C+LCuvNoHjr972Bm+MNjX7C07NBMYiDKF/eZq0xHbj1XYcvY3GjqVzl5O2NnP0UkUp3d5XxdB2U
 kRMKTDUBoWa3SJaUak+oxi08sxN+Je36bFKJwqBY9dcpbDzgF/LY2TXsLUIsLhTK7mJJZ1Zua4D
 UllLotthUK/tr3huxjhNXxTtHxzpkCFabCnjYT8xZjmKs/WZmMMSP5laKjVC95NnLsDcZQZJcaY
 fVhlX1FaX9DSWDdZ7SsxAYVJ7Ur3pbt9FjS0jeI2lOhMlBGh/ybDkx4+LAnHvXuwa1taPVB55fP
 eavqiJEVaCFIZWubPMrJDMotiK4Re7Jw1ldxwPS0Qef24xJe0PBaNgnXCwEFfIGun6uZ2ev1uiD
 hsnw6UqUOs1u/utfaWudvAaNnZjzHo0l/k5+sc6C6QYbwAOSME6sT5ASpuABBfnrKTvMiveYmU9
 iSshqRHWh3vmaVHLAuamw7P21HrLeUpe1rAs+hC2gyfZ3ZKwrw4ErSfhqVMgkOBVovFuHcx1P/7
 lQyQjY82doo6RAVRWKXjvFekoAN0iqkrC5llrFeQHZvb2oyr/0eG3Rdd4Ga+VUaHcMzU3/xLWHV
 PULRypTcExsyIYg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_063849_364757_4D5C45EF 
X-CRM114-Status: GOOD (  23.21  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 10c9b65aa242..e68ae5c172d4 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
>  
>  config PCI_LIVEUPDATE
>  	bool "PCI Live Update Support"
> -	depends on PCI && LIVEUPDATE
> +	depends on PCI && LIVEUPDATE && 64BIT

Please move this to the first patch, fewer changes between patches, and 
also KHO does not support anything but 64-bit mode.

>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 065d5af822f7..96c43b84532c 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -128,13 +157,49 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> [ ... skip 31 lines ... ]
> +
> +err_xa_destroy:
> +	xa_destroy(&incoming->xa);
> +	kfree(incoming);
> +err_restore_free:
> +	kho_restore_free(ser);

This is the pattern we have been enforcing in other places in LUO. If 
the first retrieval fails, return the same error thereafter.

> @@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>  
> +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> +{
> +	struct pci_flb_incoming *incoming = NULL;
> +	int ret;

Maybe make the error return static, and avoid another search through compatible 
FLBs if it failed before?

1. Add "saved_err;"; if it is set, return it right away.
2. Change all errors to use goto save_err;, and at the end of the 
function, assign ret to saved_err;

> [ ... skip 15 lines ... ]
> +	 * This could mean that no PCI FLB data was passed by the previous
> +	 * kernel, but it could also mean the previous kernel used a different
> +	 * compatibility string (i.e. a different ABI).
> +	 */
> +	if (ret == -ENOENT) {
> +		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);

I would assume this is very normal, e.g., no devices were preserved but 
memfd+hugetlb was preserved. Maybe use pr_debug_once().

> +		return NULL;
> +	}
> +
> +	/*
> +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> +	 * but it cannot be retrieved.
> +	 */
> +	if (ret) {
> +		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");

No need to print backtrace, please just print a warning:
pr_warn_once("Failed to retrieve incoming FLB data: %pe\n", ERR_PTR(ret));

> [ ... skip 34 lines ... ]
> +	 * through pci_liveupdate_finish(). This can happen if PCI core probes
> +	 * the same device multiple times, e.g. due to hotplug.
> +	 */
> +	if (!dev_ser->refcount) {
> +		pci_liveupdate_flb_put_incoming();
> +		return;

Pleaes use 'goto put_incoming'

> +	}
> +
> +	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
> +	dev->liveupdate.incoming = dev_ser;
> +
> +	/*
> +	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> +	 * that dev->liveupdate.incoming does not get freed while it is in use.
> +	 */

How would that work? If finish is not called FLB stays around until the 
next reboot.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

