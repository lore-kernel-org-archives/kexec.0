Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBFFC5DF66
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BCd/GM+SB+20nc87cPYs8vSFqEi5EzWcz9k0G1zmxpg=; b=g8xC9XpuOyJcZT6fQeXA9wcg1u
	I/FhZMwTDLDtpBn9Chj9X/tkD1qz0LfSsXXSxBWy67SDaZt8Gvyw+ov0pYWWDTqqAY3XRRTthmuj4
	pKwe7CkgFN4yePVLpWvUwkF6vimWhoMEkRn8hJ2tQrzNDcEM5vYiASemhshV7bCDFWPZONVivIsCM
	1dc+LTFzpXUv6fQsFU9NtknA9NxYpzMMcV0736RjSm1YxgY77SWbOWBedhGGhJGzVsGpxveWlPQDZ
	jlZ4Hx81CjVx4RsTSbywxFucFCatZ9I4zsJ22Lg+ds5ANvxJUaHpGcICMxyXYGMXfZw1Zz8zLlPx2
	Ft0GFopA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyXS-00000006KnG-0Ptw;
	Mon, 17 Aug 2026 14:42:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyXQ-00000006Kmp-0wA4
	for kexec@bombadil.infradead.org;
	Mon, 17 Aug 2026 14:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BCd/GM+SB+20nc87cPYs8vSFqEi5EzWcz9k0G1zmxpg=; b=XNfIeUkgbI30auJx5S3m91VbQ/
	aGcnxKX1RjV3NQU9/wTQrwm/ghgFZikBDvPAFELaFCizyLvrXqZ6cLSLAOGN3pkc8qSn46YrJeBi9
	HoxbqwdJjfSBGkJESlz8MTXjfPbrpWf9TEQLwsjP4ICYiwSihl7q5Q0XopoqJPC0vA/RjKnu5KsIM
	twiI6pY4MurXoaKhgG9EY9gmwM58FGTYHOs+Z4QBzyMBFV/2EpjSQlxKwwaL3bezfdppROCvaqhdy
	E+uY6e8jaBrhpn7o0Qffhfv6yU6FB2Zm0RDGhiPD7IkodM53DOei4WEjbaexr0a2dL9VSPxiyMjOy
	JvlRS58A==;
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wvyXN-00000000qMy-1GKc
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 14:42:06 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-936d00181abso154652485a.2
        for <kexec@lists.infradead.org>; Mon, 17 Aug 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786977723; x=1787582523; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BCd/GM+SB+20nc87cPYs8vSFqEi5EzWcz9k0G1zmxpg=;
        b=MmtvLqzDFGJnFknsKimemy9VvtTzLNhUPIIEXWapFOVoh1/sXotQX3hmo2XH61zx9z
         HV+cMhzhpkj4/FflXEvgqWiU1hC2N5Jtk3B95+Gf2B4q2KYF8o6diNYsRo/2yVbN/WP6
         9Wcrq+0jEYOGd27QSlywTBfyUiG1CUtG6CBpsgGnBi4s8pbiASiAIUh+Jq+ZUK263qC3
         q02FK+44UpVOWEIe0bJXFErlwqqHSieH/1jJMf2CLBM2v65ysqhOgAG6X7SNpu+BLdNI
         xEIZfibUIKKeu/uOMQZgjei3TiP+YnK1mTJA3OAIBZ7zWUYWKXaS7hn8/NidgqmzNk4f
         27vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977723; x=1787582523;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCd/GM+SB+20nc87cPYs8vSFqEi5EzWcz9k0G1zmxpg=;
        b=cgYFKxLbR9JWyGSXVdf+8vdC3gvUq2PQCZHUFqDN8eS4nXAu2FOtqnCVam4RL7x9uX
         Me2UWKU8Omkt0WItV8PH+DBS5Xv6IW2YjwrKxE818JoXrLeUzrP8uTwdUWF5Casn2Ix0
         bl7fTMohw6O0tbH//tWN7g9iGpUdj6gyzclufyLXW0T8BDAuSgcJU3RLEcpFjl9J8LcB
         7LBvRWRB9ndf2MbWA5NqBCA1DH26j642UBM/p25Uh2QupnlTpEwXcUTcI+p7yLaQkG9X
         sAye4DwM+6FZqxwXgNJNhGdIHBfeBx6SE7C5WucsRiGhrQGyoT4VvvL9+yixG3t0eYB0
         fTwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHI6xA6OZCRJ5gvq6U5+AeA4l6V8JqLTnvyR9pOjLspEOGA7Kn3Y2b9vRecaAZPbn/ekEicw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwpWRTKlJcSdhzzbHhK141kl4+EHZly0DW/TpPTroRe3i93hJ+L
	3Hklu8z33D35Vyi5HAsHPsijaBJiKqi9yUfmwDVdnzEFFD+3Fgu4J4yJMjiyK8dV5jY=
X-Gm-Gg: AR+sD13kAxm4Mwex9G/B5UqVlgsFiVt8EgPTvPUWp3Ktdu4YKSgarQlPAs0XiXFEQbf
	9uq3MUUpZKMJBuqs5uNULb1INCSdww6eWkdkmuHBrDbRz3/8cQzGa5mXso2OGJCkvNgecr5EvTn
	OuiV++AXxEAFs10Hbou09HAd2TZGOyEggXg4q1IOyLXv4zUFrCw2ptlgwcH8WS3RoLkZO4LB0c+
	clz+64t0A9lYkPmaRGv3KG1X8i0HzeFD7CxzX/t3gMjvYPb7juPLLcJrTmFkXjlJdfHfnUAa8Z8
	nN0cq7VaorlUEVfT9rfMJsubZ7YxwEZH2FH091wx7DKuumnDS37j2OEnlkbJFt/uHNRBWLTH8ee
	YLFE7p2jvBmxqxaRiDwHLWtGOXxpKJ8WsYC7VTr7Rh/Cryc3oDbrM744AVmSIW6D/aRzw8jwIBy
	zO+p/lqvo9FCw06TxCDzH0Xx4iwyhDjZU+etJXNkhoEam/x21k/ETfIzCj+ahxwNqPfD6yUMXkB
	y6i5NYld6X+2/2zOPVqWBnIw4MRP/Ziob9xWzxYmdvc
X-Received: by 2002:a05:620a:2682:b0:92e:e695:d622 with SMTP id af79cd13be357-936d22ea6bfmr2612870085a.28.1786977723026;
        Mon, 17 Aug 2026 07:42:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010c3785sm100435385a.2.2026.08.17.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:42:02 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:42:00 -0400
From: Gregory Price <gourry@gourry.net>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Baoquan He <baoquan.he@linux.dev>, x86@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] kho: rename "scratch" to "bootmem"
Message-ID: <aoMdJ7hpr1GonLz8@gourry-fedora-PF4VCD3F>
References: <20260811162642.3504565-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811162642.3504565-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_154205_467669_08416B88 
X-CRM114-Status: GOOD (  14.00  )
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

On Tue, Aug 11, 2026 at 06:26:36PM +0200, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The term "KHO scratch" is vague and overloaded. It does not accurately
> describe what the memory is for. This was discussed previously at [0].
> The conclusion was to rename "KHO scratch" to "KHO bootmem", since this
> is memory passed by the previous kernel for early boot allocations.
> 

This seems like a lot of churn to just rename some stuff, especially for
a term "scratch" which is very much understood to mean "temporary
working memory region" in common computing parlance.

The boot param name change would also cause breakage for existing
systems that update and depend on the scratch parameter.

Is there a non-verbiage reason to justify these changes?  Living with
"scratch" seems better than potentially breaking folks.

~Gregory


