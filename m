Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C1BCEE349
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9V6aLA+CV/5v4QAU6QWKGjd1JLxGYjp0JB58rm3Rtm4=; b=jxHF7HtBZFfNUzX3p0eV5k6pFa
	areENkzTAIrGP01+R/2xQAexH2/5hPssBcGO+hwNVl0A914oWtVVRWacSw2T/1Kg7f3Yyvpsyzys5
	RB7hIQK8NvZKlzoLaf/Hch7LLamWWFnkMl+SUgq8HyeVPmyZcTbsM/Q6ZBjSJezUeh2csfhgrJQJS
	3UVyiAzyNEbqwwu3j8W4k0b4A1c5EwlRpaVn2RVXVfxl/IKAxFfZ3luQNPPRtASJdQwOLdeAz+5SB
	Kl8v5INuwF6966BqBHXqHO7SgrXpTpODAfbdQV/8mYKd2CowTLJINZzmwrRsn9xb+Ozjqyw4jx9pJ
	aj72M9aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQcH-00000000xcr-31Wh;
	Tue, 18 Nov 2025 18:39:49 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQcE-00000000xcE-3Y3k
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 18:39:49 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso10972175a12.2
        for <kexec@lists.infradead.org>; Tue, 18 Nov 2025 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763491185; x=1764095985; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V6aLA+CV/5v4QAU6QWKGjd1JLxGYjp0JB58rm3Rtm4=;
        b=QcMcttMpi0UYm7x1IYSVRJ8iCvEMOo3VBRkmnZFHjz+bI7SU94+jPaeO/wjeBkYaax
         88WXEGvCOjq2fOcg62aK0NYmw73cBAgrN0XDBFdeiipqbLUkNW9jgi/pWUkH+e6BijWp
         wZfgqZp9CnCKF4dlBzmzwbUXoTOlN5sTD4vNWwmIrblBWud4XDPQikVLZ8Mi8PCz7XrR
         fsqNcMjGCMRNmMFexOK1v3gEuUvFp8NzqJZvoRygPmRlVI02WMivaq35LSRYmvYqlX96
         TEYaIGutsONHm/i9rscps5Z/ScpoHLQT6NQwuXyYmwWYxr0UD20HM+GpMfsp4UDflL7u
         OPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491185; x=1764095985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9V6aLA+CV/5v4QAU6QWKGjd1JLxGYjp0JB58rm3Rtm4=;
        b=pm4axW7rrEQH+B1fn9gt8JWivf8+bsgSkT/+FkpDy7XKWpYbT9QpqDfNkzX7M1qfg8
         mZnNacHLXwDmjFxvdNShC/qZ+5dTHldcl4DqCq3nn3j9ZzD31bUP1IVvBJ5/3VMsr44r
         RREYCn5MCCEvctXMJfabrArfwREXkk34lEplALomRTbbCemNklyWKdC+qBS93v3XnDuY
         CnXtOkD7RwlJxbR8voU0hBFlLYQgZ13dTat9Pmm1/AlW/WltPTIsCabzfSc+GZnaywpt
         K56ICO7PcPFTqLd+FliOlU5RWvne/QyKD8dwUEtphtdsnFD+NImT87kslb2Jy88pQE5E
         b+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVFdxNxWZ2JgNU0BwHD2bX5l0wD7fa/7swAuQgPNUn5nPEblWf7NQYQ8eH9Vul7CMeaetMHw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5iW8k1z2zc1QTcfAtqQ3mnm3hUtZL/OTe37ZfnakccMZeW6Ui
	sdguPRym1ngafiZVTm355waHtNMnji85gIH/O3I8hOk91B+zNibjKCq07F1cs1UqWXv/IfGWFaK
	2GTg1JmW/9g49xUrbiW7ARghWjKgtbDeHeJsiVAwk/g==
X-Gm-Gg: ASbGncvCdVQ/6dV0OKfUvN8kFKMsRKlSQrXxGGwbJmHYmWIOrnMqah8OmFkqJCh4v0W
	wsIXz0zuhwz32C4+81rWbde15wf1oFzKWl4Wc17LejrPEoWq3QTkhNf/H8/v4Vr7ws5ACYIGs2T
	tf6sCHoMH5XzXwQKYvIPRSMrTY9Fzt7vJBYiSQ6AinAyJyR42crE7+H5Z07TAGd7WXnQw+dxuZt
	Sc9sHbxTk816bE+ZPk1aVoxvXUGtKVJGD059bdsbzo0BokV/huGXv+KhCEIbLIWnhmf3jx48Q2w
	exs=
X-Google-Smtp-Source: AGHT+IFPdLU4oYkdFHTrvm3ufxvrZdc5fdQZYxhgkZuVLW1U36Xs+bmTvPNB3im9GWGpOgsCyvBrh0Ifv3TOSGRmd+g=
X-Received: by 2002:a05:6402:27c8:b0:640:ebca:e682 with SMTP id
 4fb4d7f45d1cf-64350e8a783mr15180576a12.21.1763491184719; Tue, 18 Nov 2025
 10:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20251118182218.63044-1-pratyush@kernel.org>
In-Reply-To: <20251118182218.63044-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 13:39:07 -0500
X-Gm-Features: AWmQ_blXXv0EIUAeTANiMUfiQ-ZE8U7GHZIeNO-VAyI_9nKD9wCvkFnt-Ipg4hk
Message-ID: <CA+CK2bChpd-k0tpcQRdVmK0nmnOGKWExViVVwcmhryZVEZJFPA@mail.gmail.com>
Subject: Re: [PATCH] kho: free chunks using free_page() instead of kfree()
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_103946_888402_8A627F96 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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

On Tue, Nov 18, 2025 at 1:22=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Before commit fa759cd75bce5 ("kho: allocate metadata directly from the
> buddy allocator"), the chunks were allocated from the slab allocator
> using kzalloc(). Those were rightly freed using kfree().
>
> When the commit switched to using the buddy allocator directly, it
> missed updating kho_mem_ser_free() to use free_page() instead of
> kfree().
>
> Fixes: fa759cd75bce5 ("kho: allocate metadata directly from the buddy all=
ocator")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Thank you for finding and fixing this issue.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

