Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B149D58E47
	for <kexec@archiver.kernel.org>; Mon,  2 Mar 2026 03:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cOdlrpYYSsiTQRBIydiE+e+REtytgUKUjuH+ZhB/IzM=; b=pQEZDddvwzW4meDg5S7n2b0Fpp
	tC5OaaKcTdoQBjN68ve9boik/6FUTJmwlcbgFehSjh+OuK8cUuuW2DjbSQNhvgT8u1L5inVkteID6
	Pv247Z8JEmEB1Utub+/1NE39pRLTNHvTTXRKIHb1Hqm5PQkRcl9KbHD7Mb/Qs9egYJif2V7kffjnl
	zYq4DkH71LxRR3tHd9VL7SLNrzcWGD7TmcUwy4BvfrU5qAXxmXV60E9ofI9oqvKcm6fHycowMb0M2
	MaGWlxLN7yphxALEEs85jK9kPdjAJhxCJUCxjuBOIb868nqSwHhAoyXXklwPlrUZSawCPGwmtzThE
	+SJWineg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtxk-0000000CB8t-2zsI;
	Mon, 02 Mar 2026 03:28:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtxh-0000000CB8U-24Jd
	for kexec@lists.infradead.org;
	Mon, 02 Mar 2026 03:28:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772422127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOdlrpYYSsiTQRBIydiE+e+REtytgUKUjuH+ZhB/IzM=;
	b=deLlf06on8/6yEaAslLPEVjUZIIFSZNjsnIOvxKIN7zxFgavG4tXoEEOP9E+jdnx4HeSqO
	IEh+GxScJ8NqGg5p9fKiPuPLD0FYaRSkRMD/LFpBJlOPwRAEHX76hLaA1oRPHU+WlJgARK
	c03kuub0baL9eA9SwtY4ZFMi/HzqW4k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665--51nVgoKMiCulfVoYC9wWw-1; Sun,
 01 Mar 2026 22:28:44 -0500
X-MC-Unique: -51nVgoKMiCulfVoYC9wWw-1
X-Mimecast-MFC-AGG-ID: -51nVgoKMiCulfVoYC9wWw_1772422123
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C15371956048;
	Mon,  2 Mar 2026 03:28:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5481B1800370;
	Mon,  2 Mar 2026 03:28:40 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:28:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: Fix typo in function name
 read_key_from_user_keying
Message-ID: <aaUD40DNfYVup9rN@MiWiFi-R3L-srv>
References: <20260227230422.859423-1-thorsten.blum@linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260227230422.859423-1-thorsten.blum@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: V4k5EKqiwRSLIgLZ3grMDGYUzCTZtCpt3ECOFER9ERs_1772422123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_192849_632320_158793D9 
X-CRM114-Status: GOOD (  17.50  )
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

On 02/28/26 at 12:04am, Thorsten Blum wrote:
> The function read_key_from_user_keying() is missing an 'r' in its name.
> Fix the typo by renaming it to read_key_from_user_keyring().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/crash_dump_dm_crypt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 27a144920562..dcb69e96c6ff 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -139,7 +139,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  	return 0;
>  }
>  
> -static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
> +static int read_key_from_user_keyring(struct dm_crypt_key *dm_key)

Good catch.

Acked-by: Baoquan He <bhe@redhat.com>

By the way, it's better to wrap these cleanup/fix patches into a
patchset for easier reviewing and merging when you are exploring code
flow of one feature/component. Anyway, thanks.

>  {
>  	const struct user_key_payload *ukp;
>  	struct key *key;
> @@ -387,7 +387,7 @@ static int build_keys_header(void)
>  
>  		strscpy(keys_header->keys[i].key_desc, key->description,
>  			KEY_DESC_MAX_LEN);
> -		r = read_key_from_user_keying(&keys_header->keys[i]);
> +		r = read_key_from_user_keyring(&keys_header->keys[i]);
>  		if (r != 0) {
>  			kexec_dprintk("Failed to read key %s\n",
>  				      keys_header->keys[i].key_desc);
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
> 
> 


