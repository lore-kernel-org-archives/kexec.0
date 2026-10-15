Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA5CA9EDE
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 03:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jGHt9W1Ym9gc8T/wtzJJrkO08M2WLOG7KogY7IzOxqw=; b=aqXP3jP2NRY+Otk/QLRFfoazYY
	Pu7sCPTjY2fYJtxtY03ZP1Wi2uY1msChXHLd8IW3IPlppqG8/IizbBWwP3OAqoDIL7gWbQ05Rfe/j
	IkIwyxS3y3uNUedypjFxS23XiwHl2xiy8pX4YfEAfOZgxtYtkXPCXeZ5n9xQ7qq13Acis51dz5bob
	JuiloTVr8xxlVlR1KHxrRsfz5xPVfBfC/HxdataLEThgQug2kDPyfB9gyMxRoTx3w1Ds9bOGvhxL/
	qgVHX2TUCYj1j9jUiYdlhoAFLP+aMTMlw13/+uEKpGjaPT9wr2svUu93D0eFwazj6X9UJsHiPS2Fe
	ci35jqXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHCLQ-0000000GkvO-1wTF;
	Thu, 15 Oct 2026 03:41:28 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHCLP-0000000Gkut-0vZY;
	Thu, 15 Oct 2026 03:41:27 +0000
Message-ID: <f469c550-5d02-4648-a8ec-b154f2db3c57@infradead.org>
Date: Wed, 14 Oct 2026 20:41:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR() struct
 members
To: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org,
 tudor.ambarus@linaro.org, mchehab+huawei@kernel.org,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux@weissschuh.net,
 linux-kernel@vger.kernel.org, corbet@lwn.net, aleksandr.loktionov@intel.com,
 kexec@lists.infradead.org, pratyush@kernel.org
References: <20261015020313.946940-1-pasha.tatashin@soleen.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261015020313.946940-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 10/14/26 7:03 PM, Pasha Tatashin wrote:
> KHO ABI structures declare their preservation pointers with
> DECLARE_KHOSER_PTR(name, type), which expands to a union of the pointer
> and its physical address. kernel-doc does not know the macro and does
> not see the member: it warns that an unnamed member is not described
> and that the description of the member is excess.
> 
> Translate DECLARE_KHOSER_PTR(name, type) into "type name", as is done
> for DECLARE_KFIFO_PTR().
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/lib/python/kdoc/xforms_lists.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
> index e3dda2fe8a537..e81d8a7702cbb 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -45,6 +45,7 @@ class CTransforms:
>          (CMatch("DECLARE_HASHTABLE"), r"unsigned long \1[1 << ((\2) - 1)]"),
>          (CMatch("DECLARE_KFIFO"), r"\2 *\1"),
>          (CMatch("DECLARE_KFIFO_PTR"), r"\2 *\1"),
> +        (CMatch("DECLARE_KHOSER_PTR"), r"\2 \1"),
>          (CMatch("(?:__)?DECLARE_FLEX_ARRAY"), r"\1 \2[]"),
>          (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
>          (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> prerequisite-patch-id: 557b4f406b7530b8be07d3e3aa6015ad89ceaa6d
> prerequisite-patch-id: c0430a4f0096e4be93a6200aa4e8a1d392238ca5
> prerequisite-patch-id: 524c71eab38a9175f9920f38717c8ed3b157299f
> prerequisite-patch-id: 61cfc274edef2fb23a1b867c9e0d063578387c45
> prerequisite-patch-id: ac022b05628f8e495a224216352aa037a022aae4
> prerequisite-patch-id: 50668baf257da9873190d08f21538ddc453261a8

-- 
~Randy

