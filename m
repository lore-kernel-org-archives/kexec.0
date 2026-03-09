Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22576F3C24E
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7Ml/vJyi0FRJgghGtQCc2586RzghnjwSv1hQiNW19c=; b=KocT28o5AnfaJ5XLEbWG4Vjw6h
	hN95eZdEt90jApZPeD+/5MYSdG7KZUWTeC9tu5rW6YM6/jqSBMFFiFZXLv9zn+Sh4Qtu7KmmBrWg/
	yiZjmeEsMRniMk/XuEY/PAfOCZXk/Kh2L7nYnc9b5z2dkrP8XnVtKm9PKw2jGtcYOeVttzJt1iVEC
	ZydKI8dBSV8QKUN7gdnXxKzDEHSWd7EqZtZ40/LH2X5kWLEEGWpMm56lrC49ytP4a5uu0945Sta1u
	ANep3Qki9Xdz++m1ErmuY3Ehx+32IF6Ah4bzJq1nAw9X3lnJXM5J2V55uOOebkTS9UL9CdXyIq0Iz
	tEQpLIog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzasi-00000007QIm-3OsE;
	Mon, 09 Mar 2026 13:42:48 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzasg-00000007QFN-0dtJ
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 13:42:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=O7Ml/vJyi0FRJgghGtQCc2586RzghnjwSv1hQiNW19c=; b=QnXvFd2Et5S90TK4Ts/A++2Ztl
	Cn/VR9gXgY/yUvfvqBzs6m7idnfnCuJpz9xk1huJY677VCStJcKu3lGhGjGPYntaChOsBlxa0KkK3
	lq4feo/BjeHAMPAzBVwhmn6M4jCiBDGDZagI83LFOx90LaVIemMdN4DdP8zB+H0RDceNcJPzpjNcI
	Tebz/53FVEPqzrgkcNKeiKGnwt4krm7LfX5+X5WciPzDX0JEr+gwI8N3lad5FNMCTAdqboaikDpWn
	qKkK1CYSwBT5bOPFTETm8PmaVYQRcDqoVVKGd6flSNNmaa56En8XONgahWyMIJodab1IiJQ0+/Fp7
	IGgthkzA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzasa-002G4H-Nw; Mon, 09 Mar 2026 13:42:41 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Mar 2026 06:41:49 -0700
Subject: [PATCH v8 6/6] kho: document kexec-metadata tracking feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-kho-v8-6-c3abcf4ac750@debian.org>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
In-Reply-To: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, 
 Breno Leitao <leitao@debian.org>, SeongJae Park <sj@kernel.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=leitao@debian.org;
 h=from:subject:message-id; bh=GuS2S3Wn71jXKGx9RIpG1q7JVYnitQ1EXkky0LyglZk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBprs4ze/rUp861RrV5t62pTbJLJtbdntrR9AyI8
 qkmZylG1YeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa7OMwAKCRA1o5Of/Hh3
 bZgPD/4v3Yod2PPxx34KIn9K3RWl7jTuWUrsFK1hW5GuknLIksUYSy1hNqVshjLJL0tJFoK3wbK
 Vtx8cP6mtyX6+bJqGT38vExtFo2tWIe/55xDb6xyYSFvL4b+tj3K3+A6nHr4S+5Pq94JzrFg99V
 NXoqxOcxj46lsy5L5BHNIABY5rDqSuHF84zlo/2CJ+7pMUrS25J5mMwyPpbbWBQuRZLk7JS190/
 k6Uqk0QxlwagjSHgnnjKNxib/DwMW76TD67dadJv4hzW4JKA+zZvfKYG+wvfPs9dDdDb8ydbMHy
 sPol8dSYkjkF8rrvyXAFuzX3FMjQ8tmxTZInP/oXcwhfYGKDaUgYKb20OKL1CwkEUHZfOxlqIUx
 tlEPhKfp3oCZuYTt+HIQqeXLLNbIxRUdcAAag4DjWGdHgYnwbvrF35b1NZyDN7s0bCMAEb3mHQ/
 OH8tyo88JiSVeNtJcd7fHF6i6L9B3jxJY953cHHLrHlYOpFJKe5QEO4kZ82UEiP7F5vjAOC82w3
 Ce7XCPByc1m/rvbfXZnpIalWvsCeDzgO/XgUO/mNL7PVsHabR18OWb8DkeaBqsOg5xZ4Bz4v1dT
 /j6A+KxuQ8FbDrNLwb3mInMqwr2JH+L2rHio50MXWAPzeFhnPGkMnSSGknAarZQp+tpypF8BbJi
 1Z9KvPbhp3tRUEw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_064246_208466_56255CB3 
X-CRM114-Status: GOOD (  13.73  )
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
2.47.3


