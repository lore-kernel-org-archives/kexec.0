Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC70C7EE25
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ofBqcjYpUXWi7AgkSUONkJ8skh8aYLBGkb+B711Q3zM=; b=u3CBNY+/JmrhJ7
	wTIFoy+tJfxnyqAkElqj7eAbZPNuEOE2gOoeoWjjIG+3VMk+SwRsMW6jD6dCpYwVBFAg8qyuvG4Qk
	VPi41CFW76xqvoj1m0Bu8fdRGyQ2hCZZzce7pqlQSXewiuyfFGB8ygBKDBDHc1B6YRXDMfUwlw/p0
	wtJnpv+Z+sy18x5LgnqA4HVBb5eltLJppUDMnGAl+VV5SevVoXW/WikC/SZKrJd2BpsgA3UcVyii3
	FkLu11P7sB1xF0CAENqsl9MDSTnZPRXxWl1pr9ThUoIne2M2sBhZZpkjpRLLQGKY4Ihao9P8n+quh
	c73WNbpA1vU3Dsh3DnsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwC1g-001xzT-39;
	Tue, 09 May 2023 01:20:24 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwC1c-001xwE-3C
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 01:20:22 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so2762455b3a.2
        for <kexec@lists.infradead.org>; Mon, 08 May 2023 18:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683595217; x=1686187217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvnKgDrLdGbPYsBYq8JxxD98sZ+MraP0qApL2fP5if4=;
        b=iufZEJq7q54DB+83WSv76z5TKf12tRvtuirtcVl8etOYO+KDFOgEs5HzHXV8UXRpls
         Gx1bclRmOPbq+s8Vfe44vd84pPXampuZyNEXwvmXDrBKdl2YExdkv4IRON39ESkJqC2i
         8Ot/Te9Xub2Tw9BnsW4b0h5PTrp1lvtA2B6Jm9kTB5uaoeemy8aI2Ju2wLN5k1aL5Tf2
         Bdvfs2SrGIHa91GTNbUcSC6537zXPmsiQgjjQPs79KsNpop9jDK11NwrITU9pCV8ObdZ
         W+69n1y8r7o6Kka1hCH0e6prx2fs+MbbbodjeFMOQK2sbc7ULVJKnKKg/gWK0LBJO080
         f3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683595217; x=1686187217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvnKgDrLdGbPYsBYq8JxxD98sZ+MraP0qApL2fP5if4=;
        b=j08sDBXJ19G4GkFvReQoITqOdoHLfCA9h3ZjZDrttOdhF0M1p+48TZKGD+7mP0Wf1R
         WQwMG9h0slpAege1JlRCwQbxsivqqyPT4gzTt9G2ci4aAwR3NCm7ZrIR+NeNuhUjPo2Y
         YKz9MiU9dHyNxO6t8j7TfP4akLZxRn0WryH1qKO0pecpxndO3LfE2cepMyIDqqZWVufX
         v6bYRMCXsxuShPULTSQWoXQz3KVLm35a1W9TiLC65b83dAMAsc2E3BFkXeXGuup50TnU
         C/7w/MUaVkrQxKN9uPlp7FT1Dto+7OXQEHSLgBuAs1E8EL4IvkmV6DA+KrzGuFrfEqHV
         9plQ==
X-Gm-Message-State: AC+VfDyajpNwQwRwOe5Uf8Oln6artj+JUgLtuWlvn6y3dP2vgWnMjGGo
	lCFJyabxEL12Kcqf1hqU3iCAKw==
X-Google-Smtp-Source: ACHHUZ5h+1TgYj4KujZCQwdLTfcSFgNpCbTRC56j2A0dOjVoakdhu4USEX4rOpq23HrAkNhxodPAaw==
X-Received: by 2002:a05:6a00:2343:b0:644:d775:60bb with SMTP id j3-20020a056a00234300b00644d77560bbmr10814865pfj.20.1683595216924;
        Mon, 08 May 2023 18:20:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm581010pfp.48.2023.05.08.18.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:20:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pwC1V-00D2Im-7t; Tue, 09 May 2023 11:20:13 +1000
Date: Tue, 9 May 2023 11:20:13 +1000
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: add automatic kernel fs freeze / thaw and remove
 kthread freezing
Message-ID: <20230509012013.GD2651828@dread.disaster.area>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-7-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_182021_276004_862A2153 
X-CRM114-Status: GOOD (  30.04  )
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

On Sun, May 07, 2023 at 06:17:17PM -0700, Luis Chamberlain wrote:
> Add support to automatically handle freezing and thawing filesystems
> during the kernel's suspend/resume cycle.
> 
> This is needed so that we properly really stop IO in flight without
> races after userspace has been frozen. Without this we rely on
> kthread freezing and its semantics are loose and error prone.
> For instance, even though a kthread may use try_to_freeze() and end
> up being frozen we have no way of being sure that everything that
> has been spawned asynchronously from it (such as timers) have also
> been stopped as well.
> 
> A long term advantage of also adding filesystem freeze / thawing
> supporting during suspend / hibernation is that long term we may
> be able to eventually drop the kernel's thread freezing completely
> as it was originally added to stop disk IO in flight as we hibernate
> or suspend.
> 
> This does not remove the superfluous freezer calls on all filesystems.
> Each filesystem must remove all the kthread freezer stuff and peg
> the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
> flag.
> 
> Subsequent patches remove the kthread freezer usage from each
> filesystem, one at a time to make all this work bisectable.
> Once all filesystems remove the usage of the kthread freezer we
> can remove the FS_AUTOFREEZE flag.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/super.c             | 50 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h     | 14 ++++++++++++
>  kernel/power/process.c | 15 ++++++++++++-
>  3 files changed, 78 insertions(+), 1 deletion(-)

.....

> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index cae81a87cc91..7ca7688f0b5d 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -140,6 +140,16 @@ int freeze_processes(void)
>  
>  	BUG_ON(in_atomic());
>  
> +	pr_info("Freezing filesystems ... ");
> +	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> +	if (error) {
> +		pr_cont("failed\n");
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> +		thaw_processes();
> +		return error;

That looks wrong. i.e. if the sb iteration fails to freeze a
filesystem (for whatever reason) then every userspace frozen
filesystem will be thawed by this call, right? i.e. it will thaw
more than just the filesystems frozen by the suspend freeze
iteration before it failed.

Don't we only want to thaw the superblocks we froze before the
failure occurred? i.e. the "undo" iteration needs to start from the
last superblock we successfully froze and then only walk to the tail
of the list we started from?

> +	}
> +	pr_cont("done.\n");
> +
>  	/*
>  	 * Now that the whole userspace is frozen we need to disable
>  	 * the OOM killer to disallow any further interference with
> @@ -149,8 +159,10 @@ int freeze_processes(void)
>  	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
>  		error = -EBUSY;
>  
> -	if (error)
> +	if (error) {
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
>  		thaw_processes();
> +	}

Does this also have the same problem? i.e. if fs_suspend_freeze_sb()
skips over superblocks that are already userspace frozen without any
error, then this will incorrectly thaw those userspace frozen
filesystems.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
