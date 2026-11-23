Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBC606A32D
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PRniekCy;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=XuIqji4G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=OhsoY+g6owXOc1DL4OmeSM9RwI0X3DHSQa1NGA0YGEg=; b=PRniekCyGK55GzrNBE9AMwnxag
	u6p8KcMtldO4BznG0ruDsfY7a1W+fKt1GlbPRGVCqYoz4ZFabghDmue8f9Ioz6yJf90h8g5LvSYtX
	nGM0ijszF7h04hAvBGkSwGOLC0SrLrsSxnJzueKpUhE9ZE6vkiHdV6zwLed6Xafk7kM+O2KgCuqGN
	j77SQ51NEGXI3ibdOOQpZYwlM7B+nXsvEhBMNBJfgdevO3egfEbFuWCgBR4e0x/gY3gosY65065D6
	7i5FKvrq1RvwaMTJcR6QHW+ZRTmGMYBfuj2F0IwdD3EOcLZHnoc23CFhUoBquwSdZgvpPMuudZroU
	zyiCHkxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVaKn-00000004nDd-1Nrs;
	Mon, 23 Nov 2026 20:08:17 +0000
Received: from outgoing2021.csail.mit.edu ([128.30.2.78])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVaKk-00000004nD3-1OzR
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 20:08:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OhsoY+g6owXOc1DL4OmeSM9RwI0X3DHSQa1NGA0YGEg=; t=1795464494; x=1796328494; 
	b=XuIqji4GKfdNSUkH0YsrC6yJOdJssUnoGMaKPJBpwzQ4S7yhNhDGJ/v5sdjZffBdbDUD3HS7AdN
	x5Yt85PtGsl7B9x+4LSNBvOr7VXfC+8Cs+rnDIR+WFdmM+2dk3+V5oQVC8kWJSg/KFZEvS7NBbjzR
	zMftbOsmlDQpRpbJUZqyu3tNGpDbZvSosfr9IyOVlPfbdiNTA+thCAerRMqrEaFtrYmnszQmaQUH/
	cr573lwwtYDbNikv4QIxvO2/7gsu7nkyPvF0si3Y0MYnuucZjSYaH+5oQaDOzaVpmrXiafjsW75da
	ZsCdgbmYWeK9E6kVe7jc+W3i8aAzjyEue9yQ==;
Received: from [49.207.211.146] (helo=[127.0.1.1])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xVaKc-006jgv-OW;
	Mon, 23 Nov 2026 15:08:06 -0500
From: "Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Subject: [PATCH 0/2] MAINTAINERS: Add missing files to KEXEC, KHO and KDUMP
 subsystems
Date: Tue, 24 Nov 2026 01:37:52 +0530
Message-Id: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABidBGsC/x2M0QpAQBAAf0X7bMvdSfgVedhYbHJ0h67k320e5
 mFqmgciB+EIbfZA4Fui7F7F5BkMC/mZUUZ1sIWtjLElTpJw5cQDruO1HbiR+FPhEHFy5OqGqHK
 2AT0cgTX/713/vh8jKNq+bQAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_120814_512011_2DE45B3A 
X-CRM114-Status: UNSURE (   6.26  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Several files relevant to the KEXEC, KHO and KDUMP subsystems are
currently not listed against them in the MAINTAINERS file, which would
cause scripts/get_maintainers.pl to miss recommending these subsystem
maintainers or mailing lists for changes to those files. This series
addresses those gaps.

These patches apply on on top of Mike Rapoport's series:
"arch, kexec: declare kexec and crash capabilities in Kconfig.kexec"

https://lore.kernel.org/kexec/20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org/

---
Srivatsa S. Bhat (Microsoft) (2):
      MAINTAINERS: Add missing files to KEXEC and KHO subsystems
      MAINTAINERS: Add missing files to KDUMP subsystem

 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)
---
base-commit: 3e14cad9ff9ece9c0115ee1d80eef398659db0e9
change-id: 20261124-fix-kexec-kdump-maintainers-f3a389aa6329

Regards,
Srivatsa


