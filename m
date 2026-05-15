Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7C5CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRDBDq+fY1oMHQKVFr7tarGavnnf2HzpsD2dAXXMIQM=; b=axNhD9JWE83fSYci0jrgR1vCQb
	s8vON+Jp+NBzDm2c7qoIrkpnw7AwyADa48oy4kTJNbYiXpQYH2Z2GKBWdHtswg7nlX6VDBbBEoAOs
	lyIumQUY+Xs6XVp7PhzLjmCK7OcTDUNhL9YAnO7SS959AH049O9wm5nCfzhq1Ap6ezAQ1JvUn/A7G
	Khg4NMNkBo0UoE7aIC1dYSa6cnZfN8fysKIp0Agxy2we5bCE0ctPKAkRxJafY61vlfDI7G72E7iQh
	UKwmR+iDGn7v9oVOcnAvRWec7179IR+mBdhex96EhqmkK2EKGiksWXWsQ5B+Fg2+L/SqtBbdC2cpj
	HnTSGLuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNtNm-00000008YTb-3VMe;
	Fri, 15 May 2026 14:19:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNtNl-00000008YTJ-3B0i
	for kexec@bombadil.infradead.org;
	Fri, 15 May 2026 14:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cRDBDq+fY1oMHQKVFr7tarGavnnf2HzpsD2dAXXMIQM=; b=fmLDxXSM7gS4ZyV08kJVEPIFQg
	5K8OdgtjtEXBsVYKqxf7kr9XVRHoh5tBySpWqrpEgYkxgLJjyoYylQEpBCeu0XgJ8ZlJ9QyidnWc2
	NYSrdY4lbsQ6E49oEdyRt3avGxEmP4yXWweg+uKRwRipSEhBDCHlOhYIVumAVkUggzcToAlXW+VaF
	b5dUVcRQt+ANE4UJXbwYvHBvBtZwGXOZc0p6QnLHfIixB6CW5NSLegmDG6YpZ1qWIjg7HY29+/R9Z
	Hn5xZa1mkwpbxD0Kk9ita7OgmbnxOba6Ra2/oyrOsl7GTmA306pV5MTvcmCKMiykODuDkZnnDwnDW
	hi3S/XDA==;
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNtNi-00000005QbZ-1FRd
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 14:19:16 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-6530287803cso11838481d50.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778854752; x=1779459552; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cRDBDq+fY1oMHQKVFr7tarGavnnf2HzpsD2dAXXMIQM=;
        b=k3hElnH85g7ORYZscX8vrK/dYt7GuJKIPJTCECjkDgVQrQyC1fVH0ieGYRc4uk9htQ
         ZddIxFwvbT/eaDmzFLNnfSdsFyc6nbA6unUFsYTkBRQXZ/LbUom2RnKHmrJJmPoehO7W
         CcplYvyCpZFZeJBLl0juA+JDNPKLeDuZxieLg1PkQwwO99OeYmbZS95oNLrtJNwX/KLP
         Qoh44n2W7k0R33bZXNJUfvbQEWXWnpsWOYzj8Mgb+nmH7/NWuID/UxDRR5l2M7Rb2+Vt
         eP6x2bc1DkbUrSZ0gPovl4lgw7KocaIEt8njj+KC4hfeYXsUw5fuDia164zQha1o2ow5
         PMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778854752; x=1779459552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRDBDq+fY1oMHQKVFr7tarGavnnf2HzpsD2dAXXMIQM=;
        b=VGLSlVR86vcne7numun9vmDYPoMH04xtt6Aw3CKJgV4DwJERhZxQxkQENu8efFVHdQ
         /lUlM8f823u3CXZvmcyh8t31yq7ADOSOHkK7ajI4d/E8xu/PKF4lT4mRU2ss04jPmo7P
         qA/4r9CSNTUmh+bVi5YU5FxzXRp52GEb0n+1z0z3fohjvmnmtfqnrHjdMhGfguUWWReW
         LohnBN60+o6U18pgMYvk3Otl9Sc4+6g2PKUGkvWNcCg4Ak9K19Hy/v05mskUTgGo3J3L
         9fHmrUx8t7eIPnHJ7N5cnCi3+gtiUoV+mkYnJHzXypXomUR/tbVvqe46fw03uXaLtbut
         kn7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9mMsUR4bLJg4VPLsfBs0DyetjbTV9AyLUbXAofs6sLpMQ6aXJyKYoJSnCawQTsj5MU2IFXWQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzYDYCBOlBwAmcDj67K0s4JIbdX3adP+iLZPtWQiIHXJs3w7oK8
	iAYN9x4vU7w/Y1tL9IUGBKSWPFO1i6d0FAbFl+mw1mmAAhKO7TQYsuMy/n7L5w+mgpY=
X-Gm-Gg: Acq92OGKraIrxj5MplfM6x8XPBfNu245HBdLwHToS9mX/gFTI+Q3T7W5Lt7dAgPufSb
	2QUqhIiAlq42vNySiPW2BI1PSZHdwhdxnqhkpdL2lmy2zwn5tKCPvevpKC06YvqiXPRHcozYZq2
	FEX07tF9cWr30YPyYtodgSiE20uDAZRD35i/AlESQGT51StydbeIFwfln1KzbJ3WsD0f5Zqls7f
	C1PRP5KG0vlJpiSLj2XDGUNmqOMPM7inf2Zk0dftjRAAA60Q5y4yR7QiJSBCvWM/XU+ggtgJVc3
	SUvwXZMLr+gFrSHQJVF2VL4ZnZoheAPfAFPxTVVhhNFaDmWzWiScoJZx5+7d9ZBkX/mLkxrvBjZ
	girEtBE7/9/uA8XULTY2WJrty+E4G4+9v0cXVXsy3NA+4UM8j6/eJ8fZcHVofrFod6zVKphUm40
	s0DPqqk4BqHWYv+xcx8nfMTjArBAFumjSx0xJA8+UEyK8rmn36Dj8=
X-Received: by 2002:a05:690e:1544:20b0:651:bd70:1622 with SMTP id 956f58d0204a3-65e2261db18mr3576259d50.10.1778854752017;
        Fri, 15 May 2026 07:19:12 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c359c74sm52887436d6.45.2026.05.15.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:19:11 -0700 (PDT)
Date: Fri, 15 May 2026 14:19:10 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: George Guo <dongtai.guo@linux.dev>
Cc: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
	graf@amazon.com, jasonmiu@google.com, ran.xiaokai@zte.com.cn, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, George Guo <guodongtai@kylinos.cn>, 
	Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH 1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
Message-ID: <agcrLMYHwcEi8_G1@plex>
References: <20260509024415.33190-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509024415.33190-1-dongtai.guo@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_151914_725361_ED80643E 
X-CRM114-Status: GOOD (  15.01  )
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

On 05-09 10:44, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> KHO_TREE_MAX_DEPTH is calculated as:
> 
>   DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
>                KHO_TABLE_SIZE_LOG2) + 1
> 
> For systems with 16KB pages (e.g. LoongArch), this gives a depth of 4,
> with the top-level shift at bit 39.  The order-0 bit sits at bit 50
> (KHO_ORDER_0_LOG2 = 64 - PAGE_SHIFT = 50).  When inserting or reading
> a key, the index extracted at the top level is:
> 
>   (1 << 50) >> 39 = 2048
> 
> 2048 is exactly the table size (PAGE_SIZE / sizeof(phys_addr_t) = 2048
> for 16KB pages), so it wraps to 0, aliasing the order bit to index 0
> and losing it silently.
> 
> On the second kernel, kho_radix_decode_key() sees a key without the
> order bit, calls fls64() on the wrong bit, computes a wrong order and
> thus a garbage physical address. phys_to_page() of that address faults
> in kho_preserved_memory_reserve(), causing a kernel panic early in boot.
> 
> Fix by adding +1 to the DIV_ROUND_UP numerator so the formula accounts
> for the order bit itself, giving depth 5 for 16KB pages. The top-level
> shift becomes 50, and (1 << 50) >> 50 = 1, which is nonzero and
> unambiguous. For 4KB and 64KB page sizes the depth is unchanged.
> 
> Fixes: 3f2ad90060f6 ("kho: adopt radix tree for preserved memory tracking")
> 
> Tested-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

The patch fixes 16K support on ARM64.

Pasha

