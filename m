Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2484CCDB46B
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 22:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AB8TF/nTTwkjJ2DauD9OsPoaeTkyxV0ScT5eapW1Gw0=; b=KRTFRueGk0IU8MHQq33FS/LsqV
	ZpFIpj4OqAVALmqX5bpL0FYITZB51y7KP2tbc5dz9ogNbJsG0MRuErJ69oDf54JrHyMP/AwDWQMxP
	rtwbK5J/yu48fqKM8uIyLJBSYTd6DEPokLklyFrqg9kdO5gskp036eCTPhjNHkZ83eC23TMdnNJct
	1GBKEpFPHuw+NdOpjsn9MzsZyGIZXDKN60bpLY8vfsrjlXbHV/rOO5VQYFzdPxBUK3dBXsyRyMATV
	2/4YgkneVOCIP8R5d5AOU/7YUl25SzlLnzXA+LopdWzRI3fyP22ijYo3vaEAVDkQOo53LkgMAiO3w
	a6Nq8rqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnbh-00000005SHF-1CVa;
	Mon, 22 Jun 2026 22:59:09 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnbf-00000005SGi-3RY9
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 22:59:08 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-697bd22237dso1308875a12.2
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169145; x=1782773945; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AB8TF/nTTwkjJ2DauD9OsPoaeTkyxV0ScT5eapW1Gw0=;
        b=qh6O2Yzi6ol7/7DYhocSkwh7o6wPA2KdpA2nFfpp5WXRrh0Zqkfy9hn+w6N+58GKOP
         CnKXxHKRK504qPRrAHZ9rXLSv+/a15fKhR6fQuudaW4r97hh3SjJHA7bRMBXcePJl4ek
         x1/U3w/W9x4lm6Jv4KdExundyEAvblAojPzNgofLUBDrM3XRaTPYFnY4X7wYQUiZ6it+
         YTYMxonwj0+KTba7nEoAo0HZsPICk+iH9XZhF6H4X6Xgfmy8fkvzSQg6lKPZy1RQS5JZ
         EkafXVQON/W+Up8Fq+gQawAOyrCn7IlYbAh3Ka3uEFKlCElVXWRqcfBie+0bb7o0lSLe
         N+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169145; x=1782773945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AB8TF/nTTwkjJ2DauD9OsPoaeTkyxV0ScT5eapW1Gw0=;
        b=OiuVtwtttoxX+DtarVWeiMVdlRe0CKFDWdMcfnv2YKAUDlDluSDACevVVMBn+n8Olo
         5cEjbPlPJSR80lmFqhi7NiQJw0zqZ+4b2rGPbqr+xqL1Aq8bwKPxUmPHi+pU2s0A4UM4
         NsN8d7MJNbf/WvsSARmx6g+vngqM4IhJtoU0+Zx2OCe5WQrdoe7yUXBkD0/Mvt6NasqL
         UUrvW98nJJUeUJQMSVRpRQwMXEyWrHnQLDoAIwJbzUnMIMyYslYeqb2dxCR46SCgZ92d
         c1dfMwkGffpf4Op8nz037Dx08CvJi8qTppJXdUe3GqyP1Yx4iW57DpBmzUYvWCJULItx
         bAKA==
X-Forwarded-Encrypted: i=1; AFNElJ+wRev1YzIHm7nedNKftdl++PvSSQp0VGMdnTX1FfpHtVL7kQMxzCgNriP8o5HlsOJQX12HEg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdsOicuqhtKyilI8iwgg2XVxbQQIEyoh2GN3n6fH/VflKl+PtZ
	ndbDBxQZiqzgRsxUvdqEQ+Xz1BcmdHeqatF9HRogNvjdJhGD8YDtW3dAaGMGCmM+0m7Cao/y144
	FkXxFmE+ZS9JbWQOPrg==
X-Received: from edud24.prod.google.com ([2002:a05:6402:18:b0:696:7fdb:ab3c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4302:b0:697:769c:e381 with SMTP id 4fb4d7f45d1cf-697dba6ee52mr68191a12.8.1782169144805;
 Mon, 22 Jun 2026 15:59:04 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:59:04 +0000
In-Reply-To: <178215570871.91679.11260349768439750235.b4-review@b4>
Mime-Version: 1.0
References: <20260622111215.4157974-1-tarunsahu@google.com>
 <20260622111215.4157974-2-tarunsahu@google.com> <178215570871.91679.11260349768439750235.b4-review@b4>
Message-ID: <9huzse6ew5af.fsf@tarunix.c.googlers.com>
Subject: Re: [RESEND PATCH v3 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_155907_867502_70B53778 
X-CRM114-Status: GOOD (  10.80  )
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

Mike Rapoport <rppt@kernel.org> writes:

> On Mon, 22 Jun 2026 11:12:14 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
>> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
>> index 5e2eb8519bda..618408fbe9c9 100644
>> --- a/include/linux/kho/abi/kexec_handover.h
>> +++ b/include/linux/kho/abi/kexec_handover.h
>> @@ -139,6 +139,18 @@
>>  		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
>>  	})
>>  
>> +/* Copies one serializable pointer to another of same type. */
>> +#define KHOSER_COPY_TYPESAFE(dest, src) \
>
> Maybe name if KHOSER_COPY_PTR?
>
>> +	({ \
>> +		typecheck(typeof((dest).ptr), (src).ptr); \
>
> And if we could replace the typecheck with some other magic to allow
> void * we won't need the unsafe version.

Done! Sent V4.
Thanks for reviewing.

~Tarun

>
> -- 
> Sincerely yours,
> Mike.

