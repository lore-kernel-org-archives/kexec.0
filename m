Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B917606A32C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k+j/74ix;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UBnZMgMk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LYnPwXVs5q7hiylo9HLvXwft8EbUR8+QNtfkEA01owo=; b=k+j/74ixFy/Do5
	73iGO3A1bsDcJwRoWIn+GhO3kLf8FxVJb9vyM2oYPKJln7BWF9s6StwteInkm5pN63w25Ui64p9oo
	vNA9qyl14DjHMnjhzU3+vffYjUFKfT4jANIC0fFWL6HvWQF2c/pZJatdrm8V0/OPjXTxveHOMESfk
	5UyAH1t84sHgBjvPTNN0TVR8S95wcd5lZSH5K6Ju9SX9BjWLOaiSRpjvUxzW+OeUjnS+kRE4CBRF8
	3w5ZllqVPp6Xfj5Hw8RoCUdhmbQcl64Ei1fxYkGy3b7iWHbBIpMSDLvSYCwdWHu50DiX6FIP3Ho4k
	iStnoDcuYvTlMcrvRXcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTifw-00000009YLk-2b1T;
	Wed, 18 Nov 2026 16:38:24 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTift-00000009YKz-26ti
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 16:38:22 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so444865137.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795019900; x=1795624700; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LYnPwXVs5q7hiylo9HLvXwft8EbUR8+QNtfkEA01owo=;
        b=UBnZMgMk0ruCYgNWOo8tilGpP4HX7Aguk00M8osrornPekFfhbfpSijq9mBGARowh5
         GuTUPFWYPeCPkvZC7WQy3rdPtpF+9RKlcTzAWxEZA0CyswJptzWeepOA2OGYTpotY5cF
         1uBM4ng1A6d49cPdLN1Fn7QIpt182UcOPrSxOOW4AZ8WCGxebxOooWBRLJmG31yQ5MWM
         Hrt7YN6eFRxtMCb38bgcFVf8vguGB2ZPN7MUuYkvVtVg5V8jB/27JADdHTb8eIut8mHM
         OmyCt+1bF8KF1zZH+5tJeT795YGIS7O1/OsigTV1otUWUjUmo2Plsku1VxkVwq5tx9iL
         Y/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019900; x=1795624700;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYnPwXVs5q7hiylo9HLvXwft8EbUR8+QNtfkEA01owo=;
        b=wLSK+W2S58z9IrvzWl5lM81g+XoRotX7lpTpYJtz/Bpb063sb2x4ILllSJ/OtAfxqs
         VSuyJZ1AtLqKSZiP/U9Dn5zoNiZWq3aCDqaAPlJYCzBEHJeG0c6seCKUpjG51dNIf/sJ
         nyMdneAHHH4jIeYEY5z37GcFoZVnnJ7DJ53POYZJsdI25fpITWtUWwC0xTEtFLvmc0sl
         Q1RC+WJrb/c7ek9+NZRYmyy6M9FfrBF00zx5BLN6rbJTtKGK+8afAl8ifnL5P2R2T+jU
         BBq8RYABOpLHfP52BqnLAGzyWQNJl9Ob8S1xapCmOHPBwED+GXOmjrWSVIKhP3WZxPzJ
         /tgQ==
X-Forwarded-Encrypted: i=1; AL+hErGnFHgx+8D1+HpRX7lcZJ8BPrC8dZdwmLeIXgc5uNHdT75sHtn4KhUolVwmPYdJykhUM9+n4g==@lists.infradead.org
X-Gm-Message-State: APuU4Z/5Lz3JGp8aemZN3RaTrSRl7unRjBLk1kPW496o64xKImNewM7k
	smhRnjGH9pJkDTmgNVypXvKhrIGf8OHd81h4VHGRjFN2TbOEi3/Yu3fSsaPk0HCYTs8=
X-Gm-Gg: AYBFou0XLkqgiaaCqRNedK2aAMugMafyLgK/j4+knhtopIh/38HXj6Ot/V/HJGd3Z4A
	S6Xjg/649JzypP7pH0zHJAM9kWcBjBlokz6yxTiESCTqyW/WzaqAfkiYO/+XNMcZRBllGKCQQf8
	Lp/Nrhmv741Apql2/ufD4zi5ih3g/50IGaIk/wyBIkB3kH3JQ2+bJCSHOO0VmvXAfeWFjqoSuBE
	+YF/sMBzUtqAqBC5P31HdZh9n4AgHF9xPlQvKBh2M9taxe8rQBovBbgTxp6ynNcGbmeBQIinc+p
	S/wYrQB1jF4MNhcgA3WxEHrG5Q0cjhsRObTGbKyNx5V2F2nUxGh26wBC3bfJiBKFOr/uSylFwwa
	nR3QbXPYxdRk2nNXnvhFTd3kRIJyM8EnmpODlwMXWXp36BVJ/ynfSDyoEpLDp5llF2W6j2YL0Wh
	Ukcjeb4VyvSzB3Ba9KdQFRjg9URQzdxIGIDqimnWnMiOwnV06rxAKT+H1F0RR4dwvYcxP2SlvK1
	b/eB1iFlOoMdurS0lqc9KeaFLZ4dJ/HgA16PFdUEeg1U7FjmJnjTq6TuYymiiQMFTXWCSsZ1uqX
	Z/Jcc1evOLcNmraWC6yZUPichhuyrsKKn+F/2iDBgsSJr/F9sahrFmEeHPq0IZ3sp1x7/S2QY3J
	M/9I7KPZmLST9BC/ztkrKRfiffrj+gevQc6zyDH9cbNo9dg0=
X-Received: by 2002:a05:6102:91b:b0:7d0:9587:1b99 with SMTP id ada2fe7eead31-7d6b9ee48fcmr1231586137.0.1795019899949;
        Wed, 18 Nov 2026 08:38:19 -0800 (PST)
Received: from soleen.c.googlers.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9318565sm2190742137.9.2026.11.18.08.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:38:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] kho: expose incoming sub-blob metadata instead of
 contents
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Long Wei <longwei27@huawei.com>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
 akpm@linux-foundation.org, graf@amazon.com, leitao@debian.org, 
 corbet@lwn.net, rdunlap@infradead.org, linux-mm@kvack.org, 
 kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, hewenliang4@huawei.com
In-Reply-To: <20261117092951.4017931-2-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
 <20261117092951.4017931-2-longwei27@huawei.com>
Date: Wed, 18 Nov 2026 11:38:16 -0500
Message-Id: <179501989658.250261.5046056769256366161.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=s2TgceZsirNjgZI66wNzdrJjtsGvWS0+fdcYU2Wc8h4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq/dR6HI5GpH/4iewvFIx9U9up3jTt1CD0OiBfM
 tAYaHZwb4eJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCav3UegAKCRC7dyhM23N6
 3kzeEACFJCS4M3n+dkgQTJYjctdNWWkW46rsV15OpDqGSLVsafiGK5V9DqS/YbDDUzAIL82H8ek
 ad5sQrHuBJHAawArjrrZvPvZzsjJ7BoW0DhpOcm/qpi9kWBcHFsENdJnsNI+sEKtS7RbbYWQK9j
 vUVdUL11miluOI0kgYxpgF5qaZ4UwPGOft9U1q/ZL8XoMA/wEeCWMJjAzYczqn5NlEwwa+0AB2q
 6rV9wl/qqH3k5YypOi1mJyaSbV5EkYQGGi5oaRrSDgGgUPPySAGgd2qpPcV4/nA19UkULW5+Ytn
 maeDoReb2TGTx071O1D61DRaAQroMbESBa98ybnPDi7kYDDQ8CLtcbsoJT531hV/Rb9vSyMfua0
 WYp/jw8p6CI8ckRZakilQLC6NoROctxmAW8dgqsN7qz7E8zFTylOcMwvBnWCVv/OmeVNt//PGSZ
 4pvr57QAYJHdwmcY+nTXPkmo8Ah6AewPJfQdfcObc/6kbkiKd/1d8lPhhzK25hDvF00YlLVIPNR
 9tWH7znV/vhJaE8IssOJda4n+3fjfU5Kdq/BeEciQ7PR4m3bZU3IgMli5bnUzkHVn/orX7MMm3Y
 Z7klzrAJ9WeT+Ujk7U5HYuOOt2IHqPSL3QETXW/TOkr9Z1Ev36XHxJTep93cKMnaV5yhNLmn8bY
 /EvS9/hwGM3L8Hw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_083821_560515_CA9177BE 
X-CRM114-Status: GOOD (  15.42  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Incoming sub-blob pages are owned by their consumers and have independent
> lifetimes.  Some consumers, such as LUO, restore and free their state in
> early_initcall, i.e. before kho_init() (fs_initcall) builds the debugfs
> view:
> 
>   early_initcall: luo_early_startup()
>                     -> kho_retrieve_subtree("LUO")
>                     -> kho_restore_free(luo_ser)   /* page is freed */
> 
>   fs_initcall:    kho_init()
>                     -> kho_in_debugfs_init()
>                          -> phys_to_virt(luo_ser_phys)
>                          -> debugfs_create_blob("LUO", ...)
> 
> debugfs therefore ends up pointing at a page that was already handed back
> to the page allocator, and reading the file triggers a use-after-free:
> 
>   # cat /sys/kernel/debug/kho/in/sub_fdts/LUO
>   ==================================================================
>   BUG: KASAN: use-after-free in _copy_to_user+0x37/0x60
>   Read of size 32 at addr ffff88810309c000 by task cat/27436
> 
>   Call Trace:
>    <TASK>
>    kasan_report+0xb9/0xf0
>    kasan_check_range+0x100/0x1b0
>    _copy_to_user+0x37/0x60
>    simple_read_from_buffer+0x77/0xd0
>    read_file_blob+0x75/0xa0
>    vfs_read+0x12d/0x520
>    ksys_read+0xc3/0x160
>    do_syscall_64+0x97/0x4b0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
>   The buggy address belongs to the physical page:
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1fd
>   pfn:0x10309c
>   flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
>   page_type: f0(buddy)
>   ==================================================================
> 
> The page is already in the buddy allocator (page_type: f0(buddy),
> refcount 0), which confirms it was freed before the debugfs view was
> created.
> 
> KHO does not own these pages, so it cannot safely expose their contents at
> all.  Drop the in/sub_fdts raw blob nodes and replace them with a
> read-only in/blobs metadata file that lists the name, physical address and
> size of every incoming sub-blob.  The FDT itself is reserved by KHO and is
> still exposed as in/fdt.

I suggest we simply remove in/sub_fdts without adding in/blobs. All of 
the metadata you are proposing to expose via in/blobs is already present 
in in/fdt (and can be parsed from userspace if needed), so I do not 
think it warrants adding another kernel debugfs interface. Keeping this 
to just removing in/sub_fdts (and updating the doc) also keeps the fix 
minimal for -rc.

> 
> Fixes: 062dd306d99c ("kho: fix kho_in_debugfs_init() to handle non-FDT blobs")

This UAF has been there since in/sub_fdts was first added, so I think 
this should be: Fixes: c609c144b0e8 ("kexec: add KHO parsing support")

-- 
Pasha


