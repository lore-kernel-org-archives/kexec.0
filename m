Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE64C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:Cc:To
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1CAJ2ykni84cNYD0RIjpGNdB6siaTRNnnT0m3UDVilY=; b=fFFk6e6vVBX+FW
	017grjPt6yn8JYAHf0xLSpepHt9d4PhaYE2myxpIs0NFgJStd2P+SG3bl5Guvn/f13lYKwX7h++1P
	B05C7X2UI5hh+e3KJ/Vm3QwZ8rggw54MxRf9R4GlpZsEq4zDv13MjDzItkUbVweIky7x+pvxhLCYc
	VdIjCdstaO1ZzwLjWkg2OfLCZruPnT3snkx8lv5bOHDJQjlVzHCKWt77pAnkd4h/igS1wIZQJdSPA
	zekgy5OFY2Q9S7QOPe4oF2eg4Dgf9z5Yl3oPXM1n9Ud+VwyFMtMOnf+2yyWRYrgwQ5KB0ZxAuqE/C
	JsIZw20956NxJg70ZL2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNXq8-00F3i3-MI; Mon, 15 Aug 2022 11:01:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNXpb-00F3F5-3L
	for kexec@lists.infradead.org; Mon, 15 Aug 2022 11:00:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4A3AB6110F;
	Mon, 15 Aug 2022 11:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0F5C433D6;
	Mon, 15 Aug 2022 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1660561225;
	bh=HRuOOcBQD05g4ZM3OI4Cal83GlkDdaDFartm2XUyyQY=;
	h=Subject:To:Cc:From:Date:From;
	b=WAVtCpowVTckwlOy9oBbVF7/hKkNinC+tuwOt/bSd5Bbp95pIwgOs+A+i6tpf2DRg
	 n5T29fmM09csZHT49yuI5Mez6lQKuT3Ax37hLzwmGvMiBawGtjPpkbYeu8X+JUD8RZ
	 0/XhXeykMo//DIyJBJtOA0oWr824pFFKWCk+7irM=
Subject: Patch "kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification" has been added to the 5.4-stable tree
To: bhe@redhat.com,coxu@redhat.com,gregkh@linuxfoundation.org,hca@linux.ibm.com,jlee@suse.com,kexec@lists.infradead.org,msuchanek@suse.de,prudo@linux.ibm.com,zohar@linux.ibm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Aug 2022 13:00:22 +0200
Message-ID: <16605612226641@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220815_040027_341321_A9DD90BC 
X-CRM114-Status: GOOD (  15.23  )
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


This is a note to let you know that I've just added the patch titled

    kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     kexec-keys-s390-make-use-of-built-in-and-secondary-keyring-for-signature-verification.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 0828c4a39be57768b8788e8cbd0d84683ea757e5 Mon Sep 17 00:00:00 2001
From: Michal Suchanek <msuchanek@suse.de>
Date: Thu, 14 Jul 2022 21:40:27 +0800
Subject: kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification

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
 


Patches currently in stable-queue which might be from msuchanek@suse.de are

queue-5.4/kexec-keys-s390-make-use-of-built-in-and-secondary-keyring-for-signature-verification.patch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
