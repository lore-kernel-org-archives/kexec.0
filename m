Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B876C43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PkmUS+qbA9gCTt148jOaQOCsbv1HL6/U/eK4SzvD/TY=; b=Tox067YKM/gLVQeub1mkna78gF
	i927LCU/8GC9E9qbPNw0g5eZ99JCP9HZzaXJ3B9McVf+h5ORaSxjRzd02V1vCgD+p+5287tjKFHtm
	j5XvezBFPFZXOu1X1u0JNWetrObcmgwLd3wu0FylynlxIdfkxT/UTp3ixJZ3CvxBz8Olka4Ux+ks+
	EhWB97N0Qk2O05r1s2Nva9O3Lf3JzYqBkRLyGBtopLjumgiV4VFVM+UL2X6cDMASzj0ngpvsIa90J
	kFcDn4Ay+A7y2aK5pblE2+f2sH9mdgZH9h9LERpi/kkcPxCqSkcnDtHShrbE37Kzk0lYhmwJCTy9y
	UuxBg8cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we60R-0000000Dpk7-0eq7;
	Mon, 29 Jun 2026 07:02:11 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we60P-0000000DpjG-0HIL
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 07:02:10 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-51c06402402so1823891cf.0
        for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 00:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1782716527; x=1783321327; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkmUS+qbA9gCTt148jOaQOCsbv1HL6/U/eK4SzvD/TY=;
        b=Ys/qqsWEBk/h5rnFWOqZq9rTHD1i/rTthfE5PzdO9jmwD74RTn/nF/z1d8ZbdKEVkn
         GJxGTYgtkWuAhuMVlp6/pXbM340keWUf3UzI66NNcI6Ot1EcfRIj7zyDD9LSznQmgI5o
         4qoleP+Q+HYSFOqzbiU8Tkpr0Bgs6uhPQ1mTFD9ULOOubGFhKsNExwat+FnFZnrZAgcx
         d4eZvykGjAfvHBDIksb4ormXiW6wAq/ZJRXDwNnFXFoxBs/VUsCsx/B6GvgygOUdT18o
         t8cRoOgO97oIMtEPCN94VJ/L+4HNDNGpUGkJRBlW2h8YexFwVgaODzsj3J2go90eq1jo
         cqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716527; x=1783321327;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkmUS+qbA9gCTt148jOaQOCsbv1HL6/U/eK4SzvD/TY=;
        b=gNAdL5fJg0vwyLZTD2WiUjiyoyexnc/YqWYwKZWRPY1JkA06RwiGy00YfLCkzkQtQ1
         PPM3VBUTODjtss5LseireDCK5Jewu+JrBEJd7oToL+sisOjJ6KmtbsrpXjRx3q6umrIB
         3O/ab2mqwWQc4PEBF7HPvB54GlM3qKjesSqizyvXv3YPoJUIpYu9QUu03Tx62WiRDR30
         GD7moV/xIGcamh00r0LtpnQxA9mJ+cQUR1GkC63SBBt0KCcDWadj4og9YOcLYNVxTb1u
         HnQIZ6JNZSJjkNsfS8PIikvIGh9Ur9jYJwGuX1Rl0651xVPtf+M/RVJ22ew+q5ZV1gOq
         Z77g==
X-Forwarded-Encrypted: i=1; AFNElJ/fqUt9yr0EXmfpYmBTjKca1c9xjbePKP53xZBHyHxKZonDJNECzuxU7rulbHDVUur5ek/4dg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFH/szBJEAHx2fOTqj0gYQWjlRddM1ro/RtWNoZEHv4pYY+ZJZ
	YXQpsIuw4M5wZz/ujKft9n0KAgk2TmH7X5HTHlrc64WEEfRh8qUI90ofy33K9FaJFEQ=
X-Gm-Gg: AfdE7ckkJ+EC+1xaKYf6hWS4THluNzdNmjhBNmwd8rJW+XajbfALR1HiRpv4w6waZVs
	BMoa41cYO0JZip/V8P/EGzVEUT92F4C666BK7HoHoM+kEWwDg9rzZGlr7+lTitD5YuM/fzx/+mH
	nSA5QdWcA1qC2DqUT3nuL7JN3ZLDu7UGxpuWj5IEIFX/4eHnC80LZuLL8eH7mz/MYxsfUQL0FiE
	MEQGvqpp0H7zITTnpwDYRklq61IRUOGviy95bmTihH0R6v0AQ29LJrRy7O6iIgu7J8F+fpwwRAs
	6OdSevPv6EfgOFu0OAg7kjqm3y1oEpGPMpWmtDowAbVlBSOZlzvOPMhyDGZkMALE2Bt+njlBEAp
	gzvV7HpjpTOfSpX/a8kc92hf158IS3+k8h5iWDd+DtzbgYXbJyBimCm88I/w1TsbvVp1cXP9Jr8
	QfqQHcVxScTWpnC+8aP8ofiMILf7GNs/JGYD7PTnNphnxEOPfxWuSN4+FxsPKD
X-Received: by 2002:a05:622a:608d:b0:516:ca56:a44d with SMTP id d75a77b69052e-51a5178907cmr318181201cf.6.1782716527051;
        Mon, 29 Jun 2026 00:02:07 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82692bddsm300651096d6.43.2026.06.29.00.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:02:06 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 3/3] luo: Update serialized data to use KHOSER_PTR
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
 Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
 skhawaja@google.com, kexec@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260628001114.1869564-4-tarunsahu@google.com>
References: <20260628001114.1869564-1-tarunsahu@google.com>
 <20260628001114.1869564-4-tarunsahu@google.com>
Date: Mon, 29 Jun 2026 07:01:59 +0000
Message-Id: <178271651966.13502.2620034351625890943.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=i8hMeTOD7PlXYKXCkQGIEVry2kHEdap7Vv1D92UaDwg=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqQhhtIYYuZBg6KJbH62WNctwI6mdsZePcCtfwN
 44MDknREhqJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCakIYbQAKCRC7dyhM23N6
 3h/YD/wNczubLTbms0pFp3A2EyjJjFEM/LlM1mQL5Mhx3WmXPxHlAJnaL72I+6yofWcwBajg5VC
 ernzYQ9l4uKEJzGRufG4MYpNHUtkTOs3Tz2nl7q7sTrmmWxoWj6EIZKcbDEWMRCns1bD6Vwnt6m
 a60hANaw9vrEwDmawr5obeIpzd0llmmSE2E3k3O90f8fY58rKkrqyEKeoW3Mi3gOJv9e5PzZGsQ
 s8ilIjofewCeCXV3WT9wwl4TKhiNLel5hY0yIlSCQhJ9a9Z2/Mq/010UoEuu3LTs6IrV13bXZ0r
 lDwx70HJVLinpsyqDu8duUaN9Hm8h/m5iRaaoR7zX6Dhxkjv3laM9PzwHNf+YPvslIA33JdnL+K
 PP0WCurgePElqGDXZdMrbV1lNZgbAhXq1YD0/IrYIoNEqyZh/n4wJKlsA8G2kqUCdAmzqKUSuMf
 zwO4ok5vooB1vI79jbSk57ltu8iWxuUcWdxcdyy+Kwp5qzR0B3smYZe/VOexN5lUmb9bIW03uyG
 IQnFXE11wh4D7UDXUp83rP0xZetlhhueDiIY4+x2MIMtChuf2L6K3F6yri2SVXDZOQM7begNd1P
 dqfg2xV4Oq2UD31U+CAGg7r/NzfOxnBDmcJhrU8QzCfxECfORWkuukH7bl+PlBtU20Mc5dliL7d
 mMeCz6aR1v1fQNA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_000209_142244_A1DF1C58 
X-CRM114-Status: GOOD (  10.86  )
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

On Sun, 28 Jun 2026 00:11:14 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index 288076de6d4a..9e78625cfdc1 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -89,14 +90,14 @@ struct luo_ser {
>  /**
>   * struct luo_file_ser - Represents the serialized preserves files.
>   * @compatible:  File handler compatible string.
> - * @data:        Private data
> + * @serialized_data:  The serialized KHO pointer for this file

I am concerned about layring violation here.

LUO is designed as  a generic, opaque transport layer that promises to 
preserve 64 bits of raw data. How those 64 bits are interpreted is 
entirely up to individual clients.

While some clients like memfd_luo will use those 64 bits as a physical 
address pointing to KHO-preserved structures, other clients may store a 
generic token, cookie, index, or non-pointer status. By
changing u64 data to DECLARE_KHOSER_PTR(serialized_data, void *) in 
struct luo_file_ser, we force KHO pointer semantics and layout 
constraints on all generic LUO files.

Clients that need KHO pointer serialization must cast that opaque 64-bit 
value to/from a  KHOSER_PTR  within their own callbacks.

Also, the field descriptions in  struct luo_file_ser  are no longer 
aligned due to the length of the new variable name, I believe it will 
cause warning when making docs.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

