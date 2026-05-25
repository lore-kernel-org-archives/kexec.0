Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF916CD5BC0
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hy1vnl/axXCuEJYWaxw1gEfqOcge1HsYtjEucBp1X78=; b=WSMzXNUt79Mkh8DquLNYeDcmrZ
	w7BmHXsFq78OQFBl9COaKRLlzNeYdz3dLOJ4KfCrDViixTa4BFY8RphQxoHuBHjRApEJi7A/+eqM7
	DBc+aUrAT5VA9yP5eblES4YxbUEtv4JSqhWVpCd+R4BRClT0Ys5KzePDqxa9RP0U/vrn81lE8tgxL
	WIuaUNz7Jcmb6s15ig/Hmn3wZp1Slq43LIkA78wRuVVz3lRo3dLcOF2n5obLi5wwuqPSxijBoaJSd
	dn3qIuvFwL5ceQbaS/ztBNSpkIqRQWj2hK9mom7e1tmZ1yXBgK1wP8PATLQrPzax72nprgC8j2/uq
	oLGv+tIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROni-0000000GQ2g-3P4X;
	Mon, 25 May 2026 06:28:34 +0000
Received: from out-188.mta1.migadu.com ([95.215.58.188])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnc-0000000GQ0k-0jJJ
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 06:28:30 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779690504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy1vnl/axXCuEJYWaxw1gEfqOcge1HsYtjEucBp1X78=;
	b=TJY4PHJqDlB3R77odWscnhSPPbwm9H68wWAZvxNyZIAtIklolvIxjfMXKeb+NlAfpqT5dM
	iEXiI1ZDh46GVM25OWf66JkFgGsp7DlsCDcu2btbWbtLcDL2T03HdRgZPj6yOsrPGbZkUp
	sKLcM+2MPj8jAP+t2bhDr7srZO32iPs=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: kernel@xen0n.name,
	graf@amazon.com,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 2/7] LoongArch: kho: strip stale kho_handover= from reused cmdline
Date: Mon, 25 May 2026 14:28:05 +0800
Message-Id: <20260525062810.103367-3-dongtai.guo@linux.dev>
In-Reply-To: <20260525062810.103367-1-dongtai.guo@linux.dev>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_232828_471843_067DCFAC 
X-CRM114-Status: GOOD (  11.86  )
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

From: George Guo <guodongtai@kylinos.cn>

When kexec is invoked with --reuse-cmdline after a liveupdate boot, the
running kernel's command line already contains a kho_handover= parameter
from the previous kexec load.  load_other_segments() prepends a fresh
kho_handover= for the new handover FDT but then appends the original
cmdline verbatim, resulting in two kho_handover= entries:

  kho_handover=0x4000@<new_fdt>,... kho_handover=0x4000@<stale_fdt>,...

early_param() calls early_parse_kho() for each occurrence in order, so
kho_populate() is invoked twice and the second call overwrites the first
with the stale FDT address.  The stale address no longer holds a valid
KHO FDT, causing __kho_radix_walk_tree() to dereference a garbage
pointer and panic early in mm_core_init().

Fix this by adding the new kho_handover= to the cmdline prefix first,
then stripping any stale kho_handover= tokens from the appended original
cmdline portion, so only the freshly generated entry survives.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/kernel/machine_kexec_file.c | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index ddf4d0e0e7fd..ffaedd055e62 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -71,6 +71,37 @@ static void cmdline_add_kho(struct kimage *image, unsigned long *cmdline_tmplen,
 	    image->kho.scratch->bufsz,    (u64)image->kho.scratch->mem);
 	*cmdline_tmplen += n;
 }
+
+/*
+ * Remove all "kho_handover=..." tokens from cmdline.  Needed when
+ * --reuse-cmdline is used: the running kernel's cmdline already carries a
+ * stale kho_handover= from the previous kexec load; without removal the new
+ * kernel sees two entries and kho_populate() ends up using the wrong (stale)
+ * FDT address.
+ */
+static void cmdline_remove_kho(char *cmdline)
+{
+	const char *key = "kho_handover=";
+	size_t key_len = strlen(key);
+	char *p = cmdline;
+
+	while ((p = strstr(p, key)) != NULL) {
+		char *start = p;
+		char *end;
+
+		/* Only match at a token boundary */
+		if (start != cmdline && *(start - 1) != ' ') {
+			p += key_len;
+			continue;
+		}
+		end = start + key_len;
+		while (*end && *end != ' ')
+			end++;
+		while (*end == ' ')
+			end++;
+		memmove(start, end, strlen(end) + 1);
+	}
+}
 #endif
 
 #ifdef CONFIG_CRASH_DUMP
@@ -249,6 +280,10 @@ int load_other_segments(struct kimage *image,
 	}
 
 	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
+#ifdef CONFIG_KEXEC_HANDOVER
+	/* Strip stale kho_handover= that --reuse-cmdline may have carried over */
+	cmdline_remove_kho(modified_cmdline + cmdline_tmplen);
+#endif
 	cmdline = modified_cmdline;
 	image->arch.cmdline_ptr = (unsigned long)cmdline;
 
-- 
2.25.1


