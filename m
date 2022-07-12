Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8857AC433EF
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pH68kWgy3+oKvTzeKArAuZZb8HonzupcBN6BqpBV3vc=; b=Db3kIhijJu01+V
	yUbCWr/hK9rknlNZEU/Y5MkykzRiAJ3nl34DJxdrMkVIlq0EL3nvnL91u/sINSR1HPOIzd8JSctIt
	rlE8WxAfoJrtL/W9lTKydzdLmClGi5RhLGutryIILyq7qn9LSxaB0WCyVRO8AajnaJMa+qkxt/Khv
	RkYrioYx4wnCBvt6UIsgeQwfdCusjFUKITOHKw57A20a5DvAU2CNYGKu9HGxg5oJgW+tYrB3rnfBJ
	Cerb8xkLm40bk8W+WhF36CtVJU9CC5N5lkVtLnChLD3vmLfGWhgTxBfTlPAt8z7fCRHwZMNFMjVbU
	lBrkK0JD81dA/igE6OFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB4gQ-006S3k-BE; Tue, 12 Jul 2022 01:27:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB4gO-006S1E-2y
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 01:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657589238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJoHVsOF3Ns0hbojCVbv8KvE/Pi32b6Sl12+Q0qK9b4=;
	b=hIr8Bylwm5oPtmswaztPXxinqQf+8Pl4Ap/6J5VPrWHWgUKrEl3SD8zSlRffB/lDhEk3PG
	V7zk7vHd9VolB0FLskBU/MZJV0hyJwaHAZOcVoN/dritFHhmLARRYxTsNN9Uvk/26lFOp4
	k+WU1lnyBWbTyk4g0lW+KmibE4xptUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-d6BUpj6FPxK4lPKnQ7Ting-1; Mon, 11 Jul 2022 21:27:14 -0400
X-MC-Unique: d6BUpj6FPxK4lPKnQ7Ting-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2AF811E81;
	Tue, 12 Jul 2022 01:27:14 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF9340D282E;
	Tue, 12 Jul 2022 01:27:13 +0000 (UTC)
Date: Tue, 12 Jul 2022 09:27:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Jianglei Nie <niejianglei2021@163.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v4] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YszN7VTPBMVniIz9@MiWiFi-R3L-srv>
References: <20220712010055.2328111-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220712010055.2328111-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_182724_226560_A0385A01 
X-CRM114-Status: GOOD (  21.02  )
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

On 07/12/22 at 09:00am, Jianglei Nie wrote:
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value. If parse_crash_elf_headers() occurs some error and
                                                 ^ s/occurs/gets/
                                           occur is intransitive verb
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().
> 
> fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> fails.

  Fix it by calling elfcorehdr_free() when parse_crash_elf_headers()
fails.

Other than above log concerns, you can add my ack when repost:

Acked-by: Baoquan He <bhe@redhat.com>

Note:
- Please also add change history so that people know what's happening
  during reviewing. For this one, you can skip it.
- remember adding all people involved to CC.

> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/proc/vmcore.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..390515c249dd 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1569,15 +1569,16 @@ static int __init vmcore_init(void)
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
>  		pr_warn("Kdump: vmcore not initialized\n");
> -		return rc;
> +		goto fail;
>  	}
> -	elfcorehdr_free(elfcorehdr_addr);
>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  
>  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
> -	return 0;
> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
> +	return rc;
>  }
>  fs_initcall(vmcore_init);
>  
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
