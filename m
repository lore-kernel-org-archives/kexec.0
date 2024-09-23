Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B9BCF9C6E
	for <kexec@archiver.kernel.org>; Mon, 23 Sep 2024 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FCFrUcMaCrHtzfC7chdZO/LlRZCGbci7up9qZGk5B3w=; b=tEYP2x898Vpc+v
	HzgUD9NBtxI5to8N8aUmpJz4JozBeboVDBHF7qVQF0vkdm+oUOd53XcUs6cVM6KXLiuiDMqvdVlpV
	NEyScFb3/3fhqoCn96GxqCsguA9ovkKa2h1uUyQiEmuGAgjGSMgO46el1WwedWGxE/wk7fCHQbXfz
	VuiQXngarW0TUHJN7uT/GnlmH3QngW5I/ZB8+lVsXK2l6r+eHzkMg5sJkqnQq8+XTDVm/qof9QQL9
	5OrClrfG4a6zOhgx5Dbg/EKt945ecbEpss2DoZn6FANeDoQgpzc8uUlQibvvTP1B4ln9xIo1JQ+Ek
	gbVLDRRLtaRslJt7te5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sshXQ-0000000H6Ew-0cpy;
	Mon, 23 Sep 2024 11:47:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sshXL-0000000H6EE-3PtV
	for kexec@lists.infradead.org;
	Mon, 23 Sep 2024 11:47:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727092045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPM5NqhxiueDZbMDQgj67jymiFOgjoYWmm3KSAJSOAU=;
	b=F5Mvf7oNkrS0fdPRBLkQBRHpHv23cWMoQx5Qm6G61J//J/lG8xR6jikf51977X2fvhaFKz
	POET6Kfw+RWR/rxrnFCRiGFzwP6d7TpcnZEolPPN1WHtOGDRLN90e/b1hXvBe6q0HYSgZe
	fobly6KwTNZ3U7sIYiGoowm/xcuj4mw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-RJ8c6EPGOXKdXbs5t8-6bA-1; Mon,
 23 Sep 2024 07:47:22 -0400
X-MC-Unique: RJ8c6EPGOXKdXbs5t8-6bA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FE88190C4D9;
	Mon, 23 Sep 2024 11:47:21 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.109])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C78619560AD;
	Mon, 23 Sep 2024 11:47:19 +0000 (UTC)
Date: Mon, 23 Sep 2024 13:47:16 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: kexec@lists.infradead.org, Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
 Kazuhito Hagio <k-hagio-ab@nec.com>
Subject: Re: [PATCH] Submit physical address to is_phys_addr()
Message-ID: <20240923134716.2cbc107c@rotkaeppchen>
In-Reply-To: <20240913143500.3615218-1-agordeev@linux.ibm.com>
References: <20240913143500.3615218-1-agordeev@linux.ibm.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_044727_967681_A6D943E6 
X-CRM114-Status: GOOD (  17.65  )
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

Hi Alexander,

On Fri, 13 Sep 2024 16:35:00 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> ELF program table virtual address is submitted to is_phys_addr()
> function, most likely as a leftover of replaced is_vmalloc_addr()
> function, as result of commit 2e452d75fa78 ("[PATCH v3] Enable
> --mem-usage for s390x."). Submit the physical address instead.

is the patch supposed to fix the bug with /proc/kcore I reported? I
gave it a try on a KVM VM and it's still failing...

Thanks
Philipp

> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  elf_info.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/elf_info.c b/elf_info.c
> index bc24083..7f3d053 100644
> --- a/elf_info.c
> +++ b/elf_info.c
> @@ -765,7 +765,7 @@ int get_kcore_dump_loads(void)
>  	for (i = 0; i < num_pt_loads; ++i) {
>  		struct pt_load_segment *p = &pt_loads[i];
>  		if (p->phys_start == NOT_PADDR
> -				|| !is_phys_addr(p->virt_start))
> +				|| !is_phys_addr(p->phys_start))
>  			continue;
>  		loads++;
>  	}
> @@ -786,7 +786,7 @@ int get_kcore_dump_loads(void)
>  	for (i = 0, j = 0; i < num_pt_loads; ++i) {
>  		struct pt_load_segment *p = &pt_loads[i];
>  		if (p->phys_start == NOT_PADDR
> -				|| !is_phys_addr(p->virt_start))
> +				|| !is_phys_addr(p->phys_start))
>  			continue;
>  		if (j >= loads) {
>  			free(pls);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
