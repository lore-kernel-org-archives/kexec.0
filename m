Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF539606A33A
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QU/ar9Ix;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3imFrBR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IUFbDY3pG95AdUR3ZaQpG0DNzZe45Lp61GslC9VgxTQ=; b=QU/ar9IxNB0TmX8crmliFKAVAe
	WI2ST8FedW/HD26eYmo2E3ZMBlsVA6aBIEjiaY8ozF7tONLu6biQinGonXYgFR0LpAidK4eLxXdZq
	s86spDCFQcbZebriFUX6WBQ3YxwxK90cyv0oB5EOhRVpv3eRJ2cC7GHrGHEN4lRAg3kuH3myqNawg
	gNlBr5F5JIki3Jl1/GOfqYlpWjCIZw7uVLvLrm5Td+1RYnFv64G42lqQBa6s/ODXIKRGsTr2HgxAu
	3pKHg7KHukc6njTfjk/ZrA8EXh2LuwaboxgWLiZcGI6NTOz1/nMv3ErxZbNa3DcXVP+KkJIf0uAQw
	DcdFr/uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxCs-000000094pr-1RZg;
	Thu, 05 Nov 2026 13:08:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOxCr-000000094pe-3MQh;
	Thu, 05 Nov 2026 13:08:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 30492404B5;
	Thu,  5 Nov 2026 13:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD87E1F000C1;
	Thu,  5 Nov 2026 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884121;
	bh=IUFbDY3pG95AdUR3ZaQpG0DNzZe45Lp61GslC9VgxTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z3imFrBRIo9t9Yz/Ltm7Ff8+nHDcN7NYtOjGSxZGcWd897KE8A/Sq4V/CqIvLv871
	 H/suoek4i9utHo9fCiOZgX5jaG/9bkM/yZutRwIroOlp2K38ZKl+oGX6EH9lJE5rb2
	 qyaG6ck7YoNqmzqlqBJJ2EB3YtU1lXrPG6aLcUGtmaBTvTkgZuM4WZuNdNu7GNXoCq
	 lIsMQMLpqj7ajlDCYv9m00MsHmhetq3I0LQH4pQ/fE27QcvxpOU9zJ8JKezGyYKO9t
	 793Cmut5YeoKWxEEZNvI/v6a9jEhC/D5rTokAWBTazmFQuTVVjvv0idbbMPJXJwj1j
	 pUOqQiynQ7iIA==
Date: Thu, 5 Nov 2026 15:08:33 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
	pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	shuah@kernel.org, guoren@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 4/5] selftests: kho: Add riscv support
Message-ID: <aux_0Ye5Ny2GjPB5@kernel.org>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
 <20261103080926.2079-5-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103080926.2079-5-cp0613@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chen,

On Tue, Nov 03, 2026 at 04:09:25PM +0800, Chen Pei wrote:
> Teach the KHO vmtest runner about riscv64: map the target to ARCH
> riscv and describe the QEMU virt machine, the kernel image and its
> console -- a 16550A port probed from the device tree on virt, hence
> the SERIAL_8250{,_CONSOLE} and SERIAL_OF_PLATFORM symbols.  Also
> select CONFIG_SPARSEMEM_MANUAL: the runner requires
> CONFIG_DEFERRED_STRUCT_PAGE_INIT, which depends on SPARSEMEM, while
> riscv falls back to FLATMEM (no ARCH_SPARSEMEM_DEFAULT), so without
> it the test would just be skipped.

We can read the patch, no need to list everything here.
The changelog should focus on "why" rather than "how".
 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
> 
> Test: qemu-system-riscv64 (virt, -cpu max, TCG), in-tree runner
> "tools/testing/selftests/kho/vmtest.sh -t riscv64" (boots the Image
> and kexec'es into the same Image).
> 
>   KHO: found kexec handover data.
>   KHO: exec from: 7.4.0-rc1-next-20261102-00005-gfca49e548231 (count 1)
>   test_kho: KHO restore succeeded
>   ok 1 KHO succeeded
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
>  tools/testing/selftests/kho/riscv.conf | 9 +++++++++
>  tools/testing/selftests/kho/vmtest.sh  | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kho/riscv.conf

-- 
Sincerely yours,
Mike.

