Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A908606A320
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e5mw9SOu;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TLtOz3/V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9xtLTQESNoyZANIpHgUGyLeoukqSPARphk8aXo+VHwE=; b=e5mw9SOuoezl6T
	7BOuyZCtRijEsBpcy5aCw1MtxStv3ZHylSglQ8X6g0nfPdnHBLxoCX4PTJWoMnQIe+9nbKI5AzqRn
	obBUDBmr4mNPyUXM/jQ32wItDJisrc5i57EAl2hi+KRpHGFKjET8MK2N88lHJ06zoLcVB6klzSTtK
	mKBF7uQyJF60g2Ay5uCCuX0LONZNU/SgzPXt8kc57xkBAC9g48gGEYWQfNfaQhdGKma8D6Jve6bxS
	5u3iQsLE2LwREkzCye+rUm0xlkwRwfP68/7Aj4nRIbBUOui2wl2cFEhzCJqkK06NUP+X/b8KKmD+m
	p7/04afAj1QbgkT8K0Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTxQ9-0000000BAeP-3zf2;
	Thu, 19 Nov 2026 08:23:05 +0000
Received: from out-31.mta1.migadu.com ([95.215.58.31] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTxQ6-0000000BAe1-3y3i
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 08:23:04 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=v7j+so0A9nPKyNFG/7i7Z4Ia8f3AlnUzgV4OZVQCLNk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795076577; v=1; x=1795681377;
 b=TLtOz3/Vwuj2oRnKgQShgwM2JXmHAm/33S/i82MEq1IycE+UakLvzLvRpgvUdIVIZ0BHoC8l
 Akr2G97MGgshl1tAB1+QvcUIremLvLiFkC4ETGpEHGZ+DwWlMmW7F3ywhbnde1jS4mbSipLh4lc
 vXrUVH6O539xox5E6fdKLvsI=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 09da8324dc43e42a;
	Thu, 19 Nov 2026 08:22:57 +0000
X-Mizu-Trace-ID: 09da8324dc43e42a
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	ardb@kernel.org,
	pratyush@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	shuah@kernel.org,
	ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 1/8] efi: Pass KHO state to the next kernel in a configuration table
Date: Thu, 19 Nov 2026 17:22:52 +0900
Message-ID: <20261119082252.9120-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAAhV-H5Vse=pKC3Beqhqxa7fqadiGVNqkSy_06HZ3Luw2Pmj5Q@mail.gmail.com>
References: <CAAhV-H5Vse=pKC3Beqhqxa7fqadiGVNqkSy_06HZ3Luw2Pmj5Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_002303_213152_8DD24869 
X-CRM114-Status: GOOD (  13.60  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Huacai, Ard, Pratyush,

On Wed, Nov 04 2026, Huacai Chen wrote:
> I prefer to keep it in LoongArch until a second architecture, and I
> think Ard is the same. But this is not a strong objection to Pratyush.

Kexin Liu and I have tried x86 as the second user, to see whether the
common table holds up. It needed only small changes:

- The x86 EFI stub installs the table, as the LoongArch stub does.
  install_kho_table() moves from efi-stub.c to efi-stub-helper.c so
  that the x86 stub can call it.

- kexec_file_load() skips the SETUP_KEXEC_KHO record when the table
  exists and the next kernel will get efi_info. Otherwise, for example
  on a legacy BIOS boot or with noefi, it falls back to setup_data.

- When there is no SETUP_KEXEC_KHO record, the decompressor's KASLR
  code looks up the KHO bootmem areas in the table, so the kernel is
  not decompressed onto preserved memory.

The table layout did not change. The only change to the common code is
that efi_kho_table_found() is no longer __init, since x86 calls it at
kexec load time.

Tested in QEMU on x86_64. With OVMF, the KHO vmtest and
luo_kexec_simple pass, and the second kernel finds the KHO state
through the table. With SeaBIOS, the KHO vmtest passes through
setup_data.

So I would like to keep the table common in v7. Would you prefer the
x86 patches in the same series, so that the generic code comes with a
second user, or as a separate series on top?

Pratyush, does this match what you had in mind for x86?

Thanks,
George

