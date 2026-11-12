Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6C606A332
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ng6Kk68b;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=C1IMuzwN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=E1g/koE1ml+lLoV0N9qQIwCAVIBPrzzGP9OirE67XgQ=; b=Ng6Kk68bJCj9AEt90qHYAL85mx
	0kGtQ6FWQgOdwhehXzi8Uy2yNLLL5Ojep14JicpA/m5fPCJHs7pOnF/b4YySRac5y04PJm+GHZ4KG
	vM3UaPcJJWaG35xflG/06Ms3nH1xVi+H1RxhWHYGVAlUDcfuVepKvbc8U2jvyHaMaJpQPmQ9tUZt0
	I6qtVDgE1JKA1iLzG9MMHECpx2RfyaXgeQIv5U0S6mOALxDDJxuOQBH2La4UGZPNjA8ODxScgDYHL
	V9AaOFtJJolcLsRGjfuYTHvhkkTe75BnA46L31dpt9lL3kW/dyqNBByGHiDVAvSWXTBpq6UjiW/lh
	L0RmSlKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJI-00000009w1x-2MVD;
	Thu, 12 Nov 2026 12:53:48 +0000
Received: from oss.cyber.gouv.fr ([51.159.188.251])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRUJF-00000009vul-3onG
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 12:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=E1g/koE1ml+lLoV0N9qQIwCAVIBPrzzGP9OirE67XgQ=; b=C1IMuzwNMw3boErsCqy6m26VMd
	XE7shx8hcHXbONV3VTHr2Mf61XDWfRzkk8g46vvMuSIOJgnf2Dr3oSUW8tUSqSJLKLB7Dfke1gYiF
	lt4NlKj6L6ljuw1wboh3LhXDBpsWhn+mKPq+nAyBUho7hEskAfTEY99uCNpuzHCkUzt0N+giCC7dT
	uMV8VxFT6TsttY7SyOnMEpzBK+y/PXjzpIIE3hhrhXdI98lseHpgJp3XEGEekKNJGukmG1bdECW3m
	3HD1cOtEljIpBWrccEAZeqpojB4wpRNbHJbUl3HB12IsiIpKGuI65PaNhuoDTHhuT39iZ1BfVU5p+
	tWgYHfCg==;
Received: from [151.115.150.205] (port=38878 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRUIZ-00000003H1G-09c5;
	Thu, 12 Nov 2026 13:53:01 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 0/3] ima: keep kexec dump state tied to installed image
Date: Thu, 12 Nov 2026 12:52:44 +0000
Message-ID: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_045346_114138_95069D83 
X-CRM114-Status: UNSURE (   3.49  )
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
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kexec_file_load() can change the global IMA buffer size or destination
mapping before the new image is installed. If the load fails, the old
image remains installed with this mismatched state. Unload and legacy
replacement can also free pages without clearing the mapping. The later
measurement copy can then overwrite the installed image or freed pages.

In this v2:
* Patch 1/3 updates IMA only after the machine post-load hook succeeds.
* Patch 2/3 keeps the dump size tied to the installed image.
* Patch 3/3 checks mapping ownership and clear stale state on unload or legacy
  replacement.

Jérémy Jean (3):
  kexec_file: update IMA after machine post-load
  ima: keep kexec dump state tied to installed image
  ima: clear kexec state when replacing file image

 include/linux/ima.h                |  1 +
 kernel/kexec.c                     | 11 ++++
 kernel/kexec_file.c                | 15 ++++-
 security/integrity/ima/ima_kexec.c | 98 +++++++++++++++++++-----------
 4 files changed, 88 insertions(+), 37 deletions(-)

