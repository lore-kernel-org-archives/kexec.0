Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF513606A31D
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j01d156O;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BymbJS+d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tJhC0Ffmn6Au+X55U+ymWoJQmHp6YtJ+SrtYAdk8xK4=; b=j01d156OgnfBE/
	0fI/Hk+ZGxwHnmBX8AjUHi+n1HL8qcw4Tx2P/71l0+XjUR9KADKx1Fg11nnq1JRt+zeymJJHtxons
	iwMfO6++F8v0h093CDz+jf7um8X3pAXe7uPaEBJ9FUpdMEPHv8CzKsyBumRl1bhpQuwlbFO4oiO6G
	w1Q6HamYRgW7Hyj1JzE5XU32yzEHhiYgfGPPy0zIESYKWUsoG7pJe1V61KLyFk/AW37ldZMGXiT33
	ueNSEwfhbZKjqc1gjNtK0zV4zyBnj9eV23qPNkEG83fEjpM67e1/KG2lL9EaHpF9frFmuEw1FJWmm
	8uM1EMAIO+yTtac17f3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdaY-0000000Cu4S-2Vj8;
	Wed, 21 Oct 2026 21:11:10 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdaW-0000000Cu45-18NP
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 21:11:09 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4a1ddc7c9beso6532885e9.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792617066; x=1793221866; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJhC0Ffmn6Au+X55U+ymWoJQmHp6YtJ+SrtYAdk8xK4=;
        b=BymbJS+dR2pvLPZiYbXWb22usHM7E8S7e//eXbufdm0vH39gO2IOGuvWZx1MpWkShJ
         MN96MdTFE2wifVCSo3A0SqdBlMPWKbAFTRMS3HA2LacJpHLgWprC2bbd+U17gLBlY/VC
         Lr1Edpq2GzlAkMcbXbKKAGdLWqgE8xJ8LhkwXyn+qgDLFoMe2//tQwQaPmwEK99hyKYq
         qLiX/1EXbROFVIjhb0LgnVyV/kPrZLII5x2RdZvcDIcmfwOimK7DX2nPgdiCIUdGcGVl
         bPgETwjUOfDEftHtCyLzgiGkpZYxZuWxF0ToNLltRCA9FGAT44vwW6wlctoPnw2kJhVl
         hlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617066; x=1793221866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJhC0Ffmn6Au+X55U+ymWoJQmHp6YtJ+SrtYAdk8xK4=;
        b=kTO5t4gdmpXeNaXH4mUBNm5Y3dfzCPgXVAJnxkJEbWHo0xypk+8YGqATjlwrwze99U
         Yt75ekuiBJzk5UyUaPC3IWZG8bZf7qq3s6mC8CsX58sf7u7jc0PnwPtcRkfUhe+oyRjA
         AG3+hRY/Wwv7nerqZJ1IobuNPs4pEq6P1mwOvH9oGgtOZNsEHngqCaOkWc0MdHwZzL/B
         VxYfqKAOzieV03w6ZRhLqksh/9kLNo5KiCmh2TweclUVHuhVcV7hFEyFApnbDG3hbQx7
         ZcMw7HeP76mO3VLXc5bSb/YYec9hsWJuScI+EpUZhOmvW3hDp962aen7gBu3vy64Z5gm
         XFdg==
X-Forwarded-Encrypted: i=1; AKwUvByjoWo0oGonnSH9lrV3NQUFaF6j2d5OKheUvVvtO0Ig+YDEvj8fK21hGY1vOUtnwZhaTgc5KA==@lists.infradead.org
X-Gm-Message-State: AFq9FYLwjVv58+FTXhZLX+3PiDRz6R2gapBrd2jy+d6zHYardAUupxX9
	BcrvqZ2UDtMGIwC2eBUfrvRhWrUnmDtCEruCmm+icDTNu2bRCTukUo8e
X-Gm-Gg: AYBFou2iE2rw+diu6m+tCObkzQWTVYcYzo8RE9G3C4BTo+41Mjle9SCoMrSW7d1iVQb
	DRjVbi6btjhL7fko88QcRUaVyx10RPhRvQarmjHJUBcnh5GFJhkG/qK8bGSz+6iRXGT4EOd0tQ1
	ubvJixWyqI+2u84/CW7gWM7OQ4lK3IwwBZI9D61yEtqfdmgLrrmnA6LBHCa/RPwL++zPqHz5i8H
	cVFcSAnIums2HR9/dNyh0yGvWKjWXctod9IFHvAS9SRkzj8Y4ivVtLDhLqpvCJiB9AHrDGcLFgn
	aV/yuKKtAW2umd/+qXKNq+4889fTgQVVbscLTyYChEUC0RfQeiWj6QqAkhU/Ku+sloXBC4szqJa
	b0tzcBNv5oNbgvbVD+RzJWy0wkBZUU1ItUxkLoPXuvSx3Y5u0ue09paf46q94cMaGu6n0SZ+qEw
	xf6j3DJMuQAGKGdf6GKlLE3tNP725SDPg3lTUBD3o8Um9i05t2JEAgdx06IxgY8RRIbebQY4GNp
	cLMdTmruYXpp1LShqcN9dpR6uBq0TMvEmy6t+l2
X-Received: by 2002:a05:600c:4fd4:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4a1fdd53c8cmr68455165e9.27.1792617065604;
        Wed, 21 Oct 2026 14:11:05 -0700 (PDT)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a25fb5sm22891525e9.6.2026.10.21.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:11:05 -0700 (PDT)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>
Subject: [RFC PATCH 0/2] memblock: keep reserve_mem regions out of KHO bootmem
Date: Wed, 21 Oct 2026 23:10:44 +0200
Message-ID: <20261021211058.83483-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_141108_325305_F51967CD 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a KHO boot, a reserve_mem= region that can't be revived (new name,
size or alignment) can be allocated from KHO bootmem, which the next
kernel boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG preserving it
fails; without it, the next kernel's memmap ends up on top of it.

Patch 1 factors the bootmem check out of memblock_alloc_hugetlb(), and
patch 2 uses it for reserve_mem. That also drops the TODO in
reserve_mem(), which asks for the allocation to be outside KHO_NOPRSRV,
though it's bootmem it has to stay out of.

Questions:

- If kho_discover_noprsrv() fails, only bootmem is NOPRSRV, and
  reserve_mem() now fails with -ENOMEM instead of using it. Is that the
  right thing to do?

- Should reserve_mem skip mirrored memory like HugeTLB does, rather
  than keep the fallback?

No Cc: stable, since patch 2 relies on 14773e2aa4c5 ("kho: extend
scratch") for room outside bootmem.

Based on next-20261021, as it needs the KHO bootmem rename from
liveupdate-7.4 and touches code changed in memblock for-next.

Tested on x86_64 in QEMU.

Jose A. Perez de Azpillaga (2):
  memblock: factor out the KHO bootmem check from
    memblock_alloc_hugetlb()
  memblock: don't allocate reserve_mem regions from KHO bootmem

 mm/memblock.c | 100 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 36 deletions(-)


base-commit: 9a482184d910775cf648863148944945b74e2815
--
2.55.0


