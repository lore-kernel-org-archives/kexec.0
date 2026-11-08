Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF2606A321
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M90tKkrj;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=a9+txDVN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=; b=M90tKkrjVN0jtp
	5MCOD51/x9Lv/mQMXuAfI9HQloDlRq+HNf7UNbcI7qEiGRvaOCn0+N5WZwjQNmXyFyGkTr9hTm6PA
	AkiMEBzYk3Advdmvze8UeSmTg9/VAdJfn/mkf7hY2YckZI0/E02lyT7rsMT7+VwdibY316PqgKOmr
	rxgh9hzycaZWMJtvnKYPRFGJo+av/n/ptDk7KozdOFnJHAOCw/Dg9w+U0YAAoOwENDGz0zM73fenn
	kaJtNtnttalbZ9mcq6ZgjPoehuQUjsd6aubB186+RC83RNUzU6y9e41cQMrA8rydi9jq8jl0E93gR
	1jKwfItdQANl78yGJUSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4Le-0000000GHZg-1CS5;
	Sun, 08 Nov 2026 14:58:22 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ4La-0000000GHZJ-3R3Z
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 14:58:20 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso28347e0c.3
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794149897; x=1794754697; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
        b=a9+txDVNOPJv6VKtuhZUd58AjLFfLq+PscpeuU1n8EK1hXV372oxWLvgNbP6tKqjry
         R4i/6joUYe7cY/36nMfdrico5gqPOdDsOa7RKxCeNb5Cb2ejUkXHQteWl53SBQz/T0nv
         nJ74qmNXp9Xzey7DfsD3kNWLjpOrOtvhkDppUN7o67nvdHXVSpzmShh1TBpaH/dWTuc+
         /HrHr4mK6PZbetR0uveKQzjNodUMqcZo+mbPHcgHxsPTgkK3siFpUJlpJkykvC8LVtBi
         pplPkrGTJtvXC4KNCZ/22sWC0KZC7vA2IdeZ27oXrjyG/L7WvJKyYYnle9Zm1vugYK4u
         LY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794149897; x=1794754697;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zg9wHbUjOFQvCSSXrqJHlgr9ERwDV2A9O9zK2C7wcfk=;
        b=P1Uf0EXisAa/4c0pASwv4dp0Y92pbGq1xcSaY4kBOxLZ59kDQkJ7kJg81PmS/bg9FE
         /3QGAINDg11s8jREFlgGv4jWkRMmaIk4UZBFEn1H0bIQkrXbWXBo0qH1r8ZOCD93tg1f
         gbLHB6ordLhgBAqgv+OIkdi1Bxn+SO2eb1ECuO2by4BjkoVZyM2xdO0yIBktpr359ZLv
         BBEevECDEQ6jiNuy8WzZchxXLROarKPtHjW1cV81I4bfloFho/yOKlPEMJNuUPxSvQXw
         HAUcT4bhmbpxiglvp9mzQ8fOvwV0IOFC26A5xN+FjFrlYKaCqSYNPk+xKHEAdebfOlBU
         XaQA==
X-Forwarded-Encrypted: i=1; AL+hErGJMeQ+axotbLekyqHVGb80M2gklSSQY6giKLEAvl/ZPZi22FJseeG3NinmwNBxXUz50JH5zw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9+OflRoE29KUw9468fETulqnbR/j8oEjPmXyVYNkxXg7xBWiCY
	wu5Vyowk03Hm2HOHnAe1RoRz79OsSozTXf6m2QGcJcZ0loUvp8OZTerkRhv3IOfkJZE=
X-Gm-Gg: AYBFou0Vz4aY+wCeqT2OuypqaB1TxxkxabGx3cyh38SkgHDQGUA8badBNMOfyLOsRCQ
	wIh16d0xyzwczrJMdJ6aPOISIKnlJP0+Km4cXFMkfkUlpt8ZTVFgBb2MFduDGLwqnPmp4RwT5z6
	l7T48Vv2/Hj9SrlENE9wLeyHCk/QU9szLXg+/MxySWOYDmt0HgWNOJoXOOxiv9FJvxVZuBHWl+3
	PzMY2b0UbPws9zH+2xHs9UjugmqOS94Bn1FREMQh88IbduV+fczAd22prLu1l3PGtdZEywDTqys
	UWzuHirZX8rqX0f5bd6wxDA0qASRJX9q/5Cvt6Y8yufl63Fy/mtyuWERsRu/M0vg+lJhdKCpVbN
	byMmXAApoGUvH3alCb5+Fum6Onws1K6XSV1dTVrmctPTWkEkFSWVydl0NQ4kdlckZcAp+Uhld/m
	+FkoSUWE3jVTH/t1y9E/k0MHw94BXSivNbsFmBXsO8K1/c3QJ8EyvPUHXRkHkbdWYOUW1nCXGxr
	Z8jigCKlmeSYHwzsyGF8AJuStJlUSS8u6PX14E/2ZJvhPQlSkKFEur9dzjNvwZqxJFFQ6zN+8cQ
	q/BTd9mjHq5MpmCinrb3mPqnJtnB03STZh8NE7whhU4BrAlZNwGhSRnlS+rGswQJzxM5xmIx/A2
	tGTik9XQNm8T+eI6D9U8AsrP8c8E9oCY=
X-Received: by 2002:a05:6102:511e:b0:7d2:cdd6:6be with SMTP id ada2fe7eead31-7d2db193714mr282127137.21.1794149897376;
        Sun, 08 Nov 2026 06:58:17 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a108d6sm1838855241.7.2026.11.08.06.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 06:58:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 09:58:14 -0500
Message-Id: <DMPX235ZQEHC.379KOADR3QVFU@soleen.com>
Cc: "Alexander Graf" <graf@amazon.com>, "Alex Williamson"
 <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Lukas Wunner" <lukas@wunner.de>, "Mahesh J
 Salgaonkar" <mahesh@linux.ibm.com>, "Mike Rapoport" <rppt@kernel.org>,
 "Oliver O'Halloran" <oohall@gmail.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Vipin Sharma"
 <vipinsh@google.com>
Subject: Re: [PATCH v2 00/17] PCI: Index saved capability state by
 configuration space offset
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "David Matlack" <dmatlack@google.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261106004218.604799-1-dmatlack@google.com>
 <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
In-Reply-To: <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_065818_886071_2A82081D 
X-CRM114-Status: GOOD (  11.60  )
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

On Thu Nov 5, 2026 at 7:46 PM EST, David Matlack wrote:
> On Thu, Nov 5, 2026 at 4:42=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
>> Merge Plan
>> ----------
>>
>> This series applies on top of v10 of the PCI core support for Live
>> Update series [2], which is targeting Linux 7.5. This series is
>> targeting Linux 7.5 as well.
>>
>> Both series will be merged through liveupdate.git, matching the
>> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.
>
> Apologies, an update I made here got lost. The PCI core support for
> Live Update is targeting 7.5, via liveupdate.git. _This_ series should
> probably target 7.6. I doubt we can get reviews in time for 7.5. And
> as for which tree, I am not sure. This series is mostly PCI core
> changes, so I lean towards merging through the PCI tree. Only the last
> commit touches drivers/pci/liveupdate.c.

I looked through this series. Even though it is motivated by Live=20
Update, it is primarily a refactoring of how the PCI core saves and=20
restores capability state (to make struct pci_saved_state compatible=20
with Live Update), so it should go through the PCI tree rather than=20
liveupdate.git. Only two patches (12 and 17) touch=20
drivers/pci/liveupdate.c, and we can Ack those.

Let's get the current v10 PCI core LU series landed in first; after=20
that, this series can apply against 7.X-rc1 so the PCI tree can cleanly=20
pick it up.

--=20
Pasha


