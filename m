Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB06BC79F8C
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 05:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBM06s4g0kz7WS7W0WwfUM/yQZv7aEJIy1mSj1Suf2A=; b=Hun8joo9iHqvwu67vhDxdc5IfL
	Gi7lnSvwybg8e5dEpWB/6jfxGBioU6NnrdYVLsfJ8v6sWrHZGzNNEuCFAR8KbQ6J+qu6pzcqkrF0Y
	hmxpcp6eRkmoHP0k+Ro441v8kWc3614L0+HqMooHwP9pfSVWNr5tjx+PGNDDlzq7oLIh4yQAQT1ZF
	duQ+UcdHoMBjkAudnOkKWPmcxQX5mnGgoLxbF7bLap4UU50sb/Ky4bcW0C1RoS/f1CHBy46k7oe0I
	LQpJBta9gza3yUqgN+XeaXD2+IkNXIsM+2knNb0C0PZrBlBqhTXfTz9YsxhpU0/UdTNmArnxxdkQV
	7F5Qwn5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4B8I-0000000Aoeb-2jFW;
	Wed, 09 Sep 2026 05:46:06 +0000
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4B8H-0000000AoeL-15Wq;
	Wed, 09 Sep 2026 05:46:05 +0000
Message-ID: <c0d5f2e9-9bd1-46fb-8111-d3af6b6c9e66@infradead.org>
Date: Tue, 8 Sep 2026 22:46:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] crash_dump: Disallow
 configfs/crash_dm_crypt_key/reuse if crash hotplug supported
To: Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>,
 Dave Young <ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jinjie Ruan <ruanjinjie@huawei.com>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-9-coiby.xu@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260909003657.1570544-9-coiby.xu@gmail.com>
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
> If crash hotplug is supported, dm-crypt keys saved to reserved memory
> will be taken care of automatically. Thus it doesn't make sense to use
> configfs/crash_dm_crypt_key/reuse. Not reserving
> image->dm_crypt_keys_addr makes it implicitly to disallow using this
> API. Currently x86_64 and ppc64le have implemented crash hotplug
> feature.
> 
> Also update the doc accordingly. Note two doc issues are fixed as well.
> 
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 16 ++++++++++------
>  kernel/crash_dump_dm_crypt.c              | 12 ++++++++----
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 7587caadbae1..0bf2eb100a05 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -577,9 +577,10 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>  
>  1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
>      # Add key #1
> -    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
> +    VOL1_UUID=7d26b7b4-e342-4d2d-b660-7426b0996720
> +    mkdir /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID
>      # Add key #1's description
> -    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
> +    echo cryptsetup:$VOL1_UUID > /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID/description
>  
>      # how many keys do we have now?
>      cat /sys/kernel/config/crash_dm_crypt_keys/count
> @@ -591,15 +592,18 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>      cat /sys/kernel/config/crash_dm_crypt_keys/count
>      2
>  
> -    # To support CPU/memory hot-plugging, reuse keys already saved to reserved
> -    # memory
> -    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
> -
>  2. Load the dump-capture kernel
>  
>  3. After the dump-capture kerne get booted, restore the keys to user keyring

                             kernel is booted,

>     echo yes > /sys/kernel/crash_dm_crypt_keys/restore
>  
> +For CPU/memory hot-plugging, you can reuse keys already saved to reserved
> +memory before reloading the kdump image,
> +    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
> +
> +Note if crash hotplug is supported, this API is totally unnecessary thus will
> +be disabled automatically.
> +
>  Contact
>  =======
>  
-- 
~Randy


