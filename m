Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16132CCFA04
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=vpHpBk1jVIzuo/vn/Uvc4xurVlKMfbzNWNKTG/YZBC4=; b=XB9FNuhHbLRD7x
	OOsG3k11Rot7x6V4NSxA/OEQO3HreoZmf4wZpzS/IAT+XYtFyFiOw58N0AZ94oMIJgfqkuI90O0o3
	Vyuo8PG35u8Cs47CnRw778nUGC8UClS/OoKx/2CK8kgE76M4C8QFASsfc5gQr/lg+KAlmnhapk+3Y
	r5wZHvXwAeLIdy4mfVe+dGhxZHEtLFd9HubnoJyIeeA5dApKzMJYYrK9KY2BP1exASjtpzeKZTBs8
	RFBT8AjP/zJesJAZNdzoHOd712vLf7d8E7JatLTJTjcEfGSNuXZH+nnzN3XKco0mvgNXvSzjTWi2J
	aDDYpiwO8Ck+jJWFa0qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIov-0000000C3gY-0UkT;
	Tue, 04 Nov 2025 15:19:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGIot-0000000C3gN-09r4
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 15:19:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1958460208;
	Tue,  4 Nov 2025 15:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1229C4CEF7;
	Tue,  4 Nov 2025 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762269577;
	bh=k4PWSdB9JPNF7dXkmlfgfPVWmRMPLaoLYeVYkmcgX84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YgXbrbawniJRA9mTXZfrvv5psDoKlD7p+oObyOArVrlKfTcatyvO2l4qVYgABbbWQ
	 GJBxUFaKXE+wRxy5wEYzPDSe6eZMjxsxNBSdF13Y7XI3F7C13mzlAdwnGAc8pjtrN3
	 lBoeGx3EkOaCwkEPrq2RhAOnMeVe0NyNj4/h2OLTknI6WkeEgdMCZvAelv7S118XkH
	 vOUgDqW5UXLG2gBBloPAiik4dkDFfJxdCriAO+w28cllo2sIUcr0SbXz4FZPTsGG+f
	 kuWp5LWxjzuZNuZBjZul4Qk9XB7BlWnPz149vmNlPdlFQrjc2c22oyXCA5nb+5/IV8
	 rKXN9Uac8PHlA==
Date: Tue, 4 Nov 2025 09:19:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: extend file entry in KHO to include
 subdirectories
Message-ID: <20251104151936.GA1857569@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Nov 04, 2025 at 03:32:38PM +0100, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 3498209ff64e ("Documentation: add documentation for KHO") adds the
> file entry for 'Documentation/core-api/kho/*'. The asterisk in the end
> means that all files in kho are included, but not files in its
> subdirectories below.

Add blank line between paragraphs as you did below.

> Hence, the files under Documentation/core-api/kho/bindings/ are not
> considered part of KHO, and get_maintainers.pl does not necessarily add the
> KHO maintainers to the recipients of patches to those files. Probably, this
> is not intended, though, and it was simply an oversight of the detailed
> semantics of such file entries.
> 
> Make the file entry to include the subdirectories of
> Documentation/core-api/kho/.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06ff926c5331..499b52d7793f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13836,7 +13836,7 @@ L:	kexec@lists.infradead.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  F:	Documentation/admin-guide/mm/kho.rst
> -F:	Documentation/core-api/kho/*
> +F:	Documentation/core-api/kho/
>  F:	include/linux/kexec_handover.h
>  F:	kernel/kexec_handover.c
>  F:	tools/testing/selftests/kho/
> -- 
> 2.51.1
> 

