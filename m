Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1062AC43334
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2jGT8IyPLJHbbzMYYVGk/rezsMBDv+M57l3yC619FDM=; b=E3LHkL8+eGH4AY
	pCbUzUhmNbfVt3VIsKrF1wyBOHG7wrEHjfy8IzkKDg5o4KusPMhSpYFrgcQG4ragyNZPC//91q6e9
	emb3xzTkUoLeqLt5VPgvkv6QZDx00v5U+vNCH/v8ntsHJqezgeUWwGtDkvbNn3QqP+7w9zHxajLyY
	0sYoF1warl8ff6XbJVI/lfJ82cFdUzLBnmS2FXKSsEckMcrfMVTbAaFgDZCyhuGiAnDLdqqVJ2l4m
	MrveuHcpFcxuk+dkrOX8AObmj2P6d7VTF+fwIp3vCXuGF2fl42iglIKcAUdeH3EY88EYVo6wU0l8k
	0crXCN4DBZ2DTkFKNLeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9jSY-002aZO-Tl; Fri, 08 Jul 2022 08:35:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9jRv-002aGQ-0X
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 08:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657269292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OP4X7LUwgicK2Z8iBMF1E87pgvSh5qnsKOoxYGUrQZE=;
	b=WTXE9QpcWj/4hSJCuvEnauYTvICvnfumdBI0KEsZSuJuHWIZg+M6+eFxGdVZrl4u7wOMdg
	3Kyzugz4dK+gVYAV6wMa6ZzFWpDiDOMrqSg7VjEFY/FFRxv67m+zKdDdyEK1ttlS8C2Anh
	V5OVwB+alVKQPytupjiDcqbEg9bAmxM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-YLkXHmJ7MkK83y7yYijfCw-1; Fri, 08 Jul 2022 04:34:48 -0400
X-MC-Unique: YLkXHmJ7MkK83y7yYijfCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C18123C0ED4C;
	Fri,  8 Jul 2022 08:34:47 +0000 (UTC)
Received: from localhost (ovpn-12-169.pek2.redhat.com [10.72.12.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E662166B26;
	Fri,  8 Jul 2022 08:34:46 +0000 (UTC)
Date: Fri, 8 Jul 2022 16:34:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Jianglei Nie <niejianglei2021@163.com>, akpm@linux-foundation.org
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/vmcore: fix potential memory leak in
 vmcore_init()
Message-ID: <YsfsIzjmhR5VQU3N@MiWiFi-R3L-srv>
References: <20220704081839.2232996-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220704081839.2232996-1-niejianglei2021@163.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_013455_161643_BB0F417C 
X-CRM114-Status: GOOD (  19.52  )
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

On 07/04/22 at 04:18pm, Jianglei Nie wrote:
> elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
> kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
> predefined value. If parse_crash_elf_headers() occurs some error and
> returns a negetive value, the elfcorehdr_addr should be released with
> elfcorehdr_free().
> 
> We can fix by calling elfcorehdr_free() when parse_crash_elf_headers()
> fails.

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  fs/proc/vmcore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 4eaeb645e759..86887bd90263 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1569,7 +1569,7 @@ static int __init vmcore_init(void)
>  	rc = parse_crash_elf_headers();
>  	if (rc) {
>  		pr_warn("Kdump: vmcore not initialized\n");
> -		return rc;
> +		goto fail;
>  	}
>  	elfcorehdr_free(elfcorehdr_addr);
>  	elfcorehdr_addr = ELFCORE_ADDR_ERR;
> @@ -1577,6 +1577,9 @@ static int __init vmcore_init(void)
>  	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
>  	if (proc_vmcore)
>  		proc_vmcore->size = vmcore_size;
> +
> +fail:
> +	elfcorehdr_free(elfcorehdr_addr);
>  	return 0;
>  }
>  fs_initcall(vmcore_init);
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
