Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DAEC77B7A
	for <kexec@archiver.kernel.org>; Thu, 25 May 2023 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wXRq7SenVjD5MPCeeutBqUq0/F0rlwQ1jNP/IlPFXP8=; b=EzyAAvCeQlfOt7
	1pmUpXOch7v+KJGrRNiyjaC9s8TPNQvqEtnyFgm9xT+LNQ3G90ySHNKrKWxR5wiBzBqDFEVZ70sqE
	ugaNMyc/6IUp7njWl2symlPqPtFr80pQewNJKQVOyKe/bLDKyqmWDf+TCAdYA5fUM3rpCzqT4/5w5
	tm6+PV06SWNSKEq3r0Rviq910pfgJOaCan6zoSLZjXWZvbYEP272+h2y/sJPbLxct4DlwM7v0Yja8
	/19Eup6K9LuIAYiCK9lIwd1BCamJGuCKtSAAURYz7v3Bu7rLspGxVfBV6j7VcwHosnbIZqd6EawfU
	B/BHepXrbdTfXBhETjeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2BvH-00Gq1J-0K;
	Thu, 25 May 2023 14:26:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2BvD-00Gq0i-2q
	for kexec@lists.infradead.org;
	Thu, 25 May 2023 14:26:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 259916462C;
	Thu, 25 May 2023 14:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB6FC433EF;
	Thu, 25 May 2023 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685024790;
	bh=JwGEFsVAytpbnNTBcy9sEez5APaywOmU9QISh6P6Aw4=;
	h=From:Date:Subject:To:Cc:From;
	b=SSYfx3l/xw++zk8yHiFZKMnV7NCo0yZ0o6m+PMrdb4g+bxcEF2Xb8II2nZB5HwnlE
	 //N4HEtbd2P90fo6T89Ow23UxAy6hnJWoubiLOsoX6IfBK3FQsxoS5jqm/vEakQj8D
	 ucHrj3f8a0AY6755FV6ZY9Unf/tjsJx5xaKlwPlTYfKUDoroiT3U1Hrnnxk7JRNOwf
	 Fh2rJZgfLXN7pJYOhJaEn3Lt3br5bnBpWxzy/sk2oTJvLzl6LKIZ7IiXuJWsOossA5
	 9WTt7Dkty72DAJPBa0tjU9X3zb87r97sDdEaqv9IltfqOXJmryr5vVcO4PdZCr/Qle
	 ybqFL8jhtWflg==
From: Simon Horman <horms@kernel.org>
Date: Thu, 25 May 2023 16:26:25 +0200
Subject: [PATCH] kexec: Avoid calculating array size twice
MIME-Version: 1.0
Message-Id: <20230525-kexec-array_size-v1-1-8b4bf4f7500a@kernel.org>
X-B4-Tracking: v=1; b=H4sIABBwb2QC/x2N0QrCMAwAf2Xk2UCtrQ/+ioikXeaCo0qCMjf27
 ws+3sFxKxirsMGlW0H5Kyav5nA8dFBHag9G6Z0hhngKOWZ88swVSZV+d5OFsT/nGiilkmgAzwo
 ZY1FqdfSwfabJ5Vt5kPn/ud62bQcbFtZsdwAAAA==
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_072632_150425_E3BE3A67 
X-CRM114-Status: GOOD (  11.15  )
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

Avoid calculating array size twice in kexec_purgatory_setup_sechdrs().
Once using array_size(), and once open-coded.

Flagged by Coccinelle:

  .../kexec_file.c:881:8-25: WARNING: array_size is already used (line 877) to compute the same size

No functional change intended.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 kernel/kexec_file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..3f5677679744 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -867,6 +867,7 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 {
 	unsigned long bss_addr;
 	unsigned long offset;
+	size_t sechdrs_size;
 	Elf_Shdr *sechdrs;
 	int i;
 
@@ -874,11 +875,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	 * The section headers in kexec_purgatory are read-only. In order to
 	 * have them modifiable make a temporary copy.
 	 */
-	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
+	sechdrs_size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
+	sechdrs = vzalloc(sechdrs_size);
 	if (!sechdrs)
 		return -ENOMEM;
-	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
-	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, sechdrs_size);
 	pi->sechdrs = sechdrs;
 
 	offset = 0;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
