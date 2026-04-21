Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B9BF55805
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 05:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUu9F0QJUAvXu2eBNKKwazkdi1mZNiZe1x/ss0rXfpo=; b=elPIktJueuBRbrUOGLkXtDiLj1
	9qkZsf2+oqMSrXsPfTMSJ38rEg8wErYJ/EGscvTJ5yzXSTOR3Hnyy8t+OXrMpH9gg9oMYSCIAwWFY
	EiWSr8VJY1zW21gsdJpnfAMgJ7z7M6DSYtY0mwBqHphwt3VCdnFCurlOlLZwret+mdoNqGJqf9kWa
	Ttud3KOo9Wn5XgwyZ3mRvv+MsyFVM34C9bi/VmaX5uVBZG5loRP3JB4vVEuMLKAwjlIlMDqHxCdPS
	Klh/pi2PJqehLfv30CFuadpZjL95vSsELWCZ6UCNjFbHZY1K0a+nG8OAkoJPcG42iznldBVPYHIDe
	l1uaMbHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF3e8-0000000832M-0cZy;
	Tue, 21 Apr 2026 05:27:40 +0000
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF3e5-00000008321-0qJ7
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 05:27:39 +0000
Date: Tue, 21 Apr 2026 13:27:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776749249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUu9F0QJUAvXu2eBNKKwazkdi1mZNiZe1x/ss0rXfpo=;
	b=ikkEdXk6HrAF0rWjW+STbhHaWl6mWYINd6IgcMWJwupecPHrSICzNQkO2JTxrDgkEYBnbw
	k455RhBw6lYMEikAoKEmpprUtetNyly9EfPHnk6Pmic29uBBX74x7BBUG0ZrzJp3V3nS/O
	kLvIWnDi8rXw/EzB6mPUuFHNd1P00TY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove stale kdump project URL
Message-ID: <aecKux2mdmlSPxnM@MiWiFi-R3L-srv>
References: <20260418080226.40415-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418080226.40415-1-sourabhjain@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_222737_940504_7EF7006F 
X-CRM114-Status: GOOD (  14.35  )
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

On 04/18/26 at 01:32pm, Sourabh Jain wrote:
> The kdump project URL in MAINTAINERS points to
> http://lse.sourceforge.net/kdump/, but it is no longer maintained.
> 
> Remove this outdated link to avoid confusion and keep the file
> up to date.
> 
> Discussion to remove this link:
> https://lore.kernel.org/all/e1e9e200-17d7-4ae9-b0eb-71300f4eb1ac@linux.ibm.com/
> 
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 288866c32ade..46aa9a48ec15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13870,7 +13870,6 @@ R:	Vivek Goyal <vgoyal@redhat.com>
>  R:	Dave Young <dyoung@redhat.com>
>  L:	kexec@lists.infradead.org
>  S:	Maintained
> -W:	http://lse.sourceforge.net/kdump/
>  F:	Documentation/admin-guide/kdump/
>  F:	fs/proc/vmcore.c
>  F:	include/linux/crash_core.h
> -- 
> 2.52.0
> 
> 

