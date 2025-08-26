Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB56CA0FE9
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ckzOIvZ0fWGCSpnmH5Igqs2rcFJvgg20XUT5RZD/dHM=; b=TEz34UGKHSFWvnr3W8vdxV8W3P
	2LkTtImedwp7VVndmcqMFvBZpVUAucGs7ROUdgqJjGyJq60y/+F1z+MfrV5n0Z4+VjDhCr3tNtS5I
	l9HhvWfN/ZqSOfwB+IYsSpDjW2gTDy6NCC83ClvfSx5ObPazKMdT8mRkfoVfce5n50MlCXb/fXVGG
	Xr0IaqpZ1RhD5Mg2EhWxjhwG1WxrIMh+8An87ns146eDqR4UEm4nQzrstY3VUPkg+9nlRZ4V5F4Fv
	IlJVTflQeTAWa/DRF6m8eSF6bOaEGP5vG+yU/rjgkmiPYClZohuppSkqvf3AOSCBva5oDSkLpR1IF
	zefaKfoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqt0G-0000000ByYt-0fTK;
	Tue, 26 Aug 2025 12:42:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqswQ-0000000BxwB-2xJP
	for kexec@lists.infradead.org;
	Tue, 26 Aug 2025 12:38:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 09E5F4383E;
	Tue, 26 Aug 2025 12:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F13C4CEF1;
	Tue, 26 Aug 2025 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756211901;
	bh=eMENLqxHzQQRExGaCUyCzfHRWShUoYDQAQ6JsPXHglU=;
	h=From:To:Cc:Subject:Date:From;
	b=H0duExL81okpSlnLoxs1EG1AhCa+yp/45AQAWEWwP7Z2oxsc6tdDlyY0XRd/cUfJa
	 Ji51alkHHqhzK+HtwCMwYnCp92/k3M/9XW2NRqE520tCPcw4cn0Z9krYBhxTdNHCBh
	 l6bVATbp/FW5SxW9sO3Qmte/6N2zttf+cKphDOMiw6KpNDbJmSivqK2gy2eShjTPvs
	 Gjkhrx9HzO2jI3/HFUGgFUkYsM/Bs/uiysC2YC1hnyHVAkXLc2O83Y8gtcri8bEMZu
	 +ls7hgta7LSPO3y0spLUHYnEC+ft/XgXV5dYYhHRhxxJ6Al59rDKP0RP86i8busKmm
	 FOr/DLHl24C0A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: make sure kho_scratch argument is fully consumed
Date: Tue, 26 Aug 2025 14:38:16 +0200
Message-ID: <20250826123817.64681-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_053822_761988_083CFD82 
X-CRM114-Status: GOOD (  11.78  )
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

When specifying fixed sized scratch areas, the parser only parses the
three scratch sizes and ignores the rest of the argument. This means the
argument can have any bogus trailing characters.

For example, "kho_scratch=256M,512M,512Mfoobar" results in successful
parsing:

    [    0.000000] KHO: scratch areas: lowmem: 256MiB global: 512MiB pernode: 512MiB

It is generally a good idea to parse arguments as strictly as possible.
In addition, if bogus trailing characters are allowed in the kho_scratch
argument, it is possible that some people might end up using them and
later extensions to the argument format will cause unexpected breakages.

Make sure the argument is fully consumed after all three scratch sizes
are parsed. With this change, the bogus argument
"kho_scratch=256M,512M,512Mfoobar" results in:

    [    0.000000] Malformed early option 'kho_scratch'

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd7..a90d55121a7a0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -446,6 +446,10 @@ static int __init kho_parse_scratch_size(char *p)
 		p = endp;
 	}
 
+	/* The string should be fully consumed by now. */
+	if (*p)
+		return -EINVAL;
+
 	scratch_size_lowmem = sizes[0];
 	scratch_size_global = sizes[1];
 	scratch_size_pernode = sizes[2];
-- 
2.47.3


