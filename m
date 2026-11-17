Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EF606A32C
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wM9EDpmy;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8lhV+Z6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GttENf4AQLKGgaT2xtnMonfh7k3XNqVVFPtXzQMChjU=; b=wM9EDpmy1H+6lq5zTxxS3y1PGL
	67GfJhnXgSf/N7Kzovsk05aXKlkYYbVK1K9qrJMU77GGYuLD+HbDGBXdB1Y2wUzNMx6cJQcyRYYYw
	NyK/ytlwS8+rav9Xc7j0T8cAoeEsi8ayqb3ugol0gCtwRUcsUrjAGyXB6ABAO9y/V3s4chzwrvO5D
	HpO1f4cYM7wi30WIYVDQzPY4sZnNFz6EWHSXEfane+dOudbN7o00nkP9W9YhIWWcnaodI5t+T7rZG
	LvqDAu0xhwAqvCJRCTPL6fckOJrYJDxP3AD2/oOIEFTl59UQVu8Ik7tu56oCQK5X0o1SSOw9XAz02
	dxfvMVcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIC3-00000005bs4-2z7b;
	Tue, 17 Nov 2026 12:21:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIC2-00000005bru-0v3u;
	Tue, 17 Nov 2026 12:21:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E4E6743692;
	Tue, 17 Nov 2026 12:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023021F000C9;
	Tue, 17 Nov 2026 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794918105;
	bh=GttENf4AQLKGgaT2xtnMonfh7k3XNqVVFPtXzQMChjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C8lhV+Z6SJ8XgHd/J2EKI1U6pcb4wnoZF8dID2gB43wsYDa8pyqcBqXoFMBN0xEPN
	 iDxWYqie8JE0pWF2f1kyXnCQ6L5jOHuyZy6Tob4n2/xEewU+wXTHgFe8AXq06KvIs5
	 DaKLlL4gqZ6+qRwK1mKZ/oot5DCjLn7s3MFzjm1k/2LnjoEDqxFy9MeMqgtd9sG1U4
	 fQ+kCnZ+V0Jbj9XU6dxdgPvt0chSQtjPt0YC28YBiFO312AJ3WmUWkDdu9jidpWQkp
	 kL1OZE7zrbXx1g+ZVCa5SBXHy/BmdjHWUII37KVWw/6mK+HD8vNfHhCkVxfVbbv1A4
	 ZC6mh0URIBSIg==
Date: Tue, 17 Nov 2026 12:21:28 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver <elver@google.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Evgenii Stepanov <eugenis@google.com>, Ian Rickards <ian.rickards@arm.com>, 
	Jann Horn <jannh@google.com>, Jeff Vander Stoep <jeffv@google.com>, 
	Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Collingbourne <peter@pcc.me.uk>, =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Tomasz Figa <tfiga@chromium.org>, Will Deacon <will@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Allison Henderson <achender@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, kexec@lists.infradead.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/7] mm: kasan: skip KASAN for GFP_HIGHUSER
Message-ID: <avxFYRBid_VUp6vo@gremlin>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
 <20261116230627.3537051-6-jeffxu@chromium.org>
 <avwp1ZpVudiT1Gux@gremlin>
 <85ce1f24-8b49-4cd3-a9f7-02d1be69708e@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ce1f24-8b49-4cd3-a9f7-02d1be69708e@kernel.org>
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

On Tue, Nov 17, 2026 at 01:06:54PM +0100, David Hildenbrand (Arm) wrote:
> On 11/17/26 11:21, Lorenzo Stoakes (ARM) wrote:
> > This commit message is just inscrutable. It's like reading Finnegan's Wake :)
> > LLMs are obscenely terrible at this stuff unfortunately.
>
> I truly wonder how some can decide to submit something like that with their name
> under it :)

Have you seen mseal? ;)

--
Cheers, Lorenzo

