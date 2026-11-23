Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FD606A32C
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0NbpksQd;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RpqPJ9Lx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TFQZ5Vfgmmi8vCbKTEjvDQ3KYqVEpaJ0qjUpV/3d3M4=; b=0NbpksQdcwsnKF
	gSaDJQiteJF5BUOcwd/VJvkuLkJ2wWD1IjMgOI6TGd5l9xbCSa5/EAoSgWzq3P6ryvJykWMOztG71
	f7Pxn+He5qEn8l5KCbrjDu5Zvc56ZxQ3tY7Y+sbelPVzDNg4lyHm8lhG+vfFA9ErIe+q88JluRoj3
	6XuglpTeVK0fJjRhn5LM9ZuoJy0o46aguOkkWk2c9FoxVZy4zd6RuBWHuAGRA5X0ObrJ4HXe1iz/0
	rMzjiLrjmo+DpWTuLeIqiHxe6vnqSmb/GX3atLpy1D6B79TXLhIRFrZQ706yJ4EKwv7bnpJJ4VHdI
	GB9u4faONWb6UNB3iLKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYaC-00000004Spa-1ed6;
	Mon, 23 Nov 2026 18:16:04 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYa8-00000004Sp6-3mz0
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 18:16:02 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2f046b0adc0so17973125ad.1
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795457760; x=1796062560; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TFQZ5Vfgmmi8vCbKTEjvDQ3KYqVEpaJ0qjUpV/3d3M4=;
        b=RpqPJ9LxMoCG5zh7tDkxsl5mpkgr3QmupfssbX+EY0A/F8iM9uO8ZF02t4928gFoeB
         c0zfa80Rd/mXLk9qEeoxmTDTbte88kfzun16o+U1Uet9OXyF6/4LxN9r5a+U92gSSE3W
         lOWJIoywoKntFXChV8uQgHbeiCWqHmI7EiUtx0kPgqUZLT5nWr4Jfic4Nz+vD4Qah4tG
         mX+xs8HAz/xp//s/1H8y1dGkt1kKZ60JdHa5acO7bajUQm1YLCQeDMM3jYFixNEPX95+
         XQi7qq56a6X8Xcb9cnIjkR2XJCLRJcwP3AZlnHOlVJJQVbsZPiFGdm1ljgIJR0KuUZbu
         9eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457760; x=1796062560;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFQZ5Vfgmmi8vCbKTEjvDQ3KYqVEpaJ0qjUpV/3d3M4=;
        b=G4XrOXBaF6g1tPEjYuAzh8rph56oCi8QovuuWdd46Uql9LSQnSviXqL6dIegBEU/8k
         9bzdv6CuVbNAs5enlfIJP1UUcMGGrE9vJEztCuFAta6nTypmiNH38+QzoE9HJHar23Ww
         a5LdR86qHjwmaBTLdlRt7VGmcBfmNUVE1CsxfCL81oWPaxc0jyDzxi367awniL7sAEiz
         FYFdKuKvZoUb0bS97s0pIcdWYNL9N8QUUt+1p0raCLU9ZToD80AUhAl7Grs7MpIaivmu
         Uj28hDEYrTHVfZ3U5L2qrOOlIkotxfpVEr31nX+S0MPQsoxoj+LAukQC3//Rj+pLqDMa
         nA2Q==
X-Gm-Message-State: APuU4Z9+AWLFnsOHJzyL7IW9Z7p428g1TYNodJ8tJMroiNrcn56W869e
	DHQ2jUOa7X5wTnSG8tNiPcAiheDrSLF5p5SMzXnkrhuXObiuOv0iwyRjEDXgVZed1A==
X-Gm-Gg: AZFdTZf5FcXTWChg7qS44qL0TTG62JsYnEgXvakit7DnTOROaxlPH4dU/R6cPyWX8vu
	8Y2YL3pGnEJ0llHhOzZw/TaQvEjDyfbghwcCKjXGDdBR7d2SW4twx5qUCS24HNsYJZ8vX/YvLl8
	1iV3Vlfkk9tp83dsWqa9uzj5NpK2EgGilC03qXCrtRaOh3Gb+aazBo6il060/8YBqQy0N/SJFlD
	loo2BhKBeg6n/nlzLiS86c7BU1ZgaBvSN5hPUmInM8WFvoKWuOvNYxM0jaJjByPgtXcdfdDZZTP
	WJtGOJfV8C62jQPAAAo1P1IR+k0DL92rAxCu930Fpr79nWVhdzAC9X8FHELzi7EhbGu+mtO6CYl
	KBJPtbh3pJSCqbVR/oSqrnAKv5M/Fjzzwc+o78H3pUuUyCgALQo54YnyDQsq5KNf4sbDtJkb8Ro
	E/r9O8rq7xUhDI6KwC6av3xHXNfBYaEf9go7M6NCqkr8E8DnuHaV7hOd6ZxsrqJDnsOL6ToFT/d
	urdNYZzI8gPLi1aiVW0xK0Ik839Zmwn4QDdqyVwi7gYdijI15huYIMKpb68AUUKW5LF0u8ihwUV
	Sm7PvPIKaQeeY0+W4gewQ1YDsvCMbeO27XyiaB6SNDa2jLQexLeoCegPV7rEsbjN
X-Received: by 2002:a17:903:94b:b0:2f0:3618:f170 with SMTP id d9443c01a7336-2f03f1acb10mr114729435ad.66.1795457759518;
        Mon, 23 Nov 2026 10:15:59 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm57723715ad.58.2026.11.23.10.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 10:15:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 10:15:58 -0800
Message-Id: <DN2SNNBMY48X.2HS6KSB38QPK3@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-mm@kvack.org>, "Alexander Graf" <graf@amazon.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Christian Brauner" <brauner@kernel.org>, "David Hildenbrand"
 <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport"
 <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>
Subject: Re: [PATCH v4 09/19] mm/shmem_luo: Leave freeing the preserved
 state to finish()
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-10-dmatlack@google.com>
 <2vxz33sv3ef3.fsf@kernel.org>
In-Reply-To: <2vxz33sv3ef3.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_101600_940861_4956CD02 
X-CRM114-Status: GOOD (  12.98  )
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

On Fri Nov 20, 2026 at 3:55 AM PST, Pratyush Yadav wrote:
> On Wed, Nov 11 2026, David Matlack wrote:
[...]
> I think some of this is already fixed by [0]. It holds the folios until
> finish, but only in the success case. On failure to parse seals for
> example, it leaks them. Except, as Sashiko also points out, in
> memfd_luo_retrieve_folios() the folios are freed.
>
> I don't think this is strictly related to your series so can you please
> send something on top of [0] to fix these bugs, and perhaps drop this
> patch?
>
> [0] https://lore.kernel.org/kexec/20261110175855.2437084-3-pratyush@kerne=
l.org/

Sure, I'll drop this patch from v5 and send the fixes separately on top
of your series.

