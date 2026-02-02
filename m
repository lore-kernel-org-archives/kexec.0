Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2817BE7DEE3
	for <kexec@archiver.kernel.org>; Mon,  2 Feb 2026 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j9uLyV9kFLJGHA7zrDn69gzb5Tm23oRDPvMLnu7DPy0=; b=SHie2m8UDJvHZB
	D5wOha+1XD5fAJ8CMtjU5hNDDipTJSHSROpeElPvcDS5MHg+6kr1dMdibHHmdpT5D9/LkH9kgK5rR
	2sVHpHiLG3mBdGkHZZJi/JIfLRwjhl/FzUhMHSlcbG7nxbFPQsrxy94Rr8ozL8uumn86zahb4veSP
	ia0jS01OK0Ecl7C4zyg23SS9lb7Wlgky4kw+pu2vBX/DAZRmKPlgl6UPFMK0IuTQaziXE+i5Um6o1
	khGqPFV7IcuPdv7W+iCFQJMaU8cji/c2IrOF45huwF+RSXqWflAQdanz0zEeEHQvnpnHBzBCm18AU
	WiFRnzDbYuVLcjQCQdow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmuuj-0000000566H-1TVz;
	Mon, 02 Feb 2026 14:28:29 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmuuc-0000000564O-13uo;
	Mon, 02 Feb 2026 14:28:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=j9uLyV9kFLJGHA7zrDn69gzb5Tm23oRDPvMLnu7DPy0=; b=pAP2QGa3zgjdrxhHkBkctEe5b4
	ANZYe1bm/0fZydyOBYtIgfw7OxYc4p7YtvRDaw6WWQebKcCOm0UAg0fcAOPRJ5qEzwYkDzMedxPaK
	yU7eg8/K84YPFcuPxyKJffM/3IQJWOksoQfELQJocH8DEdFxC+w2BQaPRTjUKrpU4F+6Tw5zEyDg5
	rOSE9fC2mTnHuSN48uje3X3J2O+ASRyFQFzCbtCcKZ2QiHuOiRyoRm+M50YGycH0XnDqbXdmRQSuM
	14SAIgAcPAKkrmcbpbdwdVbXYMik5CpAMfF2jBw9vlhp/zhLsmqOzo/S3h2jMeXG1NKp2Yya/qEDI
	EJf+ftwQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vmuuJ-0046XU-Lw; Mon, 02 Feb 2026 14:28:04 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 0/2] vmcoreinfo: Expose hardware error recovery
 statistics via sysfs
Date: Mon, 02 Feb 2026 06:27:38 -0800
Message-Id: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFu0gGkC/33NQQqDMBCF4auEWZtigtXqqvcoUjTO6BSalIwNF
 fHuRbvv8sHP91YQjIwCjVohYmLh4KFRNlPgps6PqHmARoHNbZkbW+v0dCEiewp3WYREExXlpaq
 r2g1nyBS8IhJ/DvLW/ra8+we6eXf2YmKZQ1yOz2T27g+fjDbalIUzhIYwr64D9tz5U4gjtNu2f
 QEZ/HDywwAAAA==
X-Change-ID: 20260129-vmcoreinfo_sysfs-ff4687979cd5
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=leitao@debian.org;
 h=from:subject:message-id; bh=gI1rB1UnSjdCFeqDmDgt6zB+vX19MFGXqv9RVorUFSo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgLRt8/uJvmAO9WWOHLmnUuQuY2PdOl13iumgj
 4SNdyDegrmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYC0bQAKCRA1o5Of/Hh3
 bQnFEACdMj0oOmwbD8xG7FWlRTtT8LyTyEBdZ2U2fGf6rlMswS0oVubjyxCmqe1ZUwXn3UvQV4h
 T2zW3gibCr24Mu7/kx05Xb8y/IJsebfdJZoNrBvVjtO3J61LYdHxAFtJtRBuTy7kWOSAVU65Gn2
 wOKdK26E7mHmZexrJncyFZwzNndbKNQWiAg4KE+bZLIPs2hCfNVgXgQZYOOiU1HUlIk9LALzTNk
 rvjbknxALwyzWIvnYPGLPP5ZDXG1VkS8DWM5UPPdcOUUY424KLESaAPK+CWWpA4NACa3Og+mHwd
 QExGhwKue4aegJaVbrb08ZHJwnIZgeToucqSZ8J6gBZnAelKrWwtxnQN3O6TKLhXO0C9COZZowV
 0ZEZJsek7p48pSXSHTyzJj8+1nHU8GMTLo6zNkclnoBCcD/DYM4S2BBu8zg0ORTzFBCSuoRvX1O
 Ie+7Mo/8uixMTI4Zez234AshN0GIw5vKjGoWQxEgizgPR1gdMg9Pr11S/5BM0w/cqCdimOgVuc6
 +1JgrAYaazS/Rp0kT6wGRqJpH6zVBeOebeyOr4Aq/uA3PsutJpPuw0C9lf7wthZXqtNpXQWrBYH
 ZN1pm7heacYfkYcTaJBeOIwh8B3r9OY1oiqfNEk5Xh+qO+/M9FbegCi9cStJzH3CYi1uxpTkCyY
 z4THSJjcVKrxQ+g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_062822_323850_5BA141A4 
X-CRM114-Status: GOOD (  10.29  )
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

The kernel already tracks recoverable hardware errors (CPU, memory, PCI,
CXL, etc.) in the hwerr_data array for vmcoreinfo crash dump analysis.
However, this data is only accessible after a crash.

This series adds a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to
expose these statistics at runtime, allowing monitoring tools to track
hardware health without requiring a kernel crash.

The directory contains one file per error subsystem:
  /sys/kernel/hwerr_recovery_stats/{cpu, memory, pci, cxl, others}

Each file contains a single integer representing the error count.

This is useful for:
- Proactive detection of failing hardware components
- Time-series tracking of recoverable errors
- System health monitoring in cloud environments

To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org
To: bhe@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com
Cc: tony.luck@intel.com
Cc: xueshuai@linux.alibaba.com
Cc: vgoyal@redhat.com
Cc: zhiquan1.li@intel.com
Cc: olja@meta.com

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Renamed vmcore_stats to hwerr_stats
- Separate each subsystem in multiple sysfs entries, one per file
- Link to v1: https://patch.msgid.link/20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org

---
Breno Leitao (2):
      vmcoreinfo: expose hardware error recovery statistics via sysfs
      docs: add ABI documentation for /sys/kernel/hwerr_recovery_stats/

 .../ABI/testing/sysfs-kernel-hwerr_recovery_stats  | 47 ++++++++++++++++++
 Documentation/driver-api/hw-recoverable-errors.rst |  3 +-
 kernel/vmcore_info.c                               | 55 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)
---
base-commit: 4d310797262f0ddf129e76c2aad2b950adaf1fda
change-id: 20260129-vmcoreinfo_sysfs-ff4687979cd5

Best regards,
--  
Breno Leitao <leitao@debian.org>


