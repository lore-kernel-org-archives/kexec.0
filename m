Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C08C3DA5D
	for <kexec@archiver.kernel.org>; Mon, 22 Jul 2024 03:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TLFRCvLnjjbSs+0SfARZdWq68tqtKxUJx0YoBjSQMhc=; b=kluS8ZQacCto7y
	j+HYiHkmXO3iuaTWJDTMKnPcp0U76+nj5uc5yU+DO2uh/CnXyGrgPKIxES5eUiSYVVfoauZTbkUWY
	7lSCjnAbj6cw7p1K9htSUu3Jge2Wq4a8kc1lNoZ6Tju/N8w2beaJtNu2lTmSlhYAHnvxH2lbo1+o9
	8zkFVNEHnABA4HdCujtueKeoPfBwh8UBW4hxIhbsxo+9tFnlxzu0LicbGQpEN6oRrP9QHN1PvdMq+
	YKE/WLutiV0+6AJ4E26YmrxGFYD66woAMxof/ZjONPIo3SVhQIQ0bVfOGgTp92QrM26m8aFOFW9IR
	yCd7JhL1BELB9oVigZxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVjQg-00000008Ai9-0YiQ;
	Mon, 22 Jul 2024 03:09:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVjQd-00000008AhX-1JRn
	for kexec@lists.infradead.org;
	Mon, 22 Jul 2024 03:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721617773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=etqba8606LAa8l3O5OcOh1bnE+W9ImDVfH1gaX+xcJQ=;
	b=iTb7sBvWUgCoY82sjii8Vq+P8WzJ8jp7wg2QdJkLxIMbBiofNUKyTJqtOeI6Wk/1VrNb/X
	K1oYGrs2pbFvzfKRxSyItcvY7oqJRc/sySk2IL8hhpktCw9KCTqnDUrq/jSx3F67ykkVyw
	/deOVbmHEvc0w5YhWJeIOSPcUScKpQ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-VZIGa3EQMGW6rcPIHnd04A-1; Sun,
 21 Jul 2024 23:09:29 -0400
X-MC-Unique: VZIGa3EQMGW6rcPIHnd04A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0746919560A1;
	Mon, 22 Jul 2024 03:09:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88C511955E7B;
	Mon, 22 Jul 2024 03:09:25 +0000 (UTC)
Date: Mon, 22 Jul 2024 11:09:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] kexec: Use atomic_try_cmpxchg_acquire() in
 kexec_trylock()
Message-ID: <Zp3NXf9UBCtFKBsa@MiWiFi-R3L-srv>
References: <20240719103937.53742-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240719103937.53742-1-ubizjak@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_200935_459388_F931AD80 
X-CRM114-Status: GOOD (  16.82  )
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

On 07/19/24 at 12:38pm, Uros Bizjak wrote:
> Use atomic_try_cmpxchg_acquire(*ptr, &old, new) instead of
> atomic_cmpxchg_acquire(*ptr, old, new) == old in kexec_trylock().
> x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg.

Seems it can simplify code even though on non-x86 arch, should we
replace atomic_try_cmpxchg_acquire() with atomic_try_cmpxchg_acquire()
in all similar places?

For this one,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> ---
>  kernel/kexec_internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 2595defe8c0d..d35d9792402d 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -23,7 +23,8 @@ int kimage_is_destination_range(struct kimage *image,
>  extern atomic_t __kexec_lock;
>  static inline bool kexec_trylock(void)
>  {
> -	return atomic_cmpxchg_acquire(&__kexec_lock, 0, 1) == 0;
> +	int old = 0;
> +	return atomic_try_cmpxchg_acquire(&__kexec_lock, &old, 1);
>  }
>  static inline void kexec_unlock(void)
>  {
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
