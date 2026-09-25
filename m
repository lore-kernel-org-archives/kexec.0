Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827D1C98321
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dA+hfa1kQZbaNVONmrZnwYeXHMn1vsq598ePpiU7B9Y=; b=HNruzIfny1ONi3
	Il2G/2TGeI97qOesBvZpya5dC/8/v46mmPNfmz0cAAopJu1pWcwJivnAHYDjMbZLDn1h70uhxiO8J
	9rWJdSedYphb528MR7unKwLQWbgHUTnPRxANyn2zRFUWKIVozEmbK/+dTSOAgmD2UzxvGKFPfo+ba
	q0RC2BDneeys/DxYWpWuXhWqDuKF2C0Wn/HCmUPMm9vdp1cd3duNyMgt/V8u+glXt0wKwQI66gAy3
	tm6TeHMBnnxk+KrZLxJKWr9ceaAE1/jzN0hBogdbz/B84iDXITujT84sksVWrB0Q66ZP/Qn9Q2vAH
	FO6bhiEvkTW2+CM5/SCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xABcj-0000000EGdr-12gE;
	Fri, 25 Sep 2026 19:30:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xABci-0000000EGd8-29AP
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 19:30:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id EDADD60261;
	Fri, 25 Sep 2026 19:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 33F1D1F00893;
	Fri, 25 Sep 2026 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364619;
	bh=dA+hfa1kQZbaNVONmrZnwYeXHMn1vsq598ePpiU7B9Y=;
	h=From:Subject:Date:To:Cc;
	b=lY/jjOpQYa1WuC/0HJnPK8VazSYniOslQPwa1od00x1u7tvjLUR7olim3xn8VbDfA
	 5Z9Hvij9oxD4JOZ8xIbh59oglxLtsCjKcvCZe8mE+ApjXlxUA0VULcRk13YMT12/tA
	 RRsk0tot8SeD5gWXijB63RdP0r/9adEepl5UVyevMp2yDl6MMaFY4w7zoGpYmKeTdi
	 tB2hcarX8yZs9HcLOqpURK5vlE+3fkKN2WJvEaZBVL0YRaQj8yxLdX34VBcDooNCFP
	 l9m7PXeG+TllvhCFIzO9ELkGq7X6wWh89CG6LF5QMg3lrP/Rrnh+SnX3vw4P6uAyjk
	 qdUrb53rYZBew==
From: Nicolas Schier <nsc@kernel.org>
Subject: [PATCH v3 0/2] Move tool for generating initramfs cpio to scripts/
Date: Fri, 25 Sep 2026 21:29:29 +0200
Message-Id: <20260925-move-gen_init_cpio-to-scripts-v3-0-99c493f76722@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJnLtmoC/4XNQQ6CMBCF4auQrq1phxSsK+9hDIE6wERtSds0G
 sLdLbgwrlz+b/G9mQX0hIEdi5l5TBTI2RzlrmBmbO2AnK65GQioBIDiD5eQD2gbshQbM5Hj0fF
 gPE0xcI0Hjb3WqGTLsjF57Om5+edL7pFCdP613SW5rh+5FPqPnCQXXBgllO4kGtWdbugt3vfOD
 2ylE3y5GsQ/DjIHVVejVKaWZfnDLcvyBpu0+1saAQAA
X-Change-ID: 20260225-move-gen_init_cpio-to-scripts-9e89ef99e51a
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Luis Augenstein <luis.augenstein@tngtech.com>, 
 Maximilian Huber <maximilian.huber@tngtech.com>, 
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Askar Safin <safinaskar@gmail.com>, linux-doc@vger.kernel.org, 
 kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.17-dev-1f2f7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169; i=nsc@kernel.org;
 s=20250924; h=from:subject:message-id;
 bh=pDqb994ic/Z+6UXT2aao8EB9GiNe/BjSDj6U340lXcU=;
 b=owEBbQKS/ZANAwAKAQdSCnAWJhJpAcsmYgBqtsufqHVxTJCI0rLc+eABWiVI3ljpInqfy4sM2
 gxxruzB5D+JAjMEAAEKAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCarbLnwAKCRAHUgpwFiYS
 aZn6EACtoEib3BZH+y5xRl0zD2V2yMwKvo5lxRBhdjAU39DdGVdrWBrpZtD88s6B48PRXbIVTzz
 6z3oGarFnGbDuaOP1lQLQvFUbmLY97a8LGv5KapqwOCjGppxaRXXaVayT5MK9wCq5fjDwgHzXk/
 +Z1qY/yPEGGVU6CjTWmqPH9nLHNyMyJyZnJTOjw+rI4NAkmT4bqwZc7ovQSjVsQxeLMdznQ7HVN
 rjMAb4DVAaNuAHZT6xwjNALqQ+zLKIdWKNBToesbHMIjJNGdhe2o3S1x3nJ1sDJje2AfkMNIDKm
 wdZHuEumebEIFqbtDJAcHL9CAJN9/PrpsVxaTs8mCe2Qbt30RgZyT7PFI3W070rRY03Hlcvb870
 pm+5svMdWB1m5zuBeuqG7QQLVsUq6fZlHS6kcELrNLCGrJJPo2c1CeiBxOocVVOjPrzF+dNh2bz
 jBWaMGNCij2OhNpZgD6cH3kPa90w0u+cNPuDDw6CruRuFc1keb+bptvLUdODnc9RLmVoFN1aWkE
 HM5wlVBYku/JnxHlhUDKgu/tKIZRiUE/7mQ5vKzgr6vMEboAEwR6uBV7AbssugNu9v4jVTqgl0W
 WrEwqtKHP3UV0Qc6inhSD/tEttFBEpY87DVNEjllvQUdUa4eJJtVDSihNY9phvp3uM/3klpfBmn
 030TuXssf+PQxnw==
X-Developer-Key: i=nsc@kernel.org; a=openpgp;
 fpr=18ED52DBE34F860EE9FBC82B7D97093255A0CE7F
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

initramfs cpio tools had been subject of several recent discussions on
linux-kbuild.  Let's get two minor steps forward by enabling a
top-level target for building gen_init_cpio w/o the need of a valid
kbuild configuration [1] and move the tools for generating the built-in
initramfs from usr/ to scripts/ [2].

Link: https://lore.kernel.org/all/20260220191150.244006-1-safinaskar@gmail.com # [1]
Link: https://lore.kernel.org/all/aSdrCFkUQup3qb-q@derry.ads.avm.de/ # [2]
---
Changes in v3:
  * Update various remaining usr/gen_init* references treewide (Nathan)
  * Link to v2: https://patch.msgid.link/20260720-move-gen_init_cpio-to-scripts-v2-0-26b7e15c7133@kernel.org

Changes in v2:
  * Build gen_init_cpio only if CONFIG_BLK_DEV_INITRD (Thomas)
  * Keep underscore top-level target name (scripts_gen_init_cpio)
    (Thomas)
  * Link to v1: https://patch.msgid.link/20260309-move-gen_init_cpio-to-scripts-v1-0-0c5059b1ec5b@kernel.org

To: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Luis Augenstein <luis.augenstein@tngtech.com>
To: Maximilian Huber <maximilian.huber@tngtech.com>
To: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>
To: Willy Tarreau <w@1wt.eu>
To: Thomas Weißschuh <linux@weissschuh.net>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org

---
Nicolas Schier (2):
      kbuild: Mark usr_gen_init_cpio as no-dot-config-target
      kbuild: Move gen_init_cpio and gen_initramfs.sh to scripts/

 .../early-userspace/early_userspace_support.rst          | 16 ++++++++--------
 Documentation/filesystems/ramfs-rootfs-initramfs.rst     | 10 +++++-----
 MAINTAINERS                                              |  1 +
 Makefile                                                 |  9 +++++----
 scripts/.gitignore                                       |  1 +
 scripts/Makefile                                         |  3 +++
 scripts/Makefile.package                                 |  2 +-
 {usr => scripts}/gen_init_cpio.c                         |  0
 {usr => scripts}/gen_initramfs.sh                        |  2 +-
 scripts/remove-stale-files                               |  2 ++
 scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py     |  2 +-
 tools/testing/selftests/kho/vmtest.sh                    |  2 +-
 tools/testing/selftests/nolibc/Makefile.nolibc           |  2 +-
 usr/.gitignore                                           |  4 +++-
 usr/Kconfig                                              |  2 +-
 usr/Makefile                                             |  4 +---
 16 files changed, 35 insertions(+), 27 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260225-move-gen_init_cpio-to-scripts-9e89ef99e51a

Best regards,
--  
Nicolas


