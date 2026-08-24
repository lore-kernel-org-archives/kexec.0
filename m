Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E120BC5DF97
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wFdw7194L4fQEjhILHsILl9N8tSIJ2MhybMqVmE6L9c=; b=b98BYc0cXRgq5j8a0TaaKkPtWE
	93rsLZKKIWkHeAl4zTEfCFtK2Bzhj0t+E4zKLdJFjVS+dU0zVQW0dGwcpk7hxD1ldElRQm5nRs876
	yPe0SVn1CZZWmzurdZUBhzgMYcHsxklZ27HqlbxlSXKcqyzAueHSYZYWTsV9wNnEZvXnPCdpUZZEQ
	YMJs71FNcHVJTc1FqU8fm7he2SL7yNmqNC6HnjvCbCo1anFFQtGG71C3vNX3IRiBtBSiAc5Wuqftt
	gPEc0NuOn2Rr9UWO16e1vt/6QfhO6TcYgqOBhYd68nQz+3EK+JxJK005Ai5ByO8BknLL4tC17xUBI
	gOQoy/ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyKpK-0000000Fq2J-0ri2;
	Mon, 24 Aug 2026 02:54:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyKpJ-0000000Fq29-0ewk
	for kexec@bombadil.infradead.org;
	Mon, 24 Aug 2026 02:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wFdw7194L4fQEjhILHsILl9N8tSIJ2MhybMqVmE6L9c=; b=I3Zhc/oDSZneTHNYEcBzwB7KwE
	IgYOz6SYVEGwUZ7c7+eWBOnZo9sC47x0//cEJTiJNJimNS/yaFJIEj0kOPCEbCeNSJ0qtky6x5nRa
	8kHHPfRVtdYOjj5aI/fxWHSDypOawBjXjd+asw8mys0PcX0Vc8c7XASu1eZC3qt7PngTkkZ1nxzGq
	kGFkdtg63vEEGnjaeuYAAjTUurHJDo9mnW0ofEYxNsVvKEDXbmjuJmOWQDs494gIsoah1JWuQpI4V
	bWSFipWf2u//ng+3KHQVKsJz5ZCxV+BBUkaRWYnLJlRC9uXFWliYif8pg6/7QrH+h6mNhuNuBaefT
	o8m2mUFA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyKpG-000000058gY-2yd1;
	Mon, 24 Aug 2026 02:54:18 +0000
Date: Mon, 24 Aug 2026 03:54:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: LongWei27 <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	hewenliang4@huawei.com
Subject: Re: [PATCH V2] kho: Convert error handling to immediate return
 pattern
Message-ID: <aouyWs39qxGI7CP0@casper.infradead.org>
References: <00c96a62-f783-497c-a7ac-1de495e4af06@huawei.com>
 <20260824024448.550552-1-longwei27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824024448.550552-1-longwei27@huawei.com>
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

On Mon, Aug 24, 2026 at 10:44:48AM +0800, LongWei27 wrote:
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1438,20 +1438,34 @@ static __init int kho_out_fdt_setup(void)
>  	int err;
>  
>  	err = fdt_create(root, PAGE_SIZE);
> -	err |= fdt_finish_reservemap(root);
> -	err |= fdt_begin_node(root, "");
> -	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
> +	if (err)
> +		return err;
> +	err = fdt_finish_reservemap(root);
> +	if (err)
> +		return err;
> +	err = fdt_begin_node(root, "");
> +	if (err)
> +		return err;
> +	err = fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
> +	if (err)
> +		return err;

Less verbose:

 	err = fdt_create(root, PAGE_SIZE);
-	err |= fdt_finish_reservemap(root);
-	err |= fdt_begin_node(root, "");
-	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
+	if (!err)
+		err = fdt_finish_reservemap(root);
+	if (!err)
+		err = fdt_begin_node(root, "");
+	if (!err)
+		err = fdt_property_string(root, "compatible",
+				KHO_FDT_COMPATIBLE);

up to the maintainer which one they prefer ...

