Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2256DC4167D
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 03:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CIT8tUgIxFILCq4kh7Ru+vhjQbjxi8mAvSe14v69UU0=; b=pUWa7LUp51TnP0
	nCzf47fLhWnRYTJ64fusNm1elN/ONz1aF6c/BWqPbp999j+FUaFYwC5y3xu7sw3vUCkkXpSBQSZ90
	w9F41TLLroiL5ht53PEFi9R41IXwoVqTDos1qadCiSIzRlTRccSUTyznSQIoNdEKYF+Zo1h5Sy2qB
	U1kIfyVi1d8UtEIyoAhY+Ko6UGBcsYOr0hFvXS9a9rybKhYPAJFsbWqYK8F0CT7p4W0/UyYMSpvjJ
	8q3ZnUvrRlIqjLDMohBqJ8Y20Ub4oQ4vhX8ClA3gvyik2dNX4xjPdm2qOJ32rpS58D2De/Mh73T85
	RsG3Vl9FSXLML9v3VJFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDys7-001u5Q-2F;
	Fri, 15 Dec 2023 03:28:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDys5-001u4n-0J
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 03:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xFjrY9f7lb5ZXGSC5fJ2WhnwT5x2Q7SVpnoNQJclmZ8=;
	b=Ag7eCNfJnFUqTbKaQgnwe3SeDQ/wQghhy3IW93Gmneg+ooJEYp49ci1rrG4X1v9BwKL8i5
	w+0gr2eocBQI9JPXg9qt2xXprsHQ2wKwtMkBFHiDiaYhI++8rHBnVjxbvf2o9JioPXGMNW
	tMlj/u/Z6b6cWrc4MAjJ6qR0o3h6c44=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-NkTdKl5KPOucS2szYBp4IQ-1; Thu, 14 Dec 2023 22:28:12 -0500
X-MC-Unique: NkTdKl5KPOucS2szYBp4IQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 807EA101A555;
	Fri, 15 Dec 2023 03:28:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB362492BF0;
	Fri, 15 Dec 2023 03:28:10 +0000 (UTC)
Date: Fri, 15 Dec 2023 11:28:07 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH 2/3] x86/crash: use SZ_1M macro instead of hardcoded value
Message-ID: <ZXvHx+HYI4zgV47b@MiWiFi-R3L-srv>
References: <20231214163842.129139-1-ytcoode@gmail.com>
 <20231214163842.129139-3-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231214163842.129139-3-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_192817_203525_7CEFB8A7 
X-CRM114-Status: GOOD (  15.45  )
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

On 12/15/23 at 12:38am, Yuntao Wang wrote:
> Use SZ_1M macro instead of hardcoded 1<<20 to make code more readable.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  arch/x86/kernel/crash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 792231a56d11..249b5876e7ec 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c

Acked-by: Baoquan He <bhe@redhat.com>

> @@ -170,7 +170,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
>  	int ret = 0;
>  
>  	/* Exclude the low 1M because it is always reserved */
> -	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
> +	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
