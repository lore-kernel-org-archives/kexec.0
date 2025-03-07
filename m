Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589D0C282DE
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihMi6eUWoBG67x5XZWjzpKw0nnicR+z1rqoKyPAosc0=; b=ioyVjgFaF4x6TswR3thxtTAf8z
	oT2dl5HIrU6vEzTBhGeZe4QYO8nhyJqnhPrKE2szZw44Tnfh/8YimZFINOAVUwLAc/ldfByk6mmFl
	K6gQPw2y/RL0Ovfburtity28s/BCx3QJH5vWzANDxip631uKQG2JyXVvmhOXcGc69lLtqJnmbXr3B
	gnUpTqbEUYK5Gfn4KOSS2gKDeSv1UcPIsud3S6C/Cb3c7vgXiaubvxqAwR41CuOKDIOg5UrcpJoQW
	rvP0IlpzZNvlpHoFJrkO0rSbgKH/XQ+plTolHO0fl/ycwESxHFjDyWWNkOcnFZc1BQmuIJ0XTccbx
	gfc27taQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqYas-0000000ERtK-3nqn;
	Fri, 07 Mar 2025 14:22:30 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqYaq-0000000ERrV-3lPr
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 14:22:30 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 306574105E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741357344; bh=ihMi6eUWoBG67x5XZWjzpKw0nnicR+z1rqoKyPAosc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KolgCqAaKSRvl4BpdkLf68uOY6ycttrCai6uBAeUv7AYMdowFzB1ry6Fa6VN6EU+r
	 bccR64R5gTWUfbaTknO2VDolfU7n0LqUsLvlq22+KM2tlEq+yeOqSE1jRudS9Q4AIW
	 o0Vc8o1cE/Hb9ZdiN8Xe39y/6NnMSNZlKE+PLAZUvlmamH5cJUvvsaF87Fx7qYv8qL
	 4Zsmao2IGj0jFTxt4SzmuF0k9XzKqv4yhhS43MGHNzZ5ZPOBnEyKIK1yjSYqQT41uT
	 vqNEJYuLNI7HBC91PUmiPRd6F/QubeYSPstaCdCrVSwoQWHLGMWq2k/ydrtBC/Ty4h
	 MI4WzsTnml+uw==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 306574105E;
	Fri,  7 Mar 2025 14:22:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pratyush Yadav <ptyadav@amazon.de>, linux-kernel@vger.kernel.org
Cc: Pratyush Yadav <ptyadav@amazon.de>, Eric Biederman
 <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Hugh
 Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, David
 Woodhouse <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike
 Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha
 Tatashin <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
 Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Wei
 Yang <richard.weiyang@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/5] misc: add documentation for FDBox
In-Reply-To: <20250307005830.65293-3-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-3-ptyadav@amazon.de>
Date: Fri, 07 Mar 2025 07:22:23 -0700
Message-ID: <87ikok7wf4.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_062228_933082_CBD45D43 
X-CRM114-Status: GOOD (  14.49  )
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

Pratyush Yadav <ptyadav@amazon.de> writes:

> With FDBox in place, add documentation that describes what it is and how
> it is used, along with its UAPI and in-kernel API.
>
> Since the document refers to KHO, add a reference tag in kho/index.rst.
>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> ---
>  Documentation/filesystems/locking.rst |  21 +++
>  Documentation/kho/fdbox.rst           | 224 ++++++++++++++++++++++++++
>  Documentation/kho/index.rst           |   3 +
>  MAINTAINERS                           |   1 +
>  4 files changed, 249 insertions(+)
>  create mode 100644 Documentation/kho/fdbox.rst

Please do not create a new top-level directory under Documentation for
this; your new file belongs in userspace-api/.

From a quick perusal of your documentation:

- You never say what "KHO" is

- Your boxes live in a single global namespace?

- What sort of access control applies to one of these boxes?  What keeps
  me from mucking around inside somebody else's box?

Thanks,

jon

