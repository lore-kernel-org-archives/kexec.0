Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AD606A329
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3IoezvyP;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=eiwqIRgG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OJqTJ4xyg07hJqswmJ5AikQ26UFbu12PW8dHC4PPKvs=; b=3IoezvyPAD/TaXeUw+j7roCm32
	k2lgsOuunsjcKNxxNc1nchVk2nKezErv20BumUhpXnBqa4a6UReCbayV5g9RgGkyG3NV+0j/aGuvg
	r91rDtoAGvXqvAXz9K69MJOeiWag3nmNVAOucOFk/bHnfQq+RG5+d5rQCfZqINA3pw7fXGcXZedYn
	oYc1A2VGQRskEji3UlP/4eZFX+3UMXyPWCaGytzvd0OuLqSmShZ6mM1YppiaZSPffICTSnUcTmkFo
	Iq+y9c3PlQHld4cTrOV7h9fUrYuG7Z58cMEPeN3pkEFbE/Uec66KVem7hSIfC6WDzDhPqa1RwhF90
	uKdMFfMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdeR-00000005uet-1um2;
	Wed, 04 Nov 2026 16:15:51 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdeO-00000005udV-49E9
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:15:50 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-9908e3cd939so252481241.3
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793808947; x=1794413747; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJqTJ4xyg07hJqswmJ5AikQ26UFbu12PW8dHC4PPKvs=;
        b=eiwqIRgG/sVuUNDMmZYb5VgZTPHIZXH4eLXsW5XfOLdoeZ2CUANwNx76yGZRiV2zLs
         S4+3Ep35SzZRRlDWlKlA2R31hAZpwm0hRwkRtdAEFUKQzQY4IdxEIC/Er/5JyJC7EpBR
         kfp3afLztvumG37sFH0Rmk/KVfHWlv5uquRngYAQ7D7zKj/3pP+3r+1Jh07SB7fsZgTW
         tgbuE4fRpQoByEOdA1yH0l4U59/VQ6JoFxOEWb3RFCCCRaP10YPcgSO91iyssUxIIOG6
         si49rKTN01jhPQCPSvmDie+IGmhotn9DUY3qjRk4w2ZIiXAB6HgXpTbxnSBicEdiNyp7
         TMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793808947; x=1794413747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJqTJ4xyg07hJqswmJ5AikQ26UFbu12PW8dHC4PPKvs=;
        b=1pTiFPQ/noPUBaIv/BldxoAJBlLHc31mRqgpZjPz8k3qYmTLODSEyHmhkB6c1/p+GM
         3Wcg3purVWqtai6SLzzsfY/gI3NxQDdEs9XSgB22smNOid3tUgVpH4B43Ofw0uiZ/xHi
         3c44TjgpTTG3biOTAtSBQ/A9qqAiGr3x7zHmssThy37PLnsk/QRq3DvtA56Xc7i7XKhI
         TblqrlGl/kE3ucI3sdOQFObfzGZ/SA10rTBef+yfXpa4AZSdhv9xTLXuzpoXzdUTWTy4
         oZCErlsBHf6cRIy4NYZrSUvR00uFUwnHy0JZnyr2FSwE7ZkeWEyulFlvkEE1dgoIxyth
         KSgQ==
X-Forwarded-Encrypted: i=1; AKwUvBws5rk7fnmRvZXo0bKjDVpnt/gDgDJCrYP3vfAPpP8Wud7X71H4aEmvXTUNO87rbtl4iKNVeg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8DV0OMHzrXCfqqoS7lrWPbfwqfjFccCqmiRtwArOULnOhujLrM
	RSSjh8JSa1jyj1um5VKlU7MFyVzaPFJSsJknbi40zp1FUnteJ3qiwdWz5hhN9Vr4TuI=
X-Gm-Gg: AYBFou2s2VekN+MNJIEDJFxa5vuXYDNAZpvcJd6CahyIGASCW+p7y2A0FrS19J+43ml
	Gi4EkCgiPFG5CwUi9LkOIEySEjHl2CyFRvgk0gOG2vK2nUkujDu6rTPqo/nekx7W1bssTupjt0E
	i8P9zpaIUBT1dX7YdR4UhzOhvZMCd1Yofc+SvvBN2lSCSAp2o+Qd2zv3cnLFMag56q04rvksTOt
	tGOYItpkobeflRlj4d6x2Vby2Flpj3YeaAjswR/cP2j6jrDugdKx+lZmXT6QpoZKcX+x6v0SxpS
	1WlFBlGjv0az9x4Gvv4L67YOLtLgFGxqZI/9vs0V5zavsWs4xGS7FCE7yCeqGtALaCQB+MVqTBh
	6WCda17R2Ok09LbXVR7mt60rGAjCAsBWOiP2kXIwgMFBmhg9wz3MRXB3VBKR8WgSGUXCpwNL4V2
	AAK4oQA8Cg4+pIYK0Gh2w1pwmoYJQS2XI3618jdwq16Dv7z9+VbCWWXI+XIrAcx/o0n5dBsX+Xv
	zPyECQ1DwS2psUmibtKOrnfESrvE0ZERjIQ1oy9Vug3RBpyS7UzSRu9nH7Ty/6Xx5Pr3niDFfgD
	gpJ4Pz7dGbZwDeyyVCLrnUg8xZL8Vz5YY79MjjGIF8+JcDoKN/oWTwVvQ88d5dRYyryDFoTzVAc
	UXchesc2Lz9FLh4vaw2Fz9F2lnIR1
X-Received: by 2002:a05:6102:8092:b0:7cc:9d82:61e2 with SMTP id ada2fe7eead31-7d0725cfd86mr6050535137.13.1793808946717;
        Wed, 04 Nov 2026 08:15:46 -0800 (PST)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afbfe6sm2262989241.3.2026.11.04.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:15:46 -0800 (PST)
Date: Wed, 4 Nov 2026 11:15:45 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 03/10] liveupdate: Allow file handlers to mark
 retrieve failures as retryable
Message-ID: <autW_3fjUS_hEhZf@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-4-dmatlack@google.com>
 <2vxzv76ck7n9.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzv76ck7n9.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_081549_059325_E1484EF2 
X-CRM114-Status: GOOD (  19.94  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11-04 15:12, Pratyush Yadav wrote:
> On Tue, Nov 03 2026, David Matlack wrote:
> 
> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > When luo_retrieve_file() invokes a handler's .retrieve() callback and it
> > returns an error, LUO currently records the error in
> > luo_file->retrieve_status and blocks any subsequent retrieve attempts.
> > This is necessary when the handler has already partially consumed or
> > freed the preserved KHO state.
> >
> > However, with user arguments passed to .retrieve(), a handler may fail
> > early while validating caller-supplied parameters (such as a missing
> > argument, an invalid or read-only target file descriptor, or a non-empty
> > target file) before touching any preserved KHO state. In such cases,
> > userspace should be able to fix the argument and retry
> > LIVEUPDATE_SESSION_RETRIEVE_FD, and if the file is never retrieved,
> > .finish() must still run to release the preserved KHO state.
> >
> > Add a retryable output flag to struct liveupdate_file_op_args. When a
> > handler sets args->retryable = true on error, luo_retrieve_file() leaves
> > luo_file->retrieve_status at 0 so the retrieve operation can be retried
> > and .finish() will still clean up the unconsumed preserved state if the
> > session is finished without retrieving the file.
> 
> Should we give some sort of signal to userspace whether the error is
> retriable or not? How would it know it can or should try again?

The goal of args->retryable is internal kernel state tracking.

From userspace's perspective, LUO ioctls behave like any other syscall 
where errno is the signal: userspace decides whether and how to retry 
based on the error code (e.g. retrying on -EAGAIN, or picking a 
different mount on -EROFS/-EACCES, or adjusting flags/arguments on 
-EINVAL).

