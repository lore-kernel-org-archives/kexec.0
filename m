Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5865CCAC5A7
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CdtlHdz8hccuQuHTmW/gkZb177dEvhf9nCDwgdsYksc=; b=wnk3GDYdn0DTpFBNf0QTE9ng3g
	Fr+2bVt4pV6k+61HIn/LA6CZFWcG/D31WRhxPSz7Tz0Aobs5AzV5hqH6T5hhPTFdYS/JR3Rn1QqXk
	ATHLBcwPJzixm0QrSj1eY8BJbIc64zRTr7ecUaBbHdJIc6C6rlFFo3QKwafMsZFUlmaWj5oQ5ACX6
	NSjUVF9bzpbwBTzDBZ6DasRfvvMbTMhGsjr4Sa8tV9ehdylAgWaz2luT5xpZEi2SrjexutcS3pgyD
	9RSXF5sJkfgCgeRohcMfFf2W6nHgSrUWI0SttBwoneVOuO+RljwHbeNTK3D7wGpXEJRhXqZbcbXKa
	wLFjAeQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v166c-0000000EIq2-26C0;
	Tue, 23 Sep 2025 16:43:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v166a-0000000EIpo-2mUJ
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 16:43:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0751B60052
	for <kexec@lists.infradead.org>; Tue, 23 Sep 2025 16:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E5FC4CEF5
	for <kexec@lists.infradead.org>; Tue, 23 Sep 2025 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758645783;
	bh=R68YJbq4BQXnzwo1q5OX+h3h/r5CPbOgf9YezQ72gOw=;
	h=From:Date:Subject:To:Cc:From;
	b=GMp5rQ0k89P6kwe7vv9B9JCdpCcEBJ3B6WVfD1gHdA1S9WJSWGxSlk3xoLp1VZwH2
	 4kyDjoCiJhMPtwUV2ZCR17xV1eznry9cIN4+PxCnpRne0DFoA4aYCf9RBzrMdVg3AB
	 ZWt9p9qWNbXdo97AfskukBh6RtuWOWqWQu23VeNXg/bJzCS+VORgtWGJmrm3eQOU4G
	 58cy43s+bgM/eIp5PLOk0uRiTQhyP5X54wG53VeAwgfSEPi/G4afwPoa4fRwFqTVog
	 fGIAuuSZWPeAqoljRYH/Yx8YMmgM7ihgcTNwRM468L7/6+kh1C1hO6WFV5zJYiEHi6
	 mbV1z1+3KbhGg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 23 Sep 2025 17:42:54 +0100
Subject: [PATCH kexec-tools] workflow: Add loongarch64 build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-workflow-loongarch64-v1-1-047ebd559174@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA3O0mgC/x3MQQ6CMBBG4auQWTtJLUrEqxgXtfzAhKZjpkZIC
 He3cfkt3tupwASF7s1Ohq8U0VxxPjUU55AnsAzV5J2/ut63vKotY9KVk2qegsW5uzDg2nDr8XL
 dQDV9G0bZ/tsHLdgQ+aOaCj2P4wdHhNDVcwAAAA==
X-Change-ID: 20250923-workflow-loongarch64-ee03a89eb06d
To: kexec@lists.infradead.org
Cc: 
X-Mailer: b4 0.14.2
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

Add loongarch64 to build matrix.

A gcc-14 package is installed as there is no generic gcc package
for loongarch in Ubuntu 24.04. Hopefully this will be resolved in
Ubuntu 26.04.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 .github/workflows/build.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index d1b3e74391ffa3e20764cea69fd5d02e9e4fce6c..1dbb31bca111c0f2746567b0ce81f70e30043776 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -13,6 +13,7 @@ jobs:
         - arm64
         - hppa
         - i686
+        - loongarch64
         - m68k
         - mips
         - mipsel
@@ -46,6 +47,8 @@ jobs:
           x86_64)      ;;
           x86_64-x32)  GNU_ARCH="x86_64-linux-gnux32"
                        CROSS_COMPILER_PKG="gcc-x86-64-linux-gnux32" ;;
+          loongarch64) CROSS_COMPILER_PKG="gcc-14-loongarch64-linux-gnu"
+                       ;& # Fallthrough
           *)           GNU_ARCH="$ARCH-linux-gnu" ;;
         esac
 
@@ -66,6 +69,11 @@ jobs:
         sudo apt-get update
         sudo apt-get -q=2 install ${{ env.EXTRA_PKGS }}
 
+    - name: Add GCC Link
+      if: matrix.arch == 'loongarch64'
+      run: |
+        ( cd /usr/bin && sudo ln -s loongarch64-linux-gnu-gcc-14 loongarch64-linux-gnu-gcc; )
+
     - name: Build
       run: |
         ./bootstrap


