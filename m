Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37981C77B7C
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 03:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mdx3+MXJ0hBfpTTv/vnHBu5EMqZQrUbHtYh1yI/4LFo=; b=tB1LjGwoWLKBnbkVbw11wkq86T
	4leojn9Z5/v/ToSlLBuGII3kKMxn/oxIWAu+fl9pE03o5wH4FtZdIIN4OU6xUzvOekTUjgSNop3a2
	FNgyRi8ZxIil1oQxzet+O47Ue6HLmk/V1dzV4JVGAiZheTHm8nsgR/QbxGDRDeQ/etFbxibGfcISf
	75wsZCZRK1Hws4kBVm7Ez/1MdP0SAhSLJ00rNDLJ3b0ZaSyUxD0Kfp+71f1E05f7jKWyEhWFjAzRo
	Oacmci+eTkdbyudMYAm5HGkbJNSjaiwvkrVPotHe5Kz8r5+Q178xbdHP2PW7nIoZiBS2AoDuaKTI5
	rzw8Etyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTXmt-00000001UiS-2x8k;
	Mon, 23 Jun 2025 03:24:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTXmo-00000001Uhf-2vt1
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 03:24:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750649036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mdx3+MXJ0hBfpTTv/vnHBu5EMqZQrUbHtYh1yI/4LFo=;
	b=Mjd0oj02eA3EL5KmjcRWC8fsg8TDKBjCYcqyFQGI0RDQRQ6q2IHat38YLEQZfsX9CxGotJ
	SF80PJSQiwK/sZiYWe9ZiHeNygUh3tAAPlVG+XbwogFP9wEfWBEtD7Xv1uFdbSvQBOBe29
	2J67zsHlmxA0jKCCAkah1q+S3D23KA8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-c-10POc5Mv6maAX83CVjaQ-1; Sun,
 22 Jun 2025 23:23:54 -0400
X-MC-Unique: c-10POc5Mv6maAX83CVjaQ-1
X-Mimecast-MFC-AGG-ID: c-10POc5Mv6maAX83CVjaQ_1750649032
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDF7119560B5;
	Mon, 23 Jun 2025 03:23:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.21])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1748319560B1;
	Mon, 23 Jun 2025 03:23:48 +0000 (UTC)
Date: Mon, 23 Jun 2025 11:23:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Mario Limonciello <superm1@kernel.org>, dwmw2@infradead.org
Cc: mario.limonciello@amd.com, rafael@kernel.org, len.brown@intel.com,
	pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, christian.koenig@amd.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
Message-ID: <aFjIv5OqUyiSNrRi@MiWiFi-R3L-srv>
References: <20250613214413.4127087-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613214413.4127087-1-superm1@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_202359_153988_D6DB69B4 
X-CRM114-Status: GOOD (  17.85  )
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

On 06/13/25 at 04:43pm, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Currently swap is restricted before drivers have had a chance to do their
> prepare() PM callbacks. Restricting swap this early means that if a driver
> needs to evict some content from memory into sawp in it's prepare callback
> it won't be able to.
> 
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
> 
> Move the swap restriction to right after all devices have had a chance to
> do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
> 
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/base/power/main.c | 5 ++++-
>  include/linux/suspend.h   | 5 +++++
>  kernel/kexec_core.c       | 1 +
>  kernel/power/hibernate.c  | 3 ---
>  kernel/power/power.h      | 5 -----
>  kernel/power/suspend.c    | 3 +--
>  6 files changed, 11 insertions(+), 11 deletions(-)
> 
......snip...
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9c59fa480b0b6..3a9a9f240dbc9 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1136,6 +1136,7 @@ int kernel_kexec(void)
>   Resume_devices:
>  		dpm_resume_end(PMSG_RESTORE);
>   Resume_console:
> +		pm_restore_gfp_mask();
>  		console_resume_all();
>  		thaw_processes();
>   Restore_console:

This change is inside KEXEC_JUMP scope, let David know this because he
ever tested and made change for KEXEC_JUMP.
......


