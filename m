Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CB1C982E1
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GnSX7BDD3R3C62GVxOXhW1Ll8Ux6h+dSNtOidsNAaz8=; b=zHlFVLF2D6hvxtSQdj39QsLZcZ
	uqQbwPypup/77/stdZ3KV76Up7JjK2FgbEY7mNK0KQVbA9hCu7q7dlsgaH/8y3/nXfMVph4bLnMqR
	2YJipRMjyy/nWQok7V0oh33YssfL3DXIv4Rlg9vgDKcz7Z1CvLndcGgdS5aFHe9Zy03VAog0rvRwa
	LI4gkcdlepDMWDyaYbXXiis8hBnxPBI7utvF6qF0VE82Xa8yiHI5lthPQxXnn4ypkQJVZIzQrLxUl
	g2I333yZcitxPeCdqjs/hufx7Bo9GAb40Sx9nfHD41yTsIvBhftApCN+yW9OQCUlHpFt6kyzE3h9O
	et6lVcUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8bXD-00000001jnQ-3LYq;
	Mon, 21 Sep 2026 10:46:07 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8bXA-00000001jms-1hJM
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 10:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=GnSX7BDD3R3C62GVxOXhW1Ll8Ux6h+dSNtOidsNAaz8=; b=mYcyu6dDYCrgItiCp3xqx7/kZ0
	RyXIRnMMl4oGyDBjhdx9EzNkDCcFPlaFNvN2/OJmKcVlVme9qM7JDGIfonToacq33tg/Pb0YnZ+ap
	sxANbuUsf6tMT79gQPssXqaQaMb3P+mRLXioYC1y9ycRUZjLyjt1acvyUr33KflM8fXBzNcJE5ZaS
	zdTKVkaTigFv4DPTQFpRub5+cSxSXjPEo0YaSTS/q+9J6zlq4tpw6VnuFVip1YOOMnnRjOTHDs1TT
	+fgaVOC4maGto2Qm5khCHKxtpfGtm6QgZEqyJVVjAXpYjDhOzG4kylcKofrEim6vtykJSvcpGGT5A
	/tMWDO6Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x8bX0-0029FF-1N;
	Mon, 21 Sep 2026 10:45:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Sep 2026 03:45:42 -0700
Subject: [PATCH] vmcore: report the release of the crashed kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
X-B4-Tracking: v=1; b=H4sIANUKsWoC/x3MYQqEIBAG0KsM3++EjBLzKsuyWE01RCa6RRDdP
 egd4F3InIQzHF1IfEiWLcCRLgj97MPESgY4QlVWpmy1Vcuwr/EXk4S/skb7uu1sY3qPghATj3K
 +2+d73w+I2cmPXQAAAA==
X-Change-ID: 20260918-kdump_print-861a49b856ca
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2601; i=leitao@debian.org;
 h=from:subject:message-id; bh=p8yNUkMitpwgzvs+cGgbKwO3+XbwijnQD+AZR0s4TxU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqsQrdNWo2mbPeqC2ctKM0U9OzNzT6UnZB7Ey9u
 HNsJAEFUjmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCarEK3QAKCRA1o5Of/Hh3
 bWnFD/0aDxinGR9m/HMt2DWUe2YmNdnYA4+TFUkLfyH9ek09lNxVLMsGeg01Ybgytzp7hscVcib
 Pabef81sLVvPCWaZCfvfE3lT/ab8LlbbWoaSUXqLx04n6HMQJRVlCKBagz6vi2clrVb++d1BC76
 Q+LFjUu90YlSOgCd8esIRs4WMLC0d5tit7OQ2FrtS/+HNaXnHJzEyr+vpzvjdV6xXk1x7OZZqrR
 No/L9vmFy8qT/EdcDQa+Tipk4Q67UBaME0IDJU/VsP3CPmr2cJgEB32HqVJ891KxRR2aG4Cy2jH
 ZaoYhU9K6jNgqx/xkvgQyIsJ7k32X9jfMAWodyJfYx+Xk/mJi6PcO62qiLRhP9M4p5oGebBONBv
 LiJ7KAVAzoHmrnrYuecoIOl4jpLtvplIEp0EHVghWeFlknU1R9Yb5HeWFsB8VW48TKcOaDkZqgh
 CVIsk2AL39Xy7pYRF7fHn2xAIS9D/48Ej8opUF+5w+WtPfx/pGCiqyy5E6xmdOtgGq9esNaLtj6
 SGAvqzhWmlCuCZQVQbxz0mjyl+FLdcq+1mknTHu1rUW1I/tIr8VBKa5KOpfMc+MdYc6vt1TR7To
 ub5cjYzOTC79K2XukZN7JkFsMsbGvEsVUykxrHSunUv9mDCu8oX1B9hBXYz4hu6rukmNHdFsTou
 XpGGy3SMPhl07cQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_034604_453419_E2803D44 
X-CRM114-Status: GOOD (  15.16  )
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

kdump runs in a very small environment and cut-down set of drivers, and
it can die before the dump lands: it runs out of memory, a device hangs
on reset, or a watchdog fires while the dump is still being written out.
This happens about a single high digit percentage on most of big scale
datacenters.

When that happens the only evidence left is what the capture kernel
printed to the console, and that does not say which kernel crashed.

A fleet typically pins one kdump image and boots it after crashes from
many different production kernels, and it is useful to understand what
are the combination of crashed kernel panic and succesful kdump
collection.

Whether the dump completes at all tends to depend on the kernel that
died: memory pinned, devices in flight, dump size.

The release is already recorded.  crash_save_vmcoreinfo_init() puts
OSRELEASE= in the VMCOREINFO note, and by the time vmcore_init() has run
parse_crash_elf_headers() that note sits in elfnotes_buf.  Walk the notes
for it and print:

  vmcore: dump is from kernel 7.3.0-rc3-next-20260917

Given this is cheap and useful, I think it is worth adding to vmcore, to
improve kdump monitoring.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/proc/vmcore.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 44d15436439fd9..406898247d7af1 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1709,6 +1709,24 @@ static void vmcore_free_device_dumps(void)
 #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
 }
 
+#define VMCOREINFO_OSRELEASE_KEY	"OSRELEASE="
+
+static void __init vmcore_report_crashed_release(void)
+{
+	const char *ver, *eol;
+
+	ver = strnstr(elfnotes_buf, VMCOREINFO_OSRELEASE_KEY, elfnotes_sz);
+	if (!ver)
+		return;
+
+	ver += sizeof(VMCOREINFO_OSRELEASE_KEY) - 1;
+	eol = memchr(ver, '\n', elfnotes_buf + elfnotes_sz - ver);
+	if (!eol)
+		return;
+
+	pr_notice("dump is from kernel %.*s\n", (int)(eol - ver), ver);
+}
+
 /* Init function for vmcore module. */
 static int __init vmcore_init(void)
 {
@@ -1733,6 +1751,8 @@ static int __init vmcore_init(void)
 	elfcorehdr_free(elfcorehdr_addr);
 	elfcorehdr_addr = ELFCORE_ADDR_ERR;
 
+	vmcore_report_crashed_release();
+
 	proc_vmcore = proc_create("vmcore", S_IRUSR, NULL, &vmcore_proc_ops);
 	if (proc_vmcore)
 		proc_vmcore->size = vmcore_size;

---
base-commit: 3f2425f5b5bbbdd991ca9cdfd5502e68d8895998
change-id: 20260918-kdump_print-861a49b856ca

Best regards,
--  
Breno Leitao <leitao@debian.org>


