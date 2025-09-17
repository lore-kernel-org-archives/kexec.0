Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D62CAC59A
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQPUKsmAc0liILowvxQAIT6pnimYT1OvWOFQs2iiA4k=; b=ElsZLLY4WetIftmUBFvGvS/Rzt
	niM+KSZlBKh/H6IbWxJiBRLMR6uqRqafihZKfwWQ3im9NLy1IvraNsqlp7A0T7c638vZRy/YUVqa1
	qInlhvMFyZlts46wKxZaayynEBsbOWeRTMKuVFRuBMImtiPzznyDn3E0x12fEfpyfG1ScNk4NpY57
	nvLqAIQPWUb/u8nqPpazYKrwU8WL56xvYZhZGStagkxr6WOY4his80hO22ic0urKPBQh+tE/jWw7M
	TYGUPCQILEKWIl3aLyxATtBaw3p5gFuzxhV5eIEG9J2gdzI7p/puK0WJhELc1mFgAUwPpAOV00X3j
	9dHDrOkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uytSj-0000000COJa-2IC5;
	Wed, 17 Sep 2025 14:48:49 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uytSg-0000000COHF-3gm6
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 14:48:47 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4b38d4de61aso67337241cf.0
        for <kexec@lists.infradead.org>; Wed, 17 Sep 2025 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758120525; x=1758725325; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQPUKsmAc0liILowvxQAIT6pnimYT1OvWOFQs2iiA4k=;
        b=YrrFQO3NSto8DiRd2ThcpXew89FmndexdJQa714bevEeN8Mcl2dde9v9bop6A3+I2V
         D6Dyo8MGvbMyTUfTRKBxUDPu8wLzGeq0tLLo0qR/1TJEUNvjLIvzwNQ9Hct0NzUFeycK
         hk8+zvGMy9RWD3cGZOFh0U3+33ClpaViCaP7Z+wumUR8j+fSlk7OemWlqikvPWf4513k
         4DcH9tzhoz0fvuNkUannoCVgsR3xmje5eGk5Fm2OUYoX8aPFyPbcCp/Z38aGheqo1IZ5
         Onq9v7H32HihpujPxCvuFWKcEXsmVFs1L7Vsewch8r9z9qHjnpIWokPXo/Oy8jMSu6+d
         RR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120525; x=1758725325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQPUKsmAc0liILowvxQAIT6pnimYT1OvWOFQs2iiA4k=;
        b=Rbzl5TG0bbIam/3tZ23cAvNWtRVLMg5cpIHhgni2d1QjoVdaJA1GH27VBR8zWmfTcl
         vS1TPKshe2uLmma+5nqky8ZPf36nD+PdDCXih7ahSsGg61yWZrbWN1XfVgw4E5MdVlVd
         OkRXWeXWO1HCd8xsJuiQtRHxCpN9VSRG8n52MDHdJfegoZypITUIND2HZavyi4iEQy/C
         BldFcRrqG69DmViBrogAeOWnVtYyj1Lukykej98TwZh3Fu/arVhfYUOmFbWk2U/A3N74
         t0iWJBX4W3aUPMJ6FP+M/fw5CpMcxeYtunj3X5sLj+yAZJqKsjkPurfCBIff18bymjsI
         U1FA==
X-Forwarded-Encrypted: i=1; AJvYcCVpw3J8RrbmTxv3cRbqqJFS1ITQg0pSmjGdlS0izn+stP6KdDqllBjV0Dhn3AMhFM4+un0FuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLpHA9l2tUVW3mWPuWBqqKPOIPCNzTGptZwqi8828VXp13G/1d
	6GZE3nQM43NlZOyjWog1GN0J6mSVuj7OpG3VcySzY7QR3uEAfDIBjUIBnDoN9nDyLhgKPO8OY/o
	yzy475NPwRaHCa4qRyBqV9yUDgYReY8CwVrmMShWMZg==
X-Gm-Gg: ASbGncvJzABY4gkiRYJRHUy5I/34RPxRvqR8ZASFjYEpXVG53Pi06TfaSdZbhcew+4P
	ar3C1Sy+uErJ78IQ6abBkVgLKlFUM4JFMAaJaH0q18uNjUNKYpKVgOGAK8lFW3F1CCmz8nEC63d
	DEJ0bMPXMNTfp+ol3ZEGYrAafHwlzizwLfyBlmonVamMYRfPStwU/QfIUbMMJ64rMmpmh+KhtNx
	NOh
X-Google-Smtp-Source: AGHT+IE79GpXyjBV89Avr2S09fmTlI/L2wNAUrwa2E6+rwL+V03nJN++UHPUWlE+FIB9aveMjDTolm2gyToXUS/Nfzg=
X-Received: by 2002:a05:622a:5446:b0:4b5:e9e3:3c90 with SMTP id
 d75a77b69052e-4bbbe28e2bbmr8185321cf.9.1758120525123; Wed, 17 Sep 2025
 07:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917113609.GB1086830@nvidia.com>
In-Reply-To: <20250917113609.GB1086830@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Sep 2025 10:48:08 -0400
X-Gm-Features: AS18NWCrgaurUWlppllqWMXv6puRwIeZOjcCB40WylsCdUx_uF-Iq5DWN0oZ-N0
Message-ID: <CA+CK2bCV-UbfDb=QmyJrX3xWMToCO5b5a1R+Px5QOXafF_AqRg@mail.gmail.com>
Subject: Re: [RFC v1 0/4] Make KHO Stateless
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_074846_927065_CA98F67D 
X-CRM114-Status: GOOD (  17.33  )
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

On Wed, Sep 17, 2025 at 7:36=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> > This series transitions KHO from an xarray-based metadata tracking
> > system with serialization to using page table like data structures
> > that can be passed directly to the next kernel.
> >
> > The key motivations for this change are to:
> > - Eliminate the need for data serialization before kexec.
> > - Remove the former KHO state machine by deprecating the finalize
> >   and abort states.
> > - Pass preservation metadata more directly to the next kernel via the F=
DT.
> >
> > The new approach uses a per-order page table structure (kho_order_table=
,
> > kho_page_table, kho_bitmap_table) to mark preserved pages. The physical
> > address of the root `kho_order_table` is passed in the FDT, allowing th=
e
> > next kernel to reconstruct the preserved memory map.
>
> It is not a "page table" structure, it is just a radix tree with bits
> as the leaf.

To be fair above it is referred to as a page table *like* data
structure, but I agree kho radix tree sounds like a good overall name
for this, and it might make sense to rename from kho_page_table to
kho_radix_tree in other places.

>
> Jason

