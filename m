Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33C606A32C
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nj9OyMIt;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cCVrEJ6l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qvYwNBiIdSxY1ryMKCuJ8Xp5CwhF8vXQvRGoOqfiz+Q=; b=nj9OyMItTYgUnn
	gAPCMS+Dku8wIaJRGIWdT0/2yS42moSEe6AnGdbv9Vsl5uXoF8xBpxIHOA+vKY8v1gSYJKZ4j1L6V
	gR8alqf47wLBe4gw2MoJ0N14jlwSKleZjNC97Dgpq+kbjpi9O2uS6fpQMEdaPBtlSdzBnO7v8Te5v
	A5Sss6re40yXSe5I7Hlc7DOasZYh8r7qul+kr5bdSUgzdMSQ1k5QiTPQhFeVlKyqu9Zrqgs7BcXVL
	x9UP+CCAoQmtQV/HSA467/LssMHk+L0deFUUjuzb2Eh53tjGUpSsKh+Fa5Fv/Mxd9sfWFqNqad4OR
	fiMVgHRauJ2eU6fyMf7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVtVR-000000078Xa-2haj;
	Tue, 24 Nov 2026 16:36:33 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVtVJ-000000078WS-1mQG
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 16:36:31 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cddc250d815so1851848a12.2
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795538184; x=1796142984; darn=lists.infradead.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qvYwNBiIdSxY1ryMKCuJ8Xp5CwhF8vXQvRGoOqfiz+Q=;
        b=cCVrEJ6lxcnCkQDK7UksZC1ekFtyKop/64z8BTidZVTAtnHa7SQEaGdhHU51QlxqhK
         Zt5plv6EtqyVWuy6+IOmBLpUGim/ZDn6et8mTMoVPgV1ptH3AiNkyhba3e3b9T+Y1LQ1
         bZQflEe6nU4HY3jhVG5vD8BTWk6YI6x8aQsSfkh5ZKBgiFq5x1P8i0QQs/2lQM5FQ25R
         ccMsp7JyTMqEsD8W38/6YNVWPJryG601euyF6k10Bg9NRgz9FDSLtItFIrC1NWCyX43/
         tl1tEhCRffQ/0u4BpHP8/v/jZs2Qk03bAThSAKiJRErFLgQZGVGR0MD0tt6gsGYNgRM5
         Oc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795538184; x=1796142984;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qvYwNBiIdSxY1ryMKCuJ8Xp5CwhF8vXQvRGoOqfiz+Q=;
        b=SUB8EilUZiun8lVFIj9jB+s9orhYekMNxqL/1Nvd9bwUixsHLcxgsE1p8tgr/biAjF
         CqFXT0ZmD3s4Zgdf7TmZZEic+hHUqtH62HkAi1eHn56KSYQhhxRKVr+rftKdeMwcHwl7
         0XeLfTXJsd9fJDC+l95F8Xd7LBkxFcc5CF4d5DGbgQ4nhU4JxvOX1N/aTCI7Z9Utrgjv
         xhqVAhmK2fDKms8obJbVqIkwNU99x27iW2SVUoddmuxpxXpQ4b7wDeJo1/O/tddrsvGS
         lDWB3YnoBH3zgtz3uXBKhdAdxvJjLMbJIjbRSRjz2NPmqw7GjAYAg9hphggFMIv7WC0N
         kaKA==
X-Gm-Message-State: APuU4Z/YF6sK+jJMHAMPtuENc21hbWnLZM+BrEJNu5N4oP0s0oNx2xZx
	IbASUkEHnpEYbbqe/jgbj6kQiOosa6RB+iJScFpbrrKNsn6fikc5hZVfWdpcvIvgjQ==
X-Gm-Gg: AZFdTZf8WZmudlDhwUuKF7eTnE367TvccYiS7LHL36Bib9oKbMpkJPPQICi0bXp9wiL
	qlMb/0oB+yC58zxYwFFUJoLO2cuWP2rGZaCuobDm8W4ACTm4pW0z6b0IH91BYPTucb232qrjbKp
	a0dVFUWPBPA94aRt2lpPAfF2xukctrmut2bwlp+NQG42NMGgPARrLVVJhaww+wtT06jVqPmoz56
	R6es2yIRTQPyS4KJZC0DotbaC3pQENH/VJ2KQ/IyfyzDs3800VzJmdcA7KFaofLGX+fYM+1wgbR
	nVrUNQVAHJKRiVRjiSwCE0Ce4EZ/Nt/x3IhfyaplcWFocTEQo/VuhTcORLgxNbzs3Wa0hPgkQr9
	sNqgpybPPh9MOTo1GauyHguae8gHa9+8H9sXctzb3h229YUzfIY/x14QCoJSMJCh7mT1strXaAD
	+iRH7lzfbbAXvpc3NGnkweiC4L8BH1Q9HdI/0G8eOORMbsTCfw/yOQITEWYtCLyhlbsjETCROFl
	JaXspcorsSQlRsITwHLlbMvRv5eQqCl6ggcL28Rh+BiPSDgYHmI9cO7qsYsR9lgAEkMbPqJdIfs
	ueIlaXOg+Uyo6himRL9j4O5q3ZBYyWuf++5p/LutI8a/Ulsb9vnkiN+4mCf+W9kO
X-Received: by 2002:a17:902:eccf:b0:2e9:64b9:a333 with SMTP id d9443c01a7336-2f03f17c766mr149220465ad.19.1795538183777;
        Tue, 24 Nov 2026 08:36:23 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120830sm71740805ad.61.2026.11.24.08.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 08:36:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 08:36:22 -0800
Message-Id: <DN3L5XQDSVO9.1NJFYQJTS16ID@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Mike Rapoport" <rppt@kernel.org>, "David Matlack" <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson"
 <alex.williamson@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Down" <chris@chrisdown.name>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Parav Pandit" <parav@nvidia.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>,
 "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
X-Mailer: aerc 0.21.0
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com> <awKlfqlQYhphXCvf@kernel.org>
 <DN2TQRX57C04.ZT5UUS6AQ1L6@google.com> <awVjqLFrXY_PCm7X@kernel.org>
In-Reply-To: <awVjqLFrXY_PCm7X@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_083630_272679_628251B7 
X-CRM114-Status: GOOD (  11.35  )
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
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 24, 2026 at 2:15 AM PST, Mike Rapoport wrote:
> On Mon, Nov 23, 2026 at 11:07:04AM -0800, David Matlack wrote:
>> On Sun Nov 22, 2026 at 12:19 AM PST, Mike Rapoport wrote:
>>=20
>> Hopefully I did this all correctly... This is my first time sending
>> in-reply-to fixup! patches.
>
> This is my first time merging !fixup patches and it seems b4 managed it
> well :)
>
> Please check I didn't miss anything:
>
> https://git.kernel.org/liveupdate/linux/l/lu-pci-preservation

Thanks Mike!

I checked the updated lu-pci-preservation branch and the code is
identical to the v12 I had prepared locally.

One commit message nit: "Freeze preservation status during shutdown"
ended up with two Link: trailers, the original v11 patch and the amend!
patch:

  Link: https://patch.msgid.link/20261118223704.3286085-12-dmatlack@google.=
com
  Link: https://patch.msgid.link/20261123190045.2166865-4-dmatlack@google.c=
om

whereas "Adopt ACS controls in incoming preserved devices" only has the
original Link: (not the amend! Link).

Not sure which is correct.

