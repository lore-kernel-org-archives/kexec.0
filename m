Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EEAC43334
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 01:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AUtDkPiddTzUyh32/3IY2M3JuQCIl6Fx8pM2iIA+8ng=; b=rk99Zd8dWhlUQG
	t2omCBWimcp8jiHTnSg3s4qdM/aUdwEBOWBFxcOaco3YqfWgqIzPIM2KVWVQFwRVCQKw8dEw5w8JP
	bjqLHjzaTJU4J1GQ7O4Gm+OUK08Y2V1kpTwrjjOK6coF0HoK434K4FQNYUmzeszLW3OLq4Pdfy0hN
	IPAkNswhRBp2o0UNkjAgar96fhrm6nM0Yuk0M1jQNd65X03fvwS5TEfA8z6ZMqaAiGVw7sYBGY31B
	AXOKItLrHVIHFS1Tvcj0CTBsbGxw64u5iARe645TSkdQO/0WYEAqUXHwlXIVs7+0IaU8tHOt/hNE6
	zYpOnIh4b7DfNLiilkjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BGL-0037Jm-SJ; Mon, 04 Jul 2022 01:52:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BGB-0037BW-2a
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 01:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656899542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FG09NB0u+itbKukOM5H/RLays7V1RS1EZPZR3jC98rI=;
	b=QTFeVpGnSyOihPu1QdWVtdZbxXW6DdTLhp0nD2xhrNuKzGaxaZjCQXkPaOTa+OWZQdnFRR
	slEOshuP9ynvTGVjREQX30Uv25yWvWclTMZCnr1l1f+Js7jnSBU8ukjx4U9mFlI2q58PZL
	A0RxxSFofterQfFBQEt1wRNFJkHJlbg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-iK2tD7UBMyaplq7U6BB3iQ-1; Sun, 03 Jul 2022 21:52:15 -0400
X-MC-Unique: iK2tD7UBMyaplq7U6BB3iQ-1
Received: by mail-pl1-f199.google.com with SMTP id h18-20020a170902f55200b0016a4a78bd71so4282493plf.9
        for <kexec@lists.infradead.org>; Sun, 03 Jul 2022 18:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FG09NB0u+itbKukOM5H/RLays7V1RS1EZPZR3jC98rI=;
        b=Umbz5qD+YrAr3kEYSvMXvwBR9/bjb9votRUFLnCu6l1042pOPis4EMxRxFPlFAUmMa
         09r/qMUzlS9gT5Mz6nRQltF4ssskktvUf5WHometwLmAKfaK68eFRPtYdlyIsK94hdgg
         QtGg4IsMCGXf1vpRLwe1IOWVxMWYBZwYoiU1t3gp9XkPbaOjtBXLBKg/U/xTPp9ong8Y
         yVN8CNGgK6BTcr9HmRgTCuSPVq/vGwWgNN1+ehmDKxNtUufEI3eBh1uDESXmTWB+DgPe
         mzHmvlQx68ArPwpGIsfP9dnNPX2fnscXheDOsWBZf66l8acGghrpiaoADFquHSgWzy8J
         LK9A==
X-Gm-Message-State: AJIora/cQ984V0AbJZScJ9g7S/3VkVMm7ljfMzPFsdx4qaO9HM9dyrBY
	3Q/1bxkWaGHC3Q5wxxvLjcWZ66/UTiKWQYVHKGj+slRaowELXqfWm6bvJGvgVF4IVvJSsgq2ruu
	Dk4+HjZCrKT8HCu1+ovRxUr7PeBxbZD+c/XdGlNQkBPdn65hQuTRHTt7+25Yq2HJcLXo=
X-Received: by 2002:a17:902:d292:b0:16b:e6a4:5768 with SMTP id t18-20020a170902d29200b0016be6a45768mr979399plc.128.1656899533837;
        Sun, 03 Jul 2022 18:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tg48NWmOzfaIjIwWMZGLTLkGUFf7ZRE5pa/sLMc785xjASL9MdcB56k/sQgVST+0LLk+zSIw==
X-Received: by 2002:a17:902:d292:b0:16b:e6a4:5768 with SMTP id t18-20020a170902d29200b0016be6a45768mr979365plc.128.1656899533455;
        Sun, 03 Jul 2022 18:52:13 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a25-20020aa79719000000b0052551c1a413sm19825856pfg.204.2022.07.03.18.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:13 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to verify kexec'ed kernel signature
Date: Mon,  4 Jul 2022 09:51:57 +0800
Message-Id: <20220704015201.59744-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_185223_222545_70571918 
X-CRM114-Status: GOOD (  19.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Currently when loading a kernel image via the kexec_file_load() system
call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
.secondary_trusted_keys and .platform keyrings to verify a signature.
However, arm64 and s390 can only use the .builtin_trusted_keys and
.platform keyring respectively. For example, one resulting problem is
kexec'ing a kernel image  would be rejected with the error "Lockdown:
kexec: kexec of unsigned images is restricted; see man
kernel_lockdown.7".

This patch set enables arm64 and s390 to make use of the same keyrings
as x86 to verify the signature kexec'ed kernel image.

The recently introduced .machine keyring impacts the roots of trust by
linking the .machine keyring to the .secondary keyring. The roots of
trust for different keyrings are described as follows,

.builtin_trusted_keys:

Keys may be built into the kernel during build or inserted into memory
reserved for keys post build. The root of trust is based on verification
of the kernel image signature. For example, on a physical system in a
secure boot environment, this trust is rooted in hardware.

.machine:

If the end-users choose to trust the keys provided by first-stage UEFI
bootloader shim i.e. Machine Owner Keys (MOK keys), the keys will be
added to this keyring which is linked to the .secondary_trusted_keys
keyring as the same as the .builtin_trusted_keys keyring. Shim has
built-in keys from a Linux distribution or the end-users-enrolled keys.
So the root of trust of this keyring is either a Linux distribution
vendor or the end-users.

.secondary_trusted_keys:

Certificates signed by keys on the .builtin_trusted_keys, .machine, or
existing keys on the .secondary_trusted_keys keryings may be loaded
onto the .secondary_trusted_keys keyring. This establishes a signature
chain of trust based on keys loaded on either the .builtin_trusted_keys
or .machine keyrings, if configured and enabled.

.platform:

The .platform keyring consist of UEFI db and MOK keys which are used by
shim to verify the first boot kernel's image signature. If end-users
choose to trust MOK keys and the kernel has the .machine keyring
enabled, the .platform keyring only consists of UEFI db keys since the
MOK keys are added to the .machine keyring instead. Because the
end-users could also enroll their own MOK keys, the root of trust could
be hardware and the end-users.

The 3rd arm64 patch depends on the first two patches. The 4th s390 patch
can be applied independently.

I've tested the patch set on 5.19.0-rc2 and it works as expected. 

For arm64, the tests were done as follows,
  1. build 5.19.0-rc2
  2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
     db;
  3. sign different kernel images with different keys including keys
     from .builtin_trusted_key, .secondary_trusted_keys keyring, a UEFI db
     key and MOK key
  4. Without lockdown, all kernel images can be kexec'ed; with lockdown
     enabled, only the kernel image signed by the key from the
     .builtin_trusted_key keyring can be kexec'ed

For 390, I commented out the code that skips signature verification when
secure boot is not enabled since the testing machine doesn't supports
secure boot and can confirm before applying the patch, kernel images
signed by keys from .builtin_trusted_key, .secondary_trusted_keys
couldn't be kexec'ed when lockdown is enabled; after applying the patch,
those kernel images could be kexec'ed.

v9:
 - improve cover letter, subject line and commit messages, expecially
   regarding the root of trust of different keyrings and the .machine
   keyring [Mimi]
 - fix two code format issues [Mimi]
 - add test results [Mimi]

v8:
 - drop "Cc: stable@vger.kernel.org" for the first two prerequisite
   patches [Baoquan]

v7:
 - drop the Fixes tag for the 2nd patch and add patch prerequisites
   [Baoquan]
 - improve cover letter

v6:
 - integrate the first three patches of "[PATCH 0/4] Unifrom keyring
   support across architectures and functions" from Michal [1]
 - improve commit message [Baoquan, Michal]
 - directly assign kexec_kernel_verify_pe_sig to
   kexec_file_ops->verify_sig [Michal]

v5:
 - improve commit message [Baoquan]

v4:
 - fix commit reference format issue and other checkpatch.pl warnings [Baoquan]

v3:
 - s/arch_kexec_kernel_verify_pe_sig/kexec_kernel_verify_pe_sig [Eric]
 - clean up arch_kexec_kernel_verify_sig [Eric]

v2:
 - only x86_64 and arm64 need to enable PE file signature check [Dave]

[1] https://lore.kernel.org/lkml/cover.1644953683.git.msuchanek@suse.de/

Coiby Xu (3):
  kexec: clean up arch_kexec_kernel_verify_sig
  kexec, KEYS: make the code in bzImage64_verify_sig generic
  arm64: kexec_file: use more system keyrings to verify kernel image
    signature

Michal Suchanek (1):
  kexec, KEYS, s390: Make use of built-in and secondary keyring for
    signature verification

 arch/arm64/kernel/kexec_image.c       | 11 +-----
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++---
 arch/x86/kernel/kexec-bzimage64.c     | 20 +----------
 include/linux/kexec.h                 |  6 ++--
 kernel/kexec_file.c                   | 51 ++++++++++++++++-----------
 5 files changed, 49 insertions(+), 57 deletions(-)

-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
