Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B699606A320
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bsP0z2H0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRmupP+O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P3gyj12NGt5BrOAVOnJOGDgKEsVMdz42lpXGv/yZrc4=; b=bsP0z2H0ajODu/TvkKleMTYR3n
	qB3ZP9hEZ0csqRIvNo6ZiVLggdI9BCFky4KdsACD5ws8hqMGDM0xHEkJhz7IE6jy89WilJDIQxKya
	CNCXgzwJELAzHZUKaWuFr2rHanBhjsFNWKced9UgjjlhRa3J7CNFxAkqN9ad8eyayEIYH19JcVy7/
	Ci6gEvyBfmzNPaKmLs2UjQGUamhG9CvH9z24AbDzGUbxHZQZawmb9uGHgd/8yjh5yDdBe7uuXhJiZ
	9x8yEES427xgHaH/PfwxWtWYiWjAjaICcMOexMZkUs2Eoc5qDJTAJML3TgnlAomn3sain3J5wxCgD
	ouCmfI6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNDd-0000000EsXP-06Hm;
	Fri, 20 Nov 2026 11:55:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNDb-0000000EsXF-3SmC
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 11:55:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3317E40467;
	Fri, 20 Nov 2026 11:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF9F1F000C4;
	Fri, 20 Nov 2026 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795175750;
	bh=P3gyj12NGt5BrOAVOnJOGDgKEsVMdz42lpXGv/yZrc4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XRmupP+OLijrmAtsyFzXXifwkuMS8W6gNVR4LOQJPmUXO7GcnqLiZxj7w2peSSlsu
	 QMq1FxF6ebx+N5vGd+gPCfWv/hQdtBeT2ynxnVrf00EB2x6ercEW9SIcOTFr6/Gg+0
	 +0VZoq0mBHSiGpSUMlOovIy33ZXnen4fS+2fARU6pJbnmbFK3EAr2ic61lpeGjOwQf
	 iFH9PTAknNIhVdp95GGo75mLA233YHUQfa4N6a6X+dOkSuSfPvhInvrsgbZRJm5kOG
	 X4YITabmy70LoUjGg+Mx9siucKp0Y9fW03PE1MjQGJywW/z58DOrX5l+Ovs5sBRMsQ
	 9qqDxMCNtyI/Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v4 09/19] mm/shmem_luo: Leave freeing the preserved
 state to finish()
In-Reply-To: <20261111002358.1842967-10-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:47 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-10-dmatlack@google.com>
Date: Fri, 20 Nov 2026 11:55:44 +0000
Message-ID: <2vxz33sv3ef3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11 2026, David Matlack wrote:

> Don't free the serialized state in shmem_luo_retrieve(), whether the
> retrieve succeeds or fails, and let finish() free whatever is left of
> the preserved state of every file. Once retrieve() has restored the
> folios, it sets nr_folios in the serialized state to 0, so that
> finish() only frees the rest.
>
> This fixes leaking the preserved folios when the retrieve fails before
> it restores them, e.g. because the file has seals that this kernel
> doesn't support, or because memfd_alloc_file() fails. The retrieve freed
> the serialized state but not the folios, and finish() then skipped the
> file because its retrieve had failed, so the folios were never freed.
>
> Preserved folios may also be in use until the session is finished, e.g.
> by a device that was preserved with DMA mappings of them, so they must
> not be freed before finish().
>
> Fixes: f85b1c6af5bc ("liveupdate: luo_file: remember retrieve() status")
> Signed-off-by: David Matlack <dmatlack@google.com>

I think some of this is already fixed by [0]. It holds the folios until
finish, but only in the success case. On failure to parse seals for
example, it leaks them. Except, as Sashiko also points out, in
memfd_luo_retrieve_folios() the folios are freed.

I don't think this is strictly related to your series so can you please
send something on top of [0] to fix these bugs, and perhaps drop this
patch?

[0] https://lore.kernel.org/kexec/20261110175855.2437084-3-pratyush@kernel.org/

[...]

-- 
Regards,
Pratyush Yadav

