Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC9606A802
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4/I8Y5yb;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QQ1qfgqU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9OSvScGRwha8A7Tb2tHR3R5F02sXRmMamVkr8+PRTWs=; b=4/I8Y5yb1E3jSJ
	H+NlT7a6u8dG13wqxNnv3T/Ky+PnGwQeEzeyLNu5jSa2J1QQd/8r1KsTOb4LqI3awfmGLa5CY/5TD
	u8agGaeS2qQEJ+mXHNnrPbVNlEAE52npZiJrrkRkxvnhn1h1bcf5zAzI6gB7rvXA0bGu92NuGrJLi
	CxoZCNTSYUqHmT0kUMSsk3t0s2VOy94viyYeOTnvrngmcptck35pTFjvinBjXY4FN+UAhFMyyNK3s
	AgDEvgW+170k/iNztknwSqKsKjGhH6nqABB4t8HWUxpt07DTJEw0d6vo3O9Em2szW0ZIXuspJxH8z
	p+LctMEgk7UrkLvW581w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBm6-000000020gX-2k4X;
	Tue, 03 Nov 2026 10:29:54 +0000
Received: from out-201.mta0.migadu.com ([2001:41d0:1004:224b::c9] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBm1-000000020cp-1DMO
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 10:29:52 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=9OSvScGRwha8A7Tb2tHR3R5F02sXRmMamVkr8+PRTWs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793701785; v=1; x=1794306585;
 b=QQ1qfgqUbGhGBerxeLuJhyNk7bgr29IpB6mdUWq7I5GBjwVxZyy1/52gPaY/7kXtM0GXHLCx
 4RpcT2uiJ1ar4EFiI4YDe8tiB1L5f3BVfM1Orm01rf7eF0WUMSfamObsQPcMPJ6r1YAuC3tWkmp
 0vu1Vhi7wZbuoThW/OWjzw8w=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 129eb9b76a2afe71;
	Tue, 03 Nov 2026 10:29:45 +0000
X-Mizu-Trace-ID: 129eb9b76a2afe71
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: ardb@kernel.org,
	pratyush@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	chenhuacai@kernel.org,
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
Date: Tue,  3 Nov 2026 19:29:41 +0900
Message-ID: <20261103102941.11087-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2382a0ee-cb6d-4572-be6e-ce3cf4d006e5@app.fastmail.com>
References: <2382a0ee-cb6d-4572-be6e-ce3cf4d006e5@app.fastmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_022949_477685_C4A9F8E9 
X-CRM114-Status: UNSURE (   7.82  )
X-CRM114-Notice: Please train this message.
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ard, Pratyush,

On Thu, Oct 29 2026, Ard Biesheuvel wrote:
> Can we handle this as an arch table then, and handle everything in
> the LoongArch arch code?

Ard, LoongArch is currently the only user, so I understand the suggestion
to keep the handling in the architecture code.

My preference is to keep the table definition and handling common, given
the potential for x86 to use it as Pratyush described in his reply, to
replace setup_data once x86 gains EFI support. The table contains no
LoongArch-specific fields, and only the LoongArch stub installs it. On
systems without the table, the common code does nothing.

Would that be acceptable, or would you prefer to keep the handling in
LoongArch until a second architecture adopts it?

Thanks,
George

