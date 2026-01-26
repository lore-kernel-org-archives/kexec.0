Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90DBD19500
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wD58s7Afm/VpqSfRj+q5T+RmL4WmAdEhDa4vBZoYFyo=; b=2Na8/6Oz8fBJsr3BBsqGHWi+tW
	kTTkfch2KamzfiY7IfdvjDyYzVQ+S9hG/tQhgfWaFOm9PnsD6e9SXP1ICoHvUi2P3sNovmmpa5hF2
	hKhjl2llcZzVb1ZMFTB/+w8h9JDdkZSw9Evg01qbEBfARr2YFpkZgt9kpEuAw4Q42eYUSvocLU3My
	2F/GJ6f36d3IfBkX5hGKDlr0n9x4IuRpt054/6VnvGmJBoYsmgcuPzNJUhMNw7+PbAtlw+Zh2CEJ/
	YLeFfkEXaSgBAiHTUJdQSlp0oWm8PkUuADXqv4IfeJox4b2+JXs+If2GcIM5drnCW4vxClKXi3ohF
	/Dp+jKIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP8M-0000000CpgR-1uUD;
	Mon, 26 Jan 2026 16:08:10 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkP8J-0000000Cpdi-29eo
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 16:08:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=wD58s7Afm/VpqSfRj+q5T+RmL4WmAdEhDa4vBZoYFyo=; b=soYnZAFuPhU1DxNnsHIw5UePTQ
	a6FXz3eyOoC936m2ACmAu9h/bYT69r9a6FJkP5u/k8yIwyw4lDlocxXTrhrEOxQmn5IZZHzHTKgXd
	jJYDjTiSrC48CAIgY86GknFCOdTNCJr+jmto+pl/ijgnrxE3gMb2vLTDGDjb8+4BCegUjjcVqxlsE
	QapioKiqUz+On5qkl0WtwX6K80gtpXX9fDCQt0pkROmlusOjAyDfQBYX8b0K8eiVlkED2/NSsJjs+
	fu/zDA8SfFrx3kMoT44WLucMzOsil77KxgDd7m2mmtKf7vYTG+vQQWIN+MCz7AFbinrs2zrO5akJG
	P6FvYxbw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkP8H-00GI7w-Im; Mon, 26 Jan 2026 16:08:05 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 08:07:26 -0800
Subject: [PATCH v5 4/4] kho: document kexec-metadata tracking feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-kho-v5-4-7cd0f69ab204@debian.org>
References: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
In-Reply-To: <20260126-kho-v5-0-7cd0f69ab204@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2407; i=leitao@debian.org;
 h=from:subject:message-id; bh=LPIeB1HXx7yrXcJ/f/iPyLV8CRN9XseGBN7nDn4O/z8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd5FNsYxGYOfmgeChAKbgeCeJ4Qsp0Qy+6Zkp4
 dy+wiT4aQKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXeRTQAKCRA1o5Of/Hh3
 bT06EACm9JDRKk0yip7QtOwGH/xtGviLyn0x0lI5qHFZZWp/yqdNbU8HOP9iETSZuG/x1Tjn0+t
 5wWTV05RZgrHkuZX3izl50nBeBf4TaWcMcYT+HojQG10w77/61U7/ZX/9skWqlbyfS68KrgAfGZ
 6p7IfV/c99GbqvTo++uo3Q9aygJQ7lfkBdOMAFCC4oYMiP4CCGdWVsmNAzfH6K3RnYSL24QKHxc
 0mmmkLaZnceiRq9U4spubZkyXtIP+s4Ul2zxOEXYBOQBcvCmGFCC6FPfYoi15Tzxe8sC/EIzZQX
 4mYzZ9S4gT6QDj8L/FToall4nJr3eCua466cKVXuD2KAP/5Ns7RJTnbfMO2WH6LhdTmrlKEYK77
 QX+WNSWjlXAzAsRh6XJ4IeRwUzhPDYtcLRblq97HB+Dw2R7O/tGM/QXcNiN66jXpYi2Ww14Pmnu
 yFRucwlpyVrkCsqOLuFoLa5EkMZONFYPUTYkWQLk7+VV7vQqS3A7/N2wIndlp4P9CLNSJK1yiCA
 CJ2ASYS8X84qZyg5UvZSO4ywk6UhmVdbMZrWheyFJ7ccGfggPxuocfWNsFPb2PRJDrCpnutsQ0O
 SoRrEEJkjnuY6dqwX8x1+Z5d3nf8RjSpga1r6jXGq0ApRL53Ho7IN6JHQ3Q8St4MqPN6CN3Vu8i
 qa1gXGhv4nZSXWA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_080807_558933_ED2B0BA8 
X-CRM114-Status: GOOD (  12.63  )
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
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/mm/kho.rst | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 6dc18ed4b8861..3771e764bb513 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -62,6 +62,45 @@ You can move the system out of KHO finalization phase again by calling ::
 After this command, the KHO FDT is no longer available in
 ``/sys/kernel/debug/kho/out/fdt``.
 
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


