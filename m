Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64384CD4F26
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gU2OeON2khhag3065qJSEGqv0bC3o8YE/vL8VmgXF7U=; b=KgZ5YGPm4LWqxB8jwQHQLUujS6
	lv6sBJ+ZDMxUCOTjAjJLOCW1m1hrAXb1rpgMM7sasd9o7onflr7bQIzist3cBClRMUGm2zBr3Crkq
	gJm9g4QtwXhZ6pVm29KOiC7oa3ikX1Fdpn24lJftqkqeH5+P4FDuJVRsQctyJbjWgaSNm8Y4ob0o5
	BHXqsNO4r7ibn+cIuschC3TPSathfzrW81rBUS8QX18PFCnF70AAhDb80e7MDQe8dkn42SBfXpLtj
	ZoPifZudwq1pBbObgv35zK0r0BqH+lv56mGGC/rItMXr2SBsEEQ7W2CokUtJxzKELgYuyIUu5UNAh
	JXkwwYMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxcB-000000061Vb-2LPc;
	Tue, 23 Jun 2026 09:40:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxcA-000000061VP-13t9
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 09:40:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AFD860052;
	Tue, 23 Jun 2026 09:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB981F000E9;
	Tue, 23 Jun 2026 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782207616;
	bh=gU2OeON2khhag3065qJSEGqv0bC3o8YE/vL8VmgXF7U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jq5fYvOUa492pEX6ZrP+8m/pQtS/HLI87O5dO+4NFW7Es7IskHhTma6OM4AjbIqGM
	 +T6YYH4SczvapEYQq8QgH4jngvElg2YTkxL211SypoBeoQtEW27rbn6gx1Qm3Gkfog
	 j2ekBqRcLZvr/COOckez9us/aQUUqadNRQOZK8NOovfoXks95UswH2FJU4oXPSVY9E
	 SSok1y+9PCXLqAYxY9W6jXBxxcR1jzvhlb/NTfj9eLLy79WNoxjsFzY5prKSM4r44k
	 1ZHmJgIs8XC/8nv3YEqCqslm1erYYUK1gkHUChSSwYVFly3Vn3lhctsYXZd/b41D43
	 4qC9q75HbMRog==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
From: Mike Rapoport <rppt@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
 linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260622225736.2961438-2-tarunsahu@google.com>
References: <20260622225736.2961438-1-tarunsahu@google.com>
 <20260622225736.2961438-2-tarunsahu@google.com>
Date: Tue, 23 Jun 2026 12:40:11 +0300
Message-Id: <178220761161.162773.13771896658073176.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Mon, 22 Jun 2026 22:57:35 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> Adding KHOSER_COPY_TYPESAFE and KHOSER_COPY_TYPEUNSAFE to copy one
> serializeable pointer to another. It basically allows copy of phys val
> of the serializeable pointer.

Please update the commit message :)

>
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

I'd suggest declaring local variables for the pointers and verifying
their compatibility. E.g.

	({								\
		typeof((dest).ptr) __dst;				\
		typeof((src).ptr) __src;				\
		static_assert(						\
			__builtin_types_compatible_p(__dst, __src)) ||	\
			__builtin_types_compatible_p(__dst, void *) ||	\
			__builtin_types_compatible_p(__src, void *),	\
			"pointer type mismatch in KHOSER_COPY_PTR"	\
		); \
		(dest).phys = (src).phys; \
	})

IMO it's easier to decipher this way.

-- 
Sincerely yours,
Mike.


