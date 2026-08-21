Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D436C5DF93
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWUgrg2oyif/z+3LRHUgpEMONMbKe31piyu+fjgyTPk=; b=bChTUi6qAJb/cAzWEGdcYcTt0e
	a1zuKlGhWDZTVnHfmCQGLiR21KCjXaDSbzNHwXAykIWef7kwVDnwUAcRnhZkSWpy2HO50TtRKmxNC
	nQn/atYRGBY7k3/7LpEWufxsZkOFXEZSqzVLJxA5hBtrT6hHqHbkpR38pWn6r/4BFPyrTX0NONE/X
	pIO+wxNbmEObPt6z7Dn65ldcsmcTmFh3x6EvsXkIjslpS+8BfyG53NHUH2voLg71dZ88Mb5RMlyiS
	gXdZ+N4zsyxCYQWtPNhoQRvY+pqYHptEY0orYXAPRFvVF4cXlLR6jlDrcn5RyJ9EcUqy1bjUUtsCZ
	N0HM358g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM97-0000000D1S6-25fg;
	Fri, 21 Aug 2026 10:06:45 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxM95-0000000D1OZ-09Mq
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:06:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=TWUgrg2oyif/z+3LRHUgpEMONMbKe31piyu+fjgyTPk=; b=AXjvKfsHRrlUy/85X/g+r0/wvs
	5DG0fiowafk/zPk/acmEyRjV/KlM0elacpnox/ob9oO4uYc9hMcPv65xjjvaFX+BlCwGv4qjSHfgG
	QcKUnWafqX86nz5TtczUQiiYj23FMHpWyQULqnrjQJvyhk4ZWA71Hf4AUds80tndb9SS7qe9gyZTk
	9ItsYoDjdbWfEV4gW4oUlvYJVx5ApWYXPWULFzErttrczEy4ireCV+JE0+nzLA3keuSuw7jGV0Cth
	pMjviVHvQXA4yoh85zKSWLYNr0IFNNaCQW4+x0sc4r8ZEHyNrU4L19EHSL8UT+7Wv1tr7wENCmoaJ
	yfLn94gQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxM93-00BGBj-1G;
	Fri, 21 Aug 2026 10:06:41 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Aug 2026 03:06:04 -0700
Subject: [PATCH v2 4/6] efi/libstub: install the poisoned-memory table from
 the stub
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-hwpoison-kho-v2-4-5743791e48e6@debian.org>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
In-Reply-To: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, rmikey@meta.com, kas@kernel.org, riel@surriel.com, 
 kexec@lists.infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=leitao@debian.org;
 h=from:subject:message-id; bh=C5EuuwpNY5nvk98hyZjVmVyrfx8vi+SqUwzV/WPLKts=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqiCMaDftorVUDCaUHLSwpSUmd8hWjXyWY4oOXI
 ryUjhDKDbGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaogjGgAKCRA1o5Of/Hh3
 bRrvD/9HZjdZmiXO+WacXh65YCVhn2MyGUVpEgcGoMQfmso15ErjMO93KJzMYBcz8nP2MoN3RQT
 ExgpjFq5TgjmMtn6kixUuJeMoNauEYJURdhfoxEFOmtKvceN6vGs8Gv+dMV4ioklRcWhcUBvKd+
 UkLqi1X/Cjy1Iba0aIUSsQhpx6ZH7NEB6JfksmbevOOgarNY50zL/QQr3o6AlhTJyFPeA2L0vkr
 Gr79L6/Q/sJR5gVU+95frI7uXA76JqMFzfm1nue7jylyEVig7bMPuY2i1trHbvLhFtcL4u9sWcU
 M+J6cQy/zzEFdmPZJZHT1zWLAUMOj/oy+hH1Nxbf8HHsG38KOiaTNrU3gJNWrusKEY98hGkHZoX
 0gSH62z9uJiEzmecV6xmgHINCQ2CeVuEtTxZYnKaR/j9UQeO+Rs3sXHT9lbyOgup0buRbfjMpc1
 BXH9RqFXPREaI493li88NNGxGP6LqZpxlG/NNMAWHgGItNzGd0/fPcI13VSt0gbKNIhOAH7MFdb
 d1QpHTrRQ/HS2o0RvLmD9X0unM1Pec1ZjEmctBULGlesSOrMr9eP4rU1miCgL0BjSVYgOulVuyH
 CxRmEjr4iBFnxO0er4olzAwigHnSbbkSlwyLGeUAiF4SK5lDoopcMDHxu/sfrlkQXSlErXTTMLk
 mYILtAkfNfZh8eQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_030643_078462_FF16A443 
X-CRM114-Status: UNSURE (   9.24  )
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

Call install_poisoned_memory_table() while boot services are still up,
so the table exists before the kernel that will flip bits in it runs.

x86 does not go through efi_stub_common(), so the generic stub and the
x86 stub each need the call; on x86 it has to come before exit_boot(),
which is the last point a configuration table can be installed.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/libstub/efi-stub.c | 1 +
 drivers/firmware/efi/libstub/x86-stub.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 42d6073bcd062..008635eb5027a 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -179,6 +179,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
 			 EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP);
 
 	install_memreserve_table();
+	install_poisoned_memory_table();
 
 	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cef32e2c82d8f..f90de11bc8855 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -1023,6 +1023,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	setup_unaccepted_memory();
 
+	install_poisoned_memory_table();
+
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
 		efi_err("exit_boot() failed!\n");

-- 
2.53.0-Meta


