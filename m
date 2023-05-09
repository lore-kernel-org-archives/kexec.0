Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF739C77B7C
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xFIp0Z1CxHGNXhKleBeyed7ANMhdfYhgcl4g7uv5CoY=; b=B/Czr0cjovjqRO
	sIlSv5rX0T5YsKrqN2HAA52W/wroImCpvloB+ccIvjc9Wrfki7Ka1/2msPH9PRJobYMMu7Y2F+lo6
	fD3AnwULxFrLRgA6eow44KIBPvAF7ZKYKtnzOySXAtDUXZdtlBXJL0U2xLmHnI5qGG36I5gaSF/Bg
	C+UofwseE6WKl3RhlQ0oNLsvEl2iOhEohvunj+I+I2Z+LU7l23dBcD5itVgjeOHHLJXCOASqmxMKA
	FstpLJne3/jvDkZVtPDAobZCsd59JpjaCf32a9V7KohvUsu4kTWxvgS661y7QQHnOBzKl6urdmlvV
	5PbgEo0vI9+PPLX4wv1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwJEO-002gLH-0T;
	Tue, 09 May 2023 09:02:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwJEL-002gKO-19
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 09:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683622910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm14icj1xcLZwuyrUAh+VMkzJdTwWmftCly76BVpCHQ=;
	b=ESInbJ5Cg1U/06ZkVelj4C79FH9/FY22AqAwUcPBaXuAW9HBHu20vo8v4KBNqE/DXN14Ei
	+d6iBiRcH0snfikXD3xJBKrQcKN/XIZE6TP0nlqEFJRNtDTIh68lbfEy96SdIlCyPGZ2UV
	UPABwYG2cYm7vHw5z2zxTSH+dOAWB+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-jYw41fAHM-2pUokrhyocWA-1; Tue, 09 May 2023 05:01:46 -0400
X-MC-Unique: jYw41fAHM-2pUokrhyocWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 525CC101A55C;
	Tue,  9 May 2023 09:01:46 +0000 (UTC)
Received: from localhost (ovpn-12-139.pek2.redhat.com [10.72.12.139])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED4B40C2063;
	Tue,  9 May 2023 09:01:45 +0000 (UTC)
Date: Tue, 9 May 2023 17:01:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
	kexec@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: kexec: include reboot.h
Message-ID: <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com>
References: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_020157_486256_56E5DDB2 
X-CRM114-Status: GOOD (  16.01  )
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

On 05/09/23 at 09:01am, Simon Horman wrote:
> Include reboot.h in machine_kexec.c for declaration of
> machine_crash_shutdown and machine_shutdown.
> 
> gcc-12 with W=1 reports:
> 
>  arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
>     57 | void machine_crash_shutdown(struct pt_regs *regs)
>        |      ^~~~~~~~~~~~~~~~~~~~~~
>  arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
>     61 | void machine_shutdown(void)
>        |      ^~~~~~~~~~~~~~~~
> 
> No functional changes intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Baoquan He <bhe@redhat.com>

We may need to find out the places in all architectures and fix all of
them.

> ---
>  arch/parisc/kernel/kexec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/parisc/kernel/kexec.c b/arch/parisc/kernel/kexec.c
> index 5eb7f30edc1f..db57345a9daf 100644
> --- a/arch/parisc/kernel/kexec.c
> +++ b/arch/parisc/kernel/kexec.c
> @@ -4,6 +4,8 @@
>  #include <linux/console.h>
>  #include <linux/kexec.h>
>  #include <linux/delay.h>
> +#include <linux/reboot.h>
> +
>  #include <asm/cacheflush.h>
>  #include <asm/sections.h>
>  
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
