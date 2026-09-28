Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E51CA5FA1
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9TV9CZp7F6pGowVYUJzJ4N6Q8t1cPGPvHxtYWak4BOo=; b=raJTi6mIHZbDfC
	rwrOChKS7Rvv8NT5vOyCLFxgGUmJ0qyI1a2dZtjX75yxaVvr0yaSlu6bLbqLC5jz5LHNMBPZP5g5B
	+Seli72qsm4UWOjCky6ZuZsWIyRv9L5Rv+ZdhJpVrQQJk2JLzSe0YlAYNCJ/IkMRtz9sRcgLOQivw
	SYuZEvGYPbBRBZb7BgWplNQIUiQhSW2Iw5i/6M93P4GuZjKBqCkq3wrXJOWkAvADvrzwuBR2V2/dp
	vO+iSmJcCvyEF+EAZjfPP+s8NTpO0Le7DzRQD7d1cP7qHJXXCFtvUAB1/vCAs6QRzgvjHIofCGzGE
	u3QdBApk7cM1QrQWMtPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF8e-00000001A0s-0vOH;
	Mon, 28 Sep 2026 17:27:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF8d-00000001A09-0XXi
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 17:27:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 99D0D43B2F;
	Mon, 28 Sep 2026 17:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0B9CD1F00893;
	Mon, 28 Sep 2026 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616458;
	bh=9TV9CZp7F6pGowVYUJzJ4N6Q8t1cPGPvHxtYWak4BOo=;
	h=From:Subject:Date:To:Cc;
	b=ML2QdkCS3OlmsKQFbRneo/Dlnm8gkGcBAJgnibAb7/PJa0WxDM9XNJv8kL5KqiL6t
	 7z/7Tkm1ZnURsXPB3nXojxLLZzPXiQ1mq4IXis0jZYFfttjVG4b+nKFlz8h6Iz2BBv
	 /wXXvB0zyoX9KJy7Uz43TV5kxt/eZUI4i2s3oUJdzEEer5tgUK55Xt6xUCSXtPoyW3
	 9VHz2rq7lyb2ERXoBToE4x/4iVBmX4e+IBvDSJqiTyltIGP//E4SHOsBO4tdd5mZUM
	 G/0WhFcUBKkyeoRCTvMXgORvgbGczTvTiJACqSc4N7zazKWAMld/JZUOA6Y0savHQk
	 uxDgyLuCI25Lw==
From: Nicolas Schier <nsc@kernel.org>
Subject: [PATCH v4 0/2] Move tool for generating initramfs cpio to scripts/
Date: Mon, 28 Sep 2026 19:26:56 +0200
Message-Id: <20260928-move-gen_init_cpio-to-scripts-v4-0-f437a33c40ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGGjumoC/4XPQW7CMBCF4asgr2tkj3Hc6ar3QAgRMwmjFjuyI
 wuEcnecsEBVF1n+s/ie5iEyJaYsvjYPkahw5hhq7D42wl9OoSfJ59oCFDQKwMprLCR7CkcOPB7
 9wFGOUWafeBizRPpE6hDJ6pOoxpCo49vi7w+1L5zHmO7LXNHz9SUbhSty0VJJ5a2y2Grytv3+o
 RTodxtTL2a6wJtzoNY4qBw0rSNtvdPG/OPMm8PVv4upHKLfoelc4wD+cNM0PQGCR+iCaQEAAA=
 =
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; i=nsc@kernel.org;
 s=20250924; h=from:subject:message-id;
 bh=AHw6WcgdVZgKfWGs8wYDEg+b2spe6e8gjU2uAAY/cLc=;
 b=owEBbQKS/ZANAwAKAQdSCnAWJhJpAcsmYgBquqNngpRwJH7gtezweBGwAnX75e2BjKoR7HKmD
 +sDP+kdN+2JAjMEAAEKAB0WIQSHQTenhzckp4G+wsYHUgpwFiYSaQUCarqjZwAKCRAHUgpwFiYS
 aURsEACSbagu8wpV2hI77TKfpUyKYeiN6C1f9X3Ib3qZeypiAv7bCFlW0vHuECGboSOccAcPG0j
 kO4zYR7Rd2P09QyWjep2b9RMx9ebQZa3Pkw7CkNJRvRYdzaXqfOrZKNVyycf6cswhNzYg/MvFNC
 2mq3S456NmxFP+tBpQDzRRXE8cR3tWgOdMPgzeFpskkcloyPWmme31LFMmQc4uG2QAVIvJCP3ru
 Vjc1+U5ZVyJnci53Ndu3IiOzfNOGu45RzYNsVXZ8WJd81QHVcJP+utNDpOAQAlVbpRBiLXcs9Pv
 LNILfhKuAgtV0Hbq2cEN54Tn225iFOmgJU3u1JhIhGHnFT7dlPfhP3i0tCvRLBjurAjAMic51aB
 O8oInBBP2YTcR3eVNlHacd9ookbdHuYODSEcLrCfT/ZOfsnYKFSkZYuYievOivk7sxG/NBLJzJ3
 XnMnh7m9UN8/dDaur9qQoVyNdfZSlWIPauVTtp29cD51mfY5TNU4KQKYMaaCJrXme2Sl/+J0f4Q
 +Z5Mxr6NJ1JKBrnHlYDtjxNe1VABRnfxKsLH3bhhe/cF5Ucum3QgTr+pXiGTA2OsF11Y+x5T7l5
 N6wI1iHm82VVYP9Px+ogjtFrfdcjwerLMNMLtctbbgc0MSYcSZO57QmfOk1eVPI0TiVUoIl7lea
 uO06Fu8x9SVY80A==
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
Changes in v4:
  * Update tools/testing/selftests/liveupdate/vmtest.sh to new path of
    gen_init_cpio (Mike Rapoport)
  * Update stale comment in gen_initramfs.sh (sashiko)
  * Link to v3: https://patch.msgid.link/20260925-move-gen_init_cpio-to-scripts-v3-0-99c493f76722@kernel.org

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
 {usr => scripts}/gen_initramfs.sh                        |  4 ++--
 scripts/remove-stale-files                               |  2 ++
 scripts/sbom/tests/cmd_graph/test_savedcmd_parser.py     |  2 +-
 tools/testing/selftests/kho/vmtest.sh                    |  2 +-
 tools/testing/selftests/liveupdate/vmtest.sh             |  4 ++--
 tools/testing/selftests/nolibc/Makefile.nolibc           |  2 +-
 usr/.gitignore                                           |  4 +++-
 usr/Kconfig                                              |  2 +-
 usr/Makefile                                             |  4 +---
 17 files changed, 38 insertions(+), 30 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260225-move-gen_init_cpio-to-scripts-9e89ef99e51a

Best regards,
-- 
Nicolas


