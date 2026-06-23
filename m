Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F57FCD98F2
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 11:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0GTqVg+rgasX/S0lzuuc6nnVfnMSvL9+pic5H7oW7Ww=; b=LBGzfi6m0WSDecOsWTJSSt5jUp
	rJnyPLZLDnifjRCDDuLsgXC/5Iqm5z1zJxHLXeDA7dqnfMVpAjVaNfk3xI1SLRnkeo6cTUiRueuI7
	XDqb9PEfA97RgJ1fQDRionwgqhsOcQfiN7DjbUIEuD/jq69iw5UkuM+eX4a9OgG4LYbXRK2oBk6mx
	8oAIC8wcghi5VCtrUh7qpP54g5P1ODfSkGCiT2bnNaa0BPtCkFkUcy1TI4+N8h6mZnq7ar1j6tZkY
	J+HU8AZUPDaoUadUPST3gqoIJPdlGV2TFQaOfMY/ye85yKdvNp/hne9kY7hrke5wWDEIIadbWdnbF
	7JUPWn6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbz3E-000000069z9-0PJy;
	Tue, 23 Jun 2026 11:12:20 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbz3B-000000069yH-25GA
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 11:12:18 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-695c6b2814cso5634601a12.1
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782213135; x=1782817935; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GTqVg+rgasX/S0lzuuc6nnVfnMSvL9+pic5H7oW7Ww=;
        b=DM27t/UGoUdjet5o3w3VIjIfjbBTauv/WSZHjHGdmt/3nGjOxqVQvSUS/tIz/hV5Nc
         GG1sTA2cmgVl5Ily/D+r79KrpkpwLf4QrBHNnntsASo7KoP4LeMBDysDvYXUgikIZkjQ
         FRkSvujCdJFUPK8VG3Z6gcoxrwwng4NOXMk05oS0RIabRlVz0E4BLF80Cv1YADTAfkFL
         l4R67d5h8mMXcdiTOjQSpNDkfAXQyHd3RUyxbEQPTp38Cb+oETGCC1JgQyJCszn9jfHu
         AzcN3nA5fRCQcxPAdZYpk4RE8OclE6+IFRQhYKw9K/qoT2PGVU//CgjJSk51nPd1pPXA
         847Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213135; x=1782817935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GTqVg+rgasX/S0lzuuc6nnVfnMSvL9+pic5H7oW7Ww=;
        b=MmhoOt6JGZbg87mPYBCxQvvU+by053jrceJlttrtKCkzN11Enp51tO2LnElfqJ/G/W
         hR02XqHv02mRC2+aeroXBhQ1VaAqAvGq92anV5+MfJ8ECJf3/uE1YKTNbonHtiiWzVBB
         zeE7hAVl+XmVShOrw772CBaeCd0hdE+Q1D2QdOlZVumtmiRNAPRrCATHuFRNHj0OZ2at
         hJxIi49d/uZxxSqWT7Y8Fgk2cCexIyydpyPFpZ8LMXHKFvTZ8qxPkR/3CHErwdAWrg0Z
         VAeIoQtbSd9toH1W+UPGapnLXvTgX7N1IBjEdNbkQxK+UVpAy1Ynnvc5tY3laNXGpodM
         OEuQ==
X-Gm-Message-State: AOJu0YxuVRmTbaoiwHFA2aVky13MASOugvaOSUzpo3W8SN/09iJd0Yir
	BAaMTcZq3n3GEVzh+Ov5WLQOAcnAQbcOvLnESwEYqextVC3VUnZ570Ho9pYqi3YkFAGnCfXJDlt
	40qerCXHhCEfP7qN6tw==
X-Received: from edaa1.prod.google.com ([2002:a05:6402:24c1:b0:695:df16:a5b7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3205:b0:68d:4450:d21 with SMTP id 4fb4d7f45d1cf-696ee621b1amr9223700a12.8.1782213134747;
 Tue, 23 Jun 2026 04:12:14 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:12:13 +0000
In-Reply-To: <20260623105201.3724592-3-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260623105201.3724592-1-tarunsahu@google.com> <20260623105201.3724592-3-tarunsahu@google.com>
Message-ID: <9huza4slo6ia.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v5 2/3] kho: add KHOSER_COPY_PTR to allow phys copy of
 serialized ptr
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_041217_571895_C7E7B471 
X-CRM114-Status: GOOD (  16.60  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> Adding KHOSER_COPY_PTR to copy one serializeable pointer to
> another. It basically allows copy of phys val of the
> serializeable pointer.
>
> It ignores the typecheck if any of the argument is of void *
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/kexec_handover.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 5e2eb8519bda..c1b61d875dcc 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -139,6 +139,17 @@
>  		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
>  	})
>  
> +/* Copies one serializable pointer to another. */
> +#define KHOSER_COPY_PTR(dest, src) \
> +	({ \
> +		static_assert( \
> +			__builtin_types_compatible_p(typeof((dest).ptr), typeof((src).ptr)) || \
> +			__builtin_types_compatible_p(typeof((dest).ptr), void *) || \
> +			__builtin_types_compatible_p(typeof((src).ptr), void *), \
> +			"pointer type mismatch in KHOSER_COPY_PTR" \
> +		); \
> +		(dest).phys = (src).phys; \
> +	})

This needs to be updated as per Mike's comment on v4.

>  /*
>   * This header is embedded at the beginning of each `kho_vmalloc_chunk`
>   * and contains a pointer to the next chunk in the linked list,
> -- 
> 2.55.0.rc0.786.g65d90a0328-goog

