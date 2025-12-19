Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FCCD74970
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDF4h3Jh9GgHGMLVFPx83dqWDttLVLJuGGw2qG0PEFE=; b=W6DHkQmCUsul+N3Zz98Fr4nbJE
	OWKafeYp/MphDeBuH+DVewCji6AfZfPSg5GEfDL9Muwu9dfJXJxr2U96z/mtO+idMAdPW+t3MHeHU
	QVX/J3RIvWLr6MUL4z5mbFZxt9pD4HpNo6883AXyyAq8B6E68FyqFaU4z7jCuXVXqgZakZezMxPru
	FEub/h4DjnmUXMG8/HaBa4e+ftRSM1Usc23mGqPYCDVR9TVlMX/njjIIBhlvrwn/Dxv42GlfegI1P
	7/ffMOHGuJOC1evwPcI7z8YHDdGK7W0Aiayro+aNAcXR1I+U8I9ub8ojmxtcELWNuFyGN02AAQPbY
	bTJSW9IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWsl-00000009xrZ-2Cf0;
	Fri, 19 Dec 2025 09:34:43 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWWsd-00000009xeQ-3Uh3;
	Fri, 19 Dec 2025 09:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766136816;
	bh=UDF4h3Jh9GgHGMLVFPx83dqWDttLVLJuGGw2qG0PEFE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=pdJp5wN7z4eFeVowqCWVpB/vKYmjXGxHpgxzUwQrHm6pc6wTZH/8WsR/gtDxfUqq4
	 kimGm/kk69stHppXjFLHlHZIrF7fVFges+AuXiGEzmBG+q1FqxafPD9mIQXjhERn27
	 Y2nHGOZw4TL+oNugQ+xSIjzqkUue63ywDbrL1Tlg=
X-QQ-mid: zesmtpsz5t1766136798t48f4f980
X-QQ-Originating-IP: FPwl8qTGfn+61UlViOYpcJHqZAzjuxj54MRGHmXIgaE=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Dec 2025 17:33:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3273388139071314314
EX-QQ-RecipientCnt: 8
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v2 4/4] arm64: kexec: Adjust the debug print of kexec_image_info
Date: Fri, 19 Dec 2025 17:31:34 +0800
Message-Id: <20251219093134.2268620-5-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251219093134.2268620-1-maqianga@uniontech.com>
References: <20251219093134.2268620-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NSukcgWmJNd8BYYCvQ+Z4AU7BbL32JoK30KTc31XPVU0YecuYp1Bd/jk
	ZBRDoGHjHhW/kjmhyvQ7ynPo8q3YEeua5oNtbzpUhiyHzbaK1r/o5b8IN87GcozGeXWQh28
	gvVIcV/HNYp1OXDrskrPffUB+EdlY2nJPw4sElaEQY6qrjPCOKnK15bp22IADHOHeNv8Rp8
	xXf28bA5sCcHz9RbIq8okKg6VtP5dxhOz0xoI9BVrIEeCxKQQNdkLMFxZVKvxYUtYoTIDzs
	+1OUOAEjABcXIPooQoJ7B234gBceh8TELNwAnAAdi/jnkOW/UFn5fBGycffY3J8OnUtzIF+
	eMh2/Mbv7Qkw8ZLD5qfPct+28WiD+D4KYiDkhSd6eni6Pp3xTDeZz19NNeCny/K7ly67HZ3
	GYtTR42uM+y/iKdOzl0POxSPr3z4oTgq/+X4QVwr7vfq+kPdFa8q353l/p5psRweuUHmqvN
	y4NiZvZpmzb3zCizfyW8SaGadAtdSpkzYLQVEN24VTqAMnXy3udf2ACwBFiWLJXmj+1lyTI
	qJ9SGsn3E3R920QoA+EET0lD1w5nE7nimnWkEcPZkbG0DNIsjGPBq9tBu3dHzX2I+PPKccI
	hv/X/D09vgSe2b+rqLJe6dlj6HaQN4OJLN5uB/SOEICHRoJ30t3r4VMTSehQwnbZuAPzMga
	wjI2o4+FgZFZ3dJuj9vtRhyzeUpZOe7EeJ6PDn1WlL9M7Ce4IQXYqy8eW5UyDAsbgBI6zUU
	n0fA8KYmMMokSh99d744QhUWUJa/2SRFmBJQUOXAy/AOngWSzc9UevWMu4GDXrdVm2H6/Nz
	jKj0LuRp+Jw6TUWbZ4qRDCLvNU6bqoQY98KQ8VHzcAtrYS4QEQM0s7gaqn99rS5fpOXEGVq
	tqTeY9iksJQGSOKHvJFmAZY6RxFChEZxqoHV2I9SKLKfvx7lE5ktW3m9+1JYfwtsmJYcA6p
	Dew55sT1KvaLrHrx2CjoTlLdPBwh4Q1fj6pG5LRLpnRddfAtWTNEEWGeik5D0B+0OFU0/CQ
	AiKnPNE3wBltG7241CAFtYVje6ezFCydGWD/Eb0Pxj+DQk6zoJ5HtfFvTFoFnylnZk9blUl
	w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_013436_328189_462FB8A7 
X-CRM114-Status: UNSURE (   7.97  )
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

In the previous patch, we move start/head of kimage to the
generic code, so, we remove them to avoid duplicate printing.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/arm64/kernel/machine_kexec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 239c16e3d02f..0896e3e6a811 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -34,8 +34,6 @@ static void _kexec_image_info(const char *func, int line,
 {
 	kexec_dprintk("%s:%d:\n", func, line);
 	kexec_dprintk("  kexec kimage info:\n");
-	kexec_dprintk("    type:        %d\n", kimage->type);
-	kexec_dprintk("    head:        %lx\n", kimage->head);
 	kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
 	kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
 }
-- 
2.20.1


