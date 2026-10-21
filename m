Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61803606A31B
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r/lanE6Q;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KyAaAhH/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RoigheuXlEgEVVeOm0wqZxiwY5/DXHnZexKpxuh+vtk=; b=r/lanE6QZF8hyb6GAjSOFcNKDu
	IN+9/pM5uRZVhlJ6uZSfsKljkzxZPeH9VWapmOff83pa2V6xaFK7y9x98rfShx8LLAScOXscDLgaQ
	MsGYmETnbJ0vFNOZxYkYFjTz1uLTT+CEdTXukI3MEaXOMthehj66ij+KvXlZqeBX/b+BPH70TZlNM
	vcynRhfbcipEiGP+TbHURyyOGMOTmD/9vXTfjiKCa8sfSiwzf+NNLkmvVd1DQ3Z7WM9fLikhibUzF
	Hs+d88gMvy7vyq3JWpLrGFDg9/zCvaAnOaz6ns6dM4pQUVXqAdDXHSKYw/qfDrFPJkplycwI+lYij
	iT3eNjGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJPXg-0000000B9fZ-2Iod;
	Wed, 21 Oct 2026 06:11:16 +0000
Received: from out-240.mta1.migadu.com ([2001:41d0:203:375::f0] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJPXe-0000000B9f2-0EXa
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 06:11:15 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=RoigheuXlEgEVVeOm0wqZxiwY5/DXHnZexKpxuh+vtk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792563069; v=1; x=1793167869;
 b=KyAaAhH/eYfv2EtlnJFOXQeqVG+6ADHWw8k6iQd17UIBgcsZIaW1WIf+o+/Q81kvO7aqjckN
 k9gsBbyAi4mn1MRj7Lgh/OA4smyfnFbNsOgKeACNDfbNnJViy7hw/dO6dgnysEK4hYW6c25EUpP
 Ur5IANeC4CF42e1c02Tz/W/U=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 73700c2a578380af;
	Wed, 21 Oct 2026 06:11:08 +0000
X-Mizu-Trace-ID: 73700c2a578380af
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: pratyush@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org,
	ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v5 2/5] liveupdate: synchronize EFI KHO channel at execution
Date: Wed, 21 Oct 2026 14:11:05 +0800
Message-ID: <20261021061105.3697-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2vxz1pal5u64.fsf@kernel.org>
References: <2vxz1pal5u64.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_231114_251629_0749DBF0 
X-CRM114-Status: GOOD (  16.76  )
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pratyush,

You are right about the text, and I am sorry. I used an LLM to help
write this series. I meant to check every commit message and comment
word by word myself before sending, but I made a mistake and sent v5
to the list before doing that check. That is my fault, and it cost you
time trying to read it.

For v6 I am rewriting the messages and checking every line myself before
sending.

On Tue, Sep 22 2026, Pratyush Yadav wrote:
> > The EFI KHO configuration table is a global channel. Updating it while
> > a candidate kexec image is still being loaded can leave the channel
> > pointing at the failed candidate even though the previous image remains
> > installed. Synchronize it instead from the image selected for execution.
>
> Huh? Sorry, I don't understand this is supposed to mean at all. What
> failed candidate?

Rewritten in v6.

> Why are you setting this at kexec time? Why not set it at load time like
> every other architecture?

Other architectures store the KHO addresses in the loaded image itself,
so each image has its own copy.

The EFI table is shared, but the normal and the crash image can both be
loaded, and they need different contents: the normal kernel needs the
KHO addresses, the crash kernel must find the table zeroed. Whatever is
written at load time is wrong for one of them. For example, after
"kexec -l" with KHO and then "kexec -p", a panic boots the crash kernel
with KHO addresses that were meant for the normal kernel.

kernel_kexec() and __crash_kexec() know which image is about to run, so
v6 writes the table there: filled from that image, or zeroed if it has
no KHO state.

> Also what's this "sync channel"? Use simpler words that _actually
> describe_ what they do.

Renamed to kho_update_efi_table() in v6.

> > Use the actual scratch payload size rather than its page-aligned segment
> > size, and propagate update failures before live-update serialization.
> > Keep clearing the channel for cold and crash images best-effort.
>
> Huh? This is word soup and I don't understand what any of this is
> supposed to mean.

Rewritten in v6.

Thanks,
George

