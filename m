Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59840C43458
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 06:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L27aDEOtIhuxLNy7MyEok9eUqvvl9O0jW79d0mjRuwc=; b=EEqDsiOmB/nijecLRtRlol5AnY
	zCHh7jShVwEjzDjtxbLfcEdwgGkQXQ/JzERFFNm88OFt51r53EE9pe053WJZCDFObTSPC2/XfGd8o
	vqFJumeYb3+N6kB78Vuw00OdQFxLQ95F/+EUGvuuURQTXuNxuqONJLmZvD7bc+NufnXOeFuKq6Brj
	+LRbIqVLYD57LWvXErOK+bHKwdansBmO9bi/qobwgbHthN9vGoc/fF3iQWIWNsDkI+8ckMZueTXl3
	YM79LFpb2s5mAh5CZcurla5v8a3N3Rre17k3prm4TxZ4onGYB7rYd39qZccdfjKkTMivw19CWedHr
	NX1kLstg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkFFO-0000000GWBY-2UiD;
	Thu, 16 Jul 2026 06:07:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkFFN-0000000GWBN-3aDp
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 06:07:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A5459600AB;
	Thu, 16 Jul 2026 06:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47E11F000E9;
	Thu, 16 Jul 2026 06:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784182019;
	bh=L27aDEOtIhuxLNy7MyEok9eUqvvl9O0jW79d0mjRuwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxW4gExIw0hkM+y9+43pUo0apzAdH9+Qb/9FoLL5GHGZ05RliT4wgU1WTWs6Uxivi
	 WqHTzFM1UoFcMcerlgoF318CQ+/kz7I6n63yQ+dHxEGpZFRVvuNmqcXpE91sI3xAvJ
	 3U4AnR6HCUeBkd+w1r3vRcmECoOq6I5+twvEdZuk3jxYgherC6TUXn7UL6tJAPhSCj
	 BXcuYon06k5QjBjWRqedNuCPlbaJRJkfEj3Y2QaQPG3+byDEQCExgGx4NR8hMOp+Ox
	 IoChYAsdQ4ZAeWx/D6Irzkq3zhxDqvXChQo7b2nQmPnROsn1lcrzdjSE6ASgMx/GT8
	 DrAbW8UTlbfxA==
Date: Thu, 16 Jul 2026 09:06:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>,
	Luca Boccassi <luca.boccassi@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for
 /dev/liveupdate
Message-ID: <alh0_aCbZITvSaox@kernel.org>
References: <20260714190356.190328-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190356.190328-1-dmatlack@google.com>
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

(adding Luca for systemd POV)

On Tue, Jul 14, 2026 at 07:03:56PM +0000, David Matlack wrote:
> Remove the single-opener restriction for /dev/liveupdate by removing the
> atomic in_use tracking and the exclusive open check in luo_open() that
> returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
> that concurrent open attempts by multiple processes safely executes
> deserialization only once. Update liveupdate selftest to verify that
> multiple concurrent openers succeed.
> 
> LUO does not inherently require a single opener. There is some
> documentation about it simplifying state management, but the only thing
> it actually protects is the session deserialization during first open,
> which can be easily handled with a mutex.
> 
> Relaxing the single-opener requirement avoids the kernel forcing a
> design pattern on userspace that it itself does not require, e.g.
> allowing multiple userspace processes to create and manage sessions.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Samiullah Khawaja <skhawaja@google.com>
> 
>  kernel/liveupdate/luo_core.c                  | 46 +++----------------
>  kernel/liveupdate/luo_session.c               |  8 +++-
>  .../testing/selftests/liveupdate/liveupdate.c | 14 +++---
>  3 files changed, 18 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index 1b2bda22902d..931bb79da276 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -254,19 +254,8 @@ bool liveupdate_enabled(void)
>   * which allows a userspace agent to manage the LUO state machine and its
>   * associated resources, such as preservable file descriptors.
>   *
> - * To ensure that the state machine is controlled by a single entity, access
> - * to this device is exclusive: only one process is permitted to have
> - * ``/dev/liveupdate`` open at any given time. Subsequent open attempts will
> - * fail with -EBUSY until the first process closes its file descriptor.
> - * This singleton model simplifies state management by preventing conflicting
> - * commands from multiple userspace agents.
>   */
>  
> -struct luo_device_state {
> -	struct miscdevice miscdev;
> -	atomic_t in_use;
> -};
> -
>  static int luo_ioctl_create_session(struct luo_ucmd *ucmd)
>  {
>  	struct liveupdate_ioctl_create_session *argp = ucmd->cmd;
> @@ -329,28 +318,9 @@ static int luo_ioctl_retrieve_session(struct luo_ucmd *ucmd)
>  
>  static int luo_open(struct inode *inodep, struct file *filep)
>  {
> -	struct luo_device_state *ldev = container_of(filep->private_data,
> -						     struct luo_device_state,
> -						     miscdev);
> -
> -	if (atomic_cmpxchg(&ldev->in_use, 0, 1))
> -		return -EBUSY;
> -
>  	/* Always return -EIO to user if deserialization fail */
> -	if (luo_session_deserialize()) {
> -		atomic_set(&ldev->in_use, 0);
> +	if (luo_session_deserialize())
>  		return -EIO;
> -	}
> -
> -	return 0;
> -}
> -
> -static int luo_release(struct inode *inodep, struct file *filep)
> -{
> -	struct luo_device_state *ldev = container_of(filep->private_data,
> -						     struct luo_device_state,
> -						     miscdev);
> -	atomic_set(&ldev->in_use, 0);
>  
>  	return 0;
>  }
> @@ -419,17 +389,13 @@ static long luo_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  static const struct file_operations luo_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= luo_open,
> -	.release	= luo_release,
>  	.unlocked_ioctl	= luo_ioctl,
>  };
>  
> -static struct luo_device_state luo_dev = {
> -	.miscdev = {
> -		.minor = MISC_DYNAMIC_MINOR,
> -		.name  = "liveupdate",
> -		.fops  = &luo_fops,
> -	},
> -	.in_use = ATOMIC_INIT(0),
> +static struct miscdevice luo_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name  = "liveupdate",
> +	.fops  = &luo_fops,
>  };
>  
>  static int __init liveupdate_ioctl_init(void)
> @@ -437,6 +403,6 @@ static int __init liveupdate_ioctl_init(void)
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> -	return misc_register(&luo_dev.miscdev);
> +	return misc_register(&luo_dev);
>  }
>  late_initcall(liveupdate_ioctl_init);
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index b79b2a488974..ca4d0639d39a 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -584,13 +584,17 @@ static int luo_session_deserialize_one(struct luo_session_header *sh,
>  
>  int luo_session_deserialize(void)
>  {
> -	struct luo_session_header *sh = &luo_session_global.incoming;
> +	static DEFINE_MUTEX(luo_session_deserialize_lock);
>  	static bool is_deserialized;
> +	static int saved_err;
> +
> +	struct luo_session_header *sh = &luo_session_global.incoming;
>  	struct luo_session_ser *ser;
>  	struct kho_block_set_it it;
> -	static int saved_err;
>  	int err;
>  
> +	guard(mutex)(&luo_session_deserialize_lock);
> +
>  	/* If has been deserialized, always return the same error code */
>  	if (is_deserialized)
>  		return saved_err;
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index 502fb3567e38..a8e1a8911849 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -11,7 +11,7 @@
>   * /dev/liveupdate character device and its session management capabilities.
>   *
>   * Tests include:
> - * - Device access: basic open/close, and enforcement of exclusive access.
> + * - Device access: basic open/close, and support for multiple openers.
>   * - Session management: creation of unique sessions, and duplicate name detection.
>   * - Resource preservation: successfully preserving individual and multiple memfds,
>   *   verifying contents remain accessible.
> @@ -70,13 +70,12 @@ TEST_F(liveupdate_device, basic_open_close)
>  }
>  
>  /*
> - * Test Case: Exclusive Open Enforcement
> + * Test Case: Multiple Open Support
>   *
> - * Verifies that the /dev/liveupdate device can only be opened by one process
> - * at a time. It checks that a second attempt to open the device fails with
> - * the EBUSY error code.
> + * Verifies that the /dev/liveupdate device can be opened by multiple openers
> + * concurrently without errors.
>   */
> -TEST_F(liveupdate_device, exclusive_open)
> +TEST_F(liveupdate_device, multiple_open)
>  {
>  	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
>  
> @@ -85,8 +84,7 @@ TEST_F(liveupdate_device, exclusive_open)
>  
>  	ASSERT_GE(self->fd1, 0);
>  	self->fd2 = open(LIVEUPDATE_DEV, O_RDWR);
> -	EXPECT_LT(self->fd2, 0);
> -	EXPECT_EQ(errno, EBUSY);
> +	ASSERT_GE(self->fd2, 0);
>  }
>  
>  /* Helper function to create a LUO session via ioctl. */
> 
> base-commit: 10fd52dc7bbd6013e949ff1833be0821b7553fb0
> -- 
> 2.55.0.141.g00534a21ce-goog
> 

-- 
Sincerely yours,
Mike.

