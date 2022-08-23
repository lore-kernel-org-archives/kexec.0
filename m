Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35672C32774
	for <kexec@archiver.kernel.org>; Tue, 23 Aug 2022 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZnEhXQQhxjWnOvgwxDJHTOm5d3eBugAqqDcMeCfLafY=; b=xVXOrwSEj/wrbe
	TZxWrVSisnomPo2HQK/500yFvwkw5/jvr5vr6SQftzhsSH3hHx7R49kqDsYzr4m2TOVf2dM2xnY/7
	7TTXeCbcVUF92n8Zgf4k43Z5sYM52lW+W8bb+FL8dOdl26BAVrpO6+a4N7gnaghucf+A58pz9zkfb
	UgJRsbzkS1aaaiIfdcBofl5Tu4TaBVOESTLKYc3RRSDYJtKb06ViN+LsoYyYT+cvL3WyQ/ji162pP
	gKxCSN4xyUN6DR1TFTvfs/aw3SZbZYSniDM9peFXQr5BKhPRWlNg9MkT7SCcDSsVH79EzAEwuQsJR
	yQAMkvAXIyXul8luebJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQQFy-004VNj-NZ; Tue, 23 Aug 2022 09:31:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQQCr-004TgK-5X
	for kexec@lists.infradead.org; Tue, 23 Aug 2022 09:28:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D22F361342;
	Tue, 23 Aug 2022 09:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE792C433C1;
	Tue, 23 Aug 2022 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1661246896;
	bh=QdEMINy4DpflPJbO9OpDwJFttTM7M9zPcsVxmvhY6PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsIBZnRv52wiDsJ0+Elba6BTP6RyWoGLIraj348FHlb57TvvEL7ahMuR3Nu22wkhA
	 YqpV1c7nCO02SirpHbNV4RgquTEuXkZZdglp6iWvY0fpzTP4P9orSG9A9VbIh/25Z5
	 gf6jvoMa72Dn6caMfj7DFhpfBbQE1TqPUhhaGqFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Rudo <prudo@linux.ibm.com>,
	kexec@lists.infradead.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Michal Suchanek <msuchanek@suse.de>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Baoquan He <bhe@redhat.com>,
	Coiby Xu <coxu@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.4 254/389] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date: Tue, 23 Aug 2022 10:25:32 +0200
Message-Id: <20220823080126.207983967@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_022827_542752_20EF10C2 
X-CRM114-Status: GOOD (  11.95  )
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

From: Michal Suchanek <msuchanek@suse.de>

commit 0828c4a39be57768b8788e8cbd0d84683ea757e5 upstream.

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/machine_kexec_file.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -29,6 +29,7 @@ int s390_verify_sig(const char *kernel,
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -63,11 +64,18 @@ int s390_verify_sig(const char *kernel,
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(kernel, kernel_len,
+				     kernel + kernel_len, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(kernel, kernel_len,
+					     kernel + kernel_len, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
 #endif /* CONFIG_KEXEC_SIG */
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
