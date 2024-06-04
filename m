Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45290C27C54
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yar8OLzFlNC5EzAu2YHOrUgjr7SSFROg0WPJQEoUIY4=; b=a5gWFpuqR1pOW9
	/VjYFs4FZEwLOElZwPemCPsmmxN55dEHCR0TqHt41ql5X7rQmG05cZJf3lnXtvgFOBOdcltxMqw3c
	IPdJoRDS6xlZLCWmqfTrUjXJqt3MfDZQpR7S6zrkPJaLg102v4rAi4GdlUNdPFCunaN4HNu+zwKwI
	2fymIwFCZbG8ik+FC1GhIksev7fyQFb0RIdBiddf+PQaDa5E3+92vM53w8C14WgIuDGNHNDLUcKrk
	SZwxnU7yNusfR+VCEh+yH3IgE1mDJYvKwdHb0Q08VX8UZjGyhGI31pIwbjjnI2eprAMjGMGTOtcqj
	laOMnipPZa+2wR4V6BZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEUb6-00000002Zwq-3Icr;
	Tue, 04 Jun 2024 13:53:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEUb5-00000002Zvj-061A
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 13:53:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0VxfhH1OEgJBZVeakcTEgY15FfwsO+wwN+9uT42qak=;
	b=ZKGtHWvvV/uWDS+3po8ibtIma09Pj+g92mtzv2QgT5IrHZZ5dAQpnANLCe/fXdvrJQVfZb
	cIs0tZhKVWqutDBWSUK0Q5jCfENvCuOjHxlHbxn9x9jjd9atXruMtuaA+BC4PpBARhRrKF
	py3LzNqg2ln/I8PKKrMydFxughK3w7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-GvTqAB9lMauck_M8KHLNIg-1; Tue, 04 Jun 2024 09:53:01 -0400
X-MC-Unique: GvTqAB9lMauck_M8KHLNIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D423B85A5B6;
	Tue,  4 Jun 2024 13:53:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0212166B35;
	Tue,  4 Jun 2024 13:52:59 +0000 (UTC)
Date: Tue, 4 Jun 2024 21:52:56 +0800
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
Subject: Re: [PATCH v4 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <Zl8cOOv9gVzdkU0f@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-5-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-5-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_065307_160802_FF8EFFA6 
X-CRM114-Status: GOOD (  23.77  )
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

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> When there is CPU/memory hot-plugging, the kdump kernel image and initrd
> will be reloaded. The user space can write the "reuse" command to
> /sys/kernel/crash_dm_crypt_key so the stored keys can be re-saved again.
> 
> Note currently only x86 (commit ea53ad9cf73b ("x86/crash: add x86 crash
> hotplug support")) and ppc (WIP) supports the new infrastructure
> (commit 247262756121 ("crash: add generic infrastructure for crash
> hotplug support")). If the new infrastructure get extended to all arches,
> this patch can be dropped.

I am confused, what is the new infrastructure? And why this patch can be
dropped if 'the new infrastructure' is extended to all arches.

> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 89fec768fba8..b4dc881cc867 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -10,12 +10,13 @@
>  // The key scription has the format: cryptsetup:UUID 11+36+1(NULL)=48
>  #define KEY_DESC_LEN 48
>  
> -static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded"};
> +static char *STATE_STR[] = {"fresh", "initialized", "recorded", "loaded", "reuse"};
>  static enum STATE_ENUM {
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

Is the logic here wrong? Isn't it we return when it's REUSE. If not
REUSE, we need build_keys_header(), then add buffer?

> +	}
>  
>  	kbuf.buffer = keys_header;
>  	kbuf.bufsz = keys_header_size;
> -- 
> 2.45.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
