Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486AAC433EF
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Poi7jXD7fpo/w+AwvGpCPOIkQzV5EZe5rEXr4DVPTFA=; b=iveULxhA0Hfn7+
	PYnl+PeExkkrpy/x/CjihgnWGeHiWTu97d4lZi4F+2gFkbbsZfRmKSaATUxoUICDHfHkbQDsSTVv1
	64c9bdtG95bqrWG6HLfWiIJ4RB1NQFJvM+xF+AFjO261GuF7YidB1w92xRpZmUGBLIfsgsavrpN33
	9VCaQ1n2AW1d45b8Hq7rIjrcVC7B4muudLwkD/LMBVP4Ta+NuiYWstmruK8nqAavVw3P/edu/R3kc
	BKY6gOZr+psOD8sfIADzBTVjXeogNd96mhc8khb8Qr2BUjhLU5/nTL7gq+UkR9ZHdpuZSQDqrNlQM
	K1tnfG1UFgOJ7hbL/uvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz5C-00EoGU-6N; Thu, 14 Jul 2022 13:40:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz58-00EoDH-GI
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 13:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657806040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PG1WsGRWRvVRe8I3xrLjHusVh6PAsG2ZTZ2d691+jyw=;
	b=IT35p+qTE8IQ1UYUkgFa+1+I29582oiNjdHSUe/fT/EJYOiJ9zTXexuRL1eJ/dxYaXfQIo
	pqmTtXRyeL1ImW3UGCrFsE4cvVAoMrc4ldlv5/sTUNdyW7IHaPdmto9i+WeWBaCQG3K9Ns
	UKrxa24oPWFbtxD6LgrwLktLXzHXv6A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-witK2VuIPi6JDRZmnhvmfQ-1; Thu, 14 Jul 2022 09:40:39 -0400
X-MC-Unique: witK2VuIPi6JDRZmnhvmfQ-1
Received: by mail-pj1-f69.google.com with SMTP id rm8-20020a17090b3ec800b001f07b25d636so1397745pjb.1
        for <kexec@lists.infradead.org>; Thu, 14 Jul 2022 06:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PG1WsGRWRvVRe8I3xrLjHusVh6PAsG2ZTZ2d691+jyw=;
        b=Woip4Ej2ntWG2QFAsXhJ6Jc4kfRAnVX7++5apWOH5cpI2aZsBtQkJ/62m/fDutQNYC
         MIf8v+Rs09L/j3hfnuk0AvyGmFJtofOk//rilufizBl7tn9vZXn3zq80wxFh7qyG86CZ
         r3dyQm35rgyVUcRmR08qkd0jdXQ41y9WEUirNCi2mBVCda+K476opORQ3aIJl+xBqhi8
         wBcFKLIRdjSTFhLX3IQklAo16phH4l4XIwHv9DHzAVtLg5XfOgMVrrOjQyJeX37ZDmKK
         pl6Dy4nKpeNjIC9wbTNeyPpDZEzokhdJXFTTe2F/D2iz5QEoFjy0em5bRPQZz1fxnPNv
         QyYg==
X-Gm-Message-State: AJIora/XAbAuecEYx5cXgzJizJ6q9MZtzFcMWJ9E3fTjU8Qk72GyVajA
	ayweUyOMfQmdHzaS6eNMgqXtBr3Zzuk1+bwRdkX+WBw8ozVYUkDel9WQMoEZQIVJGBKN6bwYdQE
	UVKU4t6P6bZeriH3Gzg4G3l7zonQ+J10l8XHJUhUpCR5LkOueFUtynzD97qXwzPcUTOU=
X-Received: by 2002:a63:68c7:0:b0:405:1da9:ab69 with SMTP id d190-20020a6368c7000000b004051da9ab69mr7922165pgc.233.1657806037078;
        Thu, 14 Jul 2022 06:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uVKyvFxKJJVTEcre0pPRg6laUS8s7uC3NACW6lW/xJmM7S6uGd27qyh4tX8GUQRRZJI8PDrg==
X-Received: by 2002:a63:68c7:0:b0:405:1da9:ab69 with SMTP id d190-20020a6368c7000000b004051da9ab69mr7922129pgc.233.1657806036590;
        Thu, 14 Jul 2022 06:40:36 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b0016a0bf0ce32sm1489511plk.70.2022.07.14.06.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:40:36 -0700 (PDT)
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
Subject: [PATCH v10 0/4] unify the keyrings of arm64 and s390 with x86 to verify kexec'ed kernel signature
Date: Thu, 14 Jul 2022 21:40:23 +0800
Message-Id: <20220714134027.394370-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_064042_640733_D68D9C87 
X-CRM114-Status: GOOD (  21.25  )
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

The 3rd arm64 patch depends on Naven's patch "[PATCH 1/2] kexec_file:
Drop weak attribute from functions" [2] and the first two patches.
With Naven's patch first applied to the next-integrity branch, I can
confirm these patches are directly appliable to the next-integrity
branch without any conflict. The 4th s390 patch can be applied
independently.

In v9, I've tested the patch set on 5.19.0-rc2 and it works as expected.

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

v10:
 - resolve conflict with Naveen's patch which drops weak attribute of
   arch_kexec_kernel_verify_sig

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
[2] https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/#mbd23f46b3714c3c9eecc7484c832a5af49bfa340

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
 kernel/kexec_file.c                   | 50 ++++++++++++++++-----------
 5 files changed, 49 insertions(+), 56 deletions(-)

-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
