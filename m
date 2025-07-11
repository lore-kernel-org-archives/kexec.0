Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFABC8303C
	for <kexec@archiver.kernel.org>; Fri, 11 Jul 2025 06:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yeoEDjDU8a4IeYmps0ds8/3XOPMV0IgPKVsoQbtyLww=; b=R/9BWGgQJ9M7mFhgF4LGT/kvtp
	48Y88FVnsUdnVHiszeLsL3yh0wagOVlgf4pBh+mttRJdg867o5vw4BY7TB6MlXdvcYyom5UFNTqdM
	REubCknJDVNE0ahXPhil4maZr8YRXrtBoI/mevd35r4qJMMSTUpGRTpnw8/44HXcnWFF5XCu3uxiA
	WKU7MaCMxebIN6QldT8FIfxHpXDDPW7IZxXfLjZCbt+E4wnf/hVuOjtWaZ3QOyRvnH2osHDuyazQm
	dpBSspsBLieAsu1jmVpty4qxxk2KutF18swl7M7t0ONuf69CDpnlLD4gMmrbUZWfua+/X3jh004nW
	YbQIusHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua74C-0000000DpiQ-1RF9;
	Fri, 11 Jul 2025 06:17:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua749-0000000Dph1-29Y1
	for kexec@lists.infradead.org;
	Fri, 11 Jul 2025 06:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752214619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeoEDjDU8a4IeYmps0ds8/3XOPMV0IgPKVsoQbtyLww=;
	b=Pk+6RlpctyOzM7aCvtc6Ykg/mpcIiSHuWvIMVmbJekM7CbxUM5KawjmUAq04bKeytVnclD
	ZNmTaANXBB6BUSJsUqPlcbOce/+RktSEah5o/q4N1KQU/bsKXaL6AxJIOtZk0hy1ELjbaG
	lwtz7r20YJ9qq5diqw67+LzUngT7OY8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-f_ewVtGgMG-LM5h8dmQEvw-1; Fri,
 11 Jul 2025 02:16:55 -0400
X-MC-Unique: f_ewVtGgMG-LM5h8dmQEvw-1
X-Mimecast-MFC-AGG-ID: f_ewVtGgMG-LM5h8dmQEvw_1752214614
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B617F18011DF;
	Fri, 11 Jul 2025 06:16:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.59])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 825DB1956094;
	Fri, 11 Jul 2025 06:16:52 +0000 (UTC)
Date: Fri, 11 Jul 2025 14:16:48 +0800
From: Baoquan He <bhe@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v1 1/2] kexec_core: Fix error code path in the KEXEC_JUMP
 flow
Message-ID: <aHCsUAhqRz5zJH2t@MiWiFi-R3L-srv>
References: <5046396.31r3eYUQgx@rjwysocki.net>
 <2396879.ElGaqSPkdT@rjwysocki.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396879.ElGaqSPkdT@rjwysocki.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_231701_624026_D913FC10 
X-CRM114-Status: GOOD (  16.32  )
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

On 07/10/25 at 03:10pm, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If dpm_suspend_start() fails, dpm_resume_end() must be called to
> recover devices whose suspend callbacks have been called, but this
> does not happen in the KEXEC_JUMP flow's error path due to a confused
> goto target label.
> 
> Address this by using the correct target label in the goto statement in
> question.

Sounds very reasonable, thanks for the fix.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Fixes: 2965faa5e03d ("kexec: split kexec_load syscall from kexec core code")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/kexec_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1080,7 +1080,7 @@
>  		console_suspend_all();
>  		error = dpm_suspend_start(PMSG_FREEZE);
>  		if (error)
> -			goto Resume_console;
> +			goto Resume_devices;
>  		/*
>  		 * dpm_suspend_end() must be called after dpm_suspend_start()
>  		 * to complete the transition, like in the hibernation flows
> 
> 
> 


