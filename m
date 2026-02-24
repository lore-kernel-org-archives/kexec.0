Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A95EEC2AB
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GriSu+rHCn93XDuWZWOQkqMZohlC+6Y/CRMlBkyQGvI=; b=rPbn8e5REpbGNpYrXZe1XGtog/
	kurb1LKomR291RhWrEZ77R72hWerp1qIghbrSz9l2Mzi2rild8SpE5WJgi/5Zx8wG/g53NE8sWsWb
	CBrALV4lh18Kg0lD/08si+Aq59gwdzVadmh4zJvLRHrZ/e7ZpEKAVdji33Pf0RgdjA2nlnvcfqlXB
	7iLNcLgmKfNyv5NAWTyjvWoCGK0QFPt+wl2l9dMgxdu8P2bkvg9o2/LA3gTAmI0ZC0DR9ac3BDksH
	kaipmlTzDG7hbo/8gXZm0TDZPRSo2nFqTkZU+Qjx24ajWnL7FqgpDiogZVm8I9LjfX/d6v86jW3py
	Gg23xHpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vufrl-00000001DmS-2ESh;
	Tue, 24 Feb 2026 00:01:29 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vufrj-00000001Dm7-0kD9
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 00:01:28 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-38706f96202so30892251fa.3
        for <kexec@lists.infradead.org>; Mon, 23 Feb 2026 16:01:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771891285; cv=none;
        d=google.com; s=arc-20240605;
        b=lUVgG/lJCvpgwxoOi0HHZ9TFnqgVpHo+1gfKzE1yYCEWiL91PdL7Tb9uljCsGPaSzC
         WVu7sIT87g/7j1TP44WTd/70o/Cf8B0IpAdw/l0AdSQ7wDu6qjIkpqEDsoD0KBa9dVMg
         HF42SEJUt+uw6FxoW0BZbJxnEWdOxZJRWN9WM0VDtuJwTImEKwXHsSL0GW1SoEJbt7s2
         9nsEG18Hs1lal0Yp4o07IHP6dcGHwG/X/cGdRpDw4AEjp7Y3f/BQeAzRjI6mzTRTkEeg
         XwSZVy3nyLUvpP8iitwdPydrU7l1NoANTAdL3gz6NLxX/ZJkGN9Qcq36zhAaWfNOlA/0
         1HPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GriSu+rHCn93XDuWZWOQkqMZohlC+6Y/CRMlBkyQGvI=;
        fh=IXhjreKF46o1z9kowSr4apa8ozuwG9bixe2E60maatU=;
        b=NT8JjJPOG2yKGJnE+/1Ej0G62IOtnXyhS8CT6PQsvdSsRy6I5gIBsvlLP8OiYzfIZR
         lpqHukVLhY2aXIZv6HRng3cb/7N6QJa/gtACgAM50d9SjYGyW2EZoUREEbVoW9GZcc/l
         tIgOuWnU8qs151n/jk+f0FCo+cSkAbeQeew7nsOtyfU9UF/QTHLJ+xdu7kwJOm3fvY6E
         cAs5wXDzmeczE8mEAp5iFEhjGaYDsu9qyxMQAiH7RJ05qhbhyRNBOCJ5/kjKh5o+H0aT
         haodHeB5j1WUahXd/mA50gp/nOtbzbieur08E5o2vqZbpwwSFrBz6aSPO90AKHLTXDW1
         EwmQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771891285; x=1772496085; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GriSu+rHCn93XDuWZWOQkqMZohlC+6Y/CRMlBkyQGvI=;
        b=FkNMUOZH76axGyjPJKNbqLFksUHTZH/MOkTiDrcHu9ZU30EQaLZWDrgWl1Fvzcn5Gq
         vVkYu55YchvSIDuPrtEwm8RvzNBsAaSjxVlbWU2JO+ozSU7psjDWhxGERc1OlQQJVlSi
         BOXjh0lC34udyrhZxNvrvuoFEA1afhdyYXYDAw0qlUJyW2cuTGecG3eTDc+ivnSgSdiq
         e24G6KnVhsHczcGgTUkcOqlL/hZSjUK1KBdsAFmE9sfdDm20v31LQsyKCInGh7zSrtX2
         M0rzMohwFFPxXan0ClFsgo6abpbM6DJ2CZoIeFh+gV6lm7J+y1+3Jo9PPEOMjxsiWrfb
         ewxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771891285; x=1772496085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GriSu+rHCn93XDuWZWOQkqMZohlC+6Y/CRMlBkyQGvI=;
        b=W1RBqEE1qXmbzQK8zK/edeVOlBdtskwhATJ7lS9jBwnBbN55/GyFVsaKsPlx9GzReC
         /RozawXUZk8dtQ6RnzOFiAjN7Lyi3IybGNgQew4DLYViWNgTn/mOdCbxNCsuyCjuSfFj
         fsTkeytqOrZbHLT5oKwTGHw8E98CWEOfPXmY0Fg9SXeP0fdl5IcRA/i/o5MHIVFPkQBM
         cdDrM0GTeprR4M5eQ7io7fjIcBlbHdeG2cPK33u69J4mLv+mEtXshdfh6LVYIqGwrqHa
         AdT46PORMYyjDAu1TS5dJxVDBHcIvVFPydJYj6EZHxagDAWHhK8tNVFbHUaMfCw0q9+Q
         OjEg==
X-Forwarded-Encrypted: i=1; AJvYcCXl3GAHUk9MQHn/QmduxgD9ocUREatm9v04RE2zE2Sq/KGOCV+amAnfXLH1edpLoEz4i+GVRg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwBUB7qOyRNWBUkczexcARwn/Xg2Zhj/zAN0kgaKdLZEHrTtlqm
	cbgDnAG+n01Dg0Wyl5nf2Zekv55dMaRg0tsafcLgl9uZykv+7uGJpa4kP9GIt/4/c98l7LCY36h
	1MdIxNz+YPPR31UcQuVRlwvAMpebxeSmY1mSwtSpj
X-Gm-Gg: ATEYQzxfL088fkdRQJwjlFj3GzELW0Z5VC7LB9JEDL3dOOneG0O1xZcqgx1NRbh3vuH
	c0FBMK96iqHJTP0g4V48M28ggva2sxbB7w4At/Ew5kaEhQyQ0vC6x8WfkW4XICOgVJxhudkHBXC
	Eg9NtFDf8iKfC5nFEwA9ODAoNzSmYJgwtwlMTGYK4DBU1tWy+xQDsr0ndBoMLdMSUmsVDmy7Jyc
	C5Tvn0c1JCAanckW860ESpM9aAgCt0K9HJskYNlKdO+lisco4oqiK30K03IX8hsSLocxiZzvTLd
	BXt86Xg=
X-Received: by 2002:a05:651c:305b:b0:37c:c84a:99b9 with SMTP id
 38308e7fff4ca-389a5dbcff8mr25152861fa.24.1771891284261; Mon, 23 Feb 2026
 16:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <4mbhcmimhin2ulz57mbzpe5p5dkhfziiyep5k3vgls4zmom3sb@g6jlouyvmpuz>
 <CALzav=eXY=ZBshmpi9axt+_0SxaAm0Xbo7w==nCWJwKK3xcThw@mail.gmail.com> <574e4wq43zm5tyfvvtjfvzqlhoyijcgvvk7gptghrx3ofq5ck2@l2q7xbmtibbq>
In-Reply-To: <574e4wq43zm5tyfvvtjfvzqlhoyijcgvvk7gptghrx3ofq5ck2@l2q7xbmtibbq>
From: David Matlack <dmatlack@google.com>
Date: Mon, 23 Feb 2026 16:00:56 -0800
X-Gm-Features: AaiRm52Dp6IBp6nUtMfXlMTK93T1cVz8F1V8LZFFdJp40no7f29X-MFiBmci9Nk
Message-ID: <CALzav=c1P7aoGzhSuGsFi6VYsNjygPvBR5jWXb9uqbJ+3MqARQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_160127_246758_A084CDA4 
X-CRM114-Status: GOOD (  19.35  )
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

On Mon, Feb 23, 2026 at 3:43=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Mon, Feb 23, 2026 at 03:08:19PM -0800, David Matlack wrote:
> >On Mon, Feb 23, 2026 at 2:04=E2=80=AFPM Samiullah Khawaja <skhawaja@goog=
le.com> wrote:
> >> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
> >
> >> >Drivers can notify the PCI subsystem whenever a device is preserved a=
nd
> >> >unpreserved with the following APIs:
> >> >
> >> >  pci_liveupdate_outgoing_preserve(pci_dev)
> >> >  pci_liveupdate_outgoing_unpreserve(pci_dev)
> >>
> >> nit: Preserve and Unpreserve can only be done from outgoing kernel, ma=
ybe
> >> remove the "outgoing" from the function name.
> >
> >That's reasonable, I can make that change in v3.
>
> I should have added it earlier, but the same applies to the
> pci_liveupdate_incoming_finish() as it can only be done with incoming
> kernel. Maybe we can remove incoming from it also for consistency?

Yeah I can make that change as well.

I was erring on the side of being overly explicity with the
incoming/outgoing terminology, but I agree it's unnecessary in these
APIs.

