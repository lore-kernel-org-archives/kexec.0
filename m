Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41707C4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 01:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lJVCFUp37syNsTwyIxW4sQsOVjy2xHdddZAqYDq8mYs=; b=G3/WTex373bWpu
	BsDOYYmA2hq75c5Cr9NkeHN4ODsW9zbnDeXm1S/UKeY4QegjZtv6a8EDjaVWfR9KTGqIWb4xnVPX9
	7Cwx1YdUtWXk+RKumrBB147DGnQlPTlHwZVml0KqfjnJxBzw0hhZNrl0ZLArwL/NXHCrS/R4dXLq8
	/fL9Om8fCMpT4AOD2UeXZ8S1iaeG+SoVAdVXyl2LRn+uatmI4pOJOp1x2I9oU+0tIzVL/eSL3ZpR3
	veaOT4fdRgpFjghoRh1E08SDjAXz84HFg/7OAYZS1slrMT06Tiq6LmmQoENBAzXSbO5IcWMSfNaQy
	9ZtNhA9Q9wHTNilvnWCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8W3S-009hU2-1t;
	Thu, 30 Nov 2023 01:41:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8W3P-009hT1-1k
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 01:41:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701308480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+mAc5bUWQHIfKcRKPqP2W6po7z2iVLf+97SiNfRjUQ=;
	b=Z3mRjB/gbHpdQsrzrMb8eWj+V+RDUM5VxEldCrTQYXilPX8i7hT3GV1jAFsJ05vc4m3fsZ
	gfx3af18VyoD+JSsLPwTwGxh2WeFLMeEqSEZ0+ivkLjQI7L28vm3Yvr4glMSKp0dnHtlb5
	i+1iWnPxUpuOk1EDHtAGyUybglZ6/ok=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-tegoFPWqOWuDru5oX104Rg-1; Wed,
 29 Nov 2023 20:41:16 -0500
X-MC-Unique: tegoFPWqOWuDru5oX104Rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ACCF29AA3BF;
	Thu, 30 Nov 2023 01:41:16 +0000 (UTC)
Received: from localhost (unknown [10.72.113.96])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 881A6112130B;
	Thu, 30 Nov 2023 01:41:15 +0000 (UTC)
Date: Thu, 30 Nov 2023 09:41:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	eric_devolder@yahoo.com, agordeev@linux.ibm.com,
	kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-ID: <ZWfoOLEnS+TnikpA@MiWiFi-R3L-srv>
References: <20231129220409.55006-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231129220409.55006-1-ignat@cloudflare.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_174123_675316_7BC1A9BB 
X-CRM114-Status: GOOD (  20.42  )
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

On 11/29/23 at 10:04pm, Ignat Korchagin wrote:
> In commit f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for
> CRASH_DUMP") we tried to fix a config regression, where CONFIG_CRASH_DUMP
> required CONFIG_KEXEC.
> 
> However, it was not enough at least for arm64 platforms. While further testing
> the patch with our arm64 config I noticed that CONFIG_CRASH_DUMP is unavailable
> in menuconfig. This is because CONFIG_CRASH_DUMP still depends on the new
> CONFIG_ARCH_SUPPORTS_KEXEC introduced in commit 91506f7e5d21 ("arm64/kexec:
> refactor for kernel/Kconfig.kexec") and on arm64 CONFIG_ARCH_SUPPORTS_KEXEC
> requires CONFIG_PM_SLEEP_SMP=y, which in turn requires either CONFIG_SUSPEND=y
> or CONFIG_HIBERNATION=y neither of which are set in our config.
> 
> Given that we already established that CONFIG_KEXEC (which is a switch for kexec
> system call itself) is not required for CONFIG_CRASH_DUMP drop
> CONFIG_ARCH_SUPPORTS_KEXEC dependency as well. The arm64 kernel builds just fine
> with CONFIG_CRASH_DUMP=y and with both CONFIG_KEXEC=n and CONFIG_KEXEC_FILE=n
> after f8ff23429c62 ("kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP")
> and this patch are applied given that the necessary shared bits are included via
> CONFIG_KEXEC_CORE dependency.
> 
> Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  kernel/Kconfig.kexec | 1 -
>  1 file changed, 1 deletion(-)

This is a good catch, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index fc38f1ae3a30..946dffa048b7 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -96,7 +96,6 @@ config KEXEC_JUMP
>  config CRASH_DUMP
>  	bool "kernel crash dumps"
>  	depends on ARCH_SUPPORTS_CRASH_DUMP
> -	depends on ARCH_SUPPORTS_KEXEC
>  	select CRASH_CORE
>  	select KEXEC_CORE
>  	help
> -- 
> 2.39.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
