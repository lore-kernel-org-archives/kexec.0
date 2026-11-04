Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC5606C925
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YlC50B2x;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ZIybCcyP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aqgdpi7gCkH60Z/isUI3USxyApBzH2FtqkjwxCL88mU=; b=YlC50B2x9wQZTi
	SAQBP44nVPdil6KsxRdq24nfu1vZlB42bALNhxFG3Tk9lYm8+jNpgV34MHOMeMhxeCFBxnBxxyhEJ
	tJK8JFMS9NovPhgGDmVbfjYkZf6MdhhkYumJSIsQouEnmT6JlLfWFWS/n+68Fsxt2JwvMJX54JvRI
	b5KjcaQTTaWhIXxQB507Pi3P4vV8JpNRD3lgVGs/kd1wx0wE2Ozrvip23+MuaB1RI9gIlcd/62Laf
	7G6GlVzRV3q8IkpiTw3r3iXlzM2TsO/OrLzZDVjVS65jO+Fxc5RgJ2g/cDw0u1B7Jogq6sU2xvBDu
	ijcIKUGIO/p/99xc2xRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOi0m-00000006xMT-3UWW;
	Wed, 04 Nov 2026 20:55:12 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOi0k-00000006xLO-1HVx
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 20:55:11 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-7cc603a168fso368889137.3
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 12:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793825709; x=1794430509; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aqgdpi7gCkH60Z/isUI3USxyApBzH2FtqkjwxCL88mU=;
        b=ZIybCcyPanH4twBl9Riu8LG9ZfPVxHnxyR20V6rSE9qKaz/gu/GENqqvG2KHnWqbpj
         iC4GqZe5uvI+9PQ5whZQdxXY+el75n0GZDvicArY2bJRb5/2BN9rg0Jo2SW8dK09eGpS
         NRcXXWVkbLQ6jRV0y+YGGP7OBQejbQFAuHDA7AwA3SmIIFcb6E0q77H8lRHhkhyL/Z7A
         nY9mZvSwUi1odDoCZr+WNrzj86cH4MbkHUAhFl4RWaPM2qM9ZnfrKRPklDcWEfU/5GFi
         gsUoKtoYwxzWN7NnP0n80YkRtU8ySVOL31vj5EDsrxwi4KSA6lupSUUI7Lo2Vrkv94ul
         Z4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825709; x=1794430509;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aqgdpi7gCkH60Z/isUI3USxyApBzH2FtqkjwxCL88mU=;
        b=b3+oerRodgbxWa/PrI5AarTDXuRr+ZkwQ2ckQstOiFYVBDmeT80rFqJqOgOlUFeorY
         vatMJfpKx+U7zWrzW96GPk16hh1JJN1KD24Wqwez/T52WCE7KesUANCf+P4Q4EPS+HB2
         fy0suJNR2phF3MS+u/KbFmTx5luKUTYQxOoprJOYUXJwGv3VqAg+RjW0DgkkiotmwFwy
         tBXQTr0jx5via56EEYTTTgNrQ9ZzV7PNXFXaLX+tprjl07IwR/Fm8jGDNCCmr+f2ZAWp
         6FY1/VxhIi7K7fWZ11ZtsZyqhgGDfHh1lKWnljLuReNYko7kj4ExXXm6i8uO+LlZ+qBl
         xhAg==
X-Forwarded-Encrypted: i=1; AKwUvBy3CjExkchzhIfFVCxNVEeLSKitxPzC3eaVfNRDJKlVYSAKV2PYaBDCkmsJNVAKrb5JaCl21A==@lists.infradead.org
X-Gm-Message-State: APuU4Z9mYtxtW7lfY4hyw4mPq7kobk5jfDS8ZwvBI4dXy9eXsRaCu5um
	zDLeDghr8KsD55+wOCpmzBbDDrHZk364YYwTLaPF9InWZ+TntBZ2vgL/giEFbBH40do=
X-Gm-Gg: AYBFou1uTW+w9BBAt9B30PeyNTcUEaVdpVMQJQ8yt/WmxUJ1NwoDcg4F2sy6QYsy/RW
	s97F0m5DbDRRMlNQwFm7eruHk5BEhkpkNuZw/h5W6MDZ97scObhRt/urEKZ/KVB+lT5JrnT8w8P
	Nd9mQIp5G+s/QuqEmZl/iJrwuw8zK1IhxgPR8arQEwJ3hemVMAdOfcdAouKi/BjXFN6si2U+Icy
	lJnwjTjTw0NppiluvGlfukxRBtkhMtDdfZpUmFtSScGkkyybJNCNiyKuaFtBeID9toJluvYUVNw
	n1MY9a8ccwG3uMb9/PM583GZctHl72R5uMrLumQH0wg/NgCbllEg68qLtlQjse6udBmMKMa87zT
	PCnjBYkPuXkD3PxtrTBqn12AkQ0hF6QCCEEriKESEIU/06bSQQssTnz6yvwZi7+oWjIfr9MxyH5
	MbvopqmpLQcFfl2drkt2YAeCa7TaMnrsvQF+/W5gGmB/618FKvwAoRJv9UVR7fdpxkiWJuWSTkb
	4cUf0DEFcRBCq4SmI50w0OnHTOxChnSw52MMndbV1bSfYnf6tBGOoUnV4kj/kYDl7DbQpVgefzc
	uiiYKbl9OZxw4CCGhSIUeRAZ3+sd99/f4jHdTRHfc1/t8ZzgyBytyDnHepwEZRlFY1zlN9KrYZd
	cY1KGn5yRtMxOaqELBjIDhsI9ulbNS6Cl81SmbG50GXaTs+8=
X-Received: by 2002:a05:6102:1623:b0:7a6:a24e:8140 with SMTP id ada2fe7eead31-7d072c2ba18mr6112103137.14.1793825707582;
        Wed, 04 Nov 2026 12:55:07 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d212bsm2888015241.6.2026.11.04.12.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:55:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] kho: Remove redundant 0x prefixes
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Thorsten Blum <blum@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261104162352.140836-3-blum@kernel.org>
References: <20261104162352.140836-3-blum@kernel.org>
Date: Wed, 04 Nov 2026 15:55:04 -0500
Message-Id: <179382570401.2089669.6201187990672133004.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=nf/pbrG/3HMY+E3Xb9PYIXXf5eFKpBebgul3T9w7Tns=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq65uqenFbBMaztBsCNPi+5jP4Gy+jdHDzzMCE0
 AC8artOAtiJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCauubqgAKCRC7dyhM23N6
 3g6FEACxKJFKSeWDmcpF4MW+HdGHBych9VYleOaeLks4H5Jobe5OdO4PZ1BxPgjlf33ihIu0Cvy
 qUJll+5ee/BP7ue8XHEoKp+bs5J7/hJbsqiU9RBst4yORNBrHOTl8M1xUhUG2mLxA8t+3Q1zQqc
 JqLug6dfJmV22HOKmvtZZ5KnHz9hvhbXBWMpwgnBkg/9/dW/Cy7pZSeouW9JY8018P0hAAl7yET
 Gffrvg4Q952YZhd2yBktR7RjQ7nwTM/ntrpQLek4b7CLUg8NpCezTuNXXvkpi3ijzsJyluEzX9P
 SbLmD14CRvA8bQtgoW9rAKf+h7aRMxeemVftJ6EuV9Rr+ydhlygMqW9NTLTEHVEH+j8L8ULw9ZT
 tYXpnXcjNN6SUxD1WAhZd3UWDlSb5i4VemuPUjoaMgTp0Pxy4gbnkg+w/KZl/ytltxii7mMBjmv
 oaY/iz6jEO3XpHdRGNVCENGOesj1my4WTYt4aJikQngaKQyZzTdPzxjJFB0tllSy8LZ5yeojFbG
 1kTU5jsSvUOmJTifsIPYsrapvlZMhaLTP4t9nS5qGAGYwORWKAoHe46sW01S9FfU+PUhpjv2ZXU
 D2jgjT+p1VLkkOI59RjeZ1Hi1YLkfqzORCz1Tgxqtk+R7Rl6ZcZ7RZxA0J/I3d4mzxn0+gtKhfS
 04eqDdxWL00PXFg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_125510_361216_7D4B891B 
X-CRM114-Status: GOOD (  14.61  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The %pa format specifier already includes the 0x prefix. Remove the
> redundant prefixes to avoid printing 0x0x.
> 
> Use phys_addr_t for size to match the expected type.
> 
> Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
> Signed-off-by: Thorsten Blum <blum@kernel.org>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..6a7600a0a7d5 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -2010,16 +2010,16 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	 */
>  	for (int i = 0; i < bootmem_cnt; i++) {
>  		struct kho_bootmem *area = &bootmem[i];
> -		u64 size = area->size;
> +		phys_addr_t size = area->size;

I am not sure; having a variable size of type phys_addr_t looks strange 
to me. Furthermore, KHO only works on 64-bit platforms because of how 
our radix tree is designed, and we do not plan to add support for 32-bit 
systems.

I would keep u64, or if using %pa for u64 is still an eyesore, use 
0x%llx for the size field.

-- 
Pasha


