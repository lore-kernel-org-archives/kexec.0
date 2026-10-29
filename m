Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B3606A32C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t6+Twyb3;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PJRLYFI7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=; b=t6+Twyb36tyvEqQCs1/tB7vQ3e
	aA4Pf7DBJkItjTACVqIvVC+pas8PuGgkxmvQqI6CQ21/jT1xsoNd5IJudtSg7mY4U2SNtWwGjioQV
	u26qppLp3WvT2dN87BOweW4Q306FIQOjxXt01NON7aM+qKMGPATJh3Qwj1O3/vjm0XT9Ge6sxmhmd
	Mc1wpsVVuLCeDQbiys6BWpqlp+QM1fXX5+br/b/ZUGidJwOwCjLStY7QfjsX7awxteifS0FI3Sn6E
	btsS98SX4GtovyFoUpR6Im3dAHNGB6mduqYy+0uOYDyd/vPtfJ6WHj1rr5PhfbT+s/2gROuqGwQJ0
	2gGULk6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWoY-0000000AK2T-2y5j;
	Thu, 29 Oct 2026 20:33:34 +0000
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWoU-0000000AK1M-2bHS
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:33:32 +0000
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-704597ef1d8so1192114eaf.3
        for <kexec@lists.infradead.org>; Thu, 29 Oct 2026 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793306008; x=1793910808; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
        b=PJRLYFI74XRCwRhIgpuD8dNyhzOxstudgQgfjZwk7CkE68B1OeTflTbKRujL/inML/
         wUKzbnE0IFCOEa3tW6Swgm40ObM90ASwqg4AxmWAnYeHoZsNFM2MdGyNtiWp9Fa754nf
         sj0HBESEYwA5NkfA8mLFMUc5uBmlv6ahKn0RgGri/I5dgFF2Y2j6bvkos7RgzyhDYa9F
         KO08DQhhs7iaVw6CQh3rnqs2hc0DrrIj4JW3u7JgcLNVf2iPBCqx+NYn/TREeKj80kam
         Neb+lBlFFitdvFZ6WUnqYXNBE8/crrJNd1dvxr9b4cmCNOXkOTy9a8cfn7sgQDrXHbHa
         wwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306008; x=1793910808;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
        b=Kn3PmCWDyhmDw0SXtKStTFwP4rufhKJX0xuJP23n9bHjbmgIS71lYkimK1d/Ugq7mh
         1uaJy6/unaAts8HGLF/iUuMbRCiaQUMtTCXEcfcRrGDsvDLdBxUfWa3tjrPCTWZ51aZI
         HrBhkaLExsBkxfo4mbMW5mq/BdiWw46B7FDtcdlNZ9CLaR63P2IWSQlKFGsWg6Ek21Ga
         GJyXCbz52NtT1VnyZDNYcWgyoM7uTqXb9DG/YN35bo/hTB6NfdsIzyXTcKHljT1t5cOR
         uWfpgT/2jgUtZ7CO2i3C+C5xszp28SYXqJvydx7DvRZyUapGlhNB/mOVO/MWHldg6LcN
         tXLA==
X-Forwarded-Encrypted: i=1; AKwUvByAnOa8QgYR2UEWso9761Rv9j2404mMB+PR6ka6crQrrpW5FzEVoPobEZmSZECw2XB0JOOZZQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJQazVfdj3rMjCe09XbmXKSWeBQX39igpQ+JqVhZLmczUiw4B64
	5c2zS93P5Bn+tsNYKUSwQpbLSZBCozW0zkmEr/dkgtFcWpS4z1Oowc54QaQCLUDiO3sg
X-Gm-Gg: AYBFou1cAqCk5KuunrmIJdbQVQdns4rIrcugNJCtnk6vPXpw9NroQJV2BB88GaJ38eA
	56VpfStM65ZJc10wueM6IMn5dnhvoyKSJ/ERsuz+Rd78o9xMnmfYBDuwh3NLIjEKQn0zLnWeBJq
	MVFd9oNTt+q+j/kex8dTjjDMA/JKzLp+bOYf/hIXiTLoCgIPXKp+0z1nJQBNk8OC4t2vextqLKT
	bgH6iIsmDW3oEl6vHXbHOBfF/KP9Xd2D/opozrY3Fd26aQwjjbpB9J2o6m+biQY0hmEWkN6BzbA
	O8YrXBEp/p/AFFPHuSS+V9i51U7mNkFKfwGgJNBKskLLWMrdU0b9c2ZB73AmE5OuVtJTjMlkQom
	9U4f5VW9Q44xA13eReVZyX95Idvk/cWA9kg8jhv64t+ULVPxPXhjbTQeCcbmKt0/q8XWDH/1Rnz
	jZumyIBet5bQHx46Wf+aOL9uJrv4h40ZaCtcwuXXTGbfjrk1k8hbGir1+XVWdIxTyN+cgOXOtVi
	xnQL6rHZ1mjmgpmIRz3jeXLP8X5FfM2yQYqtpBnZjx6ljbdhX9hsWlXqq3nSqAqm59UQX+34b3U
	Exe0QScwzDjywIaPh6Ibm/xL
X-Received: by 2002:a05:6820:240b:b0:6dd:25a3:94dd with SMTP id 006d021491bc7-714f29beb56mr224819eaf.41.1793306008134;
        Thu, 29 Oct 2026 13:33:28 -0700 (PDT)
Received: from toolbx ([2600:6c8e:af00:4c:73ea:df46:8ccd:ac9f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce7c9csm260964eaf.5.2026.10.29.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:33:27 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:33:25 -0500
From: Andrew Halaney <andrew@amutable.com>
To: manuelh@nvidia.com
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
Message-ID: <auOn9CzT_gku-5cH@toolbx>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_133330_929347_3F125095 
X-CRM114-Status: GOOD (  24.66  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 12:30:38AM +0000, Manuel Huber via B4 Relay wrote:
> From: Manuel Huber <manuelh@nvidia.com>
> 
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
> 
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
> 
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> the early lifetime of a system. The trusted component can then sign the
> IPE policy, destroy the private key, and load and activate the policy.
> During that phase, the system is considered in a trusted state whereas
> the system transitions into a possibly untrusted state afterwards,
> running arbitrary user-provided applications. In such a scenario, the
> trusted userspace component could reside on a dm-verity protected
> rootfs disk, and applications would reside on additional dm-verity
> protected disks. The latter disks would be dynamically attached and
> their dm-verity root hashes and/or signatures not known a priori to
> launching the system.

Not trying to muddy the water here, but I stared / thought about this
a while and wonder if I'm missing something below...

With this Kconfig approach, aren't we now saying "if you want to use IPE,
and you want to ever use this feature, you need to make sure you seal that
keyring or else someone can replace the IPE policy!"? That seems rather
easy to foobar, and means to me at most kernels (i.e. distros) won't have
this enabled which limits how easy this is to use. I know Fan wanted this
behind some Kconfig to make it controlled by build time, but does it make
sense to keep the command line option as well to really make this opt-in
for users who have it enabled at build time? Otherwise you really are gonna
have to craft a special kernel in my mind.

Likewise, but more nitpicky, I'm not sure the restrict_link_reject
requirement buys much over the chain restriction. restrict_link_reject
stops new keys being added, but pkcs7_validate_trust() walks certs
embedded in the signature, so whoever holds the private key of any cert
in .ipe can sign a new leaf, embed it, and have a policy accepted anyway
I believe. Under both restrictions that basically means "holders of an
enrolled private key and whoever they delegate to". If the concern is a
restriction like key_or_keyring:<id> pointing at a writable keyring,
that seems like a provisioner bug rather than a reason to rule out the
chain restriction. Am I missing another reason for the stricter check?
I do realize this is rather pedantic in argument and doesn't have a place
in the use case described, but I'm wondering if a future use case will
want such a thing.

Thanks,
Andrew


