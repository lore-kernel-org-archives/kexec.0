Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A051D2F038
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGV9QY0eKC+XLC5jci/d/FFQqBpectBL2Qr4Jd0liqE=; b=eVPMZCPTgFmvWNOcDaTQjVnrUA
	QCMbEUj9PXLOkLYoXKjKq0FpW96EsxsBB/k9okH+dkvgUfJVEAaL7q+N0iDer5K+ibgSLtb9+doGp
	B9oimOFnWBQ9kUnSM82tp7L0K/Fvs+fx0/ageyeUwirehjM/bDoPMOGUywYZFDfoLGp51TT+I5v3Q
	v+JNI5oKCeViwic6Lq8zlqFEx0lQwwAkrxWbjI7uMTh1fgP50Sz9+hmYS0wjrtDaZBzaiFiTlDuOW
	Vg01472UDzLoM+reWSXYNr1GNbAbLWU2xNBQOyxb4xP1g6Xa4f3nX0wj7l24yBvLAcFs7aZ6/ADne
	riNqRtAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkDQ-0000000EPgN-2InH;
	Tue, 27 Jan 2026 14:38:48 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkDN-0000000EPdx-0Fwp
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 14:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=mGV9QY0eKC+XLC5jci/d/FFQqBpectBL2Qr4Jd0liqE=; b=Q1GNF3jdZtMn3P4r5/R4swjm0H
	3yUVhKTRKvrV3Kn3O6O6PrJZ9qQtu+MGveR9TBXf0QG/h7G4dfNYoNB0RTmvYrdehJ+TdBrfXiTQM
	opXZSQg5NymiQfotFJJXTlkF59l6CNxQoiM5Th3sNlsN36ssJi/h0zPw+Ty3AnQskbqOF6hha/A/U
	xt0ufAkOO4ewK5AGtMJkGqTXwejFC3MK43AXlxweD5Xg7SToiXnICmKYiojiWbLY6P2hbRGuUnwNS
	KM56g3mb5GJcjtdTCXmPTPuVNwY0f7xsd8d5zn94hZ20fwcDF40y6AvtWyNCtxF8OmB8vEtY56VWT
	F9BJlIqA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkkDG-00H3bi-VI; Tue, 27 Jan 2026 14:38:39 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 27 Jan 2026 06:37:39 -0800
Subject: [PATCH v6 4/4] kho: document kexec-metadata tracking feature
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-kho-v6-4-56f9396681c2@debian.org>
References: <20260127-kho-v6-0-56f9396681c2@debian.org>
In-Reply-To: <20260127-kho-v6-0-56f9396681c2@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
 riel@surriel.com, Breno Leitao <leitao@debian.org>, 
 SeongJae Park <sj@kernel.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; i=leitao@debian.org;
 h=from:subject:message-id; bh=BibzqRu4Th29Z9ZLDMxo+dYOx89bJU5ET1VM3xltlKE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpeM3XfBATMClwlLj2ScoQxI7DhQS7XCCiu3I5D
 FtWzWXHM32JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXjN1wAKCRA1o5Of/Hh3
 bT7WD/41L7tomElTT+B/OFwWEDmD1wkVMFmcJDn4NThPerzTRJ16JJaxnLwDPKxdO9zeHGNw5d0
 nN4ounqpCCm6im1A/MwlfK4BJHlPVp4yfZM/x1WKXGwwRELNyxBVx1rQCmzk76Jo30v0n7aqC/n
 4374aKlmnLBDboqebEyzibBkMI3ORDPaQZyCz7IqZTc8wA35G5CqraUwN3GZjV99zsaFw/v18zt
 /3afIV7lpZD1KCUKxLsRgUQPUZV87oTOn/VmFI5BCfBt91jII4fRIaYeZf0ppOQKS7Hv7UkG+8+
 halD0xRANRnrceVvs83HsA7SgrSMoM33X8xCo0DWbzJCuE9eXHAcd+7lXaCY4pJz+kuZ/RO8SIf
 8wwjqyc64nteoaG8m4CYwL4mhRhWECW5VWer/xNKXZXwHTLUYR32eXDiYpetNvSLiG9B+eji/Uk
 CdtK/gTZK7aU7TXoJ79kI1uerPEyn7gSyK3ADnwBgaNK+ej5PmLec15uXw9mV1CHDaZB1IgQLc8
 9Br6cicR2iiVlFYzDgpcVbVAyWEuVbOHuOSSvQsvgWj0p4Q6bmRc5KlFx5AwJKxaxL1B+JGGKUF
 Gh8ZblvWHSE/QeNGsxcvad8RwH4eZ86cTCjDM2HSvwNk36BWmSp/cZfgVeVoXbCkXh020Q35Hl9
 xdCbfDI/GQcqWHA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_063845_105135_948C83E5 
X-CRM114-Status: GOOD (  12.61  )
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


