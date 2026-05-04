Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DE6FF885A
	for <kexec@archiver.kernel.org>; Mon,  4 May 2026 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k1pBQ3dmpauwMVc7roa8Vteafz4/mkMyRaEsDsPXXbk=; b=rL8Q7kNw+1omlj26nu1/NUIn8d
	cOhJRicugX8458ovXy657HbdE7TlQVpLahEmU50kaiKxpJ95BLxKSnVi+VKYnJ23j26tp4+5mj7n4
	0E5iwnqctRI6pFBf1s7cDJnHcunBzrNYqoZ4cCcWNP6DAlXnNcvNK7BiSKDToyDXlpqBZbRxTMOe3
	5PqBwl6E9iTxbvOTH4g2jOmGGxMgai1weiGP6FHUpK4+dz64tkSC3v/bLRte6fxTHqM3v99Eb2UqT
	2Ce/VyzMdc3Obbqx3Z/bIr0LWVoZTyS/IevWDzo8Y27Eoeu8i+UeyCXfBdCjcrORcLyuzZXE0gxbn
	qoCIOCoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJqbd-0000000CwNb-3QaY;
	Mon, 04 May 2026 10:32:53 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJqba-0000000CwN2-3BMj
	for kexec@lists.infradead.org;
	Mon, 04 May 2026 10:32:52 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so6201114a12.1
        for <kexec@lists.infradead.org>; Mon, 04 May 2026 03:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777890768; cv=none;
        d=google.com; s=arc-20240605;
        b=iEx+yessliZKkuLCHkZ9PWvNApYKKwfqb9ysU0khoHXz7v7O/N5AnIv9i2R/WTXHnZ
         DhDtC5o431Mxirv9GiVBIXK1XHpNSWq1izUr7ewYxf7xcOCs4EjxkibwFbmnLBVyK2E8
         +wGfgw97aGCR/pIvuYqQULOKW9FiFeIC5RhvK3mwZvvJqXFR324pGdmI8tZMochsD+ei
         oUYXeUAMWkfmi60mXcJbhZpUrOUJ73zQ8bDxBMeh96NpPcwq/WbOIQ57GkXBSCj/0bls
         +15xTEjbWSOBNCp6U8Q0r+ohm0YyvfaFKWpzMfeX+mtrg9CmdtcAxt/bELdaaoDoaxST
         8axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k1pBQ3dmpauwMVc7roa8Vteafz4/mkMyRaEsDsPXXbk=;
        fh=x0zaMcq2cfHQni9j03Qjj4BC/r1TlvlMPEmJv8fnttg=;
        b=kifldW2OoxJM/gRA8wc/GQEk3QOFLnPFfROaQ2nnlcoocb6z+ERdNQVxqYqf/Dvbc1
         ZmtiJh49ugsvwyKjnuFNfKf27QohxUf/Ap9CW1N/GJjQ3zgm+M+u/v2Zfz2opZngb+LM
         IDcmUAM9RU7hMGlIbCJ7iG32Qkh8iQ3QKHlyFyI+o5iBlCzGW3EhIpKIW3UyBf+u04un
         MoQyMNEU7uLEoHNq4aaV98nTdT7dw3WxWoY2eCqD0QI5zjv9z//oDQXeY1NQMJ7EJ0TU
         qAl1ge1jzAXUUphdjmErAMo+U7VruDrpqrLnYyac7+aEskQExkbeXhmnIJro4ebUH/ww
         ULNw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777890768; x=1778495568; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1pBQ3dmpauwMVc7roa8Vteafz4/mkMyRaEsDsPXXbk=;
        b=B0TQnri/083VjmmorlqdDQj4Vl+iKztQnXTc38CxoAM963NhoLXhvhpmOFG1Nv7FrC
         X8FLyp5G4C7OyfskkO7Nn57uNlrlrE4iy6RNTH5AIi6FSg7qdOmq3kmi0nWzbCYLVj6u
         j6I3talikmkRzgOlugsoKP6ZTAzYhHUX8MV1+MlPDWQYp+urcvZOmKD7d/+zwQ4G/+P0
         4M5dlnX+1JMHDLrny/hprxWNUsSF8kaa5jjBgzsZhV2G3dYL9fwfSuLiexKetpRmVXRf
         WNydiLnDgM4Ovl9OoztRWEz/T0iGQVbnlx+xGrLTPSpWX/EKE0e+U17ErJ/bKZ6VEeM0
         UmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890768; x=1778495568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1pBQ3dmpauwMVc7roa8Vteafz4/mkMyRaEsDsPXXbk=;
        b=OeUTb30XqaXfXOH1rsFXjVmp25q/yyz4R0bfHXc1rdfrZh1Tj1aXLpTggiVyreqUwl
         L+B6oytoX10Q1NGVvOq0y7wRbewisBNpZS8B6KU/A+PQBXHB49EWZwULJsLn+LWGEHBz
         9xXdw8LrQHaTJ3dbMxLuLJQhWKtDpSJ9eeqVyDkGll5TTm7W6fQM0uRHuf7fC1mAbWEF
         YyU2MHySpViRUrmFzTeWrkZk8Qh/3gViT858nnVYiABplwJk5GMGRPeJZ4ETOmiZ6gGW
         2fXmd9JN5NpktwUXt4rDRv7XeYlYAPtWUwxE6TQ03TCXJpTwYWmUKLZpWGJjrOjorMzh
         haVw==
X-Forwarded-Encrypted: i=1; AFNElJ/GP+/e0lQHfNY3OfYEnd105NEnksvZw8yPQeJpWwZxQU3ICAZLOVbSJAuhsIdH9g0I15SrGg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzrNBkaT6E/wLTCF36eNMjWdMDYp82V2pGrGpES50u1mNSTZVn+
	2MNuWO/9TZvyuFMIIJEJDpI5BolU5ZMSeNacU1EmNbDFzNaFzRG84EXCQMFIcbWk5voUgl0OCLl
	IXCUzZBHWV9XxgIzgYG4mol6uGOWBrKLUUBPj6Lo0HPHGBvzj5qiDvVI=
X-Gm-Gg: AeBDievXjorGR4Dp7DiJdMOp1ux0teoSIW11GdVk2HxCsNs70lTIhUas5IrVcUtk+Zv
	tx+5rWsQuq9HfhiqofOh8S3XuKiDuZJQijiU9Pa8X6FgMwBvKZnbS9ZNl8Yvjlsb8u9+VUR8xVi
	peiH4GqBO47nSB6RKgHlhviEtsh4+pDsoA+INOEoq7Unm8O9d6+r4setOHExNLJJmBg/w+ROtcN
	nbzS461Riz0qUGzVdrrRCKAd/rvvafW5TWVG7xsn1hCN/H0+mGvMNkW091D3QVhkavyi7a5kcQ4
	fTyU5YAQbtjQt5mf/FjLeo12zhPXz4RfnsrCrNxycs46wxjWWg==
X-Received: by 2002:a05:6402:a0c6:b0:67c:1fd5:32c8 with SMTP id
 4fb4d7f45d1cf-67c1fd535c6mr2725210a12.19.1777890768158; Mon, 04 May 2026
 03:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260504102742.3833159-1-pratyush@kernel.org>
In-Reply-To: <20260504102742.3833159-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 4 May 2026 06:32:11 -0400
X-Gm-Features: AVHnY4L7O8G_KVLgdHkNSHNSESCfg5WNMWa7oZ57dDlBl8aWaYRhiLVDiqRj_wk
Message-ID: <CA+CK2bChn3bAFBnmD-fNw2zh-JrAaA73DNmm416EbjXr=mTakA@mail.gmail.com>
Subject: Re: [PATCH] memblock tests: define MIGRATE_CMA
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Michal Clapinski <mclapinski@google.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_033250_918722_E31EBCF2 
X-CRM114-Status: GOOD (  18.42  )
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

On Mon, May 4, 2026 at 6:27=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> kho_scratch_migratetype(), defined in include/linux/memblock.h uses enum
> migratetype. This breaks build for memblock tests with:
>
> ./linux/memblock.h:634:73: error: parameter 2 (=E2=80=98mt=E2=80=99) has =
incomplete type
>   634 |                                                        enum migra=
tetype mt)
>
> Fix it by defining enum migratetype and MIGRATE_CMA. As is the case with
> the other headers in tools/testing/memblock, do not bring in the whole
> thing, only what is needed.
>
> Reported-by: Mike Rapoport <rppt@kernel.org>
> Closes: https://lore.kernel.org/linux-mm/afcdDm4aAJvNaQqH@kernel.org/

Link does not open for me.

Pasha

> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>
> Notes:
>     I didn't add a Fixes here since the commit hash for the deferred seri=
es
>     isn't stable yet. Anyway, I think we should fold this into "kho: fix
>     deferred initialization of scratch areas". So random bisects don't la=
nd
>     on a broken test.
>
>  tools/testing/memblock/linux/mmzone.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblo=
ck/linux/mmzone.h
> index bb682659a12d..8d934ff5b080 100644
> --- a/tools/testing/memblock/linux/mmzone.h
> +++ b/tools/testing/memblock/linux/mmzone.h
> @@ -35,4 +35,8 @@ typedef struct pglist_data {
>
>  } pg_data_t;
>
> +enum migratetype {
> +       MIGRATE_CMA,
> +};
> +
>  #endif
>
> base-commit: 74d1099bb4edfca3ce6edc61dbacbed96720034c
> --
> 2.54.0.545.g6539524ca2-goog
>

