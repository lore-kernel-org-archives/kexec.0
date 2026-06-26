Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4DCC43327
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 18:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6DYOZPc47JqTq3OBvPwgELKvYMpLEHI1RmYpvjUyG3k=; b=yjkOpqMuB0sMg0CYyl5lVoHPdB
	L1vtK1KX676tKAqSyZ1IPLUknPuY2FrFs2G0JCPMPg8ia9pTOLrHOk5q/CWvgfbmUZACQUadfwbHP
	GfAXppJpmWKLbcP2hCwoXlTeJrw27PEi+YU8wQukrVcVEi72rCeosjCBRjvsbVFNOgEU3diTPKQau
	lEpBLdDKKP9hBX0uWhg9mYdZ5GF9YEOlBPORjVIq0VF+RFIgV4ci/Z0L4Fgg3iyjFzRRnn78z07S7
	hN7lGVNfjhqsnOMm9Lc06iNyk9VdQnBvYxpbzyji/C6dxUa9ug7hXejrAeMevl/b2yoaDNvCr2FGA
	RjdoHDHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdBcA-0000000Bljf-0zCJ;
	Fri, 26 Jun 2026 18:49:22 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdBc7-0000000Blj5-0Xec
	for kexec@lists.infradead.org;
	Fri, 26 Jun 2026 18:49:20 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-6982445bc4dso1235072a12.1
        for <kexec@lists.infradead.org>; Fri, 26 Jun 2026 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782499756; x=1783104556; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DYOZPc47JqTq3OBvPwgELKvYMpLEHI1RmYpvjUyG3k=;
        b=CX826WdSo1e8pv7oh/lZ14IekKauPBgfmEawMpYk6qwUSF2F5KTOOPi+AbiHtZGs7B
         9cxRW0PY5n5/JL40dkTcqh4OUOuVLDMtwRkHKH6ooKgUYheoljHu5a901EW2eYS9xfUo
         BT0qhE9NkItjE7oagWngm9R3t2QWCyGICwdq/5WegTx9YLJpzaXoM9s2A1akJXFO9DEK
         VbfThJHUZt9JuIAqEEIC2hjff2kE1OcyLhZ8MCUGy0EDZ2NV9qLIzaIqqUFlPOjt3S+K
         7RU5GyQSPeF+a2bcEJmoYDkYmJHiCkb5U2Hg85JYeO6+hweKhds67IPaB/cMkB4kc8u7
         AFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782499756; x=1783104556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DYOZPc47JqTq3OBvPwgELKvYMpLEHI1RmYpvjUyG3k=;
        b=oKiopK6wYvjX7Z4mooz2klCT/0mUxmKxTpnFZ6SiOHZplaIS1wuuY1Ifv7zVkKU21i
         Tb7QsOuW1qJWO76AwR2o65HsHQVuYeQnjWSzwrSpdq6Eehuy+rJ9q7H4b+bpYePSr0rK
         3mMl6zVLKF68kg9mE6AVEDardZUQovZMGp38CQZSFf9CXOuQvyLZPrLSTd5lufNw2cSd
         d2cW66ZgicxPXp2xBtuQ2WpSI9Bbsri/JQOzHuytzEn8xHyKZ3x1Km/LrA+RwSJ4Nper
         i0KxI9wRzmfllkw4ZZudeXykFrSr5klRCb2O+uIfVO4mabBFSXrD2qbfd+2YAu/h0UBP
         WyiA==
X-Gm-Message-State: AOJu0Yx0VFhUEh1vXydUXTwHUT8EP5oK5XMIoJv1SySB1HHiZIPMkMEi
	2G3A8TXQ4UNbMekZz59uJQ2BHJUWviw6m/ChX1SBo5QxRaVKepgvpunA0/ZQ3jiluAspnN7UNN7
	jwMO67noqpg6+/7VPIg==
X-Received: from edaa16.prod.google.com ([2002:a05:6402:24d0:b0:695:9e2c:a1ca])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:280e:b0:698:3b7c:3b2f with SMTP id 4fb4d7f45d1cf-6983b7c3e1emr618285a12.17.1782499755827;
 Fri, 26 Jun 2026 11:49:15 -0700 (PDT)
Date: Fri, 26 Jun 2026 18:49:15 +0000
In-Reply-To: <20260623105201.3724592-3-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260623105201.3724592-1-tarunsahu@google.com> <20260623105201.3724592-3-tarunsahu@google.com>
Message-ID: <9huz8q81yw5w.fsf@tarunix.c.googlers.com>
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
X-CRM114-CacheID: sfid-20260626_114919_219188_0ADA6705 
X-CRM114-Status: GOOD (  16.92  )
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


+mike

As per you suggestion:


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

This is incorrect:  as it looks for type instead of var and adding
typedef like below throws warning in checkpatch : no new typedefs.



	({								\
		typedef typeof((dest).ptr) __dst;			\
		typedef typeof((src).ptr) __src;			\
		static_assert(						\
			__builtin_types_compatible_p(__dst, __src)) ||	\
			__builtin_types_compatible_p(__dst, void *) ||	\
			__builtin_types_compatible_p(__src, void *),	\
			"pointer type mismatch in KHOSER_COPY_PTR"	\
		); \
		(dest).phys = (src).phys; \
	})

OR we can add __builtin_...(typeof(__dst), typeof(__src)), But this does
not solve the purpose of improving the readability.

So I am fine with the original, as it is more straight-forward to read.
Typeof(pointer of destination) (typeof(dst.ptr)) and so on.

~Tarun

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
>  /*
>   * This header is embedded at the beginning of each `kho_vmalloc_chunk`
>   * and contains a pointer to the next chunk in the linked list,
> -- 
> 2.55.0.rc0.786.g65d90a0328-goog

