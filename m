Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86808C4332F
	for <kexec@archiver.kernel.org>; Fri, 30 Dec 2022 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g5kCXexNT/j9en/dYd3SOR7JbrWJnjM+9qmsTwQ7ADA=; b=h1SkyNyv3wi0ol
	X2EM04E1jg2Xs8aBkV/axUvjpyVWW5X3Qa9Nqsc2eFffLvwlahlXoNbzV6U97oT7dsuUGMTojTitB
	YuAltjXUGPcRbVp78c/Ft+jytf/V1Pay1FRgrRoI+rot18L5simAJTWnX9mPJnOc2Bu5dyynt5q1v
	6Hx4uSYaNAX/PuDoksBClSpYenZhc1TGiHwgFU7k5BVvZBcBgz7y6O0snEKlDss+poAmC7SrCX1iy
	8qUU1qW6frSFu5YkC5MMYpC3M7WJ36QIhieENrgaV2ODBsx4l5NhZ/QwgCLlcEZm5kZAB81eBkYs2
	C8tsa8Q2nG7Wj9mB5Bxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pB9Mi-006fPV-0e; Fri, 30 Dec 2022 06:59:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pB9MB-006f52-8H
	for kexec@lists.infradead.org; Fri, 30 Dec 2022 06:59:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1672383543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfQVFUk68QjEj99AgM4T7hbGZN2TqICY24ExGXMOCJA=;
	b=NazmobyWMN61Lb2ehOtmz3K44iWPZpI1U2K+919Ugi94z2hE0Rfx3FA0OZ4x6dRluUX/gw
	yzbyiich/pmiggyqiso8gHy2GXSN4o6LdNzOEVuVNE4PiXd5QOz81wKMJxV3nI3UdDjzBN
	fRPEg9lmIbafTSNj6V49We++8kd/zbs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-410-yi0Zy9OcNEiLwRfkiq7nqQ-1; Fri, 30 Dec 2022 01:59:02 -0500
X-MC-Unique: yi0Zy9OcNEiLwRfkiq7nqQ-1
Received: by mail-pl1-f200.google.com with SMTP id m13-20020a170902f64d00b001899a70c8f1so15224420plg.14
        for <kexec@lists.infradead.org>; Thu, 29 Dec 2022 22:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfQVFUk68QjEj99AgM4T7hbGZN2TqICY24ExGXMOCJA=;
        b=yPd84ZAmqCzLhHseyXHXC7FZa6PwdYlyfzDI10/FNhx0pBUoe385dJ5wmbupm5y1wu
         dbpIf+OSj19ZuTxcY1BoyCJgA9wTEM8KdGb+cQd1xKrPb1LusqNcGAROuLRV/+lKNKJm
         PzwWASKA25aeIuzjLz5R2a3g13GZ+m6lQ/bVVbFiN+IpBEND9btXf6Uy2/QVLyE+3i/8
         FLtpTnWTUGbUf5tWcQ4HWupBwsUq19BA2kEISHkSkZdjK5FHKr46ftujMuWHTXAbaDr2
         VXACNLD4UdzsjnnTeoPszI7O3/80l+7i9/+7qdt2pFE4aU3efeakJ/j8Hz7vGdWmQijz
         nNKA==
X-Gm-Message-State: AFqh2krRM1fxGK1rNKotFCFNdJx/BmLGAyQL9OpCX/tS8oDMEZlW1MJ0
	uyZ45ja0GzQjBhZcnByjh+eEU2RL4sKRuUQetzFPXd3fwffVjdti7WIVx+ff1jtQDENgT/QTLBu
	tZSrof4+utSEcdaeelnG0NN9XPmndW0+prQyzM7RzN03enhPh7Fb71hy+6nHD6o/B9K0=
X-Received: by 2002:a17:902:d3d3:b0:192:8f38:7492 with SMTP id w19-20020a170902d3d300b001928f387492mr10901750plb.13.1672383539923;
        Thu, 29 Dec 2022 22:58:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvgQSu4eJrF7t9Ee8jFtrdmW2Mfrqq37xxbhi3CqTIuwlP91hv2uCBIjFGbYTi7mF+inP0IYw==
X-Received: by 2002:a17:902:d3d3:b0:192:8f38:7492 with SMTP id w19-20020a170902d3d300b001928f387492mr10901731plb.13.1672383539523;
        Thu, 29 Dec 2022 22:58:59 -0800 (PST)
Received: from localhost ([240e:478:10:2273:12cf:a540:d79b:db49])
        by smtp.gmail.com with ESMTPSA id ij6-20020a170902ab4600b00176e6f553efsm14012757plb.84.2022.12.29.22.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 22:58:59 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/2] selftests/kexec: enable lockdown tests
Date: Fri, 30 Dec 2022 14:58:50 +0800
Message-Id: <20221230065850.897967-2-coxu@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230065850.897967-1-coxu@redhat.com>
References: <20221230065850.897967-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_225907_408321_8359CEA8 
X-CRM114-Status: GOOD (  12.15  )
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

When lockdown is enabled, kexec_load syscall should always fail.

For kexec_file_load, when lockdown is enabled, it should
 - fail of missing PE signature when KEXEC_SIG is enabled
 - fail of missing IMA signature when KEXEC_SIG is disabled

Before this patch, test_kexec_load.sh fails (false positive) and
test_kexec_file_load.sh fails without a reason when lockdown enabled and
KEXEC_SIG disabled,

    # kexec_load failed [FAIL]
    not ok 1 selftests: kexec: test_kexec_load.sh # exit=1
    # kexec_file_load failed [PASS]
    ok 2 selftests: kexec: test_kexec_file_load.sh

After this patch, test_kexec_load.sh succeeds and
test_kexec_file_load.sh fails with the correct reason when lockdown
enabled and KEXEC_SIG disabled,

    # kexec_load failed [PASS]
    ok 1 selftests: kexec: test_kexec_load.sh
    # kexec_file_load failed (missing IMA sig) [PASS]
    ok 2 selftests: kexec: test_kexec_file_load.sh

Cc: kexec@lists.infradead.org
Cc: linux-integrity@vger.kernel.org
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 .../selftests/kexec/kexec_common_lib.sh       | 16 +++++++++++
 .../selftests/kexec/test_kexec_file_load.sh   | 27 +++++++++++++++++++
 .../selftests/kexec/test_kexec_load.sh        | 12 ++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 641ef05863b2..06c298b46788 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -110,6 +110,22 @@ get_secureboot_mode()
 	return $secureboot_mode;
 }
 
+is_lockdown_enabled()
+{
+	local ret=0
+
+	if [ -f /sys/kernel/security/lockdown ] \
+	     && ! grep -qs "\[none\]" /sys/kernel/security/lockdown; then
+		ret=1
+	fi
+
+	if [ $ret -eq 0 ]; then
+		log_info "lockdown not enabled"
+	fi
+
+	return $ret
+}
+
 require_root_privileges()
 {
 	if [ $(id -ru) -ne 0 ]; then
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index c9ccb3c93d72..790f96938083 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -139,6 +139,16 @@ kexec_file_load_test()
 			log_fail "$succeed_msg (missing IMA sig)"
 		fi
 
+		if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 1 ] \
+		     && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing PE sig)"
+		fi
+
+		if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 0 ] && [ $ima_signed -eq 0 ] \
+		     && [ $ima_modsig -eq 0 ]; then
+			log_fail "$succeed_msg (missing IMA sig)"
+		fi
+
 		if [ $pe_sig_required -eq 0 ] && [ $ima_appraise -eq 1 ] \
 		    && [ $ima_sig_required -eq 0 ] && [ $ima_signed -eq 0 ] \
 	            && [ $ima_read_policy -eq 0 ]; then
@@ -181,6 +191,16 @@ kexec_file_load_test()
 		log_pass "$failed_msg (possibly missing IMA sig)"
 	fi
 
+	if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 1 ] \
+	    && [ $pe_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing PE sig)"
+	fi
+
+	if [ $lockdown -eq 1 ] && [ $kexec_sig_enabled -eq 0 ] \
+	    && [ $ima_signed -eq 0 ] && [ $ima_modsig -eq 0 ]; then
+		log_pass "$failed_msg (missing IMA sig)"
+	fi
+
 	log_pass "$failed_msg"
 	return 0
 }
@@ -215,6 +235,10 @@ kconfig_enabled "CONFIG_KEXEC_SIG_FORCE=y" \
 	"kexec signed kernel image required"
 kexec_sig_required=$?
 
+kconfig_enabled "CONFIG_KEXEC_SIG=y" \
+	"KEXEC_SIG enabled"
+kexec_sig_enabled=$?
+
 kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
 	"PE signed kernel image required"
 pe_sig_required=$?
@@ -225,6 +249,9 @@ ima_sig_required=$?
 get_secureboot_mode
 secureboot=$?
 
+is_lockdown_enabled
+lockdown=$?
+
 # Are there pe and ima signatures
 if [ "$(get_arch)" == 'ppc64le' ]; then
 	pe_signed=0
diff --git a/tools/testing/selftests/kexec/test_kexec_load.sh b/tools/testing/selftests/kexec/test_kexec_load.sh
index 49c6aa929137..0542887866c0 100755
--- a/tools/testing/selftests/kexec/test_kexec_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_load.sh
@@ -28,18 +28,24 @@ arch_policy=$?
 get_secureboot_mode
 secureboot=$?
 
-# kexec_load should fail in secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
+is_lockdown_enabled
+lockdown=$?
+
+# kexec_load should fail in either
+#   a) secure boot mode and CONFIG_IMA_ARCH_POLICY enabled
+# or
+#   b) lockdown enabled
 kexec --load $KERNEL_IMAGE > /dev/null 2>&1
 if [ $? -eq 0 ]; then
 	kexec --unload
-	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ]; then
+	if [ $secureboot -eq 1 -a $arch_policy -eq 1 ] || [ $lockdown -eq 1 ]; then
 		log_fail "kexec_load succeeded"
 	elif [ $ima_appraise -eq 0 -o $arch_policy -eq 0 ]; then
 		log_info "Either IMA or the IMA arch policy is not enabled"
 	fi
 	log_pass "kexec_load succeeded"
 else
-	if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] ; then
+	if [ $secureboot -eq 1 -a $arch_policy -eq 1 ] || [ $lockdown -eq 1 ]; then
 		log_pass "kexec_load failed"
 	else
 		log_fail "kexec_load failed"
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
