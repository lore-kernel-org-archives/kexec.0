Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9A9F46453
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BIYteLscNbuJ8M2TNSr6zCYdcchlP9A8lbucS9J/eKM=; b=tyxurHtULnnIapJc55JDOMPER0
	HD5WmvPKj1vHt6Kf/0Gennw3f5bWuIymoEYZMYTuquyK9faNCcriENQmr3gEQyFSxJetUTmkG0USY
	/waDZNTYfehn7JKhglLgMQtBjJTF9MYgjmi0hfNORMXtbGfiD6L9607qr7o+biZ3ekvjqWH2S2vCd
	NBdLob5l8oFCoRDUQydUafR9quYgfzrWGrBQAKBe47pVlgMQZiR2D3zkvXNZCF6C+iE3Q1rWMR+21
	ayN5L92N6ooj35Kw5rYtrq55NDpxVgZKzJdhPPVhvhoo3PNuvRHuPQpQkNli02b3Mtli7mURm6Ay1
	QzboUkaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26Yo-00000003s75-3OSQ;
	Mon, 16 Mar 2026 11:56:38 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w26Ym-00000003s4n-2QNu
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 11:56:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=BIYteLscNbuJ8M2TNSr6zCYdcchlP9A8lbucS9J/eKM=; b=dDQO5U45OCJInWUfMljGpNPgtG
	RwOlhLLZ/NVovVcj0BZxiSxD3u++sO4Yk0hEPH9w78eUOSub5y59p3743N7mO61WsJNaiWMt1XLCm
	51I0YretIcEO314uOiH1306FlRQxx25idisr0wDsQi4B3zLwmNNN6SvJWiw6joUTXDvsiUEr7ez83
	pD0aCItoagki9+0ZHpllMTrHb2O6+F2JDvwac6dx/KNevobmOfoL+7O7yNqK43QltNEBdZpoJHviW
	HFNnxNjmFDLKtPkJBTwtkrlCcqN7P1aQVgCeN/vHnpLtgHOvy1gIPZgTkHDAAzeXte+fCih66Ukeq
	40SgN6Vw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w26Yh-002600-Pc; Mon, 16 Mar 2026 11:56:30 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 16 Mar 2026 04:54:36 -0700
Subject: [PATCH v9 6/6] kho: document kexec-metadata tracking feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-kho-v9-6-ed6dcd951988@debian.org>
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
In-Reply-To: <20260316-kho-v9-0-ed6dcd951988@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usama.arif@linux.dev, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=leitao@debian.org;
 h=from:subject:message-id; bh=Hlw5chBPs/GGmVd2Vfxvsk1mq2UGfEKb5hoy1/gHS0w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpt+/R5Ez+Wu4VpdqaIcba4CabNLUTikRuvc4JA
 kTxLX2vZ2aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabfv0QAKCRA1o5Of/Hh3
 bZAvD/9v6OGnwOodgkswz4dXFI57BWYERIzbFFV8eyQEWwpYnEMvn4ucpEsAjnFtM3axRJvRZUQ
 zgtWrLUsGbsh6s/uzr7aNyorRMRMZgHtV2uPH9CwOzzeSuPU9KA+b/wg8i3QvsxKGYL3Twxp4Ma
 YnpTsVVYeOOzWRRbB4c/FmljQfVDpxkAvi33oKRYKxNXLQGJIZ1ffcnocBeVekqBJVWfltzSbuQ
 j3T6H8Lyyr7Iim59ZGeCACPdS1u/8vAz/zhFTIBeJxx6UCsdlpP5zK41ydlaOSAXoAhYtEckezK
 uuq2wrS5CdfYOKvH0K8qrf1qz0hxOseu3CVyOOgr4F/on1fmXkIpzh6+Gnjk92u9/W3UBho53HW
 QyXG6m5ZyBm+GWLTt8JbKCSRgTNIqwbC1bG2G9k7/CmhKDvWYI3eFkWfB9lTCQJoG6krEE74cTp
 vrhH9++h8XWFvj2Dwv5/xf8m9AltqFtKYS75RbhghrDxk+67/lWWVi3WDjxRhsmTgc/YgUyKZgS
 jkvyiMIDMiN8ewfgrfc+2myP0z3x5fNixbklx5B43LKvRLj6ulHHoxfux8nnIVjdoJaMo1ojCnB
 thkFsdEdhNDenMvPgUz4OfGYQNQGTicZumN3qLD+HWWKBxqrchmwlR2ByMqljUd7JUmu+csnS4n
 UHR5TfwPVACncRg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_045636_632691_3A330FE0 
X-CRM114-Status: GOOD (  12.96  )
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
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/mm/kho.rst | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 6a4ddf3440465..2c26e560bd78a 100644
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
2.52.0


