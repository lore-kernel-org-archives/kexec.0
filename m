Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A48606E832
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ufLxCiNx;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KZuHrX20
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AqrMQTautnZWVcHeal8+VHryjxTdMHJnQLEYqFDhRfQ=; b=ufLxCiNxZd7O+LUzf++fTk4hCp
	a5DCRf6918GrZvSsRHDrVAG+e8pRi29r8AqCAsbCCSaZJsP3xqnsamPgSx5blV1RUjEfLskWcT9B1
	6RIV0B/cVUJ+W57XpDMRYXVzIwNMXszl7u8tq+07FPHx4lz++9M/D/7Ih/QKcA7YL1ZX+lGiGR7vD
	pKVy8CAhny0uHLPTzs2imGc48VgXpjF5sWhLFSXD+49oy51sVmSZWRqB1E3uxBRCUK+QWdYoTRSJe
	3cpJNGMe9v6cEGSOSug3T1CPCexvcxOHpbjFkUzwheObu3XyiQ55NmNJquqv+yhZTdMcv4ew5EB8G
	8FlkXcPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjWr-000000079tD-0P3k;
	Wed, 04 Nov 2026 22:32:25 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjWo-000000079se-2pBE
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:32:23 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2e60f9af6e6so12126315ad.3
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793831542; x=1794436342; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AqrMQTautnZWVcHeal8+VHryjxTdMHJnQLEYqFDhRfQ=;
        b=KZuHrX20AQDbjSxQmVnkS11l7sNgC4ewGigC762Uk+iXi8+Qe7/V88vfAS4YaJ0WhF
         qCoYcpHhI4HldJdFpbYY4REhmKvRlW0XukZnHh9PRk6WZqSjDDamK0rXLWCgdtHTdp9o
         0UjJVxgigG65k0yDY7jlEtuH1ae41U2Hi7tCrd0+c7ZV6/mD8UsS8A83L7WrOGuHE53Q
         My0kGeaQdT6DJFGuelkaLwDy1SwvElIXWgjT7raeE8+BOS7SIA6AdbchrKSu3sHVrwgm
         csKN6rTIwcPvfvbgJo6xjv/gwUuo7olFFn1kP93DsGsIdLi1u5kVQdVkMgM6casjNddZ
         EdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831542; x=1794436342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqrMQTautnZWVcHeal8+VHryjxTdMHJnQLEYqFDhRfQ=;
        b=lHcpFJnGFKCBFVoZO8bHY7HWZ1KqMxN9B5jA7bO+ZQBoGEAvmBSD2N3NXW92qRB173
         XRMarsdJzWo98OMqLABiEdvCG6nkXFifKXcsMrP7P3t1GZwebpGRUHSMPGmzVEwKquX4
         WWYfy5CoSgX23qWoqT1UZJMJ5pH9x7KLZ5riEOg6rc2UJ2kxv1LYV4KK1Me7EsO4ukPu
         cKqcEms5rGXSoksfuiKKZPOU3nhKg0WmQWeMiGa0/3cKTVzfsuHo3B1d8NXHiZqBCezS
         rYjgnBcVUrAoGzZojcD0FN74kSZbMvijjLA2TZa4LOJM53tp/5uc/4j1cZRWfj7sULIF
         UDkA==
X-Gm-Message-State: APuU4Z/PB0Jx+t06cr4UiXgyPz1z6FYO1FGxK4HpUP+JUzC3efDQ/w+I
	xyPBKaSngtlIN08KpZhdpE6SzrU2yC/fuxJ2Lx4GIHPUWmYWpMijwlsM6jpPZxxiVA==
X-Gm-Gg: AYBFou1+VSmWKJoOqlvCB0gYSUNDgCcxqulWoBoG8ZBQ3TAmkGVLILIOLI0mCic9n+5
	uEUQBYBdWgBukc16PAlb1KCr9GCmq+8ZAp+BPlMkiQDz6EvSwcZ+MzEPn9KG8AntuhD5lOiC5Uj
	yOVSuii4Pd4j/I1Bk8+UPSjRC8O6RClX44uPohMaeIqz7mdHfQiIhS0oerlu/xkXm57Y3caOxor
	uIGANxafgavulqiAoTer0PK+Ofm0y3xc7L8ZeMF2gx5dFLn73fe6AMZnjJOX0aVHsuyy/pHfpOI
	xF4u65VNYYjeiiq/zZLhWjlWGhZfM+10r4SlPrIYMAZwsxiSgC9wAsXoTB/ONCEluUbM6AYr5yU
	sPacvudgnwWAPSDN1RpBbmna/lwpHq2iU7Yv5McKMcUBo1Ab1L7NDU8XnUUhgA8rJ5o364CI1/f
	K+R27bsjjBM/j9i+cuQVrTZ7ioOncJazn1Tp+f5NS8RH1iGUDiRqTmiJj/0o8kKmEjZCNxdoPQ9
	Zy7r0BUW00nUi4d1tflAxzH81LhK/ysFQ9NP9VZD/uAjN5fmSBzO9/QO3X/qxYMij5JB9pisphW
	QWzKFCNcHoOhwq5BuNJ2lvfKvhLrLXUNNcBP/i7XeI4Ai+UgrJBRvUvGLmUAq2nFvagt9yv5ITR
	VG/K2wUrklA==
X-Received: by 2002:a17:902:f603:b0:2ed:130f:869d with SMTP id d9443c01a7336-2ed130fba9bmr22390155ad.43.1793831541004;
        Wed, 04 Nov 2026 14:32:21 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed090a1475sm11919255ad.41.2026.11.04.14.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:32:20 -0800 (PST)
Date: Wed, 4 Nov 2026 22:32:15 +0000
From: David Matlack <dmatlack@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 08/10] mm/shmem_luo: Allow preserving tmpfs files that
 are still linked
Message-ID: <auuyb7FYBX7xdr5z@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-9-dmatlack@google.com>
 <2vxza4nok0ji.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxza4nok0ji.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_143222_715287_9E8E4E51 
X-CRM114-Status: GOOD (  14.94  )
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

On 2026-11-04 05:45 PM, Pratyush Yadav wrote:
[...]
> > + * Preserving a file requires it to be opened for reading, since the retrieved
> > + * file can be read. It also requires permission to write to the file, since
> > + * preserving it affects all of its users, as described below. But the file
> > + * doesn't need to be opened for writing. For example, a binary that is being
> > + * executed can be preserved through a read-only file descriptor. The owner of
> 
> Why are you talking about preserving binaries being executed? Seems
> oddly specific. I didn't know that was a use case we cared about.

It's the reason the check looks at permission on the inode instead of
requiring an fd opened for writing: a running binary can't be opened for
writing (-ETXTBSY), so requiring a writable fd would make it impossible
to preserve. Preserving binaries is a use case we care about, e.g. to
carry over the binaries of services across a Live Update. I'll keep the
comment shorter and more general in v4.

