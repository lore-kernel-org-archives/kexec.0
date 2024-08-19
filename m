Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FDCC3DA4A
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ZH8BC2Eti+B5K6EaOjYwX2cGwK6sLW6X5UQOHCVwVE=; b=X/zbGzuZc09FLj
	lYSP1yH6tGn8rPfPjuGp6Z+VPR9sWpywYALwTZNh6obgOgSc7W/RfwKQLu+IJ8W9dxKoT3qSn9fU4
	nDrY1s2wceZewq5F4Sw/182pC4mxYzB/9I4nMzh0OtSFGt2M/yevYaYsEtsyBTylg4JZonRfP+Ps6
	4o1WzdAqgq7qCqfq9L45r50M6goFJFnX0BsSNmzP9yXjxdykODwQuPIPQ2akKhAIfJBsqjUuHuMon
	qLzM7i10kCFeoMgzeJ1+03FSAmiXFQIrchgajDOEDdp+YFCUHMuRQNQrip5h0m0EXbfMTAorC0D4x
	/XLthgfP+5z80nwYmPbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3o4-00000001qVg-33AR;
	Mon, 19 Aug 2024 14:56:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3o1-00000001qTS-0eEm
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 14:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuBomQYrL4neI9/UIiUoEKpHGEUfWQV2ECUiNi8myCc=;
	b=YnTErmrrQifwCFhzkdCK79vcXb/0qb3sbQOgHvRkqJahhd8FKFWwpPha4t//y8won6bnEj
	xc6MVAUijBCvPS/toDeH1aQqcoTaqGLbnpjE0+U6ow5d+WSyd+J9/8alkG4we1kIfS9t03
	BPUELJ2Y/1/DBUguAKMHpzYhRpcPS8U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-CWQEnUUsNYCtspDcNI2Rqg-1; Mon,
 19 Aug 2024 10:56:20 -0400
X-MC-Unique: CWQEnUUsNYCtspDcNI2Rqg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DEEC1955D57;
	Mon, 19 Aug 2024 14:56:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A8CE1955F45;
	Mon, 19 Aug 2024 14:56:09 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 9/9] arm64: kexec: Enable kexec_pe_image
Date: Mon, 19 Aug 2024 22:53:42 +0800
Message-ID: <20240819145417.23367-10-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_075625_343776_156D5FE6 
X-CRM114-Status: UNSURE (   9.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Now, anything is ready, enable PE image loading on arm64

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig                     | 4 ++++
 arch/arm64/kernel/machine_kexec_file.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b53..fb6de7b4cd008 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1550,6 +1550,10 @@ config ARCH_SELECTS_KEXEC_FILE
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 
+config ARCH_SELECTS_KEXEC_PEIMAGE
+	def_bool y
+	depends on KEXEC_FILE
+
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 9fca3a35f04d5..c259d871b8e33 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -24,6 +24,9 @@
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 	&kexec_image_ops,
+#ifdef CONFIG_ARCH_SELECTS_KEXEC_PEIMAGE
+	&pe_image_ops,
+#endif
 	NULL
 };
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
