Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4096C25B74
	for <kexec@archiver.kernel.org>; Tue, 21 May 2024 03:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jssDreCZJYa6Z36QdnC5/4mhHrD85CVh5+sUwMaEqjY=; b=nji5vL5BNj6712
	c0Um5ysMc0Vx16wJtawp4zeieG0rNzZUaKRN4jKY7sjvsJOFpPZMa4DLhgxd3WMXw8euXrZmkda2H
	5S2kTzYxA1AW93dUm9q+vjbXZPLGKQLLynIQqN+65Z7Pu1IoATYFdVu/MzUUkPVLUpKsNrNbxAxAz
	BSt+uRzZPCVCrDpQ/XJ32EXjRtiuk0zwdjBGm7EjLtzNhgfhaU7y94vW6CqRQSdz3KgSnmNizpOm1
	XkfS1bBAVIG8Y9PRk82n7c8WAcUYLyCwS+EAconw1ujblsCh4rqEjIe4ZASkqw+O4A55Vbrdp8UH5
	xsAf+XsGBdVwqWhb0EKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9GVV-0000000GFJ1-2PXO;
	Tue, 21 May 2024 03:49:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9GVS-0000000GFHz-38o7
	for kexec@lists.infradead.org;
	Tue, 21 May 2024 03:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716263379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84fW/dirVXf5VBFqyibcvwX/hKqHiB6YLgeewDy6EUw=;
	b=QUdmzNq3gFpB6U2Qr21h0ofJOz+aM2VaVrsfKuqEgHsYemfaU9GB3kugbClbIQHLSjPJyi
	7AO91hGUHeReNMYYdM2R9U4X887ZC9fOCvGHViZ0kWaTltutnTbrq4dWqYHDM5b9/0BVII
	W4+HV3kRY45+eHkOA40R0B6Bsv/xeCg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-hZPXxrt6Ov2PCqM5ZY3_8w-1; Mon,
 20 May 2024 23:48:55 -0400
X-MC-Unique: hZPXxrt6Ov2PCqM5ZY3_8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D43F43C0BE36;
	Tue, 21 May 2024 03:48:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E60157412;
	Tue, 21 May 2024 03:48:53 +0000 (UTC)
Date: Tue, 21 May 2024 11:48:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <ZkwZfcfTOL1UGKJb@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-5-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-5-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_204942_885855_DEDA9065 
X-CRM114-Status: GOOD (  24.64  )
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

On 04/25/24 at 06:04pm, Coiby Xu wrote:
> When there is CPU/memory hot-plugging, the kdump kernel image and initrd
> will be reloaded. The user space can write the "reuse" command to
> /sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.
> 
> Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
> hotplug support")) and ppc (WIP) supports the new infrastructure
> (commit 247262756121 ("crash: add generic infrastructure for crash
> hotplug support")). If the new infrastructure get extended to all arches,
> this patch can be dropped.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index b9997fb53351..6ac1fabdb6cb 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -10,12 +10,13 @@
>  // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
>  #define KEY_DESC_LEN 48
>  
> -static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
>  enum STATE_ENUM {
>  	FRESH = 0,
>  	INITIALIZED,
>  	RECORDED,
>  	LOADED,
> +	REUSE,
>  } state;
>  
>  static unsigned int key_count;
> @@ -90,12 +91,31 @@ static int record_key_desc(const char *buf, struct dm_crypt_key *dm_key)
>  	return 0;
>  }
>  
> +static void get_keys_from_kdump_reserved_memory(void)
> +{
> +	struct keys_header *keys_header_loaded;
> +
> +	arch_kexec_unprotect_crashkres();

I don't see the corresponging arch_kexec_protect_crashkres() in the
following flow. Aren't they a pair when used?

> +
> +	keys_header_loaded = kmap_local_page(pfn_to_page(
> +		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
> +
> +	memcpy(keys_header, keys_header_loaded, keys_header_size);
> +	kunmap_local(keys_header_loaded);
> +	state = RECORDED;
> +}
> +
>  static int process_cmd(const char *buf, size_t count)
>  {
>  	if (strncmp(buf, "init ", 5) == 0)
>  		return init(buf);
>  	else if (strncmp(buf, "record ", 7) == 0)
>  		return record_key_desc(buf, &keys_header->keys[key_count]);
> +	else if (!strcmp(buf, "reuse")) {
> +		state = REUSE;
> +		get_keys_from_kdump_reserved_memory();
> +		return 0;
> +	}
>  
>  	return -EINVAL;
>  }
> @@ -175,9 +195,11 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>  	}
>  
>  	image->dm_crypt_keys_addr = 0;
> -	r = build_keys_header();
> -	if (r)
> -		return r;
> +	if (state != REUSE) {
> +		r = build_keys_header();
> +		if (r)
> +			return r;
> +	}
>  
>  	kbuf.buffer = keys_header;
>  	kbuf.bufsz = keys_header_size;
> -- 
> 2.44.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
