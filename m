Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C344E77188
	for <kexec@archiver.kernel.org>; Mon, 23 Dec 2024 00:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0XpDxUSgIanHaSb41TvtptFexiXfezTIhDNDrOlvQKw=; b=0TguI+yzXTatn7nA7QxXQyrcAx
	/AY2XI6H6Wa5bsAk3Z70Gb4fZmWhwymVkZdj66USAenluU5Q+GsbhmI/7wMmu79vkeneS3PyYvV84
	m6wBaAO75SnknkjJWtjpxCY1y+gM2sNRvf8OuDPTlKm+1+cVlHOK0zMlYLmclPykQQ/1qeHO6c6R9
	Rx7CHfOfsUhZrOFZeZrHy44L6ncycJfj0PTzF1TqWWBKpxkjcUUjDml0zlTiy6zdIHnC32zeql8zF
	wHnCnRDL8E3nkfHiXSStMoXhiWBKb8SFaK5JiwRWdHiHynI4oMWjRqZlwoCJRJlJuVK5mD/gEg+ys
	gWHgy6Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPWZZ-000000091iw-3HWR;
	Mon, 23 Dec 2024 00:45:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPWZV-000000091i6-3Tg1
	for kexec@lists.infradead.org;
	Mon, 23 Dec 2024 00:45:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734914718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0XpDxUSgIanHaSb41TvtptFexiXfezTIhDNDrOlvQKw=;
	b=cKnaH3LWkpGSZetFBMCoEnQ7PLlbDkhOlavlu3ec9D7PyYqZqJ1GDnqtrBCsNYnJ5mNEjP
	AiUoK9ED7rbCZRI2zlrouBhoePr3zFJcOo6XSIw9UVi3BP/xOE7mAHqRWat2Ml7m/G9KH2
	dhvCM7dr6z+uTYrmE6iUy9X7KWu1KQw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Qe52T7UnPPuOFmRMhg08CQ-1; Sun, 22 Dec 2024 19:45:17 -0500
X-MC-Unique: Qe52T7UnPPuOFmRMhg08CQ-1
X-Mimecast-MFC-AGG-ID: Qe52T7UnPPuOFmRMhg08CQ
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7fd4c36920eso2188265a12.0
        for <kexec@lists.infradead.org>; Sun, 22 Dec 2024 16:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734914715; x=1735519515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XpDxUSgIanHaSb41TvtptFexiXfezTIhDNDrOlvQKw=;
        b=coChYDShp6RX9ClvmDGnxTA2iR2i0qb8Bw+i8EEyAQHzlbnWFkHsR70j8/4CZnOEgf
         Za/EftST8o/48NVH9d2jkBgXbLPuu7iKE5kgFshHpzVBJ2a6zJ6warH0rsQafB/mPGR/
         akbVnaYbOnoWbUr65BftyO1WSKxF+L8wCoyhoG4ifvuUFNTnkGw2wZEw2jzi842PwyGI
         /HPEOpQvpi5iY0AtR6IWw2LuTwywQUu7vL1VAEPnE55WGhewQGd3moNbaPVfl7qao6IZ
         jJX17ehPKT6DANLAAuweHG+4XxR0l9m/ZV9UmaVtT0DoYcRE6dd4h40XW54z/arc+yDU
         JrmA==
X-Gm-Message-State: AOJu0YxBqTH6bKQVMyDe7vnPAXQJrxP/1uYoyE00mbH2G/8+bC0WFF1D
	JQT5bOmuH62RJLMlaHTN4KYfKhKjOYn9Ikh0KYc+nNNBgzRbaAFXOM1/Miy13E7kxU/izz48aEa
	hmG5FbZhEUTYd7CPe0flMtJPs7rni36Pu3z2Pgk766RiFDOjFz68q8wMUTQ==
X-Gm-Gg: ASbGncu+mm9cARJW6t4lkQ5ZvxgXksAPplvNe2BQF80MeZ94JrP2e5LBPKaDXYllCG0
	wC2ZgvWuSK3Se1au68qxny4SiLCTiGFpcgssagBO4aW2+ZHuiLftcOhTC5coZ6DTmveDfPLKAd/
	C3ESt4Tf9ZuXHut+lxMOQ9IFfZ4vi1jN+1OWd6UMk+mFb6mKb+rEpQBkGeb/p90XryQ+cdPn0QP
	s12eadKgvLb69zp1XqLKFj83/iaw+wVrtNiQRSAs7GnDIta
X-Received: by 2002:a17:903:2a8c:b0:216:55a1:369 with SMTP id d9443c01a7336-219e6e9faa0mr140170145ad.18.1734914715308;
        Sun, 22 Dec 2024 16:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa4UQsff0KbzFg6Mxt7hJ+tRYAUJtVDnajB6tdl4MeAqt1HXY2tEZ0xq3U+DwDh3FEV9iLIA==
X-Received: by 2002:a17:903:2a8c:b0:216:55a1:369 with SMTP id d9443c01a7336-219e6e9faa0mr140169865ad.18.1734914714985;
        Sun, 22 Dec 2024 16:45:14 -0800 (PST)
Received: from localhost ([180.109.216.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26d89asm9046807a91.46.2024.12.22.16.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 16:45:14 -0800 (PST)
Date: Mon, 23 Dec 2024 08:41:07 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 4/7] crash_dump: reuse saved dm crypt keys for
 CPU/memory hot-plugging
Message-ID: <n53jx5fhh5e42yugnegiduvbbqnyic4m6ujadppcfbwmdny43o@vg6mgxm2qpqn>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-5-coxu@redhat.com>
 <Z1mO2wp6zlPCV6JJ@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z1mO2wp6zlPCV6JJ@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FaqE_7iEv_QIGz_tzSapxUi7ghVuvtFXQhdRiIQafMg_1734914715
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241222_164521_997703_A7C7612D 
X-CRM114-Status: GOOD (  19.11  )
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

On Wed, Dec 11, 2024 at 09:08:43PM +0800, Baoquan He wrote:
>On 10/29/24 at 01:52pm, Coiby Xu wrote:
>> When there are CPU and memory hot un/plugs, the dm crypt keys may need
>> to be reloaded again depending on the solution for crash hotplug
>> support. Currently, there are two solutions. One is to utilizes udev to
>> instruct user space to reload the kdump kernel image and initrd,
>> elfcorehdr and etc again. The other is to only update the elfcorehdr
>> segment introduced in commit 247262756121 ("crash:
>> add generic infrastructure for crash hotplug support").
>>
>> For the 1st solution, the dm crypt keys need to be reloaded again. The
>> user space can write true to
>> /sys/kernel/config/crash_dm_crypt_key/reuse so the stored keys can be
>> re-used.
>>
>> For the 2nd solution, the dm crypt keys don't need to be reloaded.
>> Currently, only x86 supports the 2nd solution. If the 2nd solution
>> gets extended to all arches, this patch can be dropped.
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  kernel/crash_dump_dm_crypt.c | 52 +++++++++++++++++++++++++++++++++---
>>  1 file changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index ec2ec2967242..51431f93fc1e 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -28,6 +28,20 @@ static size_t get_keys_header_size(size_t total_keys)
>>  	return struct_size(keys_header, keys, total_keys);
>>  }
>>
>> +static void get_keys_from_kdump_reserved_memory(void)
>> +{
>> +	struct keys_header *keys_header_loaded;
>> +
>> +	arch_kexec_unprotect_crashkres();
>> +
>> +	keys_header_loaded = kmap_local_page(pfn_to_page(
>> +		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>> +
>> +	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
>> +	kunmap_local(keys_header_loaded);
>> +	arch_kexec_protect_crashkres();
>> +}
>> +
>>  static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>>  {
>>  	const struct user_key_payload *ukp;
>> @@ -150,8 +164,36 @@ static ssize_t config_keys_count_show(struct config_item *item, char *page)
>>
>>  CONFIGFS_ATTR_RO(config_keys_, count);
>>
>> +static bool reuse;
>
>Give it a meaningful name since it's a global variable, e.g
>is_dm_key_reused?

Sure, I'll use is_dm_key_reused in next version! Thanks for the
suggestion to improve code readability!

-- 
Best regards,
Coiby


