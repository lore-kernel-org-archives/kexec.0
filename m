Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A89CCF9FE
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 06:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIvvjEbQ1sG5r7Z8cl/qUt9KXwEgp0m6a/j87zSOL9s=; b=qmTfauKaqB88I8guiFOEbs6I3u
	lyh5/uV/HwH8t5HoXZceBOE6Y4Hc3I5AHUNI44mV6peuFXK1Zo+OQQQdRFuRDAH0yi8aJRHFmb03m
	tPECuJot6sXjARB4mTgqKZZnxVrh9uwfxD3IxsHzwInRxY8GJXY3pQmcc+fDx6b8bIjF3umVR56ab
	N1oIcp1aZS17a9X0tdESYUa4If0f1ncGcfgMnJxRpbaoSulpfTH2N+IeTUb+xgs/hQEkg1uUfpsqP
	VOQ7TmrmW2RDMHlnpekOGqgLXzLaEavTpcdzHWUHM4/PK6SyOjOirQMo2kDE4GFIirmRamleaWYgG
	RmQlNVwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoCv-00000009JHP-0dBO;
	Mon, 03 Nov 2025 06:38:25 +0000
Received: from smtpbgeu1.qq.com ([52.59.177.22])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFoCo-00000009JBC-3lVm
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 06:38:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762151867;
	bh=eIvvjEbQ1sG5r7Z8cl/qUt9KXwEgp0m6a/j87zSOL9s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LWRDz6b1jz+nU4M4m8Ko8LAttQO7uYKVOE3HYUKcnqSP9M2FX8289qZu+DkAfw9j6
	 RkrPYSQ8M9GxUeG7NlvC3hGNjhvxFX68NEQ+VA2JX6JntiEWigkj3Lj5N14JgpETC/
	 FYMMW83sP46ytNzmCxWXjy0EOUC1MFBLzTevYwKg=
X-QQ-mid: zesmtpgz4t1762151852t66baf00e
X-QQ-Originating-IP: HP92wee9TdxOT6l0k09HV0bbxacm4gZA3xqBTdJ58Mo=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Nov 2025 14:37:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 565133868988275124
EX-QQ-RecipientCnt: 6
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 3/4] kexec: print out debugging message if required for kexec_load
Date: Mon,  3 Nov 2025 14:34:39 +0800
Message-Id: <20251103063440.1681657-4-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251103063440.1681657-1-maqianga@uniontech.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MZyrYvuwV95ZwJQF6kolioZMMFDFt9KRZz+4V9otQXiSIxe0w6YsrgSb
	aG0Rs7qmazMPy8AjvrnWzkIA/L3BaK6szUTN1OzeuliEoLOEz88R+xorH9zuc+T37WoaaFT
	hjWK4IL1IpLZgwdcvNF1YgjpcljUsBLxUa5yVz5Z+GWDKo896kFmP2NdKCEnh+2x6ZKRf2W
	k+TOApqRhxj3kRJAZsXqfrHO7OuTxW6IJVc09VFQWJoDR62jwp/XQJhATN4xNzlc3sNpFLd
	Gu6TO4Y5RMHRJmWpwkiO4p/nY1B9kM4SeYvUjDbxFAlNIPNnq7evdgJDpTg14zjd4Jvk+zg
	dLrERuYNXTvG/gXIws8BGOj+U3YGDR5sfdzOT+z5WbW4IBhlGhuN/ht+ihsVEJpHEUPYXB8
	JvUuYG4ohzRMbyrtRBOpc3FoxI4jgvUN8rQt+dM5SoupYLytXzzA6hnbNK58TdtFccoZSLT
	Kiq+b9rdlGq1eqmPXgC9FcEDYPLRgMQRX0YSvtNoCJEnsvogwNIYUiLTSZzx42tIZTR0if2
	wZvqycxnQfGdEEF236UcumOSHyHdnWa4x5dYX+u9vt0CkgiFeBTOQ8s0DJ/DtHbJhpT1gf/
	qFfo6MXTIvF8k4KOir8hmNf+z/oEse5i9AU7zn3ul8nc2qJ6m7y9De9FW4oFoL6b7u9pv5c
	yYNa/WHnvdATH9o5LD/Uf2KI4T8RXRQgeMsckGGKb2G9B/FsYEp5nGNXB/nCRzn5vqmew1P
	jAL9Z/H+/iSleqBUT9wsvlBiCpN7wmWgw2mWhaRes0ENVy7zp4vwgpE3zNw+xXnNVA6UWvl
	IVW2y9zseA6TO0x6anCd7CfLing4eaRuqqJPdB6u0dxRs3GhetW6N5lHilI2iZ+ghabLaQX
	L99bEa6iMA9pPFVEnUPDLDdWevtCgWkoV0SThohmQ+P18wpnFkPtDDatlxrs0Gw+O4tblGc
	l1/PmvcCpD9SRk8Hpht1Xf4b6mHbnzfP9GfKsZ4iskZZx/D05oNMROCT4hSyPig46geiekd
	3miP/UFs1eY6J/QdkHOox/UmP3rXZGk51w28hlTmLY7U2uesNJFwlGG42BB90uOgHtBbns5
	PEylMGxp52jYWNNsQi9JJ3+/PtB1fSg8N7y4CQTDHuHs+y8M6IaaJc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_223819_386404_AF7DA5C7 
X-CRM114-Status: GOOD (  12.06  )
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

Especially in the RISC-V architecture, kexec_image_info() has been
removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
message if required")). As a result, when using '-d' for the kexec_load
interface, print nothing in the kernel space. This might be helpful for
verifying the accuracy of the data passed to the kernel. Therefore,
refer to this commit a85ee18c7900 ("kexec_file: print out debugging
message if required"), debug print information has been added.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
---
 kernel/kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index c7a869d32f87..9b433b972cc1 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("nr_segments = %lu\n", nr_segments);
 	for (i = 0; i < nr_segments; i++) {
+		struct kexec_segment *ksegment;
+
+		ksegment = &image->segment[i];
+		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
+			      ksegment->memsz);
+
 		ret = kimage_load_segment(image, i);
 		if (ret)
 			goto out;
@@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
-- 
2.20.1


