Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41793606A31C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4xEDn88/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEF4MGo/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Cc:To:In-Reply-To:References:Message-Id:
	Content-Type:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wHgrig9qjFP2gPZLGaq7vPBylHZ9kF92oCc7Wi052Sw=; b=4xEDn88/TmvG4Pd1z3XpnWn+z9
	Vbz5Lea8hHZYVjeNjgLYGwJ7z/Ps7E/5ca+H/Cdx2hZOJQcBE32/aLG7//7GWjd2mdlr8/y6JeAtW
	b5UG6WlRw8jbS+YPtz07MUVyyXhnH6FpxnjCq87YqVrdweh49TM8n2LY9qwcsbgFqjZ8ljqa3xM/y
	qDG8d+UGJfqe3Yp6QIQzSb4LdWPslnRgSLxrhOjO1WEFgb7QxduEKTm724OaxKVVVr3PAn2T0YPS+
	/8MWY7aW0N2LoPWd+pBPZCCPOlylYClP1dm1Dd8boc7kqp3FBlTHS/EGqTcvMEfmlWNyqhTsDXRLQ
	UExYnyeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xME35-000000085zJ-36BZ;
	Thu, 29 Oct 2026 00:31:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xME34-000000085yq-0HSo
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 00:31:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B3EC943F07;
	Thu, 29 Oct 2026 00:31:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793233877;
	b=cQ036rESxVHkrk4ST7+vnZKcAYa4B59U76MJX1g9VI6Z9RXJ7Qwj6avzPu4Gux+TOGKR
	 tZ3fvDtxgMDhigAf/c6g2yTUB7tUjo4EMsXfzqwFziqUabNnunEQiWh9L5U7jruwEIweo
	 NfOKfjRC478mMK/Y4Tv3N2BpTsPCrlinr9ciSUu2RaiARoM3dEmeJadmzhzTxfr1xVlky
	 SKFKQSCGCo3S+NsGy8G5mXBuTDnLJ+8QvzQQCiP4P549bVtbbbI7xf7yfp9H7pWEI8hNU
	 z9/doSgoB/EuVLcKTvTP9P+AT6qmd4yYlO554ka6H3E5ABoioogfzxifxrwAmfUr99A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233877;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wHgrig9qjFP2gPZLGaq7vPBylHZ9kF92oCc7Wi052Sw=;
	b=a9uxWMdGKhN5fVbvtS31duEnvbj9fNjFwnVx3a7gJoGGBRbHAabHy6zLPDJX2R5IFjmF
	 QbOagnqOY7M3NvERLvS4Ht8ZUn42t522iAs+g5NvsiL5f2k20K+FBh0ujK222cgoViXT6
	 N/6cAIZlEUVRAbHpcsqfSqLpvW+2RDBmp0iDsIRB8fpmJ/9+Gnse1TyuiM8fH3G6bYj3p
	 ohs6ql6P3BW2zgzdNF+z/MZLzMmUZ8W9OXFgJd8Zb0M4gpK1doJS8hMurR21qxphwhxem
	 KTWWkKD9mf4B9xSDHbsGsCCYL3Nc/qN4Z87QRuu1LlZnsEOf/bOEHlZZhxmmZFavfPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 13F4B1F031E0;
	Thu, 29 Oct 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233877;
	bh=wHgrig9qjFP2gPZLGaq7vPBylHZ9kF92oCc7Wi052Sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DEF4MGo/SXzQnYAvszVzL8Gt+FB5/8tW3Aur1B8+yIkCUrLlgyiaM1+HTfwdj2yhP
	 bEHAYVKQr3yw6ZpolEz6EfAW6mzT8vpJBroN1Awu5Md6c0sL50Cb4xwvDteGASXZWH
	 WlF/mkFCZkk4XX0JV0NUQrsqY9NChyaUrmTofyMhn8LqTuK0x8pBEEIUpxKg/COALl
	 k66rtfG5uBL5etdm8EFpBotzUuEoFFbGub0HBLeOdQUkJUvBDgw0+9D+WeMLOo9c94
	 iTW8TzAfgkvF9Oft+jLbkxKaiJrm6EiRZacmR3S2+vjGPW9S/q3Gjy7uiOdZ1+iFWZ
	 tamkjSzaT5EiQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 738864563B;
	Thu, 29 Oct 2026 00:31:15 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Date: Thu, 29 Oct 2026 00:30:38 +0000
Subject: [PATCH v2 1/3] ipe: add the .ipe policy keyring
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
To: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, Manuel Huber <manuelh@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793233875; l=8137;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=qUKO8xyX+/8KnwHErrUte/NPW7CoaYPDwwyvYL+BdNU=;
 b=MXkQBF9XIPmW3lQQqP3IeEwfmaFpTfmzIFwNsZAfrIlG+uYj7UlcRHC7eY3gmY9NLyjJSOSXl
 UChshGXrzhTCTBe+wgtGrLi/y93tQwVlFJqhvvfgB0ri92DtgmGQM/r
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: manuelh@nvidia.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manuel Huber <manuelh@nvidia.com>

Add a dedicated .ipe keyring for IPE policy signature verification.
With this, userspace can provision its own keys into the keyring,
then restrict it and activate it for IPE policy signature verification.

Gate creation of the keyring behind a new by-default disabled
CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
is empty and writable. The keyring is used as a fallback after the
existing policy trust sources only when it is created, non-empty, and
restricted with restrict_link_reject.

This enables scenarios in which a trusted userspace component generates
an IPE policy, and creates an ephemeral policy-signing key pair,
provisions its public certificate, and restricts the IPE keyring during
the early lifetime of a system. The trusted component can then sign the
IPE policy, destroy the private key, and load and activate the policy.
During that phase, the system is considered in a trusted state whereas
the system transitions into a possibly untrusted state afterwards,
running arbitrary user-provided applications. In such a scenario, the
trusted userspace component could reside on a dm-verity protected
rootfs disk, and applications would reside on additional dm-verity
protected disks. The latter disks would be dynamically attached and
their dm-verity root hashes and/or signatures not known a priori to
launching the system.

A concrete usage scenario could be Kata Containers, which enables
running Kubernetes pods in ephemeral, headless utility VMs, possibly
without systemd. The rootfs disk is static and known beforehand, but
containerd's image layers might be acquired and transported into the
VM using the erofs snapshotter and dynamic block device attachment
using dm-verity. While in that usage scenario, signing a per-guest
policy with a pre-provisioned policy-signing certificate in the
builtin, secondary, or platform keyrings would be technically possible,
it would require including its corresponding private key in the guest
build artifacts. Making it possible to use an ephemeral,
userspace-provided key avoids shipping a static policy-signing private
key with the guest rootfs.

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 security/ipe/Kconfig                            | 16 +++++++++++++
 security/ipe/Makefile                           |  2 ++
 security/ipe/ipe.c                              |  4 ++++
 security/ipe/keyring.c                          | 30 +++++++++++++++++++++++++
 security/ipe/keyring.h                          | 17 ++++++++++++++
 security/ipe/policy.c                           | 17 ++++++++++++++
 7 files changed, 87 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..9fabbc1c95b6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -23,6 +23,7 @@
 	HW	Appropriate hardware is enabled.
 	HYPER_V HYPERV support is enabled.
 	IMA     Integrity measurement architecture is enabled.
+	IPE	Integrity Policy Enforcement is enabled.
 	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
 	IPV6	IPv6 support is enabled.
 	ISAPNP	ISA PnP code is enabled.
diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index a110a6cd848b..5c51da074264 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -51,6 +51,22 @@ config IPE_POLICY_SIG_PLATFORM_KEYRING
 
 	  If unsure, answer Y.
 
+config SECURITY_IPE_KEYRING
+	bool "IPE policy keyring"
+	default n
+	help
+	  This option creates the .ipe keyring, which allows trusted
+	  userspace to provision certificates for IPE policy signature
+	  verification. IPE uses the keyring only after userspace has added
+	  at least one certificate and applied a reject-all restriction.
+
+	  Enable this only when the userspace component that provisions and
+	  restricts the keyring is part of the system's trusted computing
+	  base. Such systems must also prevent unauthorized kexec, which
+	  would start a new kernel without preserving the keyring state.
+
+	  If unsure, answer N.
+
 menu "IPE Trust Providers"
 
 config IPE_PROP_DM_VERITY
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 2ffabfa63fe9..78161dfb48ea 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -25,6 +25,8 @@ obj-$(CONFIG_SECURITY_IPE) += \
 	policy_parser.o \
 	audit.o \
 
+obj-$(CONFIG_SECURITY_IPE_KEYRING) += keyring.o
+
 clean-files := boot_policy.c \
 
 obj-$(CONFIG_SECURITY_IPE_KUNIT_TEST) += \
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 495bb765de1b..ee8731eb4070 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -7,6 +7,7 @@
 #include "ipe.h"
 #include "eval.h"
 #include "hooks.h"
+#include "keyring.h"
 
 extern const char *const ipe_boot_policy;
 bool ipe_enabled;
@@ -97,4 +98,7 @@ DEFINE_LSM(ipe) = {
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
 	.initcall_fs = ipe_init_securityfs,
+#ifdef CONFIG_SECURITY_IPE_KEYRING
+	.initcall_late = ipe_keyring_init,
+#endif
 };
diff --git a/security/ipe/keyring.c b/security/ipe/keyring.c
new file mode 100644
index 000000000000..8502f825945d
--- /dev/null
+++ b/security/ipe/keyring.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/key.h>
+
+#include "keyring.h"
+
+struct key *ipe_keyring __ro_after_init;
+
+/**
+ * ipe_keyring_init() - Allocate and configure the IPE keyring.
+ *
+ * Return: Always %0.
+ */
+int __init ipe_keyring_init(void)
+{
+	ipe_keyring =
+		keyring_alloc(".ipe", GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+			      current_cred(), KEY_POS_SEARCH |
+				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE |
+				KEY_USR_SEARCH | KEY_USR_SETATTR,
+			      KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+	if (IS_ERR(ipe_keyring))
+		panic("failed to allocate \".ipe\" keyring");
+	return 0;
+}
diff --git a/security/ipe/keyring.h b/security/ipe/keyring.h
new file mode 100644
index 000000000000..d9a057a14978
--- /dev/null
+++ b/security/ipe/keyring.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef _IPE_KEYRING_H
+#define _IPE_KEYRING_H
+
+#include <linux/init.h>
+
+struct key;
+
+extern struct key *ipe_keyring;
+
+int __init ipe_keyring_init(void);
+
+#endif /* _IPE_KEYRING_H */
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index e542329726bc..514a1985b5e1 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -4,11 +4,13 @@
  */
 
 #include <linux/errno.h>
+#include <linux/key.h>
 #include <linux/verification.h>
 
 #include "ipe.h"
 #include "eval.h"
 #include "fs.h"
+#include "keyring.h"
 #include "policy.h"
 #include "policy_parser.h"
 #include "audit.h"
@@ -160,6 +162,9 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 				  const char *pkcs7, size_t pkcs7len)
 {
 	struct ipe_policy *new = NULL;
+#ifdef CONFIG_SECURITY_IPE_KEYRING
+	struct key_restriction *restriction;
+#endif
 	int rc = 0;
 
 	new = kzalloc_obj(*new);
@@ -188,6 +193,18 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 						    VERIFY_USE_PLATFORM_KEYRING,
 						    VERIFYING_UNSPECIFIED_SIGNATURE,
 						    set_pkcs7_data, new);
+#endif
+#ifdef CONFIG_SECURITY_IPE_KEYRING
+		if (rc == -ENOKEY || rc == -EKEYREJECTED) {
+			restriction = READ_ONCE(ipe_keyring->restrict_link);
+			if (READ_ONCE(ipe_keyring->keys.nr_leaves_on_tree) &&
+			    restriction &&
+			    READ_ONCE(restriction->check) == restrict_link_reject)
+				rc = verify_pkcs7_signature(NULL, 0, new->pkcs7,
+							    pkcs7len, ipe_keyring,
+							    VERIFYING_UNSPECIFIED_SIGNATURE,
+							    set_pkcs7_data, new);
+		}
 #endif
 		if (rc)
 			goto err;

-- 
2.53.0



