Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDCCC001B0
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h5Ek/3oU2QRY8YOILaghkBQZddMH8+9KpvJfez/vd/U=; b=otwKOD9LZIwuTP
	rr0tfITT6Vz0vCyzHy7v0eiM9KWfWCDYnPrW4h0TXkzgrltg5yM+jbgjeluSWnS3mdUj34WAtZKry
	WlLjD1TSfT6bC52GXL3KnUnQoX3TVqx+jtP6qUaoHbSRN4U3Xj0L8LX2QUXgl/Xdb3KLW0q9huOoU
	40n3nhhhBPgzeLWVA4ZFw2ZxCqFl1R0YIb0SMr3M1HzENh+c8jUlAQIPTGbpnCZcr2/qggmsT1ef3
	odW6vAWa8lGEWYXD41dxK9c0A848QKDJHpOFk+jvM+VvpUaCmX9igDA+JEqB6EVWNbLiDy4GeeKUP
	9TFku5UeLD+HbuQ9vbFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNqqZ-003Ecr-1p;
	Mon, 24 Jul 2023 08:23:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNqqW-003EbF-06
	for kexec@lists.infradead.org;
	Mon, 24 Jul 2023 08:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690186990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ye5hZVkJgwhIyK0/JiD2r7SsrzVvzq+O4olxaiN3AL0=;
	b=F+2s+me9rO5vudcwYoy6MgRc9ZtfscGQ0X9js9zbsvDLfpe2R+cxfhFpe1nScJWItRgufG
	9NghFo95CDEACYXl5cX/Rgy5HAnJTnp1AsJ0LZEEA3YBiMQsB8aXdta9gR3E5rTdw9fgLr
	Nj90PJNIsbkAElvHOmvlGtaJShxZ7zY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-P7kk_43WOo2WA6SRQLK3gg-1; Mon, 24 Jul 2023 04:23:07 -0400
X-MC-Unique: P7kk_43WOo2WA6SRQLK3gg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79FF481D9EC;
	Mon, 24 Jul 2023 08:23:06 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D31661121315;
	Mon, 24 Jul 2023 08:23:04 +0000 (UTC)
Date: Mon, 24 Jul 2023 16:23:00 +0800
From: Baoquan He <bhe@redhat.com>
To: "Wenyu Liu(D)" <liuwenyu7@huawei.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, ebiederm@xmission.com,
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH] kexec_lock:Fix comment for kexec_lock
Message-ID: <ZL405LGPVa6lOl5s@MiWiFi-R3L-srv>
References: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_012312_134487_C99BB5AF 
X-CRM114-Status: GOOD (  22.50  )
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

On 07/24/23 at 11:45am, Wenyu Liu(D) wrote:
> kexec_mutex is replaced by an atomic variable in
> 56314b90fd43bd2444 (panic, kexec: make __crash_kexec() NMI safe).

You could use a distros kernel or customized kernel and made change
based on that. The commit id isn't correct. I pasted the right one
at below.

commit 05c6257433b ("panic, kexec: make __crash_kexec() NMI safe")

Other than this, this looks good. You can post a new one with my ack.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Fix some comment that still using kexec_mutex.
> 
> Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>
> ---
>  kernel/kexec_file.c                | 2 +-
>  security/integrity/ima/ima_kexec.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 881ba0d1714c..b5bbb2fe0668 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -624,7 +624,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>   * kexec_add_buffer - place a buffer in a kexec segment
>   * @kbuf:  Buffer contents and memory parameters.
>   *
> - * This function assumes that kexec_mutex is held.
> + * This function assumes that kexec_lock is held.
>   * On successful return, @kbuf->mem will have the physical address of
>   * the buffer in memory.
>   *
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 419dc405c831..ad133fe120db 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -77,7 +77,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>   * Called during kexec_file_load so that IMA can add a segment to the kexec
>   * image for the measurement list for the next kernel.
>   *
> - * This function assumes that kexec_mutex is held.
> + * This function assumes that kexec_lock is held.
>   */
>  void ima_add_kexec_buffer(struct kimage *image)
>  {
> --
> 2.33.0
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
