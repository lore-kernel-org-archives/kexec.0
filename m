Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E21FFA0C20
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 03:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvazPg5VU+ff3GG9G9Sg7D1DK46/CfVYdvWCb3xkBOk=; b=2jzET3ZKYFVqoI0y6YdDP2D8Cp
	FHM/mEg3JJx5erfxcFjK1xh5MQsmDPo0US5tVq5tTqvXgJRKAOWX+hoXXafNBmzj4YJboMqUMn1sC
	vK5mbsmSiY3f8k6BuIzETg1eOND+E1cnmmbliCWyd3u6SlbH9dILdNRlPFCeCejzOjA0seEZeF++f
	RKmmCFl+JjPaChOxbtOIYMB1cRfimVtn3VugL1VsPbIggf7/1APSg+xTWl/TaQygyW1gLmYrmIWDg
	Uh26XfiEDa6E0Zz8N+Zm6rc/qNUcY2e1AtIvwdeHHjfyAolMn8RqplbFDJho69R/klM5uL5iiiLRB
	aTvZxrsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCr0v-00000000WZT-3nNE;
	Wed, 15 Apr 2026 03:34:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCr0t-00000000WYw-2BAR
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 03:34:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776224042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YvazPg5VU+ff3GG9G9Sg7D1DK46/CfVYdvWCb3xkBOk=;
	b=KtzsVMAal2TxQ9pUqMLyf8jOzXDbo5xx3pmQmbAjdJdfYFf78Mv+dhv7goIBOdnerlPKe5
	m0r3gXzFI+Vu8o+WOmZ4eIDCpM6exqwMJWDgi7nMsYRbnUEU2G/uXu8+5kWUi9SJ55OsgB
	a8lIDl87SvsmAwI8tX/Vh1U+FGnTzqs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-x4l1m6okOUaFoNQ-SjDO6A-1; Tue, 14 Apr 2026 23:31:38 -0400
X-MC-Unique: x4l1m6okOUaFoNQ-SjDO6A-1
X-Mimecast-MFC-AGG-ID: x4l1m6okOUaFoNQ-SjDO6A_1776223897
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38a1f798464so27217801fa.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 20:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223896; x=1776828696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvazPg5VU+ff3GG9G9Sg7D1DK46/CfVYdvWCb3xkBOk=;
        b=OkW+XTfuBGnBC7AFloxes+ziGLyyQIgj4wOi+YUvRd+iDAdZFxQF0F4YPXonrG+e2w
         pYf+PE6uJRdRjQvYrsZ2Di2Wxe7jYHaGx56/+06i6RirdMYAnV4JOPAiis8SgDVjL31l
         IYFDuvelR8o/0YGcRwIls33/pXAO3ZnMzIIBdiE5EzvJkkaeklsrVyKjRR36NSSZt24B
         SIdaTg8OT7HjxtYS33ISWy1EMdgwn31PmQ6opppUVbF2sSmbYXOqgg/hvnMTZEDyyfeX
         6g9w3h6ESK5gzm5CxGntacj7xpH44DSNUe26Q0wbued+4AeOL6KhFjcPv/wEefxc6lfI
         92bg==
X-Forwarded-Encrypted: i=1; AFNElJ/Fl5yHTj6ZuwHiml8y+bKcMAwAglWXrSHqPsHzV+y+pFZoSeNOtT+NmJ/jD0HtfGluq9zm1w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwskJNwgPwV3f4+DsBoKiUAGMMLqhwFpLQQqBrL4xJl59riO25N
	csomGHXHB6VqN7gbR4jW/IB8+Av7XKXMZCUmWP4ke3Cc+xRLfhZLTB7z4BGYCXyJWlrrJ+CCF/g
	/rr5ptAMBoVBOaRfX0BKPqWyWDNXO5zREVR5y360nr/uEcr+tRmtqt/9TAYPZssB6NteeqYkKOP
	lDTLYBbZI+X94M+S5SYJF9sDcxkD3Rz6OhrE4n
X-Gm-Gg: AeBDieszmMwrBj42jgA+ndNz3BsjjiN1Ke36Ws70N+gzkCmsBYSQan08T0gHxi0Oab1
	kIcfm+IFE7YxkijPANDZZG6/vPltCF7cAdBWxI+nLhlkcJUEnmhvnC/VqszE7zJwxyS+aKBak9N
	Xau/atPucyAm/KX7E5+eBw6CkC1zRzjVuLcXurUJ6Vv3jOLJe7ochEgGhQ5iv54IXsJpHg1tKrZ
	+HwXaKHboeuuikPgXf4jbLrTCxKjcsKXa8XBtK+jMv4IqmCi99LSFJ6Cr0gMbU7/jXB
X-Received: by 2002:a05:651c:418b:b0:38e:5a4e:1084 with SMTP id 38308e7fff4ca-38e5a4e1fb7mr46581561fa.21.1776223896411;
        Tue, 14 Apr 2026 20:31:36 -0700 (PDT)
X-Received: by 2002:a05:651c:418b:b0:38e:5a4e:1084 with SMTP id
 38308e7fff4ca-38e5a4e1fb7mr46581461fa.21.1776223895827; Tue, 14 Apr 2026
 20:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <ad8GFhh3SI1wb7IC@darkstar.users.ipa.redhat.com>
In-Reply-To: <ad8GFhh3SI1wb7IC@darkstar.users.ipa.redhat.com>
From: RuiRui Yang <ruyang@redhat.com>
Date: Wed, 15 Apr 2026 11:32:26 +0800
X-Gm-Features: AQROBzDMdRWxvl1CVJr7d-PUt96m5bLdRLMCYbEN_isMPm4PL1UFgAnfTc9bmJY
Message-ID: <CALu+AoSb8hOD8TEyyx_NX7zSL7LY=KFwXnMYPN6gfPYjzqj9VQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update kdump reviewer email address
To: Dave Young <ruirui.yang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lVXOuDkut00Fb3-FRpr5XXk4In6X3sIGNIbNscRqcN4_1776223897
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_203403_649865_A1328CCB 
X-CRM114-Status: GOOD (  17.12  )
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

Hi,

I did not have much time for patch reviewing previously,  but I think
I will take a break soon. Hopefully, I can find some time to review
patches.  If I cannot make it after some time I will send a patch to
remove myself.

On Wed, 15 Apr 2026 at 11:28, Dave Young <ruirui.yang@linux.dev> wrote:
>
> Use my personal email address due to the Red Hat work will stop soon
>
> Signed-off-by: Dave Young <ruirui.yang@linux.dev>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..473340e09175 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13796,7 +13796,7 @@ KDUMP
>  M:     Andrew Morton <akpm@linux-foundation.org>
>  M:     Baoquan He <bhe@redhat.com>
>  R:     Vivek Goyal <vgoyal@redhat.com>
> -R:     Dave Young <dyoung@redhat.com>
> +R:     Dave Young <ruirui.yang@linux.dev>
>  L:     kexec@lists.infradead.org
>  S:     Maintained
>  W:     http://lse.sourceforge.net/kdump/
> --
> 2.51.1
>
>


