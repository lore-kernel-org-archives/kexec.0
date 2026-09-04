Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8E5C624DB
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 03:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7GLPFSnnFeOlonSv4cUL0ZxqzHYNNFqmWiEIZlFftr0=; b=GE2/c7jO5PPlIUtAE9t+jV6GBG
	doTpA+aTWjXqW2iFeEdUvTbUKC0Krgm/RckCXSnd7XGlGOUGj+sGYFsg8Ga9bBa36t7Ex94NFDGyq
	7DH40YMtJcSU37Ow69Sf1s5q5yd5N/FfK38wdvSvo3GGam86p/RsegqlfvpukxNwJAwVJ0JJpiiPH
	yskbtfUYVuTVh3N24X7MGEeecXM/Dy72hERi2jM/iClbneRJZmFGTXy9jyqUX4OARAt/+ZIIVfqD/
	ykRNY70dqstIb6XR4nzDv2gWyZLw8id6v2OqsGqoEMEE09xL6T940n9UafbVmuSYBfpL/nzbFXDn+
	ZZyis6tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2KKm-00000000uJr-0Kwr;
	Fri, 04 Sep 2026 03:11:20 +0000
Received: from out-84.mta0.migadu.com ([2001:41d0:1004:224b::54] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2KKj-00000000uJY-02Ug
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 03:11:18 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=nx/eitTR44C33VFjQT5eDwZTcChTpu7T7AIpTkNv5MY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788491473; v=1; x=1789096273;
 b=tIP0PUq12dU0AdfeuLhKXHPIC7GZk4dQfvotWfPZjBVhXvOw9s3vCeHO6VIEy/icCoYZfTwR
 jvKIXO2+z2Bo2WERgsssEfGAAQc630iIfIsRCEpYLH1X02A0mhaRoiDxZS3UmiStPUSL3gy8sPR
 MphpGHrucCPQMo3EJPke+xHQ=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 946ef5c41bdd8706;
	Fri, 04 Sep 2026 03:11:12 +0000
X-Mizu-Trace-ID: 946ef5c41bdd8706
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	shuah@kernel.org,
	ardb@kernel.org
Cc: guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests/kho: add LoongArch vmtest support
Date: Fri,  4 Sep 2026 11:11:08 +0800
Message-ID: <20260904031108.11986-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807103714.33074-5-dongtai.guo@linux.dev>
References: <20260807103714.33074-5-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_201117_336935_FEE4A467 
X-CRM114-Status: UNSURE (   4.89  )
X-CRM114-Notice: Please train this message.
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

Hi,

While preparing v5, I retested the LoongArch vmtest without the explicit
`kho_scratch=16M,16M,16M` setting. That setting was masking a pre-existing
bug in the generic percentage-based KHO scratch sizing.

The percentage heuristic itself is reasonable, but the old implementation
calculated each per-node baseline after allocating the lowmem and global
scratch areas. Since memblock allocations are marked MEMBLOCK_RSRV_KERN,
those scratch areas were counted as new kernel demand and scaled again.

On the 1 GiB LoongArch guest, the 98.45 MiB reservation baseline and 32 MiB
alignment made the old ordering request 224 MiB of lowmem scratch followed
by 672 MiB for node 0. The node allocation failed and disabled KHO. I sent
a separate generic fix here:

  https://lore.kernel.org/loongarch/20260904025101.9959-1-dongtai.guo@linux.dev

With that fix, the total aligned request is 448 MiB and the LoongArch
vmtest passes using the default percentage-based sizing. I also ran the x86
KHO vmtest with the fix; it passes as well.

Therefore, I will remove `kho_scratch=16M,16M,16M` from loongarch.conf in
v5 so that it tests the default sizing path, matching the existing x86
selftest behavior.

Thanks,
George

