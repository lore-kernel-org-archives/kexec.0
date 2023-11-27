Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C44C07CA9
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 02:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5cJ4kVor4UE4rAfql6WpgYhP2ZPeL/t3RuMga5uBSbE=; b=jrX3cMVU+Jn2gH
	PlJhrxGrlsth49R7tjFFTO1qTBrOwdgxw2+GiOc4lxkeDB43aG+ly0dJOBkfuxB1RJfL5GlQclF3q
	8vMFGJKMjoMzP+mtS+RuT/1kwY/6psl+A5tTVeAGEvuOgskKUXpEq170j+2Pj9VmeKzFFFPYSqCnj
	Jeg8mCdnNBuzUxXkMVhwO/qsaoFy41E85Ovve/NWysysQMjHG6XM+tjnm78l2FcJ3+XeiepCpWqNn
	VH5c6TW/PXe9e1T63x8dt4j+ljZdSepGuiGt5+Xg6N/BwcweYQa7CjxBjnYJTEjk1gK4k2fBBeHCu
	t6lMqbGWziJuL7Y2hCew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Rj1-000xxh-2P;
	Mon, 27 Nov 2023 02:51:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Riy-000xum-0c
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 02:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701053511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKWQaEsR/p/IgYIkhOghvk9JdKsTzVVqrJ68PyhT4Os=;
	b=BO+Ykn0Q7PRZbuvtzHrHmKXBG0Gf02B92fD4BQfVpdt+uhQvsI39nTjl7Z4UckdRol8+B3
	gKsDU+Tc5TMeh1076PdbvC4jO+U5qRVLn3zNAt+9tos2lpzfaLbW2LRSXlyZeAJNKATTc5
	xk/hG4q6SAqhIb/fXQALHqS3FOWfFD0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-YUiZv4FFMWGxnDQun8zWTg-1; Sun, 26 Nov 2023 21:51:47 -0500
X-MC-Unique: YUiZv4FFMWGxnDQun8zWTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1588A852AC0;
	Mon, 27 Nov 2023 02:51:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A30E1C060BB;
	Mon, 27 Nov 2023 02:51:45 +0000 (UTC)
Date: Mon, 27 Nov 2023 10:51:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: k-hagio-ab@nec.com, lijiang@redhat.com, akpm@linux-foundation.org,
	vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
Message-ID: <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231127020727.25296-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_185152_350811_2CF7E608 
X-CRM114-Status: GOOD (  16.70  )
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

Hi,

On 11/27/23 at 10:07am, Huang Shijie wrote:
> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
> and kernel will not use the "classic sparse" to do the
> __pfn_to_page/page_to_pfn.
> 
> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
> This makes the user applications (crash, etc) get faster
> pfn_to_page/page_to_pfn operations too.

Are there Crash or makedupfile patches posted yet to make use of this?

> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  kernel/crash_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..9653c4177191 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -765,6 +765,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL(mem_map);
>  	VMCOREINFO_SYMBOL(contig_page_data);
>  #endif
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	VMCOREINFO_SYMBOL_ARRAY(vmemmap);
> +#endif
>  #ifdef CONFIG_SPARSEMEM
>  	VMCOREINFO_SYMBOL_ARRAY(mem_section);
>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> -- 
> 2.40.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
