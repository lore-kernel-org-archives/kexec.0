Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A3AC5DF71
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geUggQKkf9+bWoESoFLGromyzmNPeThR4rOhKDhhax8=; b=ir2iNa/bs582tKOrQG4ByB2vhL
	Gmxl3iUyMC2Ftt+i0/cAFRjGOb+1WIlpvekpkG6tkUzf1k+nvA6QafB6O5UA9wi753sQ6Qsk7QrsK
	PyUxC+ZuyKkqvIVnXzWwezJjIA6eM1O9NGVH7IHBSEKv9RD595v0gn7jWHiT04gzKvsC8vWwz/C0B
	D6ABH19FFfYORCM1yvhr6ifhGMJgpme8Ev4SudaoMoBQSiHy69qPhANZWLZOxw1Mbtk0NPzQOc5pa
	frs78nB+/0v5R0eL2iLsWpRxAroCQJMGdIvC23lg99ZKtBRv8whTzxcUCRMa8Wd7OUo3rQ4jQ9nsx
	EWA0DHBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKzf-0000000CcMe-2J1E;
	Tue, 02 Jun 2026 09:01:03 +0000
Received: from out-174.mta0.migadu.com ([91.218.175.174])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKzc-0000000CcK6-3oi9
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 09:01:02 +0000
Date: Tue, 2 Jun 2026 17:00:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780390847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=geUggQKkf9+bWoESoFLGromyzmNPeThR4rOhKDhhax8=;
	b=e9UCPKxqf43WWBZfvIpyyeBxjfDmQFSW3ljr5OI42v2WepkNHpC4JimMTlqPN1jxf1S9f9
	556jbrgQb0mTT4XSo4aIHsD7krukaqeWYzQmxq6a6AdaJ0vkh7038gkgiTpzM7ko4G7afT
	EWT/UkIIc40IWJc5ITOxye2cZqfFlqk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Michal Clapinski <mclapinski@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: skip checksum verification when relocations
 aren't needed
Message-ID: <ah6buJpght3ak0js@MiWiFi-R3L-srv>
References: <20260601191136.799134-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601191136.799134-1-mclapinski@google.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_020101_169937_00E4D660 
X-CRM114-Status: GOOD (  12.92  )
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

On 06/01/26 at 09:11pm, Michal Clapinski wrote:
...snip... 
> +	/*
> +	 * If all segments were loaded into contiguous memory, there will be no
> +	 * relocations. In that case there is no risk of memory corruption by
> +	 * uncancelled DMA and we can skip checksum calculation.
> +	 */
> +	for (i = 0; i < image->nr_segments; i++) {
> +		if (!image->segment_cma[i]) {
> +			can_skip_checksum = false;
> +			break;
> +		}
> +	}
> +
> +	if (can_skip_checksum) {
> +		pr_info("disabling checksum verification in purgatory\n");

Use pr_debug() or kexec_dprintk() instead because this is unnecessary to
note users if it's a normal action?

Except of this, the overral looks good to me.

Acked-by: Baoquan He <baoquan.he@linux.dev>

> +		goto skip_checksum;
> +	}
> +
>  	for (j = i = 0; i < image->nr_segments; i++) {
>  		struct kexec_segment *ksegment;
>  
> @@ -867,6 +885,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		j++;
>  	}
>  
> +skip_checksum:
>  	sha256_final(&sctx, digest);
>  
>  	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
> -- 
> 2.54.0.929.g9b7fa37559-goog
> 

