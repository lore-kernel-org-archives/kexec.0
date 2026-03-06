Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EABF0182E
	for <kexec@archiver.kernel.org>; Fri,  6 Mar 2026 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ov55JeCCcCTI9x6RF1+xOgMdlYSvCZuzinIPQ6ZR/W8=; b=R8xLxYGPRvvS9erddYR2Yp5Lqj
	H3fvCuXXG8kVW1jIt1GmVY3h+AHd2UR59+BPGP39g2DuIZ4N8wDloFWLLTVPVSLeFv3BHVcASn2vl
	hHg5q+OvMeOr+Pdkfu0ONc/Gw1LfCM6gDxIOjePjDV+HRYp3SZ4uIukLiNZDmc/kxvy8kKrP4ocDd
	FvZ1eizLhMX314Y0oLuLERBArdJ7daouCfB06D5a19FYUfsngIINwaj/vxlseEMmCS4fgUVPi+G6V
	LmxPkaZvMJzaQKa8COmDFquEbwvTJ4YrM/Osebh8JH0L6ZkYbDxVD+uHQ5m2s15gekzZuQXR9vC6Z
	CJePzi2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUTQ-00000003f7d-1Kon;
	Fri, 06 Mar 2026 12:40:08 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyUTO-00000003f5n-0xdA
	for kexec@lists.infradead.org;
	Fri, 06 Mar 2026 12:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ov55JeCCcCTI9x6RF1+xOgMdlYSvCZuzinIPQ6ZR/W8=; b=n3mdsYCpgoWo4ZadI4IRQMe2s3
	2igiPsHr8bu/s0uHunrTT4u0v2shTOqTNeX7FmzAUeEviKXBwzaRRXkBjScjnFw/gQd93Xm5J1ybI
	d5Q81YdkfiqgYdWDqW2dK+xwddNzEkoFxwlwgVbxZeYUsgZPJPdXwkS612XbG75kUC0WGGIlLwE+D
	A/pmENobybKc/tO68hBIjUuOlHPlgsSqbxdepPtw7f6JT8mqYKKfmPrRYlWuysrogb7DV6jdAJQEZ
	wHPrIZLLLqXYqZDxmzEzqll/Mj86ukQvvk7FtJ3rgNN0Ou3XqnRI64bpXTtnvm3d8VYXu7Akr8OCB
	9p9ylgQw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vyUTM-00HVRn-C6; Fri, 06 Mar 2026 12:40:04 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Mar 2026 04:39:25 -0800
Subject: [PATCH v7 6/6] kho: document kexec-metadata tracking feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-kho-v7-6-404d14c188bb@debian.org>
References: <20260306-kho-v7-0-404d14c188bb@debian.org>
In-Reply-To: <20260306-kho-v7-0-404d14c188bb@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=leitao@debian.org;
 h=from:subject:message-id; bh=QTYE0HCCPpFCLiFL5V/nZqYT03OWnMpDhIbyr7syUIs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpqssGqwKfHdo2QxZJ6I25DRn3JnCg9iml8RDR5
 KBHqXz3mHiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaarLBgAKCRA1o5Of/Hh3
 bWTgD/4jWQiT2UnkeKb9NEgYI+ILjpkrxclkPGXdbg4z8XrpmcS7fzoREezM0yFZd9evwYRH+7T
 kbtvWRxfUeDI4XmFGQ2Ovrai/v50qE5nEHl7L/mfolZM1J+kktRv/zpGBICBb4lcJOYRtdKZhMi
 RDC30ctSlkl3OJLuIbhbNl3MxywiWvMHBXWPX4SAxKSIxkTQCZCOzITHKJltf9jZYZ++2X4+hDO
 x6NYMp0nswM4Oij3+hMgVjvVQ0nygvIPrl1j66yGA47gKa7kOhPigXcScQiEBwv5Y5kNCLztk+v
 Ex3OJd8XGNoFsqDvIKSIWNc2ssVgx/3wwRzLNuFYExoG+8//L9FmhaZJhxE0GOkh1ZvTsBnXpnQ
 44IZ+nnukzcjF4qfZ/LL8aXmGVsj2eYrHLGP6STMYu7yFlU6Nnh5R7d/8yFzqv8fMAaW7Z1fGgv
 xLcqCQNcOeL7YbxGf0g/sxdWGWJzmeP+RaQR1bNmuNFuzeqYqEc/2+J8Hp9doEP0HqY8wddKpkF
 uoiwhKDNMyb8tVIIu7q9LXULlz5kiqGvnokn+XBwEad9oeEVabEL9wiLz5do1tyOiQUzFYslwnf
 CyU7UUMJDyC63h0gbp4sPRARzaQlJMWiBfY1rJyoDPYKI9co06Bk7X2/h0G8o2ArlY6zwbuFt+x
 X+VwYWAubtbstLA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_044006_289697_20591AB0 
X-CRM114-Status: GOOD (  12.84  )
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

Add documentation for the kexec-metadata feature that tracks the
previous kernel version and kexec boot count across kexec reboots.
This helps diagnose bugs that only reproduce when kexecing from
specific kernel versions.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/mm/kho.rst | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index cb9a20f649206..b439e4db152a4 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -42,6 +42,45 @@ For example, if you used ``reserve_mem`` command line parameter to create
 an early memory reservation, the new kernel will have that memory at the
 same physical address as the old kernel.
 
+Kexec Metadata
+==============
+
+KHO automatically tracks metadata about the kexec chain, passing information
+about the previous kernel to the next kernel. This feature helps diagnose
+bugs that only reproduce when kexecing from specific kernel versions.
+
+On each KHO kexec, the kernel logs the previous kernel's version and the
+number of kexec reboots since the last cold boot::
+
+    [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)
+
+The metadata includes:
+
+``previous_release``
+    The kernel version string (from ``uname -r``) of the kernel that
+    initiated the kexec.
+
+``kexec_count``
+    The number of kexec boots since the last cold boot. On cold boot,
+    this counter starts at 0 and increments with each kexec. This helps
+    identify issues that only manifest after multiple consecutive kexec
+    reboots.
+
+Use Cases
+---------
+
+This metadata is particularly useful for debugging kexec transition bugs,
+where a buggy kernel kexecs into a new kernel and the bug manifests only
+in the second kernel. Examples of such bugs include:
+
+- Memory corruption from the previous kernel affecting the new kernel
+- Incorrect hardware state left by the previous kernel
+- Firmware/ACPI state issues that only appear in kexec scenarios
+
+At scale, correlating crashes to the previous kernel version enables
+faster root cause analysis when issues only occur in specific kernel
+transition scenarios.
+
 debugfs Interfaces
 ==================
 

-- 
2.47.3


