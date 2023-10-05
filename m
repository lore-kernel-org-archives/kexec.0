Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0800E92723
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TNBphJdNRm2l4NUdbMw87cAoUdQThoo8FAfgmQQbUbU=; b=vLOzmZrbQQULeH
	CoEEh/8BW/hWe7qKyOvOkpgCXXCMhigEZeuVVm+Eu7tck1uuaqfOefikPfNU8AXy+7nSKvIEPmC2t
	Fs4phupZMNogsyrNSQsR30PDSlashokBP5xF3DvXcUa8FluExwE99PBys5DJCZXQzzjSuioEnm7R9
	/WXY4ZJSB5JCw1vNC1Utkzy963gPOig9SO+Gk0CVbblV7w0o4EwBnkZCMPpE1NxEza+MB9Vkvaag9
	Zdbip2TkWzSZZqtKsbi7lBE+U51Bgw4cU5dFdaMFoLd9G2S7bVp6SH5rGwKvmplRdFJqYXrfsSf91
	dziNNwTMry84m8uk1/AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3C-004HSV-1j;
	Thu, 05 Oct 2023 18:26:18 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT37-004HPv-2S
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 18:26:15 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4FD0220B74C5;
	Thu,  5 Oct 2023 11:26:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FD0220B74C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696530373;
	bh=Udqv0jaboMhxWHknI6g5+GDLvPqkVFywTKuSTdC2gbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqSMC7bERhS0/N9DffbA9GM3BY+SW1tOE0W+Jh2x5uqnVbKTyjgIlB8ngOwdezyxc
	 05WBHartxAG3n2JcJcb1tcSE44PT/HLgJLdRVwqlRLdkRSonltLyrengvISLxTUMXq
	 GQLsQf09S+iFLhmHqu/NN8s7Dv/zDE6kxL+QPpRI=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2 4/7] kexec: update kexec_file_load syscall to call ima_kexec_post_load
Date: Thu,  5 Oct 2023 11:25:59 -0700
Message-Id: <20231005182602.634615-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_112613_872514_E99CDB07 
X-CRM114-Status: GOOD (  13.92  )
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

The kexec_file_load() syscall is used to load a new Kernel for kexec.
The syscall needs to be updated to call ima_kexec_post_load(),
which was implemented in a previous patch.  ima_kexec_post_load() should
take care of mapping the IMA log buffer segment into the next Kernel. It
should also register a reboot notifier which would call a function to
dump the IMA measurements into IMA log buffer segment during kexec soft
reboot.

Modify the kexec_file_load() syscall to call ima_kexec_post_load() after
the image has been loaded and prepared for kexec.  This ensures that the
IMA measurement list will be available to the next Kernel after a kexec
soft reboot.  This also ensures the measurements taken in the window
between kexec 'load' and 'execute' are captured and passed to the next
Kernel.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 kernel/kexec_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f989f5f1933b..617dbbb6e46d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
 }
 #endif
 
+void kimage_file_post_load(struct kimage *image)
+{
+	ima_kexec_post_load(image);
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -399,6 +404,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 
 	kimage_terminate(image);
 
+	if (!(flags & KEXEC_FILE_ON_CRASH))
+		kimage_file_post_load(image);
+
 	ret = machine_kexec_post_load(image);
 	if (ret)
 		goto out;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
