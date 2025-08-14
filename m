Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7135BCA0EE3
	for <kexec@archiver.kernel.org>; Thu, 14 Aug 2025 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NANxMn0kp0MpYVpQIXpGC768jBcE/p9R2w4NOLkSmsk=; b=a6ykHtWm5urAMETCKyMihSDRyu
	5ptl5sDdeD3gjQmZv4M0nDPCCdrkuiMOk1VE+8D8PeHSmZBkL0jJMwh08wRs+ApYy7DUCdUL0GJXk
	pgIV7bPuFVAPpicf5P3nvd7rFLOE56ZK/U+teU0hTF2aLK4QjAvsJZKOmwCdOGGgVOz5ZVWUbDs6n
	uzvpgDzxjXW4NSg9rmDva3zQK7CnkLbzXZqLOP4NQ73vWm+ayfTPCWEBXOU3LNQSL94dx1jsxB0zV
	oGHKcGszX9w0CshxJD9QnUYGuydL+C2A8j3CihtTrQevWcxKN+nOjEevR/mEcyQIRRrpfM9H1HdyV
	bn84D2Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umTLC-0000000GFPD-0RNF;
	Thu, 14 Aug 2025 08:29:42 +0000
Received: from sender4-pp-o95.zoho.com ([136.143.188.95])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umT5x-0000000GD4Q-2xPG
	for kexec@lists.infradead.org;
	Thu, 14 Aug 2025 08:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755159230; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZLaz5SkLRvtFj6a2vO7v+77uapfVinH4TduHlsApmc64c3cnLoeRkqU6k5ANojPIW7XdZ27KDzlUEOXHcFFnPG0gT3xQZkKSDePkuUWBxHvnq9fhP6+JR/jxwboplzLNynqWyh8DS/lYnAYQdSCd9KGFnDBSblGx+LcJLCUFrMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755159230; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NANxMn0kp0MpYVpQIXpGC768jBcE/p9R2w4NOLkSmsk=; 
	b=igdmkHJq+pDuFCgZMGeIPaXlXj5SVOtIk4l9gLkiixHczm4O/AHpCgFOVSQDbVSZkd0Mpfz9c1ys5CnDYfXg5vrQR1W1DBQRJ7faAjAc4gTzeYM6QX8KN4G2hhJ+hsXXOcerroJNpxqXcyEwLTGu4TM4C918eYbMS2fS1RfQmfo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755159230;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=NANxMn0kp0MpYVpQIXpGC768jBcE/p9R2w4NOLkSmsk=;
	b=Xh8ZqHvHW22+8ifwRvkVt0kVSN4F89ke7T9oRdiwIzd/biczcmm9cdx9kv4gNwlV
	UUnvwupRR/A7IsPVh78tNBmksp12dylkfqn1X0wtRFsA4borXsLpfAlLXJEv/cq7Gc2
	wWy5KXJiiCdwMXziQ1+/7+Bd60XP+rBwbveHOv14=
Received: by mx.zohomail.com with SMTPS id 17551592278291021.230660374127;
	Thu, 14 Aug 2025 01:13:47 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: lichliu@redhat.com
Cc: brauner@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rob@landley.net,
	viro@zeniv.linux.org.uk,
	weilongchen@huawei.com,
	cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	initramfs@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
Date: Thu, 14 Aug 2025 11:13:32 +0300
Message-ID: <20250814081339.3007358-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808015134.2875430-2-lichliu@redhat.com>
References: <20250808015134.2875430-2-lichliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227466eb76ce3e4e437ad93f265000074d57b1229c1e9b231b9c15b94dc87ae5bcaaf1d296d821af2:zu08011227f9fa19961d9837b310fd6f8f000023202898679270735621609aaee0cf91119224c883476d316b:rf0801122cbba89950dff1d994ded06a600000e38d9a91600849de1c9931edb8ae6ed551c6e7af003eae833ab9b405a00a:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_011357_787208_03EBC46E 
X-CRM114-Status: GOOD (  31.65  )
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

Lichen Liu <lichliu@redhat.com>:
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
> ---
>  fs/namespace.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ddfd4457d338..a450db31613e 100644
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
> +
>  static u64 event;
>  static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
>  static DEFINE_IDA(mnt_group_ida);
> @@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
>  	struct mnt_namespace *ns;
>  	struct path root;
>  
> -	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
> +	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
>  	if (IS_ERR(mnt))
>  		panic("Can't create rootfs");
>  
> -- 
> 2.50.1

Thank you for this patch!

I suggest periodically check linux-next to see whether the patch got there.

If it was not applied in resonable time, then resend it.
But this time, please, clearly specify tree, which should accept it.
I think the most apropriate tree is VFS tree here.
So, when resending please add linux-fsdevel@vger.kernel.org to CC and say in first paragraph
in your mail that the patch is for VFS tree.

--
Askar Safin

