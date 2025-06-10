Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2FAC5B543
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofChJacQ1qiYJqBxicfF0O8ZtFsM5woxFYS+jj/lodM=; b=ew4hgTlt1VYLuQHByDZ2vtcuJV
	BwGRu0e2Jennl2yx5QNcaDPAVGajTJrwBF1qFT29da8dlzRSJVH+bCdXRiO4mxjaA8GYSYQ9tNK2q
	kIrSdhkeseWWEgyoW6TrA/1GWA327Bz6Kmse5TVckR39uQt82l6nrEc/KP7/OJMm+zCQMIcVFbRYz
	AXnO8P1CnbVyvSUivXm2u9HIkjKhQKRXTT2xKeY5sWgba1BoDBAr6M2ltmYXG1I1L7j6JxuJE+PoZ
	zoqUS0UIyMrdnDWASyyxRY+TdPZZ5wK8Psh549DjKp/ELJdQWUWLhLzAh8okqMpYgtuT2efSmrTMN
	Z2rt26FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOxjU-00000006iM2-36ds;
	Tue, 10 Jun 2025 12:05:36 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOxDB-00000006eKx-3AzA
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 11:32:14 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-23508d30142so68523265ad.0
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1749555133; x=1750159933; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofChJacQ1qiYJqBxicfF0O8ZtFsM5woxFYS+jj/lodM=;
        b=Y+mNGpfqrECmPMexE1C2Int0AD4ixYG7MXdO1lMJ1RdZakORRGYnKFRqzzghf15mqn
         9HwBgZK3kypOAa553O02IfPCWZcMSKPPqu3DZ9ztxHSMnkf2By4KC9s0t7REN7oPeOYT
         At2U+Vo55dmiLYe4S79zPQFF/bKZfv6XrkYNO1yE8VIjo1sOKNwM6wKGQccSeHF4Bl1c
         D9lEtLvo2LDr3sGZ4FDwFhG2OUjz77XzclNDZ4IbxZdwv1EpZChioEJCJeEG2uLagCAP
         wdwFf5fbNJV/x0oyh+uDjLG2y0kLEHHuP67E/0ydDZbEF25IZf+cFZDa1WQPwAeZHpTb
         1/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749555133; x=1750159933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofChJacQ1qiYJqBxicfF0O8ZtFsM5woxFYS+jj/lodM=;
        b=jgklxsjmszpTpseCMB/g81ppcYO0lRQLJdRnnZis0wwSGn9Ea6X8bcaUrsR2yWXHXw
         nqvbfbGnYeWDapokNUB7i1tOmB0Ghzp1XsAiaC8KDzSCwuY1whlJ0+rjUr3WF48i5jOs
         YWwkJ8wDQK+2VHCO3RR91+NxzpvZrzTXj0XRWv3vsfK60DVwqfagMX394nzifa2wEC3J
         8XnXOAQ2aDSpYvz3D2l63jXj4a8q8elicZ6kmTyPTWOZeA06plSdp8ivSYlRt2zVTs7Z
         sBm/9sEyxCFAvXSv/hyzNwsEwVy5nB3+ziqLiZmvchomUn5MCXbJH2UkX3tJW5O5ewZc
         IQLw==
X-Gm-Message-State: AOJu0YyaipoowqobiJL51d0PXAo9ffvjc490BXgJ77WwMB2T9zuUn0my
	4omuCPP/i7oR4T5i65GiXOPuyPvHWF85XHqnWMmfZa/hvA470BF0B43z6MT4LZw/7LDJeWqvKMa
	1wjfpaXKVO5SMktiCYMCAE0e6+ac5NkB0ZV7uqGBTI6AdbaeHk6UW+Ho=
X-Gm-Gg: ASbGncvGnx+oZvPXrk3pRaXafkwSOwLQF8qk8QXaf+s79ZNDT3OvT5L8A4nMc4l5gl6
	Ps7KQbCKmInQJF9WxisMSabWQjJItPtWB7nedcnXRAIycgp5htUG72ObXWll9KGjCOYxckAg98m
	2jGzisnulaf9wXHKhl7Fvhg3pwXFMrneB9D21KbBTa
X-Google-Smtp-Source: AGHT+IHarIKTCg7Wh8AuZ0Tt40r0q9LllShk2yggWVtkhQj8gIAUkQYg7kT1J8Wyzz1/DOT2OhgAA7LXwaUXjy9MHtg=
X-Received: by 2002:ac8:6f08:0:b0:4a4:419f:8329 with SMTP id
 d75a77b69052e-4a5b9a033c4mr286210601cf.8.1749555121947; Tue, 10 Jun 2025
 04:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250610085327.51817-1-graf@amazon.com>
In-Reply-To: <20250610085327.51817-1-graf@amazon.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 10 Jun 2025 07:31:25 -0400
X-Gm-Features: AX0GCFvB36FQ2mONd23CJy-bQAsJdpMnU5jLlIePTapa208TPsg1wFXBXlN5zec
Message-ID: <CA+CK2bBhUdEjD=-gM3=D6mKBYctbXh74_hq-bMf1fa8mfS2Edg@mail.gmail.com>
Subject: Re: [PATCH v5] kexec: Enable CMA based contiguous allocation
To: Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com, Baoquan He <bhe@redhat.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_043213_794611_361A288C 
X-CRM114-Status: GOOD (  28.87  )
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

On Tue, Jun 10, 2025 at 4:53=E2=80=AFAM Alexander Graf <graf@amazon.com> wr=
ote:
>
> When booting a new kernel with kexec_file, the kernel picks a target
> location that the kernel should live at, then allocates random pages,
> checks whether any of those patches magically happens to coincide with
> a target address range and if so, uses them for that range.
>
> For every page allocated this way, it then creates a page list that the
> relocation code - code that executes while all CPUs are off and we are
> just about to jump into the new kernel - copies to their final memory
> location. We can not put them there before, because chances are pretty
> good that at least some page in the target range is already in use by
> the currently running Linux environment. Copying is happening from a
> single CPU at RAM rate, which takes around 4-50 ms per 100 MiB.
>
> All of this is inefficient and error prone.
>
> To successfully kexec, we need to quiesce all devices of the outgoing
> kernel so they don't scribble over the new kernel's memory. We have seen
> cases where that does not happen properly (*cough* GIC *cough*) and hence
> the new kernel was corrupted. This started a month long journey to root
> cause failing kexecs to eventually see memory corruption, because the new
> kernel was corrupted severely enough that it could not emit output to
> tell us about the fact that it was corrupted. By allocating memory for th=
e
> next kernel from a memory range that is guaranteed scribbling free, we ca=
n
> boot the next kernel up to a point where it is at least able to detect
> corruption and maybe even stop it before it becomes severe. This increase=
s
> the chance for successful kexecs.
>
> Since kexec got introduced, Linux has gained the CMA framework which
> can perform physically contiguous memory mappings, while keeping that
> memory available for movable memory when it is not needed for contiguous
> allocations. The default CMA allocator is for DMA allocations.
>
> This patch adds logic to the kexec file loader to attempt to place the
> target payload at a location allocated from CMA. If successful, it uses
> that memory range directly instead of creating copy instructions during
> the hot phase. To ensure that there is a safety net in case anything goes
> wrong with the CMA allocation, it also adds a flag for user space to forc=
e
> disable CMA allocations.
>
> Using CMA allocations has two advantages:
>
>   1) Faster by 4-50 ms per 100 MiB. There is no more need to copy in the
>      hot phase.
>   2) More robust. Even if by accident some page is still in use for DMA,
>      the new kernel image will be safe from that access because it reside=
s
>      in a memory region that is considered allocated in the old kernel an=
d
>      has a chance to reinitialize that component.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

