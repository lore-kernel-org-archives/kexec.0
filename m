Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9DFC001DC
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 04:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HGChRxxWKdiF0Utk4gFr52fC5m+TaC2I+WN/D4Cm3ok=; b=nnQoaPMmgelQby
	8mv0KUXzq0X3PEDF5LNMAX8gp/w37fkHBftzcBm1eqmqZfXZInjQ5xogS3jgKSsZjGjrzTUIdmOrS
	GMcc4IJJF+F+UBh5iFr1NW7C9vjQDRM5n/Ar0LR1vv12zpOxJDn84bRJFa0Jnqw6n4Bn1OgAzKi83
	gETyFA5yPFJYl+mDh9KFDoxUgI9mXcKc/SzCfchZi0p/J4liraFUwnKokXOWBmxGW7WMYL5MNJ6HR
	S4zvhdimM30jjrSBfiuqB6WRNihXa++92A+/aREG+UfT20JORwkBjeQETRJo3DXC9ZV19H0RrHqsv
	c+c2em43IGUkyLSWHMlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOVrE-00965a-0l;
	Wed, 26 Jul 2023 04:10:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOVrC-009657-01
	for kexec@bombadil.infradead.org;
	Wed, 26 Jul 2023 04:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uMDpXai9jnzcyG1+E1KFnjBJUtDKa0sU3l3aqJf5M+Q=; b=dGXA4NWGVTSoEmqk20tITHiyuE
	lPYPO6433XZ4tnt3t48LsE+d/4VpNeS7oM84J6y+thfwX/XPYruwCi8vYRFHLt+GjDjCiHIw3MOf9
	B21S3QCJnJSQVU4cmVrMA6Jwxia0nG8m3HOCU5rdRiQ6gG8soU8Qjqj6y1ihQKybMrEnsXy7uw3aa
	oXjrcZqWY8VGbOpl7xebCsuPS5dZaIJp1WF6eVY2mca4sqyVVYH3Qi1HU8k9pMX8ZE1Qa7nutJJ21
	vKLYSH4ku2imUu6ZYo8rdtqCTm83go7AEUCC1l8bmHLUIc2eqRqhsJg0vXj9KOvIgeUc85oxV/W6D
	EOVARvtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qOVr9-0069Nf-DF; Wed, 26 Jul 2023 04:10:35 +0000
Date: Wed, 26 Jul 2023 05:10:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] proc/vmcore: fix signedness bug in read_from_oldmem()
Message-ID: <ZMCcu9KHh0uC2VFq@casper.infradead.org>
References: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b55f7eed-1c65-4adc-95d1-6c7c65a54a6e@moroto.mountain>
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

On Tue, Jul 25, 2023 at 08:03:16PM +0300, Dan Carpenter wrote:
> The bug is the error handling:
> 
> 	if (tmp < nr_bytes) {
> 
> "tmp" can hold negative error codes but because "nr_bytes" is type
> size_t the negative error codes are treated as very high positive
> values (success).  Fix this by changing "nr_bytes" to type ssize_t.  The
> "nr_bytes" variable is used to store values between 1 and PAGE_SIZE and
> they can fit in ssize_t without any issue.
> 
> Fixes: 5d8de293c224 ("vmcore: convert copy_oldmem_page() to take an iov_iter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
