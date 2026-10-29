Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BE606A31C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vi0iadDv;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=EqO0VQxg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UtW/sYsNMYd14q833jtnLcBy0iGbA94LyKtY63+yQks=; b=vi0iadDv7cKU+8wLiGpbuLRE6i
	FMtswh2Qr0UIMLCnz8ckTmY4j/iBA5XQr7I1yYVUdXTiuVgLSuVOma4VdVfNeqFvtIQG9xOYwG0yB
	ni44sNey9f66ssXzKt7NM1EYUQy+Ug1GZDWeV644ic6aX1fATjju3jpFxuc0ke593sgPqZz2vJWTO
	e2F9o+YRZIKIQZW+v0tZ4bJ4bz9EOB1dHFpetES5lqEjJAgqhB7JJTOufTx9Uim43LR7KgysLUzuB
	V4I+JdXBtxGrtnfIBFmXvPhWW+0ZrTjd5/LvNySpS4QCcJjXa2GqzDVqvdit4+cIVHCqPqNnj1fbn
	zOjwqq9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMDap-0000000850Q-2jLC;
	Thu, 29 Oct 2026 00:02:07 +0000
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMDam-00000008503-12sg
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 00:02:05 +0000
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-5eac01ff101so571664e0c.2
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793232122; x=1793836922; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UtW/sYsNMYd14q833jtnLcBy0iGbA94LyKtY63+yQks=;
        b=EqO0VQxgA9bL88cuK2q3lObRUQK0siRthzl54llk1oQ1hoPfQVqF+RAcs1opzYlMVV
         MXP0XBR9rBKTvBz7wjaob+i1R1tb6b5Dpc3UCT52+eOXnqABcrQKbKNdsTxFUHmQIt4A
         O636nUR4/j6zlsEy9wLFjmzvN8sFTAbb42xRQOJG7snED2FeQ1RQXcFQS7qan57efrvo
         PDk+7/oWr+wGPVOmAkh3+fFM8uBao01TWrskpZy0Id/u06voHOzFZ4aHZ9n3zd/11Pbo
         5zjQHFgo4yW9RiVy5AhMkUG4VIklIXp+kuEAO5n4JuDZHz71kni2DSKJJX20oYQcyI5e
         aUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793232122; x=1793836922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtW/sYsNMYd14q833jtnLcBy0iGbA94LyKtY63+yQks=;
        b=jVcY6zvzLD2w4929jE1WEtjwLCnem85p0eEgV4ejhW1LF4lChafAc9Z6poYezn8ASV
         GDQl2R2ZuZvhvpButKkfOH+1GAq0dsGQjE5+Ogb4bk60qGsf46FRhXmnMfCGEOV5YWv+
         sCIutx6cqfox1o+x7depYqbggwGiYbOFxNKQCt7Hyslbmi6sQ6Cy2x3iwZgMI9Xxurb6
         9JFcpRjsJfz0xueSVPmDrpUVfQu1/iGF1jplbcdtXc31lBUNeIR5FFr0Ux+WdS3POm2x
         fl9jdbYZd6rVU3dJKB/EihTTSs81p5PEuSnZeiZ0vVSowHB4MVJ+8KJIO4ItYL35QMLr
         u4Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxcTu7xL6EihSsdR/gusJqLDr5331bxGg+V6p0ZozDq3HsDsmDWi8VvJA5mA5oblIbcbLbeWw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJaRn01jwo0nQ4d5vn/2/VkIF/3VnZ/t156e30BLYojonTs7pwV
	m7ph08ZT6L90rHMSauKZ1E0mF2q789YdQBAZo2glVn5E7GwoV2R/NoEnOFC/MGMG0mU=
X-Gm-Gg: AYBFou1Eq/YTGgfGBu1TrsqZ1IspGMsZ4O9Yk0wU0l+6HpZUrTkUfyTSvfiVmExexok
	zTr0eo8ZLCxAMMwYJxQW3oR8wlT34GdfseAQZm4wKs4qfuS1b5NyHDO+E3Pv00l24xdMYXzJ5hQ
	rRbP1BdE+0+KPVMXl96Px2VAs2OXGQQR98uyiLVRhSfUYYaX7qMljfk0F7ftQFhTUf1wBuiAk42
	OY9hnZY/wcMEogIeFsrSNW1K1p3Ro9h9RGIWDDVXP1sX41XxE7YICakLfm+Nrg7RF2VHDD11F0Y
	3RNghlYAe3A0k4kEPOm390CqGzz/BFfgHTwIsi7LLgzLHXccC42GkXjF4T29+Q2x00L5B7HxhYI
	EYfH2s8q4w6jws7O8UTeDlkKSEThN7HFUOlb02Yq+tXULJHzdUOFl2VPMYhv07NbIaROyI3niXo
	8HOQOE5SrdSzkdEVMt7FDG689Jci0BthBirLEH/IGS2OwzuTUtmCMAewSa27hSGZVqqelQREO/z
	RC6Dj00stcM1RCZ0ECF4+Wk7RCyWzTvgQKrfcvWqCr2DFGSSQ5GKptNzLr5zrbe0WCMjwOmqSrB
	aDbujIw1EoCe8hd0apDNmbzG2C+bS1PnQjHQlYhh/c2/to4D/HIXJVxNFjYi11n6agqRmeoK0fD
	h0t2xxxx9fpAeXVqeiYodA7o8LbmjYxad
X-Received: by 2002:a05:6122:1c03:b0:5ea:d14a:ef8f with SMTP id 71dfb90a1353d-5ec4cc14f21mr1861192e0c.4.1793232122251;
        Wed, 28 Oct 2026 17:02:02 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f931911sm3523257e0c.10.2026.10.28.17.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:02:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:01:59 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [PATCH 1/3] mm/memfd_luo: don't use memfd_pin_folios()
Message-ID: <auKJXHWnNMzju7cv@google.com>
References: <20261027173031.763213-1-pratyush@kernel.org>
 <20261027173031.763213-2-pratyush@kernel.org>
 <179321872100.1775665.6881420026761127422.b4-review@b4>
 <2vxz4ie5o2ak.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz4ie5o2ak.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_170204_307927_201E0BD9 
X-CRM114-Status: GOOD (  16.78  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-29 00:04, Pratyush Yadav wrote:
> > Nit:
> >
> > I would suggest adding another helper, memfd_luo_get_folio(inode, index, 
> > &folio), that wraps:
> >
> > - shmem_get_folio()
> > - The !folio_is_longterm_pinnable() migration retry loop logic
> >
> > I think this would make the final code a bit more manageable.
> 
> Sounds good, will do.
> 
> >
> > Other than that the patch looks alright, feel free to add
> > Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Once the nit is addressed.
> 
> Thanks!
> 
> I think the MM side might take some time to gather reviews so I will
> send this out as part of a liveupdate-only series. This patch is useful
> on its own anyway.

Sounds good. Could you also consider adding a patch to that live 
update-only series to extend the memfd freeze from retrieve to finish()? 
That would close another gap that does not affect us yet, but will once 
other session fds depend on the memfd mapping.

See:
https://lore.kernel.org/r/20261022225035.377445-8-dmatlack@google.com

-- 
Pasha

