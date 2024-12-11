Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3FCE77180
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 13:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FbeRezV5hm2/6lW9aLR5qCafBn2p4lCy6fln0nBStoM=; b=GTCyzDK4qtGu06zPdXRkn/ikmZ
	WUjVmGhcW1HEZjv0lSsk8i91zAsj6EoUEQKbsVPkAHlV7J/67bTcDwVeLl/BqQgfwuy2c9CrRSYl2
	IXA0pBwTcRixueH5JgX1k+EkxX83rW8OBJZYaQCazf7OSQz4OJfdAm8ogNpdQsyGb1nUmJRUf0GGg
	PoPe5tWBZSSZM0HyYz2GM77Jnbo0NRYm+9rlKB7o9qrwtrrNL9l3oDOqGna6iUzbmRwUsx5IA0rvs
	vS7EQOGmubl/W3nwZmrersd7LIH3bScDu5Fp/LJLMcTnrfoMF+61kIsSvNTieFkdh8pHjaicELh6v
	olOcYpcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLMSa-0000000Ew95-22Er;
	Wed, 11 Dec 2024 13:09:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLMSX-0000000Ew8W-2SVX
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 13:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733922536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FbeRezV5hm2/6lW9aLR5qCafBn2p4lCy6fln0nBStoM=;
	b=W5BKmf+rfqyeOR8yqixFqunFu1xRsAxfKctDga3CIIEO5inVpjODdt35dyu0O+y65u5pzG
	YeixuP5TCm0cEGKGHU+N+QVa8oH0rxyb7+gwtQhtifGzd2YNein6ph7tV8kKskSjiob5tQ
	uidBgH7vbEzqXaKrtvDOht8Q0xxsG6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-UOhrJCgMNMWUresYsBYRLg-1; Wed,
 11 Dec 2024 08:08:52 -0500
X-MC-Unique: UOhrJCgMNMWUresYsBYRLg-1
X-Mimecast-MFC-AGG-ID: UOhrJCgMNMWUresYsBYRLg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56938195609D;
	Wed, 11 Dec 2024 13:08:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 078A819560AA;
	Wed, 11 Dec 2024 13:08:47 +0000 (UTC)
Date: Wed, 11 Dec 2024 21:08:43 +0800
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
	Greg KH <gregkh@linuxfoundation.org>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <Z1mO2wp6zlPCV6JJ@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-5-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-5-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_050857_695577_C1FBFBDC 
X-CRM114-Status: GOOD (  23.05  )
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

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> When there are CPU and memory hot un/plugs, the dm crypt keys may need
> to be reloaded again depending on the solution for crash hotplug
> support. Currently, there are two solutions. One is to utilizes udev to
> instruct user space to reload the kdump kernel image and initrd,
> elfcorehdr and etc again. The other is to only update the elfcorehdr
> segment introduced in commit 247262756121 ("crash:
> add generic infrastructure for crash hotplug support").
> 
> For the 1st solution, the dm crypt keys need to be reloaded again. The
> user space can write true to
> /sys/kernel/config/crash_dm_crypt_key/reuse so the stored keys can be
> re-used.
> 
> For the 2nd solution, the dm crypt keys don't need to be reloaded.
> Currently, only x86 supports the 2nd solution. If the 2nd solution
> gets extended to all arches, this patch can be dropped.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 52 +++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index ec2ec2967242..51431f93fc1e 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -28,6 +28,20 @@ static size_t get_keys_header_size(size_t total_keys)
>  	return struct_size(keys_header, keys, total_keys);
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
> +	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
> +	kunmap_local(keys_header_loaded);
> +	arch_kexec_protect_crashkres();
> +}
> +
>  static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>  {
>  	const struct user_key_payload *ukp;
> @@ -150,8 +164,36 @@ static ssize_t config_keys_count_show(struct config_item *item, char *page)
>  
>  CONFIGFS_ATTR_RO(config_keys_, count);
>  
> +static bool reuse;

Give it a meaningful name since it's a global variable, e.g
is_dm_key_reused?

> +
> +static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
> +{
> +	return sprintf(page, "%d\n", reuse);
> +}
> +
> +static ssize_t config_keys_reuse_store(struct config_item *item,
> +					   const char *page, size_t count)
> +{
> +	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
> +		kexec_dprintk(
> +			"dm-crypt keys haven't be saved to crash-reserved memory\n");
> +		return -EINVAL;
> +	}
> +
> +	if (kstrtobool(page, &reuse))
> +		return -EINVAL;
> +
> +	if (reuse)
> +		get_keys_from_kdump_reserved_memory();
> +
> +	return count;
> +}
> +
> +CONFIGFS_ATTR(config_keys_, reuse);
> +
>  static struct configfs_attribute *config_keys_attrs[] = {
>  	&config_keys_attr_count,
> +	&config_keys_attr_reuse,
>  	NULL,
>  };
>  


