Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26979C43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGhxiQ2wHg/fmfhidZ4pixyfl1k6upbKB+lX0ueY5go=; b=KhEovWx5rEP4U/UQFxnFDh7Gag
	7IXRwWEVrpJHDpuUZYoyHkH2xkuqwiuC2lm9iPCkgyokCCHqRO7T3rd9ARXoWS2N4YMa+T+kU8YCy
	KtkEaJTfu+HarrK6OD0TRUkV20jPE4xHSwPyHl9p6u4YK8mquxi21HFcpXEjKfbzddxBdtAz3Ao9l
	Io+DW/5ZgaxXmTre/R/h2A4TdNiYYV77IB3x60P509N+A9rrS5G08s6yIHO8ZzFh9W5xtJP+a47cD
	MAxZCe5yRAf50ULzZuZMrDnbW19WQzlxckaSTKbgDSt4X2FOFDdI2IEVtSFMaS/q8mtTR9TlvhDYd
	oy6uRxbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiC4K-000000054Oi-3TQH;
	Fri, 10 Jul 2026 14:19:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiC4J-000000054Ob-2Chm
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 14:19:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9CB1C60051;
	Fri, 10 Jul 2026 14:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0A51F000E9;
	Fri, 10 Jul 2026 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783693146;
	bh=YGhxiQ2wHg/fmfhidZ4pixyfl1k6upbKB+lX0ueY5go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qFlaihadj2osXgYoq5pgN81gSLfdraUFeTRyznRcKUEMTtPKCZrr9NmUkUTDtejqN
	 1W+OIAZkXybtMXrNqkqSVGJBlfSBX2JHHnZPWNVTGp4xhYQ/Tx7xjeY4yjRBed1+G7
	 q7az5F8YauhjZC+poa5Z/WLIzhcF1cqXxyNDRTZE=
Date: Fri, 10 Jul 2026 16:19:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavol Sakac <sakacpav@amazon.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	David Woodhouse <dwmw@amazon.co.uk>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, linux-mm@kvack.org,
	kexec@lists.infradead.org, nh-open-source@amazon.com
Subject: Re: [RFC PATCH 09/14] iommu: lazy-populate iommu_group
 reserved_regions/type attrs
Message-ID: <2026071045-pushcart-duller-c3fa@gregkh>
References: <20260702174033.32116-1-sakacpav@amazon.de>
 <20260702175114.24659-1-sakacpav@amazon.de>
 <20260702175114.24659-5-sakacpav@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702175114.24659-5-sakacpav@amazon.de>
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

On Thu, Jul 02, 2026 at 07:51:09PM +0200, Pavol Sakac wrote:
> +	/*
> +	 * Defer reserved_regions and type - both are read only on
> +	 * VFIO/iommufd ioctl paths, so let the populate callbacks
> +	 * materialise them on demand.
> +	 *
> +	 * KERNFS_LAZY MUST be set before kobject_create_and_add("devices"),
> +	 * which calls kernfs_inc_rev() on this kobject's directory and
> +	 * would otherwise leave a stale negative dentry cached for a
> +	 * missing reserved_regions/type child.  WARN_ON because
> +	 * iommu_group_alloc() controls all group kobjects directly.
> +	 */
> +	WARN_ON(kernfs_set_lazy(group->kobj.sd));

You just crashed the kernel, that's not nice :(

>  	group->devices_kobj = kobject_create_and_add("devices", &group->kobj);
>  	if (!group->devices_kobj) {
>  		kobject_put(&group->kobj); /* triggers .release & free */
> @@ -1091,19 +1210,6 @@ struct iommu_group *iommu_group_alloc(void)
>  	 */
>  	kobject_put(&group->kobj);
>  
> -	ret = iommu_group_create_file(group,
> -				      &iommu_group_attr_reserved_regions);
> -	if (ret) {
> -		kobject_put(group->devices_kobj);
> -		return ERR_PTR(ret);
> -	}
> -
> -	ret = iommu_group_create_file(group, &iommu_group_attr_type);
> -	if (ret) {
> -		kobject_put(group->devices_kobj);
> -		return ERR_PTR(ret);
> -	}

Why isn't the driver core creating these properly on its own today?
These calls should not have to be done.  Also, what's up with the "raw"
kobject?  That's not ok, this is circumventing the driver core in a way
that is not going to work out at all (as you are finding here...)

thanks,

greg k-h

