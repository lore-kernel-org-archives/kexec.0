Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E9606A333
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h/P4yeYY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=dSy2UYV3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	References:In-Reply-To:To:From:Subject:Content-Transfer-Encoding:Content-Type
	:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qgPn1TU8Qzde4rDA9hSBS0Cx8PK07vtzri2WT/d9DTk=; b=h/P4yeYYqEj9LN
	MC/dIUW7dpvEshcYypjZ3gVrOkvFiV/ETp9DJh2HEQI/zwR9zpB97MRphR8c3gjktVPWHb6YS/A75
	5/5hnJnxg5Iispd5S6UeDJYrXAcqHBo8r4R+irY/pCV7PmfOW01VJeZ5AlP+daXN/wOhZAkjMDX0P
	grDepa1caP9l/hxq03QU/Q7Y02roGeMdqEMXUvbrdvcenj2q4Xs0NgyQgxReKNp7Q7niAZQS3nyJW
	G/S17w2zyLDclbH5bG8PSmYy5+ou5mXXH1Y1Y3SF+O0+/BBqjni9b19Q2VeOBa7IkxHSB4QvcOFNi
	sfistEnGRQj3Rhj1MvCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOnDR-00000007aAT-2ylP;
	Thu, 05 Nov 2026 02:28:37 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOnDP-00000007aA2-2Fez
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 02:28:36 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so985023e0c.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 18:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793845714; x=1794450514; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qgPn1TU8Qzde4rDA9hSBS0Cx8PK07vtzri2WT/d9DTk=;
        b=dSy2UYV34bcPJBkokXZf5Vi0SP/zZ3SJgOVoeQjfPpOpA0g84jR+KbPeJVHxOZrQ/s
         rgKpdx6t3Ddf+lM1juqUHhtZfa+mratS/BYZo11GoiwxGxkj5xIjDhsVGyhe7pW6JYVd
         MllHKIMTloJAEhMgZRzesZQ1/4rW1O0BJ++hoSzbJwEGHeEVPrM5kM2s/GO8pCJtyx7X
         ToR+UhhvG0fr8Szk2A91uLaIN8BPWvP6AHyuJ756vh37a3p/MxFds9rh0xsZrhxGbJNk
         6AXXiQZQmjHrKOedWVYk4h88P5PGtTy7CgIq5B+x4ys1lmPPaez7SBnXnEo9KFi8I9h+
         sL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845714; x=1794450514;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgPn1TU8Qzde4rDA9hSBS0Cx8PK07vtzri2WT/d9DTk=;
        b=MQf8YPMwAkEZB/1sC9FMuRJxPB/kx3or5/8OxnYQ7Di5MFPWILB/fBrkmFW8XNhEfz
         ak5xWiS3YN3O9mK4JF+8UJJNg02+6TwEQnfxtxWrh9xB0FK1OayYSoYHLqoC80ssv66N
         tg/LiYSZzSv25+lDbtqp2SnadYx3+8RunlNq4nPe6IV2k9Hcm0yZQSUoRpfxsNfZ9s8Z
         hHbIqvXUHFjWqg5PllrXk3W0AK9j+JK/Ejtci2wV7roUGB8xJ7PtbVkjhL2ljUDTOoa3
         +FIz0ZW7+PEKGBgOcGOtmjuDxbWLlfrqSTKMJ0+WiYkNUeXXk/SxL5PbOnF8EGFvO7yY
         2UAg==
X-Forwarded-Encrypted: i=1; AKwUvBxNcxfMS2Q2Sf0k0Evuib3fiFMhj6qIMkTV9mSX7v7qkW6tDm3feQsqtDdO8vIxEcrSfA1mkg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8yNOPb3qUd/wrQ+UXPKJYND4aWndCbdSd4L6ftpsAa/Q7YvY1R
	uX6Vjl445mErL9mgvq82ipYiDat+DNqBCNJFjfe1/zHpszapLDaE1V+u8L6rFYQ5gys=
X-Gm-Gg: AYBFou38pjyfF7esCMF51oh0aXBgsBNejP4waKGqY4Z6jgPkexRzJ2s5XKXzAKfQIs6
	6QhE7PLiFwcT35sfLWiogHYoODI92ok8mMZoN6PgwNwNGvZ9WYwmkoybi74pmNbHT8jhokvMh2v
	09/RgDVK6baiMj4IFML0uCnn3sXpqMPlL8Vo+ZyPnqcUyYEOH6LwJCYfqz44khPEuqc1qvjyRc0
	iY+CDMcM76Xo9SRDFkECcb94DgHEOlI7NKCFBnajaqqqxrg+zcbKrlkSR97iUTZ4YLwFs/2ATqm
	NRytYAAGKtjkoCfip9nPFYs+p2Dq7vn623zKDMgPHcdmFbl9oq/T6pC50SJfzPZB6q+Kqeqxhvt
	CQ0DnjBRyJWOlHNz6yMzYhaZ5Ns1IwUCR1YIh/U+F23iakdCT8uHpWCLQ2h6iktWNtghSNx17+d
	LQaCTbiEnsHEUe6co8secFvUIjR1Cwl+HBeZVrPLW/dbUFSeXzevbBF5946gPK66Krm6m7THlx0
	IwX24tIYrlwEOF46t/OssJGWtvwqbOW886IRMu7rgXYZE1vHsvPgf+ysrCjt6P9W+GMr66Ga+ad
	zZ5d05WIVqBU7PRLBvVfypARASvhUwIHyy2CmuJaQo81pAVZUvxnLpIHW6z54bkT2j3zJ0fsvyL
	k3iZsWdXllPGcmzKm8IizsG23gGBpH8Tv0lWSxPFj8R0k
X-Received: by 2002:a05:6122:1c8b:b0:5ea:c98d:768 with SMTP id 71dfb90a1353d-5ec6871c27bmr7768958e0c.6.1793845714044;
        Wed, 04 Nov 2026 18:28:34 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8dbb17bsm3170924e0c.11.2026.11.04.18.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:28:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] memblock: don't allocate new reserve_mem regions on
 a KHO boot
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104204235.9066-1-azpijr@gmail.com>
References: <20261104204235.9066-1-azpijr@gmail.com>
Date: Wed, 04 Nov 2026 21:28:28 -0500
Message-Id: <179384570854.2089669.6686464803021518602.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=550;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=lzEbddKUD5GuDcxbx6NPlhQyO90bGHNaEl0mNdN224M=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq6+nQbIa4wl9/OA85TgIcp6GUjRJ97N7P3RS65
 w/dH+wLy06JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauvp0AAKCRC7dyhM23N6
 3r6cD/4i+eGggrI9gSbQoKNbHehmvZ3DGILZLB/nlShN88F1/s3BSkAExC6VVWEMcC3UB2prAMe
 1qmdaaZsjv2/Uvifq86Kv9CWUVWlkHnoyJWKozJ7iEKfgbYRb9O6MVVGqZvt6gcDBGLapVOQORL
 N2BYhTtYvIj9j6N8vOfDgQSWnqCaU3LdOzeeMplOf3k0nRefNd4DRINPicEkKSvuJt6kgxlx5nw
 RBg/eYb1k2ki3/fW0/aQqPsWnF8xdmBf+sIDShF8msbkLqOGRC/Pbpl1ys/JZIQ2EFGm7xERkEJ
 SsFlo0Ul3MF/AKLUNZLeVwQguvXQzHFjoGV6XcEyKnkbyU82ZjGVzXVjsUxUtUTGwxgp0bGAOwE
 rMur4xHR1Un1klVmeUB7SP3LdXyUmPfNaltPEaBRVTTjoYBqi8kOlVT+quLTa8jeil3KQNhYCa4
 u1tTYYUFrP1KBfugXgtvFDpHpS0VdGexNS7KJd2Taq4bRde18lsMUvluxoPd2CjsEdxffVnwR2F
 V+aLewuq2DY7Tq/2il3FeVW2Ki4X4JCYddH9lK9F/upkQWS/TMzWhm6p9tIzT4pRlUScGIq2JHi
 +FQwVCuO7RxpxBnAZMUlg/S83bjlOVBPGxkmYFqM4Rlux4v6iJzz1MnWMt2Zbzz7+naB2qeTeaU
 JOlIW4F4aF9s9Fg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_182835_590264_8843C745 
X-CRM114-Status: UNSURE (   7.50  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, Kees Cook <kees@kernel.org>, Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 21:42:17 +0100, Jose A. Perez de Azpillaga <azpijr@gmail.com> wrote:
> On a KHO boot, a reserve_mem region that can't be revived is allocated
> from KHO_NOPRSRV memory, which includes the bootmem the next kernel
> boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG, preserving the region
> then fails:
> 
>   WARNING: kernel/liveupdate/kexec_handover.c:1245 at kho_preserve_pages+0x168/0x180
>   failed to prepare memblock FDT for KHO: -22
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


