Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B6DC48260
	for <kexec@archiver.kernel.org>; Sat, 10 Feb 2024 04:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lNQcqWvzdgUzYrHlK1ukAZJ1VUsoEx3y0O64VdvcQ9A=; b=jKMsK8I8GB3s9a
	eEJ1lYs0/oCYhEjWBGHBFSrKGEwtOJ/zL8towb3cAdjuwpvChJLtZFPCLPvxVnCNcBF5y/HoMy11N
	n1GmC+AOFMLv6EAqKCa3sU2y2MuQwYMEp0LmAjp8mDo7l1dAWePv36mbjN2ef7m9fQJ4qGGjGhvPY
	6VEeJf/dO6/S3RqyYltVM9nipOz5SXR+CbG4ngVhjxD0CaBalxeN2TPBiVRQubG5ramCwhj2n+f+/
	mngKm7hMYTONeQuX3YkdZyx9gxormuHGrEFnT3FChstc9qSVJzZ41Mm2W9OZAaT6Xni8mkBJC/7vZ
	7tXViqGm2gakZeAnij3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYfM5-00000001DRB-0ZHy;
	Sat, 10 Feb 2024 04:52:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYfM3-00000001DQi-0LtA
	for kexec@lists.infradead.org;
	Sat, 10 Feb 2024 04:52:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707540762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr2blnizYNbzYeHmXAd3S8ONSINWlTab6ZkCItA7o0c=;
	b=Q2flFpHWefQ4M2cuW+OLK8Bq/ziZ4wHO+wjlZzgy8I049ATByvJFYxjW/B67VCoeMIXeJT
	JRcHxjrqdEcknw2/R4YuRtugR+jT4OhDVkHjbNqtJTK8Zu0w1y1uFSywY+VKVM+zSQhNHO
	54oTfCY1DcRWMSiZSF3OVxJALznHneQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-hwSivvsfMH-pKZX2U5rqqw-1; Fri, 09 Feb 2024 23:52:38 -0500
X-MC-Unique: hwSivvsfMH-pKZX2U5rqqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F09D185A788;
	Sat, 10 Feb 2024 04:52:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 95DA2492BC7;
	Sat, 10 Feb 2024 04:52:36 +0000 (UTC)
Date: Sat, 10 Feb 2024 12:52:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Kexec-ml <kexec@lists.infradead.org>,
	akpm@linux-foundation.org, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Message-ID: <ZccBEYcrt3ZsduWZ@MiWiFi-R3L-srv>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240209123520.778599-1-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240209_205243_218779_5593DD02 
X-CRM114-Status: GOOD (  13.05  )
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

On 02/09/24 at 06:05pm, Hari Bathini wrote:
> With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> to the below warning:
> 
>   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> 
> Fix it by using the appropriate #ifdef.
> 
> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---

Good catch, thanks for fixing it.

Acked-by: Baoquan He <bhe@redhat.com>

>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4db1c658254c..e408d1115e26 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2545,7 +2545,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(generic_btf_ids)
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
