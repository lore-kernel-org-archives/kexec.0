Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989D8C98315
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 03:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5hLVLj6T9HR767S/+F3jf5pcqfuxp717t4Xo0QfiSrs=; b=YePEvziJ7LD/NH8Q7VZZXtXHOa
	HAblo0QWbzedXiD+Gq8oxCbgRcG5ENt9TSVaNBpBPPBiqCFKS6sADgOwsrjE21VO/RxmChUV7RYez
	kMDjkmNKSc3C4zTOWKvx8RORjIMoqZ7ZZHSFwJBYa0cOXO2O13/KzmxMtiYf+cDWgof7gs3mHBecZ
	Fn6LQL8gXvS6OCs4ntssC55bHFY6xUK6BGVv7f1J99mpSo/IrNTeQrrbd3CnzCoOQzpy4MW2gwyNR
	e1DHwBdB1s9VoopfOODJLI+rhi7BfcyHrmzleKNjlxI6zevQuID9dR+lO0bpDRRIUblUqCd3EFTwI
	oIBYT8YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhfvS-00000001JpC-02WK;
	Mon, 19 Jan 2026 03:27:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhfvP-00000001JoD-19Ld
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 03:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768793250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hLVLj6T9HR767S/+F3jf5pcqfuxp717t4Xo0QfiSrs=;
	b=XBrufhKOWfhNasNZ+I1BmOo0TfLXZUMzpvtMiHKKaONe2OnZ3GhiKkMc2De5k0t5w9ht/4
	dp77tOiHpINoQkgiossTlJRc0fxCP/2WuSBuritdBHGw2S3gYt4Bg/lt8UI+AfCQSEPTCg
	8Kk+NwCGQZbEqrhbsLPbWr6MLx5oR7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-Yo2Jk1SZMJS_uj0K0yS76w-1; Sun,
 18 Jan 2026 22:27:27 -0500
X-MC-Unique: Yo2Jk1SZMJS_uj0K0yS76w-1
X-Mimecast-MFC-AGG-ID: Yo2Jk1SZMJS_uj0K0yS76w_1768793245
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF9BE18005A7;
	Mon, 19 Jan 2026 03:27:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B33B71955F22;
	Mon, 19 Jan 2026 03:27:13 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv6 11/13] arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
Date: Mon, 19 Jan 2026 11:24:22 +0800
Message-ID: <20260119032424.10781-12-piliu@redhat.com>
In-Reply-To: <20260119032424.10781-1-piliu@redhat.com>
References: <20260119032424.10781-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_192731_388589_E0757212 
X-CRM114-Status: UNSURE (   9.79  )
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

Now everything is ready for kexec PE image parser. Select it on arm64
for zboot and UKI image support.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0a09c7d..922d58abbbd67 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1587,6 +1587,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
+	select KEXEC_BPF if DEBUG_INFO_BTF && BPF_SYSCALL
 
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
-- 
2.49.0


