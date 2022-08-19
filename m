Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66A5C32771
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/rgSIFn3dRykzqGcE2n47MB3yjrQ5K4jr5tCJHWh1AA=; b=XnNWHyo8hsfAra
	JkrvAPSISzk5k3ywLneLwM40DlimmG/7uJA2879E3O91fTldXHzOtIY41KrXbT1zptUSjeop1Syuq
	VaEyickG5hKMETx1jTghUNvMXbQMlVWaEg/92QSzdiEIaYGkHUosKZfvIDb3xdyMY8oWT0wS5rVHt
	TxmapGaNuTnixCNrvEgKiHAmEdnzuU5P9r9vRkjYLqPsYhWA+hwuGIuzUNCKDttFeZGjOryS9Z3+R
	x1G9wIPEDa1YHKq30pvUE5ON2ABA2g6d/lJ6l2Z+xv3clPVbrh1mdWY6FIOaTjfxusUUSaYm1YZCR
	yzM9t7hZZ1pLSdW9tA6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP46z-00A0Ii-K0; Fri, 19 Aug 2022 15:40:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP46x-00A0H4-Ou
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 15:40:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 49C30615ED;
	Fri, 19 Aug 2022 15:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4B0C433D6;
	Fri, 19 Aug 2022 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1660923638;
	bh=q01TiepYCgbd3YDF3Teq86Su7fa1NExU5eO/8Pw2Xpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inDF4Cwoo7ABxjN+YhYvvw4ANZWmqd2vqAXHKruCZ9hMbOoG3d77t1Mx8bjNe8XkG
	 FGRGlLeINtiwKZMyhh3G0GbKQ75ICa5lZMHvNHWuRr/rbKsOlp65YF9q9JuGFOs06x
	 AFg0PtkbzT9bVA2bv/QBJyymTc1V1Yu3SNfD/n7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Michal Suchanek <msuchanek@suse.de>,
	Will Deacon <will@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.18 6/6] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date: Fri, 19 Aug 2022 17:40:18 +0200
Message-Id: <20220819153710.669386636@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153710.430046927@linuxfoundation.org>
References: <20220819153710.430046927@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_084039_888955_AA68C74B 
X-CRM114-Status: GOOD (  13.95  )
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

From: Coiby Xu <coxu@redhat.com>

commit 0d519cadf75184a24313568e7f489a7fc9b1be3b upstream.

Currently, when loading a kernel image via the kexec_file_load() system
call, arm64 can only use the .builtin_trusted_keys keyring to verify
a signature whereas x86 can use three more keyrings i.e.
.secondary_trusted_keys, .machine and .platform keyrings. For example,
one resulting problem is kexec'ing a kernel image  would be rejected
with the error "Lockdown: kexec: kexec of unsigned images is restricted;
see man kernel_lockdown.7".

This patch set enables arm64 to make use of the same keyrings as x86 to
verify the signature kexec'ed kernel image.

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
Cc: stable@vger.kernel.org # 105e10e2cf1c: kexec_file: drop weak attribute from functions
Cc: stable@vger.kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
Cc: stable@vger.kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
Acked-by: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/kexec_image.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -130,18 +129,10 @@ static void *image_load(struct kimage *i
 	return NULL;
 }
 
-#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-static int image_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
-}
-#endif
-
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-	.verify_sig = image_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
