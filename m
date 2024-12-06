Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3A3E7716E
	for <kexec@archiver.kernel.org>; Fri,  6 Dec 2024 02:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoABF8CKbzP0DlqAE1ugIaL0VmIlQw+M3/r+TkryE7s=; b=MNoOSQXU1dezPZ3kU/aThujmhP
	zHni1Z/NjvtGdF1T0UUnmKzKqkERDaDLbBiwYF4pHfxEgFhbPZXKNVLVLTeiNpClaxxL0aI1sRu8D
	LYhwa5Yc26NbEApAVpfW5lPlgSMBXlepZvnw6P5/QHNrZGD1mJAJRHEJnagAIc0hmovaMAsBNBoPU
	NplmRmLwAIGQRHAGepWe79KI4VDBYwCwBQ80KkrJXNZNHfapGMXLtjDwRwRvp3Iz68j8n4SrNDmKR
	rTNyuYLOzufz371QEQFzXHD+o+0HZkw81KrjKZmlsnUHDqkdYD9nUbBF8h2TksNm445ZanOOjTAX2
	GDkEaz2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNno-00000000IPA-0hFc;
	Fri, 06 Dec 2024 02:10:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNnk-00000000IO7-3dqd
	for kexec@lists.infradead.org;
	Fri, 06 Dec 2024 02:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoABF8CKbzP0DlqAE1ugIaL0VmIlQw+M3/r+TkryE7s=;
	b=H0sQcZ5maLF4dKL31A7Uqedu1AOzfh2j2M+ofY/IdpW0+/ynjFDGz1gV+V7Def+dPn3r6i
	QWbGeNn1JOVMl8BevbQvMWL35NA8mPpek+SctUa07J3dy7tx0wOgMvpB2aMJoGbjqrvu/y
	9Zx5gCsY/qH2X7gUssoQk/Vmj6/kEzg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-xRx4sDLZM5yfFpzuN9qhUw-1; Thu,
 05 Dec 2024 21:10:36 -0500
X-MC-Unique: xRx4sDLZM5yfFpzuN9qhUw-1
X-Mimecast-MFC-AGG-ID: xRx4sDLZM5yfFpzuN9qhUw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C9171956057;
	Fri,  6 Dec 2024 02:10:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.101])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 232941955F3F;
	Fri,  6 Dec 2024 02:10:30 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 2/2] kexec: Introduce KEXEC_SIGN_IMAGE config option
Date: Fri,  6 Dec 2024 10:09:57 +0800
Message-ID: <20241206021000.8953-3-piliu@redhat.com>
In-Reply-To: <20241206021000.8953-1-piliu@redhat.com>
References: <20241206021000.8953-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zNTGJiZFcM6U19iRHZ2-FZGsC0_CKr_NHTadYS85nyc_1733451035
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_181040_971859_E8D48204 
X-CRM114-Status: UNSURE (   8.94  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Only when kexec_file_load checks the signature and Image is packed into
EFI-STUB, the internal Image should be signed.  Furthermore, it is
signed with the module key.

Using the configuration condition to reflect the above dependency.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
To: kexec@lists.infradead.org
---
 kernel/Kconfig.kexec | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4d111f871951..cb8afe8e17e5 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -69,6 +69,15 @@ config KEXEC_SIG_FORCE
 	  This option makes kernel signature verification mandatory for
 	  the kexec_file_load() syscall.
 
+config KEXEC_SIGN_IMAGE
+	bool "Sign Image before it is packed into EFI stub"
+	depends on KEXEC_SIG && EFI_STUB && MODULE_SIG
+	default y
+	help
+	  This option utilizes the module signing key to sign the kernel
+	  inside EFI stub shell. So the internal kernel can pass through
+	  the signature verification.
+
 config KEXEC_IMAGE_VERIFY_SIG
 	bool "Enable Image signature verification support (ARM)"
 	default ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
-- 
2.41.0


