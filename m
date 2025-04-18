Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203C0C369AB
	for <kexec@archiver.kernel.org>; Fri, 18 Apr 2025 13:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b+QNRWScy7VlNTBvv/Zh4APnzyG6J24ppGEfEXO4A/A=; b=v4r1eODJcFjxOeOb2HyVmrFRk2
	bbs/uvvZATsPGImxwQvsTMaryTEMjdnt6YES6d13HzYshlItszF+rkHTMgTwBf6FSis0LYuhlYmxC
	M/1/9LR8ue5a5Ch+xyJf92R7NPwTNN505m6qWZKM2Kw5vMM9uY7x4C4xw8yFvkjBDk7TQCIPwKT14
	AVrREYyf2bEyobZaRPxfULkWuGEEmH5cablujs+s0Oa2Dq6abJmnco3syBAqH0z7tXgM9r9oYYqUD
	80D2kLAcFt+Y4o1n7xx0fN+0kOztneOkFgp6BYD8QNZ/dkcPTKfM5I9dhs/xO3BKJnZtPwIv9YG8v
	sqrRcSIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5lSu-0000000GA0p-2W95;
	Fri, 18 Apr 2025 13:09:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5lRx-0000000G9pf-3ayB
	for kexec@lists.infradead.org;
	Fri, 18 Apr 2025 13:08:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744981688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b+QNRWScy7VlNTBvv/Zh4APnzyG6J24ppGEfEXO4A/A=;
	b=P9BC/AU9GE0DZozAQnPZFCTWfWGC93XyBz49GWedbpEAc/v1c+9dxK5+kIcpKq9UqXtVHK
	8euj+odgiUkdRwRu338L5zgA27wbrd6t4ACI4DnqSb/3n5gUgxjgIrNxRzPIHIf9cCZMZD
	CGgfhRpVgKBRiMI0YOVFP1wgVAB33IE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-oW3H6YwOPgmS32yPjuGLTQ-1; Fri,
 18 Apr 2025 09:08:06 -0400
X-MC-Unique: oW3H6YwOPgmS32yPjuGLTQ-1
X-Mimecast-MFC-AGG-ID: oW3H6YwOPgmS32yPjuGLTQ_1744981685
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 667DB19560B0;
	Fri, 18 Apr 2025 13:08:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FA121800965;
	Fri, 18 Apr 2025 13:08:02 +0000 (UTC)
Date: Fri, 18 Apr 2025 21:07:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash: Fix spelling mistake "crahskernel" ->
 "crashkernel"
Message-ID: <aAJOrrRMe7ohIaqj@MiWiFi-R3L-srv>
References: <20250418120331.535086-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418120331.535086-1-colin.i.king@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_060809_974441_F8CEBE2D 
X-CRM114-Status: GOOD (  14.81  )
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

On 04/18/25 at 01:03pm, Colin Ian King wrote:
> There is a spelling mistake in a pr_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/crash_reserve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index aff7c0fdbefa..acb6bf42e30d 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -131,7 +131,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  			cur++;
>  			*crash_base = memparse(cur, &tmp);
>  			if (cur == tmp) {
> -				pr_warn("crahskernel: Memory value expected after '@'\n");
> +				pr_warn("crashkernel: Memory value expected after '@'\n");
>  				return -EINVAL;

Acked-by: Baoquan He <bhe@redhat.com>

>  			}
>  		}
> -- 
> 2.49.0
> 


