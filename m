Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3448C7EE23
	for <kexec@archiver.kernel.org>; Wed, 31 May 2023 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k92YkLLdPrwKrLMpu9Id8stfo9hDgMAZf58ZSdXUhBE=; b=hA/g5DV7Ss6qOl
	eoryvRH8wP7YFtKfUPeo2xmjmdFy/1ygut8HzxmVluErlzrJHdLlIi+oy5z7OCpmoWe+hwgYvwSlw
	IMk3CML1o1GSnn9Iq71Q502LV8qGLnfznANxwlXBh/VoViGuBsrWPBJ8J8oVjYe0B22wAI86tKJZF
	KKovZqpRyynJPmmX+BFWnSOIwHwsta0dLM4YKRIi3HQCvguNM/SihyDrmTTVoK6Tew6LV0QKoTmG7
	e9Pfqs7Uo6Xf9AjTyZ5I2OylQa4DTR/CDWTe0bRY6DAJ1u/uQf9CoyQrLFwt7zgFvD1fMg4ECK4zq
	7pMkNcLDLvFyN+1UKASg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q49Sl-00FZt7-1q;
	Wed, 31 May 2023 00:13:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q49Sh-00FZs8-1q
	for kexec@lists.infradead.org;
	Wed, 31 May 2023 00:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685491987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMlftAvKzPLGRcgmcHupK2Ab5W7s4ldFaTzuXWoZEBE=;
	b=E6rMvat/8CR+PLeirfU3izFBHOvSZbLcNT3Y/89T2LAFUCEvhm5LiEYmMgZZE8MuC+PY9H
	nCdMv8SeLuuZdmETsbK+xkVgBFjZ+dQp2c/bjItg+Fgw6jCJACdaHQi2MhjH2lm/Ij1wft
	Qf0FT/VPEU1dTYB6hygfrrCOGpCvVRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-MM0jDMqZNVSJUlu95RohfA-1; Tue, 30 May 2023 20:13:05 -0400
X-MC-Unique: MM0jDMqZNVSJUlu95RohfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA084101A52C;
	Wed, 31 May 2023 00:13:04 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6F3202696C;
	Wed, 31 May 2023 00:13:03 +0000 (UTC)
Date: Wed, 31 May 2023 08:13:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Holzheu <holzheu@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] kexec: fix a memory leak in crash_shrink_memory()
Message-ID: <ZHaQ7qRYWX9FETu6@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230527123439.772-2-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_171311_798396_4E5B06F2 
X-CRM114-Status: GOOD (  23.01  )
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

On 05/27/23 at 08:34pm, Zhen Lei wrote:
> If the value of parameter 'new_size' is in the semi-open and semi-closed
> interval (crashk_res.end - KEXEC_CRASH_MEM_ALIGN + 1, crashk_res.end], the
> calculation result of ram_res is:
> 	ram_res->start = crashk_res.end + 1
> 	ram_res->end   = crashk_res.end

If the new_size is smaller than KEXEC_CRASH_MEM_ALIGN, does it make
any sense except of testing purpose? Do we need to fail this kind of
shrinking, or just shrink all the left crash memory?

> The operation of function insert_resource() fails, and ram_res is not
> added to iomem_resource. As a result, the memory of the control block
> ram_res is leaked.
> 
> In fact, on all architectures, the start address and size of crashk_res
> are already aligned by KEXEC_CRASH_MEM_ALIGN. Therefore, we do not need to
> round up crashk_res.start again. Instead, we should round up 'new_size'
> in advance.
> 
> Fixes: 6480e5a09237 ("kdump: add missing RAM resource in crash_shrink_memory()")
> Fixes: 06a7f711246b ("kexec: premit reduction of the reserved memory size")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 3d578c6fefee385..22acee18195a591 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1122,6 +1122,7 @@ int crash_shrink_memory(unsigned long new_size)
>  	start = crashk_res.start;
>  	end = crashk_res.end;
>  	old_size = (end == 0) ? 0 : end - start + 1;
> +	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
>  	if (new_size >= old_size) {
>  		ret = (new_size == old_size) ? 0 : -EINVAL;
>  		goto unlock;
> @@ -1133,9 +1134,7 @@ int crash_shrink_memory(unsigned long new_size)
>  		goto unlock;
>  	}
>  
> -	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
> -	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
> -
> +	end = start + new_size;
>  	crash_free_reserved_phys_range(end, crashk_res.end);
>  
>  	if ((start == end) && (crashk_res.parent != NULL))
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
