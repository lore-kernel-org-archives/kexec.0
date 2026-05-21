Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6041CD5BAC
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O43uMa51N36nEinrWO9reEuS/JlOyHUwEmdF+rTGNKM=; b=CcgkFiW5HEHtnSoDUnp9Z/LdRK
	J3GVim/kNZHi+kdz24qwutyCTuVJNiafqs0euOMfJcnbgcoB5KdtPDrW7/scvL3pAzzVPOa5FjADf
	r54oaRymGdOp4KBhgcTJnvrZp0za6/ZyEYLZ5REppwbMLLU5imz311nAXpaz3mxry4wS29GdazOzY
	FmyzlAGs1GIERvklt0tbB+ywN/XEk3AGOUrzXrEnEDxrl9BOtHmYxEZv8oVbDkCE9f5X0k2WUGKTF
	zJqco8S9iYYE2YPk0pHpyxDpmJ7EWW5dCY85Zj9K4KsDsC3dBnzsH+STqmxWNXOOQ/+DbOsxllAA6
	Y1bS15Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ8XM-00000008qGr-1XMi;
	Thu, 21 May 2026 18:54:28 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ8XJ-00000008qGM-1yJp
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 18:54:26 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-50e5ad864a6so74444721cf.0
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779389664; x=1779994464; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O43uMa51N36nEinrWO9reEuS/JlOyHUwEmdF+rTGNKM=;
        b=SZsyIGQK47WKas58utbFhLJax2hB1R0bgq6Tm2fod0vdyqvGXrwA78JkYqtiYvbuhy
         cDweqVarnzBcRx14bP/6hZ2HUaB0W5s/v4X84h0y9L/YuzBmoyS2k/tcwCN0pSxTbdLT
         D5gULuLxlkTQSEjJ+CPb6x/4MOP1upbRKB6qrI0JPJtgmoe04NR0FpWGdzWUE+E2HOhD
         bryFz4/UUNnk6br6cPBkRnLQdPabOyl6O7AGITl/f6wh3agaGXKLi+7bKmtXfjLoxWKP
         7vmAzg0MSIks3dNwy2xR8drSlzXt/1VEiQGOi/05DD14q4uH/dDDBXUS86xn2oBQjTNS
         3qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779389664; x=1779994464;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O43uMa51N36nEinrWO9reEuS/JlOyHUwEmdF+rTGNKM=;
        b=B5D6iyiKItuLVY2s3SGHxm9dbnK5GuZXpr1ymuCWOUDI+KxWhlZoZLrmPolKch57oJ
         Umphz3tLyvqCNqx3zdSWeYxamEPxjx4Phsn/Om7SdUKXvECg8iFMBVXrKYtx/pGJG6Su
         bYOOzW0Vdv3jwVncj4yLu4EXqDQXP2BV/u6gXQq/L0BphD3/G9+fUNwCudLoLlS4IreB
         1XG5LmQImlUWUHQLRjtNqIRClIEmCxkJup4vHol6kMGibyU5E2jRCEKeDiLbm5q/tmba
         d9BQgYzps10xvh19/Saye6qkGpZOZcTrBjT39MojK/D+W7QhsKayyqW0DVPF0DQVFKeB
         kU1g==
X-Gm-Message-State: AOJu0YwqNEZqOXGuDVUi2KavLzcxPMA7RNjiKPYiRXEFw4KrdF1j8dGH
	4zaGGXEtG8PbiX9buugCXw6t0/ig+lmk6N1v7Gh02sbVlVZslF8JgiJf1SFbvcmk/fR2NIsIFsJ
	ZvDrD
X-Gm-Gg: Acq92OE2c+RBcCsVi+G7WZop/LGtSPYnDamxY4I0QCsqwnFzY/tQ2+RcA2/9PPbSmpS
	fCeH5uC4/6WBgI23LugF6/YzIK9hbz12XvMo74Ucs0zdvqHEv52cxoUO1P9wk7y+W6DoU4RCByR
	N8Aw+M9lCvSMNdO2zptU5TxZMrJpeByk5yGEnqETr+IjKDHwDYiC2kmkczhmQ41SNbwxllI8xMu
	XQIJtyav673JG4A2dHZ2PJfFvjexE33qKAobJOoo22Vg0YGAzP/mFiuC6Bdr327G/axOaoQOT7O
	7wxGOw/A5R30gL4Ls+ZUa6SgbbWQlD2+XGrF0hNtzDV73piQmA4HqnhqXVItudYEjSIAeV5Mj+n
	pZRS1njkBjKBJOStw9t2RzfaHSuy4ex+wa1IcadZHrl94EaR2ZXpuHBuFQ9oUeLhtdRNEM2PqPl
	W4aXvowWZb7kWhHUNNox8yF7OBvuU3I69FQ0TXnbWDVVNgvV7XS69S13MkE0Hw
X-Received: by 2002:ac8:5912:0:b0:50f:c1d4:d9e1 with SMTP id d75a77b69052e-516d4376f6cmr8327631cf.38.1779389663980;
        Thu, 21 May 2026 11:54:23 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516ccf4c8d2sm13751251cf.29.2026.05.21.11.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 11:54:23 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Changyuan Lyu <changyuanl@google.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260519160554.2713361-1-pratyush@kernel.org>
References: <20260519160554.2713361-1-pratyush@kernel.org>
Subject: Re: [PATCH] kho: make sure scratch size is always aligned by
 CMA_MIN_ALIGNMENT_BYTES
Message-Id: <177938966317.1212271.16034923918291092372.b4-ty@soleen.com>
Date: Thu, 21 May 2026 18:54:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_115425_521862_50ADDFCB 
X-CRM114-Status: UNSURE (   8.47  )
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


On Tue, 19 May 2026 18:05:49 +0200, Pratyush Yadav wrote:
> When using scratch_scale, the scratch sizes are rounded up to
> CMA_MIN_ALIGNMENT_BYTES since they will be released as MIGRATE_CMA. This
> is not done when using fixed scratch sizes via command line. This can
> result in user specifying a size which is not aligned, and thus kernel
> releasing a pageblock that is only partially scratch.
> 
> Do the rounding up for both cases in scratch_size_update().
> 
> [...]

Applied, thanks!

[1/1] kho: make sure scratch size is always aligned by CMA_MIN_ALIGNMENT_BYTES
      commit: 4129715f7ac5b71183350f1983023caf0464cb9b

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


