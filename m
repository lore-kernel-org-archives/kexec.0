Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB9BCA101E
	for <kexec@archiver.kernel.org>; Mon,  2 Sep 2024 03:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=14v9e1FmmFsKYBqIZPAmaILKdsjUApwf2m7NmIz7UtE=; b=CW9T9ef3AipjAf
	/yQSyYnZFHOBMXdmZn6Rl8oafrUhV86kG13iTnqkOZLRShgmqrS6NDK5+sxRkxqHJmN62USrCHBMu
	mLsYwzeKEGNP0rAxl7cq91jO3nt3e5XWJE7+9gKoZnOi+Q+pDTu+ZVmNk5MNeevS7ipV/MesSZ5qO
	/Y019O9zx7iYwlO/FnJk87IkI1Rtt092Qb/QwmuX5nsCC4BlFOx010YY9Yy5OvORmTReFzrIX9PSc
	I9EkU1YacrjCZWdE0XbQjCD73AHzN9NRyJZZmBEIQBhx0LXQ58lU994gailxdmpJLnunAias70y7E
	dT1df0IVtjES9+gCu0Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skxNf-0000000Colk-2V9q;
	Mon, 02 Sep 2024 03:05:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1skxNb-0000000ColF-2pNp
	for kexec@lists.infradead.org;
	Mon, 02 Sep 2024 03:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725246321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/wSjolqkdgtanP1gHe7DoyJjSl0u2RbxSmbePTYD+6I=;
	b=IEPv2h58EMWcJuba8LQ/pYBfMDi8szUBbqDgMiK5L8s+FbirzvBp0phUJeBpZ88iFT46w3
	BLFu/rlhmQjNv5Piu/5kqhueWY3KWXTFHk6xoi6cwBot7ZDizJfbA+oZwl9LMwPwQgpbrw
	8C3y7GBPUrD6qkoP9K6zWf7LPrXFkDQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-QtgqlzQbOqKpg5gH5i3qkw-1; Sun,
 01 Sep 2024 23:05:18 -0400
X-MC-Unique: QtgqlzQbOqKpg5gH5i3qkw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE2E719560B0;
	Mon,  2 Sep 2024 03:05:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1A9919560AA;
	Mon,  2 Sep 2024 03:05:13 +0000 (UTC)
Date: Mon, 2 Sep 2024 11:05:03 +0800
From: Baoquan He <bhe@redhat.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, vgoyal@redhat.com,
	dyoung@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
	kernel@gpiccoli.net, kernel-dev@igalia.com
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Message-ID: <ZtUrX4n+HPYhyQ9z@MiWiFi-R3L-srv>
References: <20240830182219.485065-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830182219.485065-1-gpiccoli@igalia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240901_200523_813851_874602E6 
X-CRM114-Status: GOOD (  22.08  )
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

On 08/30/24 at 03:21pm, Guilherme G. Piccoli wrote:
> Be more clear about the downsides, the upsides (yes, there are some!)
> and about code that unconditionally sets that.
> 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2: Some wording improvements from Stephen, thanks!
> Also added his review tag.
> 
> V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc52ddc6864..351730108c58 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -913,12 +913,16 @@
>  			the parameter has no effect.
>  
>  	crash_kexec_post_notifiers
> -			Run kdump after running panic-notifiers and dumping
> -			kmsg. This only for the users who doubt kdump always
> -			succeeds in any situation.
> -			Note that this also increases risks of kdump failure,
> -			because some panic notifiers can make the crashed
> -			kernel more unstable.
> +			Only jump to kdump kernel after running the panic
> +			notifiers and dumping kmsg. This option increases the
> +			risks of a kdump failure, since some panic notifiers
> +			can make the crashed kernel more unstable. In the
> +			configurations where kdump may not be reliable,
> +			running the panic notifiers can allow collecting more
> +			data on dmesg, like stack traces from other CPUS or
> +			extra data dumped by panic_print. Notice that some
> +			code enables this option unconditionally, like
> +			Hyper-V, PowerPC (fadump) and AMD SEV.
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I know Hyper-V enable panic-notifiers by default, but don't remember how
PowerPC and AMD SEC behave in this aspect. While at it, can you add a
little more words to state them in log so that people can learn it?
Thanks.

>  
>  	crashkernel=size[KMG][@offset[KMG]]
>  			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
> -- 
> 2.46.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
