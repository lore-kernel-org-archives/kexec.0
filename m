Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D7DD4415D
	for <kexec@archiver.kernel.org>; Fri, 12 Dec 2025 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JCkE9HsOvtJz+eV+4TRG1BPljRj69BXFxbWr+6MNF/U=; b=A4UaunuP5rDMbn3KKrfXqxiGpz
	vjBLRIMnfps8F5CR5TxJGsBHFRv/DrveEFms1YRE3qQjbhyaAQuXjCmAYb+BYLyoQp1UW/+ofibAS
	f63p50n8APNc2+BBmah1awueMUusn7kw7d5mSXVLWdJRbBAcVX5Ai13J2LkOlRZBb6oic6psoJgd8
	ChewK6h37saZBV1aiQlzXwRQnNIalDiy5fWJb7Nc8WIxxSoG4fKkiyqDMQqpOtXdp17UtP7RrQ9uD
	DGk9QS01CC98nBaqxeiN5ArBdW8liFPEMMtQ1F1La/XEMlNBx2v0S77KPM9n2N8zVhURxSDTlRjP0
	o43lbL3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTzvc-00000000OEQ-20al;
	Fri, 12 Dec 2025 09:59:12 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTzva-00000000O74-1fAm;
	Fri, 12 Dec 2025 09:59:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765533494;
	bh=JCkE9HsOvtJz+eV+4TRG1BPljRj69BXFxbWr+6MNF/U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=GgCRbUUhu6WLAL3R6R02lEVI4LTNcf1b1v1jyXnAVk0Ahdavx93OnPra+USD94nN+
	 PTDtuGN5k1PM+PgU3LwYk4SzAJyhYzDlLdBkcK7Ar0G5cY8qLbgB522TERLby96nTv
	 C5hzbVo0exshdIBzj4Xnm2idVfPaKulw6OXVDqQg=
X-QQ-mid: esmtpsz10t1765533476t53bb0429
X-QQ-Originating-IP: ArCtjZoICX724vPT0Oy9DCDcchmCVdVAlOTfSuwP+3M=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Dec 2025 17:57:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2934731611208564469
EX-QQ-RecipientCnt: 9
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 2/3] kexec: print out debugging message if required for kexec_load
Date: Fri, 12 Dec 2025 17:56:48 +0800
Message-Id: <20251212095649.857796-3-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251212095649.857796-1-maqianga@uniontech.com>
References: <20251212095649.857796-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M0yQCYO1Pk4BceMs9s/21F6eWS4FMbxtBwZ4pHoC959YCGbutcHwFpIi
	fA70FMEm/i6G0qZB0jqfVBTR8ckMpLEK9l/6EoL+SkSp7GLlVRNOcf2eUloVhFuyqYReQ9U
	UGAtD568n4UTYstFpPbOY60EjWquXtlss+BOO2NaxDVLhoK3uKKWxq68mSMIZjgyEoUY3Ts
	6sjNIDxVumuZPwYkUdS7P1TrTVDHXaGm0TdMjPQ9zBOduQob2N8KLRWm2hQn2AC6s0f0V3Q
	x9O8oE4shNkxSgFpEBXhNnM06f7KZpOGGAhdZn/HqEi2700UKueuElfn5g5NgaQggNh7Rla
	AYb5X7K6KT5T34r8Ovoa9wNaW6ufqOPnOq3cirYE5nOI9pW2rYDXXRhw2tur9lhqe7Rm+6t
	R494+bfY6a0A8/rNqyand9SXd19hIwufUPZnW/2PtIwoJtqBfL//XDhcfAX1Gqx8QKM/inl
	sezKvoFLW7UDaPOx2tQMkP9t1P4Ti6ZYqTuDY3L4BCQvqdY24bq87yPOWiFhzB2ltrXDH4t
	9qq1Xp7Fv4g3FoCd6zlVpIuOUpGtesqRhKPeg+Xjr8ErUPx158p4TWcteB6q5dMGlWRtORy
	/QBLpzWlcalVrUWyFBXtlsKG/DU0ul/xegeOCZm95j0rrR7ZbKRwCYaqaOQnWfyBnZEocoS
	nzmIwK7ihiEvqwSNDiFf7GxxUfmCtQKVaROtYUcAnUWgHpSf9YJviKRgESPyOGu+ljEoFs9
	g+ONnk4FJ0wjfPN/54yflnLILZTysif6BG7YUFEOii/j05XkacZgsZHCcClayGH1eF9C21U
	4k2+aH+gWWBgORfVR6m8MrUTUCpnocaS1/vwqqw2HM4qUGmnbCGYP08V8naNB7afKTn53AS
	y0MxiaWoOYCEVTS0C9lmiMT0NnDOvoKMcYLMIRb5k66HpYvWYxBWtyI7W3ji/9sm+jzClQS
	h+cw0i5smy1wgaP8wVCjHm+xqO+hpgARzXH/WAGOflx3/BmCdRTOBnx0SRe18EhT/byBxic
	UPLd3KSZAtK1X8B8JUkUWoDOLfttahWubgiouf60VufgnQMv1l6+DMumJYrg706HBRHOMRB
	Dr1QT1ou0sp7v0gCsXJqaU=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_015910_959990_94DBF009 
X-CRM114-Status: GOOD (  10.45  )
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

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

As a result, when using '-d' for the kexec_load interface,
print nothing in the kernel space.

Since the segments debugging message has already been printed by the
user-space tool kexec-tools, it will not be printed here in the
kernel space.

And print out type/start/head of kimage and flags to help debug.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
---
 kernel/kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index f6c58c767eb0..37e4ac8af9f3 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -166,6 +166,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
-- 
2.20.1


