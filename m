Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ACEC7EE23
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tb95CV7dYiEjubVwTxjwr8GD+z9pOoP6t7vFIuigMOE=; b=GtkL6kplVXfj2f
	5IiI4yzQ5BfBx+uH0gZ+roLR19VQrkdciyEFF5W543yZvdEP/1m2FvcV7AvXwk2sCoxek8c3hMPwd
	QwD8eb6ynEtEM4kOmbs8brV2crzbkxIYLX4gXQEbOp4FIlM0KJEMlNu2JyAJB/vuRmVYvuxwVpk5E
	+2YZtOYTWFq5Y5JzgC1zyjimxV8PlacBdV2pntib159YyiljXltLx1kng+pEbaXWHL2JhiGsTvrWR
	pl7Xx4gDFRvMhp8eWMb/IF6pnnYd6B8H4DxWXzlTCUtdaVqGHMMdus+Xl0GfB+8tsC34THnUrj7dd
	QowIpe7M2tXJYfQX2MnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4fjJ-0035ms-0a;
	Thu, 01 Jun 2023 10:40:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4fjF-0035lr-2F
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 10:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685616024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UiSS9nj6xH+Um2NERpCFyQMVz8ELBfz4b0zRoYrjHKU=;
	b=UieOMlQyOsx7eEMqGI1NKfGUmNJWMIZVjuBwpZkpU7Owkn7Z3xXDfDSp75dd7OFkxwf4ut
	bX21nLjK6UA/mDDBZcDzkLIdE3LYM/BSPMCDiNaUEQkEHqNZEwnh2RFnI5/xCIFllm0LzC
	IRBgVs+BejOlrFuiHzlxkAO0rYPirjY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-CsHaACKPPbm9rtHrH7kkMw-1; Thu, 01 Jun 2023 06:40:21 -0400
X-MC-Unique: CsHaACKPPbm9rtHrH7kkMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD136280AA26;
	Thu,  1 Jun 2023 10:40:20 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D0A8162;
	Thu,  1 Jun 2023 10:40:19 +0000 (UTC)
Date: Thu, 1 Jun 2023 18:40:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Avoid calculating array size twice
Message-ID: <ZHh1kBxfOf6hCvo8@MiWiFi-R3L-srv>
References: <20230525-kexec-array_size-v1-1-8b4bf4f7500a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230525-kexec-array_size-v1-1-8b4bf4f7500a@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_034025_808544_5702C24F 
X-CRM114-Status: GOOD (  18.23  )
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

On 05/25/23 at 04:26pm, Simon Horman wrote:
> Avoid calculating array size twice in kexec_purgatory_setup_sechdrs().
> Once using array_size(), and once open-coded.
> 
> Flagged by Coccinelle:
> 
>   .../kexec_file.c:881:8-25: WARNING: array_size is already used (line 877) to compute the same size

Amazingly smart. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  kernel/kexec_file.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f989f5f1933b..3f5677679744 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -867,6 +867,7 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  {
>  	unsigned long bss_addr;
>  	unsigned long offset;
> +	size_t sechdrs_size;
>  	Elf_Shdr *sechdrs;
>  	int i;
>  
> @@ -874,11 +875,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  	 * The section headers in kexec_purgatory are read-only. In order to
>  	 * have them modifiable make a temporary copy.
>  	 */
> -	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
> +	sechdrs_size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
> +	sechdrs = vzalloc(sechdrs_size);
>  	if (!sechdrs)
>  		return -ENOMEM;
> -	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
> -	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
> +	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, sechdrs_size);
>  	pi->sechdrs = sechdrs;
>  
>  	offset = 0;
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
