Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4ABEEB56E
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WG7J1PEZdfvwyOdRCTII5IKwiRtNJ9fT3hZhb6mmyfY=; b=OkCExgySlTkk7z
	lmzxQvWIYNJgYg4BrAihtAS/cETf9XjGym/+w1FMXvmTTJpzB4/mN7Yn4xWKIAOB76QRK06pSOAdT
	crfp4w+oxxVGF0q6hpNP8NDUD8Ky5PWz3rlo0F+PWlo/JdnMrZ7i3b3QD7pIdCEaO9oj7uB5NUyDb
	uH82tJACTbWF7QlwAflEscL3cV7waXEuE9VKxnPglsFjVmNvAcwsQtqUYjJ5UTEXZ3IEyiWx3umqk
	dsiZ6HxXCt/zsBIoj71UM9EiXBCEzdy8y5x/aYBHK9oqh98AyxyzRts+T8VB588NU8A6ufRc9XkDK
	1zras7u+3dVE+UATtNTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qekew-00EfxZ-2k;
	Fri, 08 Sep 2023 23:13:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qekeu-00EfxF-1f
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 23:13:06 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388HqD5C030687
	for <kexec@lists.infradead.org>; Fri, 8 Sep 2023 16:13:02 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t06jvvkdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 16:13:02 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 8 Sep 2023 16:13:01 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
	id 01CBF24087ED5; Fri,  8 Sep 2023 16:12:48 -0700 (PDT)
From: Song Liu <song@kernel.org>
To: <linux-kernel@vger.kernel.org>
CC: <ndesaulniers@google.com>, Song Liu <song@kernel.org>,
        Ricardo Ribalda
	<ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, <kexec@lists.infradead.org>,
        <x86@kernel.org>, <llvm@lists.linux.dev>
Subject: [PATCH v2] x86/purgatory: Remove LTO flags
Date: Fri, 8 Sep 2023 16:12:44 -0700
Message-ID: <20230908231244.1092614-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-FB-Internal: Safe
X-Proofpoint-GUID: ryHDu0A_a97RCNG672_ogBzDAXw_r3AW
X-Proofpoint-ORIG-GUID: ryHDu0A_a97RCNG672_ogBzDAXw_r3AW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_18,2023-09-05_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_161304_687781_994DA2A3 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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

With LTO enabled, ld.lld generates multiple .text sections for
purgatory.ro:

$ readelf -S purgatory.ro  | grep " .text"
  [ 1] .text             PROGBITS         0000000000000000  00000040
  [ 7] .text.purgatory   PROGBITS         0000000000000000  000020e0
  [ 9] .text.warn        PROGBITS         0000000000000000  000021c0
  [13] .text.sha256_upda PROGBITS         0000000000000000  000022f0
  [15] .text.sha224_upda PROGBITS         0000000000000000  00002be0
  [17] .text.sha256_fina PROGBITS         0000000000000000  00002bf0
  [19] .text.sha224_fina PROGBITS         0000000000000000  00002cc0

This cause WARNING from kexec_purgatory_setup_sechdrs():

WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
kexec_load_purgatory+0x37f/0x390

Fix this by disabling LTO for purgatory.

Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
Cc: Ricardo Ribalda <ribalda@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Song Liu <song@kernel.org>

---
AFAICT, x86 is the only arch that supports LTO and purgatory.

Changes in v2:
1. Use CC_FLAGS_LTO instead of hardcode -flto. (Nick Desaulniers)
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index c2a29be35c01..08aa0f25f12a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
 # optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
 
+# When LTO is enabled, llvm emits many text sections, which is not supported
+# by kexec. Remove -flto=* flags.
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
