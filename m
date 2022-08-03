Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D836C19F2A
	for <kexec@archiver.kernel.org>; Wed,  3 Aug 2022 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SFUYj4aus8jLQ3sKwall7khgANfuSyCBofhKX/cxUFc=; b=eCYdnhUBC/KcF8
	PMKGr9uk58GVNVmcRxFW8H5kCJtlCFw2KfNHQMu76ytOQLRm19/U8ZqOyF1b2TNY2kF3xRm4Cys/2
	g8ePenTAFYY5VQ+cJIxTC+gP3LSk/LfCSbcKg4aj2BsGb5rV2teMgSyH/i3m6V0zNxXGrcpma2Cty
	QbPkmg8LweKOsTKAbriu9r8bxegyGJyRxCnIR+Nox2DWMrA1RrY4diZ1juZV9f39HP0sOW0PY/uk0
	sKUg9N6mSg7b8iKYBcWzGAzG14NSr10vdtx5HARNtC/vLI0ErVb9lWV7pNJ1FkcdDmqRSWf4Ki1IV
	sBGMQB/85pqxuglkBLdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJB5l-004XA1-Kh; Wed, 03 Aug 2022 09:55:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAZp-004Gsm-Ds
	for kexec@lists.infradead.org; Wed, 03 Aug 2022 09:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659518513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wC3/PO//oorDVUr2wMWH5HeOq129lBqXeyqiPu4d5kY=;
	b=IUq1jaoP230YZTfdJycK2v64wGmhBUyJc4jdmgRCTyEbxcvuW8FI2rw30baX528w/0GlYZ
	jK4+41kQBKeKwi34Fdw5LB4SWsd/LzXtZ/hEKk/UgRxKdyN/Ve6mXvx2OLLb9x8xz+s7QJ
	7rxjt8IV1GtFtRtlBXHNVeLMCOXwGpI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-pfCCUwv0NiOp6IpbbF09sw-1; Wed, 03 Aug 2022 05:21:47 -0400
X-MC-Unique: pfCCUwv0NiOp6IpbbF09sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20B4D1C06ED1;
	Wed,  3 Aug 2022 09:21:46 +0000 (UTC)
Received: from localhost (ovpn-13-216.pek2.redhat.com [10.72.13.216])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FB4E2026D4C;
	Wed,  3 Aug 2022 09:21:44 +0000 (UTC)
Date: Wed, 3 Aug 2022 17:21:41 +0800
From: Baoquan He <bhe@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
	kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
	dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
	mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com,
	jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org,
	luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com,
	paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, stern@rowland.harvard.edu,
	tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com,
	will@kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Valentin Schneider <valentin.schneider@arm.com>,
	Xiaoming Ni <nixiaoming@huawei.com>
Subject: Re: [PATCH v2 02/13] notifier: Add panic notifiers info and purge
 trailing whitespaces
Message-ID: <Yuo+JVGsYm1V8Asx@MiWiFi-R3L-srv>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-3-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220719195325.402745-3-gpiccoli@igalia.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_022205_550048_C8FEF3CE 
X-CRM114-Status: GOOD (  18.04  )
X-Mailman-Approved-At: Wed, 03 Aug 2022 02:52:54 -0700
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

On 07/19/22 at 04:53pm, Guilherme G. Piccoli wrote:
> Although many notifiers are mentioned in the comments, the panic
> notifiers infrastructure is not. Also, the file contains some
> trailing whitespaces. Fix both issues here.
> 
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - no change.
> 
>  include/linux/notifier.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
> index aef88c2d1173..d5b01f2e3fcc 100644
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -208,12 +208,12 @@ static inline int notifier_to_errno(int ret)
>  
>  /*
>   *	Declared notifiers so far. I can imagine quite a few more chains
> - *	over time (eg laptop power reset chains, reboot chain (to clean 
> + *	over time (eg laptop power reset chains, reboot chain (to clean
>   *	device units up), device [un]mount chain, module load/unload chain,
> - *	low memory chain, screenblank chain (for plug in modular screenblankers) 
> + *	low memory chain, screenblank chain (for plug in modular screenblankers)
>   *	VC switch chains (for loadable kernel svgalib VC switch helpers) etc...
>   */
> - 
> +
>  /* CPU notfiers are defined in include/linux/cpu.h. */
>  
>  /* netdevice notifiers are defined in include/linux/netdevice.h */
> @@ -224,6 +224,8 @@ static inline int notifier_to_errno(int ret)
>  
>  /* Virtual Terminal events are defined in include/linux/vt.h. */
>  
> +/* Panic notifiers are defined in include/linux/panic_notifier.h. */
> +

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

>  #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
>  
>  /* Console keyboard events.
> -- 
> 2.37.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
