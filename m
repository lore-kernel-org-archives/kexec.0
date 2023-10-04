Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985BE7B5F9
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=96UJu0OqwMAGUManNi5boa/0aLwbO7i7zLjZUVFio7o=; b=05T65Dy2rfWvZe
	tH0S6juRycUQP30RCK+j4AAfc79llTj1LkaR8/cgaFH6xmO1DvL+qe35MShqjnS+ndaPU0YETAjHw
	M+bHpBhd0KJURqOpIdd/4vL4CYXUXqEoIeJaXDLS3qpqpJo9a1p6DloQRhi94peu27NUaAWltK1iX
	v2iwOD9XjonZ1MS2nHQCGfu3svNme4SJuiZxJngysvz0tz8H3HtERDYNQczDwZ2je+KLPi3p0mHxg
	nXK2gvJ1eTPt7ZlvvzjeL0K4P1zd17nvzvLkL8EUF8K+NBmmWM4shGjV+NPErZpoCrmoWQEP4vNbX
	admcNd8147WOgroKGOqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0Um-00HX56-0e;
	Wed, 04 Oct 2023 11:56:52 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0Uh-00HX4g-2n
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 11:56:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8443ECE16B9;
	Wed,  4 Oct 2023 11:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38A1C433C7;
	Wed,  4 Oct 2023 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696420602;
	bh=gbqzfYvu/po9xwlzxBx9kQz7uDmH7lN2c/GRHLeQiKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2N3nei4E8lhr94URMceM3V80NSfwaYchp1R9uKg9fgJu1dRyc2/yd1yDaqVmipFC
	 Xbq+70+r8EosXr7hxQMi05TNjvWKRymo7gYMkGYuWxgod8eGdA+MAmDKomb9WXjau/
	 qDS1j/wa7kwWrvoAbb6TzwL0imueC+wjxm/atqZW48lks6WEmxvax17KfZXUYkr1Cc
	 id+t5/4G1PvFSJC/v9BSvXeDqEmQ8ETrFV7122aDVb50uzeHt6Wc71f2lmAXhdzchF
	 H4o9sTMgfBt82uH87Dp9aZKLnDCWwPrMrL5Mo8SgBqoEUdpH1I6amCvI6MKg8qJVFr
	 7M35/2swXOw1g==
Date: Wed, 4 Oct 2023 13:56:39 +0200
From: Simon Horman <horms@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kexec: update manpage with explicit mention of clean
 kexec
Message-ID: <ZR1S96fpn29YUElJ@kernel.org>
References: <20230920115927.1087546-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230920115927.1087546-1-hbathini@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_045648_103645_2298070F 
X-CRM114-Status: UNSURE (   7.73  )
X-CRM114-Notice: Please train this message.
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

On Wed, Sep 20, 2023 at 05:29:27PM +0530, Hari Bathini wrote:
> While the manpage does mention about kexec boot with a clean shutdown,
> it is not explicit about it. Make it explicit.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
