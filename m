Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B68D58E47
	for <kexec@archiver.kernel.org>; Mon,  2 Mar 2026 03:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1acEAhrt48XvZXt+QxSXebqR9U3MKRpe1lxlgPtU6k=; b=IQkxv44SQrtqVh5sBXYWbBM8XD
	V/VJth+3O871j2bPGzUIkU7kXr2x0Nrg7PbBn6+cd71xnEmrFXzOvko6a0sFnO51ZGQRQmHGeJ3is
	P8Yru0ZDzZgQR/k8z4Qbbf2rLtzsqv2dWy24oC5AHueXfU5UuR4SU0E2CnIG1NcwKdnYmEL3AjF0N
	vBiS9OwaljVeLueyl3i0wKczFCk/XgKsjqH+1r7OOQYrzw0JnqOGVCLSkj71rAfhiEHd7iNXFd+pF
	NQOsGkJv80KlehoCT8zjlanoVumucdniL35lm1QcfB1nH4L+LGueC4wMOF2erBqPcMG+qB9Og8tsQ
	MuiyDhxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuGw-0000000CCLY-1KKl;
	Mon, 02 Mar 2026 03:48:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwuGt-0000000CCL4-2Ty7
	for kexec@lists.infradead.org;
	Mon, 02 Mar 2026 03:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772423318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1acEAhrt48XvZXt+QxSXebqR9U3MKRpe1lxlgPtU6k=;
	b=Iy8nkB3YaSOJyAc5vkwBR+pMOlJvWfKFLQmOY6M9qvc2e50epwHrug5Q8+FB50c+dpbgJF
	TfnIPGJPyDKI3PrSAMlxyKRDqB5ldMaG3NtbyZU0LehOuEbudcodrvM7OQRVTVRLYBe1zR
	OUzNGf53IGUjh9Z4I7JJFecOVIWggAo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-rKfCszv4PaimexNIMnoYYQ-1; Sun,
 01 Mar 2026 22:48:31 -0500
X-MC-Unique: rKfCszv4PaimexNIMnoYYQ-1
X-Mimecast-MFC-AGG-ID: rKfCszv4PaimexNIMnoYYQ_1772423310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89BCF18002C2;
	Mon,  2 Mar 2026 03:48:29 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E09C81800669;
	Mon,  2 Mar 2026 03:48:27 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:48:22 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Coiby Xu <coxu@redhat.com>, stable@vger.kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: Don't log dm-crypt key bytes in
 read_key_from_user_keying
Message-ID: <aaUIhtN0oUkP5ALi@MiWiFi-R3L-srv>
References: <20260227230008.858641-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260227230008.858641-2-thorsten.blum@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: cTbR3URpLVSJUP-EU3rATBuE31-5uDxiaBXwVQ7xBJw_1772423310
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_194839_774894_6099DF32 
X-CRM114-Status: GOOD (  14.44  )
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

On 02/28/26 at 12:00am, Thorsten Blum wrote:
> When debug logging is enabled, read_key_from_user_keying() logs the
> first 8 bytes of the key payload and partially exposes the dm-crypt key.
> Stop logging any key bytes.
> 
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/crash_dump_dm_crypt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 27a144920562..5ce958d069dd 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -168,8 +168,8 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>  
>  	memcpy(dm_key->data, ukp->data, ukp->datalen);
>  	dm_key->key_size = ukp->datalen;
> -	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
> -		      dm_key->key_desc, dm_key->data);
> +	kexec_dprintk("Get dm crypt key (size=%u) %s\n", dm_key->key_size,

Make sense to me.

The kexec_dprintk() is only for debug printing. We can remove above line
or change it to pr_debug() if security is worried.

Coiby, what do you think?

Thanks
Baoquan


