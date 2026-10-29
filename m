Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853F606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=itharZfy;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXksKZnF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dbHLf79sDGkaeTIITFJP1T5z8gpLt867RRVSSnVOQ4c=; b=itharZfyuPMsX+jZATuQZPmnRZ
	fCA7tqvERfAuF/8PLhy0hTfRcaXXHPczU/wodNW/UDxt6erCRBh2FyrGtXaV35rAY47kel8CrvvP2
	jMB/LEZcYbtvUc/mnCoF+VcooaCCMq5UB4ljh3lwI0K+WKzzdVLPZAGTw8G7gsigTwCiWyUOh7NFO
	bsBGrClxkml5+yQwlKVCFGvjN9FLPIlpAVHy12H5iB7pW7sHV0chRdRCv54JUIE0eEFMxYTk7tV/6
	IEdSCLlE+Mf8d77JG/JYkfuhwpRkntoo/OzLQnoxCGUYJ8yiWCgfAxNDtS0aIcZww5Soyy0bbALYT
	oXz4hCJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDi-0000000A0MK-16c0;
	Thu, 29 Oct 2026 17:47:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDf-0000000A0I0-1jgL
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BE5A600DA;
	Thu, 29 Oct 2026 17:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226AC1F01816;
	Thu, 29 Oct 2026 17:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296037;
	bh=dbHLf79sDGkaeTIITFJP1T5z8gpLt867RRVSSnVOQ4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXksKZnFF3c2iQduO00lbZjPrZkwROo96KxxejuFw42ObmoRva517ml7gB6t5Sgyb
	 wJ5rFESDTNgyQszFUJqt+4BTxE6FqXfYlmftEiUtIlVhUEznyDLhYAzepumRQXm8sZ
	 UBYr3hRSK9vZYXlHsZhSY4qDAERXx1BwRaaKQK8RigVyrEtfq7UxswHVMJahmtJSSO
	 n9stvfu8QAZG2Cwl0FmwXyeSRdUoOTXBAA+pHTato+g16uA8VanG7Lr2kSmEf0Qian
	 W6He6BTB2meEy3LNTXvhjPjHmO0FYDBsI3yaVJOiuElZtbZa7acpZgiQj+mgteBFH5
	 hR2YnjyQBLh/g==
Message-ID: <sashiko-outbox-189748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] LoongArch: Allow memblock arrays to resize
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-6-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-6-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:16 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: George Guo <guodongtai@kylinos.cn>
>=20
> LoongArch never calls memblock_allow_resize(), so the reserved region
> array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
> (INIT_MEMBLOCK_REGIONS + NR_CPUS).
>=20
> After kexec, kho_memory_init() reserves every range preserved by KHO.
> Each range that is not adjacent to another one needs its own entry, so
> with enough scattered preserved pages the array overflows and the
> incoming kernel panics:
>=20
>   Kernel panic - not syncing: memblock: cannot resize reserved array
>   Call Trace:
>    memblock_double_array+0x2d4/0x2f8
>    memblock_isolate_range+0x54/0x1a8
> [ ... ]
> preserved data.
>=20
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D5


