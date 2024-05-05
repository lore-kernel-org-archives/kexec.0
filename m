Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601E3C4345F
	for <kexec@archiver.kernel.org>; Sun,  5 May 2024 07:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+V+GAoX0KUy7keOn/wtnyxxhgd+EWa+3wghmdEdNqPI=; b=AYdtBB0XGaBOES
	ZRCxNjCtICR6cuBrg+TbMfdu3+l4AqCItVyi8lDPIZFHNIMMqFgkM6rVdFQbHg8su5nHMy2e4/hVo
	1zgMCNZxkbpcFgmdhXt4h+Q00BhQw3M6+IQmdufBVRNT3WG47XUBRdkgQyQHUjsTbONGuRIxSZMxB
	AzSalMtQFqeAsMRoKjIB00CCfpoGrwbvqoRHy1wigHTI96lQsuDICxeGLhtXLJ+mzKpaGgUfHld1R
	By4mMCjeDFVHHs2ILpFCTJUF5VBi/JnLXO4YW3lL7W8tTXzEBK/Zw4pSkMPKVZfDpEGuxKPLyKYeh
	7GDbZBtKVWDCF3tydjpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3Vw5-00000003l6w-2JdF;
	Sun, 05 May 2024 07:05:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3Vw1-00000003koi-0YW3
	for kexec@lists.infradead.org;
	Sun, 05 May 2024 07:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714892596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S52qHVoar7wlTTIceOF47yDBu4Qxt+6rlWLzG9qUz8Q=;
	b=h7JQXwiH5ChgP39O9T4YYIBw0c//rHDUW5DFwh5zUvIfPhAO12K1tBpt6rvDdN+3oHo2pA
	FXup6z8SAmYC6QxJWou+mCvIVk6A25I9zyLzsto/M8FZfwARE6pIrgWVQfQ3GwUr1IqV7c
	0bzByAHL8lgWIXkRByoCqqaJ3qo/qkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-3gqcqRtTPkC4Q8LzzG5xBQ-1; Sun, 05 May 2024 03:03:11 -0400
X-MC-Unique: 3gqcqRtTPkC4Q8LzzG5xBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74A49101150D;
	Sun,  5 May 2024 07:03:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F65C13FA1;
	Sun,  5 May 2024 07:03:08 +0000 (UTC)
Date: Sun, 5 May 2024 15:03:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] crash: Remove duplicate included header
Message-ID: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
 <20240502212631.110175-4-thorsten.blum@toblux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240502212631.110175-4-thorsten.blum@toblux.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_000521_260994_B119BC89 
X-CRM114-Status: GOOD (  11.63  )
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

On 05/02/24 at 11:26pm, Thorsten Blum wrote:
> Remove duplicate included header file linux/kexec.h
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  kernel/crash_reserve.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index 066668799f75..c460e687edd6 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -13,7 +13,6 @@
>  #include <linux/memory.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/memblock.h>
> -#include <linux/kexec.h>
>  #include <linux/kmemleak.h>
>  
>  #include <asm/page.h>
> -- 
> 2.44.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
