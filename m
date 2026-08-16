Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB4EC5B572
	for <kexec@archiver.kernel.org>; Sun, 16 Aug 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/vm/j07+KL21gvKlwAnAdnCIMV+QoeEuexJ+hzKNEg8=; b=aGeN5FlGkX5IJUXRiDAQRl1OM0
	R5aNcRd9FX6cG+b1jWYb6WU9i4Lg9BMC92t3Y/FKol7Meev1U6UJQRWaL0uvVBbeVi3sBe19OKXAJ
	rdXWt1o+O9YszUS6482GgpWKS2FM1zebODN9e85uL0AETtcuZs/Zh3ypkkzCmGkend3ln7cKfnbpj
	rXDSJwhKhKefM9ULbSjvkHW3nTxhWXdQ47GPh1VEtwKwbt3iL1giVVtUvJ6IbqUo2CLGH0T3DQkwo
	BZN/48aIxsMBKerb+osYSqW2X0X2rT80MZBA/d7ofjdKYULy8daSzliGgea3u/P/MJ25EHVc1sWyJ
	PXMASxlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvX7b-00000004bwH-33BH;
	Sun, 16 Aug 2026 09:25:39 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvX7Z-00000004bvu-1h8I
	for kexec@lists.infradead.org;
	Sun, 16 Aug 2026 09:25:38 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-49800c6a846so28083075e9.3
        for <kexec@lists.infradead.org>; Sun, 16 Aug 2026 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786872335; x=1787477135; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vm/j07+KL21gvKlwAnAdnCIMV+QoeEuexJ+hzKNEg8=;
        b=kivYV3uFTEFy0gn0tGoD2Pfykf19HxfRaa/Z6FtfYhGxuNPJLnMj8V+xdysJcTJoPB
         G31FKsqh4RqE9h8cP4CmIcWITHN1qJygIFBrlahUMc+pXFBBakpbsEXukNbiBfRwc6go
         bILCbP2U5vSbNpdSw7ckFpPtCOQBziYbM7DVAY2jupD04capMlRpt618zz0tZYPm/ZNX
         n5XdNbSARydfBwzASeglHxXP7MvUNmkyZKs32mKVFUGf0dFzzWlUTH0E3xIFjL0JUjw0
         KRO4DKcLWRrx0wtPYsXvROvlv5nvmunnp3FUhNHeuDQ9B5pq2ib7MuNuXztfFAVFuWxs
         NIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786872335; x=1787477135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vm/j07+KL21gvKlwAnAdnCIMV+QoeEuexJ+hzKNEg8=;
        b=fi92x79rGujzUnIQP/mwb6ecXguDCBeMxKGXocUA2xwEeIynumqaeYdxVWvQND/pTn
         qswo5zZclOF93XISaFf6+f0ECcys2EP5KFuQ5cLZZcNfnSd85acX+rdZ9V/pQFmdClAE
         4t2Ly0njr0Z4t4DnHJogTPXGtGN3PiDRpQpBK6V1amL3NPCy+VKtN/SGu/soFIav1xjc
         yixeeZL8Ronu+pc2ABiPPaS4dFcyeaLAYqqaxjkciEYl2UF5hfphA+E+1izhhaYcXJRV
         TrAibEbXKz3mjXiJhSeltBGTbmV40Q6FoeE0MeNM8QT244VqU3QkpdTYiHGZXavmfeFA
         ljAw==
X-Forwarded-Encrypted: i=1; AHgh+RrDq0v14xF2CVGcOnzx4tnXwUrMd2DddSdZi3lPGFejrZFhjaqs67aNULSyYvC9oV6sMa0r6g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+ip7yGwNjHDmVulGKv3HNuwSU4CoPaNOAjWK+/pR+Q5m516qZ
	9fU3uQWiPRVOC75r9lMGX1ofvyqJpcxOyuf1rgrIsVdnbvefFrmSBjaO
X-Gm-Gg: AR+sD10kPPq4ebdHCGr2F3oZDZpD/Wl+zgCsMhI4dMsmf1knPrWH0uz8/tYYLq6CfMU
	2HPmMCFIm4NZuoyCqq806XAelvua0GJenz6SgwSPZwYVLIog1lYj0AlgDdwltXjRYjcuIkmWZTp
	g3HOomrpjLuPCZQLDDEN7hfRIWMpyFV4BUE77pof/L859VI132kfpAkLMPm1Wvb/YKLNGliWQ0n
	6kxo9NuXzkpYyXeZ2IAvZJ4VnBgfh2eAub+sSZldTlyVWde4wCJ0iJzirjSNr9U8hus7qJnJ+/c
	Z1kM/yOWyTqH8Hs1UjBK1KTeqzkXuzTv8M13wBjNemYdSbViSjGB1uhhc5k9L2UVVOoNsWhgnjj
	3yHSkS7nYGFd09ZM27DwJm5zQWyQSod3PjisdDAiUDQE0L5uCU8aWdGSE0ixBrqRVY5OySyhr3J
	nDJSe9NibVnVkm26TzGPADubez51WT4xUCijmK1UAfL+6m0GpXV9DVyzob
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id 5b1f17b1804b1-499878ca13bmr307331535e9.0.1786872335384;
        Sun, 16 Aug 2026 02:25:35 -0700 (PDT)
Received: from zen ([37.203.152.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b8asm27309575e9.11.2026.08.16.02.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 02:25:35 -0700 (PDT)
From: Kiarash Azarnia <kiarash.azarnia@gmail.com>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: graf@amazon.com,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix signed shift UB in kho_preserved_memory_reserve()
Date: Sun, 16 Aug 2026 12:55:34 +0330
Message-ID: <20260816092534.3333563-1-kiarash.azarnia@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>
References: <20260816090038.3117276-1-kiarash.azarnia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_022537_453114_17A784C6 
X-CRM114-Status: UNSURE (   6.25  )
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

Here is how I reproduced this, in case it is useful for review.

Minimal reproducer (prints what the function computes, both ways):

  #include <stdio.h>
  #define PAGE_SHIFT 12

  int main(void)
  {
          int order;

          for (order = 18; order <= 20; order++) {
                  unsigned long long before = 1 << (order + PAGE_SHIFT);
                  unsigned long long after = (unsigned long long)1 << (order + PAGE_SHIFT);
                  printf("order=%2d before=0x%llx after=0x%llx\n", order, before, after);
          }
          return 0;
  }

prints:

  order=18 before=0x40000000 after=0x40000000
  order=19 before=0xffffffff80000000 after=0x80000000
  order=20 before=0x1 after=0x100000000

Order 19 is a 2 GiB region, reachable from a reserve_mem=2G boot.

It also shows on a real boot: with CONFIG_KEXEC_HANDOVER=y, CONFIG_LIVEUPDATE=y,
CONFIG_UBSAN unset, and

  reserve_mem=2G:2G:khotest kho_scratch=128M,128M,128M kho=on liveupdate=on
  kexec -l -s --reuse-cmdline --append=" luo_stage=2"

stage 2 warned in memblock_add_range and lost ~820 MB (MemTotal 5181908 kB vs
6004928 kB in stage 1); after the fix, no WARN, MemTotal 6004884 kB.

