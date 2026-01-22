Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB5CD6CFA3
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XqfjFZjqZ+qKfuAcLr5Lq6LxiUZh0aC9ms0gfa0kYpM=; b=RDRbO8rLfR9QcOY29NuXNYgY3g
	beSWpTg4uoWgz85TWA+byo1DMUsvJx+gKTqtuEwQj8wWHKpi9VM9tHYXQlr0LyToN903JxbRxSkcf
	zQ0WPvZFAGipxaQ4IGeIqvG1ytW3hFKGh2jmYuI8efHH/WMGh3sRUOhcKtN0HzaRVt+syAX3faXxa
	LSsgvSDy1ZzJ95cQ/hwDB/EQFhDDOtC2CrSEckMQCC4wOaE53ibibU3PCWKfRc4Vs8rzanAnnJP/S
	cGO0DfMEb2cww93E4UKRVbJOtP4UGnWTBOJXMTySkEd3RvgXgnVudwzTMzqATz+s8lvSaV+gFxrn6
	KBYmTLVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizRZ-00000007dW4-38bo;
	Thu, 22 Jan 2026 18:30:09 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vizRW-00000007dVg-3Ti9
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 18:30:08 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-65813e3bdaaso1485912a12.1
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 10:30:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106605; cv=none;
        d=google.com; s=arc-20240605;
        b=KMFwt1BW1he5NX2WFbcs51SlqruwEi4ZcMbQdRKpgpguaH8vDa4yL/q8wyjk3rLYb8
         Zlq7r1Vte5YEmkfB+wetEuVnwIHaorDTxyKzUSWxWAf6XORJn7ycSVvcsYzajjSv1gZq
         8ZhuBEn39rQy2mVfHTtJ0EbIMOAFSSLLbnWnBqph97ua2fwSfRNO38gzEoRO3XA9o4RL
         Yq4C/S/GcKPQXFy2phKRbfudHnD65bFydQHnnJipU0UHhNE6vR9rM+AIqjOH9bEpILHf
         E+mLCD+ucgLAwCBq5Aserk2BAjdlPyuw3Pn08VBrfEazKbpgQ/D0XyNrjaKlIzp4vyjB
         Lw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqfjFZjqZ+qKfuAcLr5Lq6LxiUZh0aC9ms0gfa0kYpM=;
        fh=N4EMcoL306CIR7d3CnNxG9yo5o7YNxn/AyXXqDLU+0I=;
        b=JXrMU//yAeVFhk7xv3nLmq/d+3Yvq8z7SO5An5SkE45XoWXyS+R3GS6EtEjOmWtyZd
         G96/JfCjTSxO8h6s2k5HLRX8AqzHKPGZUW/miwqn0DgcrS2QXgVNNcH6j0Hlw9kNtxFN
         y9SjDG5r0n2OMM9q+IbovRXh6RKDRh/ChLmesCY8RtPDknAsEEzL9fMXfyeY3Xs1NyGp
         UYqRke00h3gmvegWqOa8qz3oKF1YzhnQNH3ojoFzyl1RfymkuiZpqw6uSZ+b1JNX/0cM
         fBH/DyJOkzXX+LAwXTP/4m47NXUyh9Qd6zXUs9BrnS8wB1//bnN8GazXqEYkj9oGgqSw
         5ZDA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769106605; x=1769711405; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqfjFZjqZ+qKfuAcLr5Lq6LxiUZh0aC9ms0gfa0kYpM=;
        b=JUTb6Axcek1f1nzewh3WkfM5I83TL6vfzrOtQNj3ynZ327FQDXSfOb3a3RWaJbWXXI
         2Oiw/7+D7RRdEZ+TVmbL1TArvvgVk5oeiQc+vfmpDENUhUdVyejStoSsbTxUgBFNGQS+
         gIo5nfuWfmMDwLL8odqPS31DEzBsHRusIVdTmg9sQrAgrXNgvo5fAAP08wciHVflEHUV
         e6KCjtnTOrsFJITQxkOz7DaUp9nFVAVgPSXTp0f7Ooxds21+Ayh2IEMqeyHElXJefmD+
         zQew3xjoVNe+vg6oVxnwW0pUvsANcqI+1yijgSGALiinIgyfuvvTUJ8lXLcn+Xx0IR4W
         lisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106605; x=1769711405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqfjFZjqZ+qKfuAcLr5Lq6LxiUZh0aC9ms0gfa0kYpM=;
        b=Yb4Fh+VBrtz8iNO3UHD3djI0TKD5BrvtL2TstjJ6O1jnx/yEVl5y1YsTax0x4gsoaS
         GKbhYVD8LU44a23EXxHELXYyZa0oGJQ44xDlfyu3pZQm7EaWnjuzOaqzmczBnbPMnOGe
         QGc4DXYp44bQwbkCxkNBObqx4RDsStCL9/Y7j36Gr9UHqMcPB3GsBa1uhgNiUvM9RALz
         NhgBq+5fsLtheNFZVFfkR5vK487C5qR1/Ap0SD2WfY+ujpLaf2Z7NEFrTK1xhAZ2vvtX
         5Vlh8l3KAuZjiHHBw5//CCeK3TZkojshQqQCumF/dbQCGA5yUPh9rHzg08OKHoNtvrXt
         Pfbg==
X-Forwarded-Encrypted: i=1; AJvYcCWU3B6fsdckb3ekxgPyY06WEMrFE5h03UU/VAFizbzf9h4lDATZoWYvJQ9X1OgkD+D08FXDKA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVCTqg2FNC0cMpuBvihtJRZGyQb+sVaibaNg4uPZ8/kjnB11LE
	zBL1qHzdAOZu4/qTdg1nHOVOs9reNCNP23XTUczrinW71HzO5ohOSLLRxU7lyc/x83uLyUOOm50
	SnYe1n6ZUMajbTbyX7+PGPRZd4hSA9KWjYDNTZvWKNQ==
X-Gm-Gg: AZuq6aL8ysVIPCIq6DR39SnpG3mu430Z8OywmWDclFyXYkRaW6meAzELxWQY/gu5HZu
	iaJcYt6JI3Ala1nT/pBbWbDxt1MoK8+BfdkNUHlzzSvkpzyu33MdnIfZEsJfj2hn7t0kZJZQ06R
	ed8Kl6tw4D17L63EDRZEUyHskbK8I4qf+aGFPms93LDStjMYZYizgyFOcOLNU3BIvlnnSgeZ9c/
	PQ8IAJ0Jgy+0v8oxQ+H1RVCW1fszwTi7rPZIKviLosjDNQua3uO8I7BHoFEZzJv+1ZPCbb/br7O
	zbbiXMhReCLeqj/ydjhxzA11Cg==
X-Received: by 2002:a05:6402:13d4:b0:653:e391:6f2f with SMTP id
 4fb4d7f45d1cf-6584b1a37e9mr194745a12.9.1769106604981; Thu, 22 Jan 2026
 10:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20260105165839.285270-1-rppt@kernel.org> <20260105165839.285270-5-rppt@kernel.org>
In-Reply-To: <20260105165839.285270-5-rppt@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 13:29:27 -0500
X-Gm-Features: AZwV_QgE9tT77JRQYCr53kQCb10BhXhbXggqjEIyG_WPw09DmKeAZcOWTin2V6Y
Message-ID: <CA+CK2bCB+n5hK9SpMewWURU75a8sY3BJz=MEu_Zy1KwU4Kr5Tg@mail.gmail.com>
Subject: Re: [PATCH 4/6] kho: Introduce KHO FDT ABI header
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Jason Miu <jasonmiu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_103006_916499_89995480 
X-CRM114-Status: GOOD (  10.20  )
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

On Mon, Jan 5, 2026 at 11:58=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: Jason Miu <jasonmiu@google.com>
>
> Introduce the `include/linux/kho/abi/kexec_handover.h` header file,
> which defines the stable ABI for the KHO mechanism. This header specifies
> how preserved data is passed between kernels using an FDT.
>
> The ABI contract includes the FDT structure, node properties, and the
> "kho-v1" compatible string. By centralizing these definitions, this
> header serves as the foundational agreement for inter-kernel
> communication of preserved states, ensuring forward compatibility and
> preventing misinterpretation of data across kexec transitions.
>
> Since the ABI definitions are now centralized in the header files, the
> YAML files that previously described the FDT interfaces are
> redundant. These redundant files have therefore been removed.
>
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

