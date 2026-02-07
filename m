Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5FBEE0AEF
	for <kexec@archiver.kernel.org>; Sat,  7 Feb 2026 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jB/fqSueCYt2RA3ppkdZrQ1ODDWf2CGc5HEiG/Wtd9g=; b=XK19KJ5nWrGwLSJ5HIkp4gHrS0
	mjXvNoPCkh+Sbr6gW7Tdb42wlrPkgT5mAyiOOhYJ7Sa0cCYk1oVeGxPKZvVnymoVqavQghlkU70gd
	pFHtu0Ba7rIrr5pHSy6gbOZiyNMeMBIGEGgOlTcUXxqpVE989pWMpxbOruOrR+kFXWdmyFsmPyTdC
	QSA04Bv9z8+BPTQhVdBsm2JmBorWie1D3qFlgU1aHfEvGGZ67LrHIgDCsvaOz1nvl3wAXJHND/+wv
	nvLI8mxGpZS4DSSBfJEtzaA4W4mecHgt6uNwz7fw2kdqSaEIgvbTWjDtHGw3hxCZ5sGTqiiRTkzql
	jY50K8Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vomCp-0000000Cen4-3nWD;
	Sat, 07 Feb 2026 17:34:51 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vomCk-0000000CemI-0dd7
	for kexec@lists.infradead.org;
	Sat, 07 Feb 2026 17:34:50 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso2295440a12.0
        for <kexec@lists.infradead.org>; Sat, 07 Feb 2026 09:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770485684; cv=none;
        d=google.com; s=arc-20240605;
        b=XzRpYVQb2dE216DbCpJng+/AnlkC2/lVqYY2ryzOLNfU9Bf46wmPXhpb9nlDCcEMbG
         2X1HWAar4tMMIrx05daYWx7nNf0EvvyF+r1xicB+R+gOkfQg22/I1uYx5FCTw7tOtnqB
         qrx+Vt0kK8u3Rhhc/KTFKDeKzGSY30lDf5rmUK9xVXOY1WqyLpdPEZAEKINCLJBcQ3Af
         Z7fCj967acQlMhqagasv7l7iY7VuzLX8J3USMJqtvcNI5yIFOZ7twO5JDaKFB3iPb3GD
         ckXBEcxchhuly3c+q3G1bQlSSHL2uUVTpFHI2kCyAwJn9TCWyOmp1JeDMxa4hqs53Iip
         wgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jB/fqSueCYt2RA3ppkdZrQ1ODDWf2CGc5HEiG/Wtd9g=;
        fh=llKWxV3jgy/ojvEBaSEZH0ubUl5Bk6ptWUuGk7AlGsI=;
        b=X/4GPFZULtQOTLeTYfORYt/pW/OpRL+Q8Y7Restb2G7J9E6YSxpvXC6eOo/4X5NYdJ
         48uK9+Of16v2ePeTx530jCXI/YqcevXI5squiN4wW9OfNM+K5EUXB2WCJly3/LfndY0p
         v/iyAlkXDoMzMrOR/IbMc+DpxKdLl63ztfb8/zUDNejTngkeHzswpBcEykji+KNq6P9O
         dg/wyrISWBtBYSmSqDniCUe4nP7nRjj584DEsclf2wO8edX/MyfWb1btqPWFqm7lh3ll
         NvVodqCtuUEw1TwTmgTzZ+Kay8N0rFLwNYskdYBxpLNAPr2R5kmGazT5LSSKAs04nUBw
         /AOQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1770485684; x=1771090484; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB/fqSueCYt2RA3ppkdZrQ1ODDWf2CGc5HEiG/Wtd9g=;
        b=Ip6bhtk945CtdATNy2gRS/v/0jF0lDGdva43O9EJTzQ1gPlom0qTLZ0Yw7y9fX7C8f
         rdGCsn1BWvfpnPXbAw8k/3WsnE37WoOzSB9FJWvVyG7GQcWwKOaQWvQFnoHBv3IpFU4P
         +iZeHQ0CMNSsl2Bxypx73BvKbI/sB4cUSLqyycnw4i68aLd0bmGXB+KY5bZASykiCboX
         yWyneucFScetXLtA/eQ1xJsa7/mtTm2E3g/oQ7g3eKAgk3sZJka6sRDQ4VPITtAtGU+C
         bfFS2/QuKiqSAbB+3QyZS68qE1/BZ4rT122y+Dos8TOWRLqVRpUS2d5FLZjxydLBWGTF
         tKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770485684; x=1771090484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jB/fqSueCYt2RA3ppkdZrQ1ODDWf2CGc5HEiG/Wtd9g=;
        b=r5U5cXcAmudgAc4E1Gsqjx+MwGVYQNeCRl5PwIUa1JWW995OgMEIa7j6XkrleRaoUX
         ojIQbrhMIHQIrXrKSfcPTWCQHNu7RxhwnTRmeUpPZHPoyRwOdQtsaMn6s4+gbUGpVTtX
         5onP/DpDX3VwHwUrwbqTVH21s9mR54f8ZAmCG2q1DsBwzPdK2Z2jM/l1/eLsduAtWGvm
         I7/Vz/Psg+6NA0RsotEjbOH/GHrU9iqkVBq5B63qAUvohKd/PZJJ00E5PEUPlk5zqqhO
         ApMSaqfBHNh01fD7PCKrdBP9t2vVdqsGBxnrjfnt4HU6dD77IiIPIpD7c5Mpz7HhGVZe
         PCGg==
X-Forwarded-Encrypted: i=1; AJvYcCUeCnhaRgdKMvjh+pHE3ftetLGqbiqR3Z46UXenMaDBXlG7CikdrLwnnGhSdiGQsylECOC8gA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdkWnEO+5jjj5KtfaGHOBB6N0oOGptpc35g6/lLeZ8h5ZQh6gn
	KXBTXL25g/O/LE/DLWlBHwoGXvJtd4BZd/l/yreg71asDtjL6tU2jTdhqVnoRC+ry3h0NycA7Kk
	mVB3aWGQ8WqFDOhGWp+PVM8KS+1nPBUG0cSPcoS0IgQ==
X-Gm-Gg: AZuq6aI+LfOs9vTgDTralpsy925S44MWAGIfj15o1FmVdPwRpG+jJMEDUXXtHNRs/sL
	Iyud+4kIdAUNmu+2JS0k+dqRmH7CoWDOSDExIeXQvdywxSZYEeEwJ9Qg8Lnb4aio1PNzPHmcKVz
	NqJeXXK61DshvlEwYSXEneEJmpetopKPfZz23gqWU9LxZoGA45m8AI2fdLU6dVofctI+nMJeDox
	DvXZxLowJmrDT6cw4P6w7d6KpaXg4XttD6W1G4vQkSCjD343aNx5FHZkPCSPmYsHxgjwzDawSwA
	fOET1xtp4F9va7swhLCLwSj3Amw=
X-Received: by 2002:a05:6402:4306:b0:659:454b:7167 with SMTP id
 4fb4d7f45d1cf-6598419575cmr3540228a12.23.1770485683992; Sat, 07 Feb 2026
 09:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20260206043121.197564-1-ranxiaokai627@163.com> <20260206043121.197564-3-ranxiaokai627@163.com>
In-Reply-To: <20260206043121.197564-3-ranxiaokai627@163.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 7 Feb 2026 12:34:08 -0500
X-Gm-Features: AZwV_Qh6oCM3WhmWEP1Nry3xlXhW5Yie6guDA3kOhQ8BM2V2J9MhOnj_y4jt7p8
Message-ID: <CA+CK2bCW9fNShn=BUuje3tAnSydCQoKw-7TXYK9HahO5DvZqUA@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] kho: remove unnecessary WARN_ON(err) in kho_populate()
To: ranxiaokai627@163.com
Cc: graf@amazon.com, rppt@kernel.org, pratyush@kernel.org, 
	akpm@linux-foundation.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_093446_230330_C1D80911 
X-CRM114-Status: GOOD (  12.45  )
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

On Thu, Feb 5, 2026 at 11:31=E2=80=AFPM <ranxiaokai627@163.com> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> The following pr_warn() provides detailed error and location
> information, WARN_ON(err) adds no additional debugging value,
> so remove the redundant WARN_ON() call.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 76b714db175d..b851b09a8e99 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1507,7 +1507,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 =
fdt_len,
>
>                 memblock_add(area->addr, size);
>                 err =3D memblock_mark_kho_scratch(area->addr, size);
> -               if (WARN_ON(err)) {
> +               if (err) {
>                         pr_warn("failed to mark the scratch region 0x%pa+=
0x%pa: %pe",
>                                 &area->addr, &size, ERR_PTR(err));
>                         goto err_unmap_scratch;
> --
> 2.25.1
>
>
>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

