Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C76C79F8C
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ai877TlnF1A1wauNaxnBDKNCz5niaLrOXjrpPRwxxBE=; b=2x7trhylv+PYfKTbiInCsphab9
	WFsH41qTYqny+MHLaA1cHBkof7KtNmhWufnKsKTTZKJrAErHbRNSZGa4E6UbMksIzK4T6VJkPGdeB
	qZCzu9DnvKRYXkJcY/wy9m7MCXieEOOo+47rR0J5tj06JB3RrOUC7nwYLVpgImpECkRoaxTuJY3Fw
	pKAeYo5JHWAJCLlfR50SXuTqMwU7l8yRlQ7P0lo45SQ1bq6IVcl1XYj9Jcp+2IaOFlmdxo4Ckz/L5
	nFOe7mYgUWYrSxUkBrsv/WyGb1YDC4lpul+tp7BsBtcHz42YedVefPgr95DHJl4EbZfuhqgf13bFi
	nH9S4hJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4BAN-0000000Aosr-10en;
	Wed, 09 Sep 2026 05:48:15 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4BAM-0000000AosQ-1S9E;
	Wed, 09 Sep 2026 05:48:14 +0000
Message-ID: <83b9fd96-d0dc-4ced-97cd-287c82cdacbe@infradead.org>
Date: Tue, 8 Sep 2026 22:48:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] Documentation: kdump: Add arm64 and ppc64le to
 encrypted dump target support list
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>,
 Dave Young <ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jinjie Ruan <ruanjinjie@huawei.com>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-10-coiby.xu@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260909003657.1570544-10-coiby.xu@gmail.com>
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



On 9/8/26 5:36 PM, Coiby Xu wrote:
> The encrypted dump target support is now extended to arm64 and ppc64le.
> 
> Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel")
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 0bf2eb100a05..36ad6125c670 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -572,8 +572,8 @@ Write the dump file to encrypted disk volume
>  ============================================
>  
>  CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to an
> -encrypted disk volume (only x86_64 supported for now). User space can interact
> -with /sys/kernel/config/crash_dm_crypt_keys for setup,
> +encrypted disk volume (only x86_64, arm64, ppc64le supported for now). User
> +space can interact with /sys/kernel/config/crash_dm_crypt_keys for setup,

                                                                  for setup.

>  
>  1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
>      # Add key #1

-- 
~Randy


