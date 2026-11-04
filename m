Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9F606AB2F
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0WevHOdh;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R3xnNN00
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Osoc1/zc3WCPxn/uivsVACevUkiPfuARX2+mZ1FpT3s=; b=0WevHOdhY6tNKHhGqooMXkhntG
	CsVYi1b/1RwhbZIvskTYmZEpYbjm3cLEWxWcEm5VNmc3gNGgwhUETgI2T3bjf/FkGxohIKdKp4Uhw
	kIJxSLQVtFDw+5neRrNS3zcCUHMD0Zq7vQJE/9acA4mvKwfagxnIgGSyQsmeQWbrKsArejYgvzAS0
	E/FoVAXog6dGCqhPoI/2fIFHeKZMgKAFgdATxp8srkGbOAieWe4gQiP8b0OrNffoFTXz/NX3GcSb+
	6FCqTtwIfMgey58Ii8Tb/jaatjv1mlWqrvk6o6X91Vr01ZfjR3Fom65YnyZLuUXn4LQtUbUcWQymq
	FRWN5RJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjZr-00000007ADU-31Nb;
	Wed, 04 Nov 2026 22:35:31 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjZn-00000007ACy-22dQ
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:35:30 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8b1a705b88aso425340b3a.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793831726; x=1794436526; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Osoc1/zc3WCPxn/uivsVACevUkiPfuARX2+mZ1FpT3s=;
        b=R3xnNN00WBIUqz8uz8t+M4hDkrHBS4lWD4Dnwgef7A8WLaOf7f8PIb1O40EMX9HH6Q
         ipBmdvx9JFNPeVjh0c7HYoSnnuTz7zCzag0xqy7l7MGft9TpMG/LHRin//gU769kw2NT
         2xKdRGcliqnMGneIiuuXdzAPj1QlHfyXAr2Crax88lFzI6pst1PffzIj1u62faZIa+5i
         T5DmQkY0SDasC4yB89I8y7lkipHSZ1UzOjPiclDqPqBS1SOekGPcIUuywXeaRkZN8eXd
         cwclXDSehsquAjxFA10ncuzzVqFN+GoO9hJxZ7DicVOT1ef/245GTmno/PDlOXEK1g74
         lyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831726; x=1794436526;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Osoc1/zc3WCPxn/uivsVACevUkiPfuARX2+mZ1FpT3s=;
        b=eJqbuf7SWDcYWsSXTWERxooQnUlzpJG90MjMzwEoXj0C4RAJpZ/ngVevNVoHTtRHpl
         SgrP3Tr8kV605rIsxoydLC6HQA+BtvEUlrBgbhWWayF8wifJg2buuJ9ZZQNDVLexedmJ
         w9eO4X5dWInzlsKa5JPI2csmv8luCkesezJWbzRiG7V/u42CXQo6kuFZ36O0ylSmNh+9
         peXeYl5VyutFBSegNhnLXqKNaz1h5Bx3UzVA2mft/O58BtnUf/TWu2b4JoEuFw3OSuQt
         nKj/eYgkhzUTx+EII/nJejYaoUzqSOGadLTcn7mdMWNJdji82qi8jpIpKLEHujYwBc4k
         dDBg==
X-Forwarded-Encrypted: i=1; AKwUvBxffFP7Qx/GETx0yeWyIsfoDRwh/hX7KSrRQAsAJ8e/UeJsLHwj9F4v2uiNeW+AF6DUYEMgyA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/emiwnKmQKbDOu4cFMZ5k0FqEF2qAUREK/xpWvqVBaRQCOxRvw
	PDAQJyqD4SFw79M9dHY4wf/cv1Y5cI87W9mJOvI9w0X5OXzRmPcOyX6ksGWGGnMvqw==
X-Gm-Gg: AYBFou2zbbm1U7EyLnQsAIfmOpVpxT6oJ9rNMx7GUOGe9j/Hxnw27omdE/EqOPYop7X
	ttKHSr9AR7WoMukOW85DFbgHT8dlmOvOgXqYldA2SpvKDqCR4Ik0wtVkLMboZZwJvi/2At5imEQ
	3yDA8EOWMvbxmtFTmsp02+/6zEZSYou8JUyhdA60FQXkWPzyO3iH/YaT3g/6AgfWusgFFPU7AaA
	wulsuroOU2RfGuC+xIZ2qmyWS1/tulJLmiFAIFwor+BKiXa1s3+CuiOcJQffnQeT3g+QUtEsXcc
	GNBSuVAdU4nMkH/ZkaHxZ7CRM4W1/3D+6+YxlkLJLL50ZeFFPuDIMPQVcJFmjUwlqdc/XYUd8IL
	wFg4ppiPYXrpeW4y/IYyyNY9ih3D9nV7mYnJ1BxGfK6J8Cb+3XUjug4rzlOfYNEy4lhg0BaDu4a
	M4iId99nD/QxPIwML8roWafC8hOtSELqdyJ8+wjL/Bz4wI/W90be77MzIo0WafMNjJRwocvvYmm
	m1fCjSFGTDxVCRSiyOWNWsz/BQeXE8KAfO1/6BUgE8mkxzA1lsdXti3lOOFxDqyI8UcmUbhnBfs
	OrLOY34HkrIEz1AUhS91tFg2VGbwBVdafGa5U/norxGUspzGhhIa82nbnzkw7uBJ/L8piiUoG6+
	JTwwgAFxhIA==
X-Received: by 2002:a05:6a00:1f0b:b0:899:67fe:3c52 with SMTP id d2e1a72fcca58-8a9be1a4461mr15308534b3a.15.1793831725909;
        Wed, 04 Nov 2026 14:35:25 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b569495sm1376244b3a.37.2026.11.04.14.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:35:25 -0800 (PST)
Date: Wed, 4 Nov 2026 22:35:20 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 09/10] mm/shmem_luo: Allow retrieving tmpfs files with
 O_RDONLY
Message-ID: <auuzKNZsPD10XM4q@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-10-dmatlack@google.com>
 <2vxz5wyck08d.fsf@kernel.org>
 <auuJ4msatqzoOrjN@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auuJ4msatqzoOrjN@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_143527_548605_CE25B337 
X-CRM114-Status: GOOD (  20.11  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-04 02:45 PM, Pasha Tatashin wrote:
> On 11-04 17:52, Pratyush Yadav wrote:
> > On Tue, Nov 03 2026, David Matlack wrote:
> > [...]
> > 
> > Can't you put all your binaries in a separate session, retrieve it as
> > the very first thing, and then finish the session? Then you can execute
> > those and retrieve all the other sessions.
> 
> This is a good workaround. I am not opposed to this patch for 
> completeness of functionality, but if we decide to keep it, perhaps it 
> should simply be squashed into an earlier patch. The current diffstat
> looks bad, as it mostly deletes code that was introduced earlier in this 
> series.
> 
> In any case, given Pratyush's suggestion, we could also drop it.
> 
> > 
> > Why do we need to support this in the kernel?

That would work for binaries, and I agree that use case alone doesn't
justify this. But I see O_RDONLY as part of the retrieve interface, not
a feature for one use case. The retrieve argument is modeled on
openat(), and openat() lets you open an existing file read-only.

open(O_TMPFILE) only requires write access because it creates an empty
file, and an empty read-only file is useless. A retrieved file isn't
empty, it has the preserved contents, so O_RDONLY makes as much sense as
it does for any other existing file. Without it, every retrieved file is
writable, even when userspace only needs to read it.

Preserve already works the same way: a file can be preserved through a
read-only fd, as long as the caller has permission to write to it.

If we keep it, I'll squash it into patch 7 in v4, so retrieve supports
O_RDONLY from the start. The commit message will lead with the openat()
reasoning and keep binaries as just an example.

