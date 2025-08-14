Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8CBCA0EEC
	for <kexec@archiver.kernel.org>; Thu, 14 Aug 2025 16:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOaspXYmR4qnAwmVi9UcnEM5QQJXPu+Og2WEpjR85DQ=; b=ND+MCmYFTbwwuRTDca8VhtMdiT
	HHFhEX0P8cr237VfCq8NYFkMNuAfXWVlLYqRgiHqDlgro6jpcEPV0t9kDfJqIXhuuQuu4Zba4vX02
	rvBeKYOVpcDa8uZm8U7Kg3QIAXaMuxrdVgNOM4nOJMoCuSUz4SktIpdwgoklg1t+nJv7cUztjB3sf
	rAiwCoZgsNaOkvVet2ML+rgSTfabKdzgMJsbmc0m52i1nmp35fFLJAHGS7AVvnoiMsudCzQfGwoEe
	RyzycmCxbTbkGUEDcm6l/XobGsxG/3tq9WqC4u6ilpDRVpiVqk4e66t569GnUU28ix6GXW9EtclFz
	5haRiKhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umbHI-0000000086N-3SWJ;
	Thu, 14 Aug 2025 16:58:12 +0000
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umak4-000000003k8-3S3q;
	Thu, 14 Aug 2025 16:23:52 +0000
Message-ID: <dd25041f-98e0-4bb5-bcd5-ba3507262c76@infradead.org>
Date: Thu, 14 Aug 2025 09:23:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] fs: Add 'rootfsflags' to set rootfs mount options
To: Lichen Liu <lichliu@redhat.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net,
 weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org,
 zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org
References: <20250814103424.3287358-2-lichliu@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814103424.3287358-2-lichliu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi,

On 8/14/25 3:34 AM, Lichen Liu wrote:
> When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> By default, a tmpfs mount is limited to using 50% of the available RAM
> for its content. This can be problematic in memory-constrained
> environments, particularly during a kdump capture.
> 
> In a kdump scenario, the capture kernel boots with a limited amount of
> memory specified by the 'crashkernel' parameter. If the initramfs is
> large, it may fail to unpack into the tmpfs rootfs due to insufficient
> space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> memory must be available for the mount. This leads to an OOM failure
> during the early boot process, preventing a successful crash dump.
> 
> This patch introduces a new kernel command-line parameter, rootfsflags,
> which allows passing specific mount options directly to the rootfs when
> it is first mounted. This gives users control over the rootfs behavior.
> 
> For example, a user can now specify rootfsflags=size=75% to allow the
> tmpfs to use up to 75% of the available memory. This can significantly
> reduce the memory pressure for kdump.
> 
> Consider a practical example:
> 
> To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
> the default 50% limit, this requires a memory pool of 96MB to be
> available for the tmpfs mount. The total memory requirement is therefore
> approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
> kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) ≈ 220MB.
> 
> By using rootfsflags=size=75%, the memory pool required for the 48MB
> tmpfs is reduced to 48MB / 0.75 = 64MB. This reduces the total memory
> requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
> smaller crashkernel size, such as 192MB.
> 
> An alternative approach of reusing the existing rootflags parameter was
> considered. However, a new, dedicated rootfsflags parameter was chosen
> to avoid altering the current behavior of rootflags (which applies to
> the final root filesystem) and to prevent any potential regressions.
> 
> This approach is inspired by prior discussions and patches on the topic.
> Ref: https://www.lightofdawn.org/blog/?viewDetailed=00128
> Ref: https://landley.net/notes-2015.html#01-01-2015
> Ref: https://lkml.org/lkml/2021/6/29/783
> Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-initramfs.html#what-is-rootfs
> 
> Signed-off-by: Lichen Liu <lichliu@redhat.com>
> Tested-by: Rob Landley <rob@landley.net>
> ---
> Hi VFS maintainers,
> 
> Resending this patch as it did not get picked up.
> This patch is intended for the VFS tree.
> 
>  fs/namespace.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8f1000f9f3df..e484c26d5e3f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
>  }
>  __setup("mphash_entries=", set_mphash_entries);
>  
> +static char * __initdata rootfs_flags;
> +static int __init rootfs_flags_setup(char *str)
> +{
> +	rootfs_flags = str;
> +	return 1;
> +}
> +
> +__setup("rootfsflags=", rootfs_flags_setup);

Please document this option (alphabetically) in
Documentation/admin-guide/kernel-parameters.txt.

Thanks.

> +
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -5677,7 +5686,7 @@ static void __init init_mount_tree(void)
>  	struct mnt_namespace *ns;
>  	struct path root;
>  
> -	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> +	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
>  	if (IS_ERR(mnt))
>  		panic("Can't create rootfs");
>  

-- 
~Randy


