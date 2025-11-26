Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C35D1038C
	for <kexec@archiver.kernel.org>; Wed, 26 Nov 2025 08:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7b1v+VfWdS9vnI3hgHts2MCpC3pXD6k/AqQcBNZpi3w=; b=YWQynB02O4dweu8WH3QSHVxQl6
	e4ZxvntseTIM2bLETWtcXC8Ze5pmkklc5zzgUODfIFZc7LuTqI2AQe1A81U1YTeCAKTSo7mIHFvnr
	gC/eFloBzU2jlw68jAmQosqm16XLkyRITg+4zCdzj3euBmP5iArYtkYRTjJJp7KOJSwoRB1wV7i4J
	QW9LUp6urdfxA23UVBnmfmzb1SV/ytR1KjTBnV9WuX6vh3dtxKD/k+GmRViBm50A2EPc3JK/1+JC9
	5Gw6vrsb1aPrb1BN8jGWHilXdfCH0GwfTdusQ8P9bHYxz1cUU3tNvj7fc3BGWKoC3qeHEWGiT7xa8
	VamCcRCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOB9h-0000000Edkh-2EpU;
	Wed, 26 Nov 2025 08:45:41 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOB9c-0000000Edbr-1ZzF
	for kexec@lists.infradead.org;
	Wed, 26 Nov 2025 08:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764146709;
	bh=7b1v+VfWdS9vnI3hgHts2MCpC3pXD6k/AqQcBNZpi3w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=R8uzIO7fNJMx+rQyxcix3eaALrK3QmnP/uBzIAIEVjX80H79g1EMNuLAEQBPw00un
	 r8zGdvZZJzVCOQI9SzRwruvQNHmNszomQnbanHFT8U9zpYJpNI5IUzbengaec60MfP
	 jB2yhJk5oAJ9ozTuXU+74ks0mFjYiJ/8nuUM4xXU=
X-QQ-mid: zesmtpgz7t1764146705t92bcfc87
X-QQ-Originating-IP: LjE2iX/jIr2kW4U183fcosGl+esKkN4mwkn8InklZ9k=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 16:45:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14949448011716842836
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH v3 0/3] kexec: print out debugging message if required for kexec_load
Date: Wed, 26 Nov 2025 16:44:24 +0800
Message-Id: <20251126084427.3222212-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MOSHzC1SiP/mFgoaNtdf5wbgdDIutKBV8hKBXDqn1dkLC1ozIeoQrVw3
	7SwHJ2EPnEzNWuQRMLUmoneUM/3SCxxP4vPFivGocy5ewU38iasFXkWAzOlc+o9UR0b/K6i
	VqEIrRoJbMeMDVTDF2QOl0MwDz4cq80+LcN7HkW64Gcu/fFw04mgwFp8wr9ioE4qIwzhI3M
	FcIChIKYrHnNtRp9eMkr0/tqZlZEBvB6f8MOETd+e2q2oquAGl9u2L3c8BCEzGBZhbP+K7/
	Bu8LLN5h765eIYaSbQ3t85/ZXjAkAUr899b/XNEYp6P3D+ufHFGIVgbq2rx5Qg2U3/gW9PV
	oGGv0dHO0+idxArxgRa6Pka5l9RykihqKyvtTqHt8ieyUmZH3bCTcg6xEJ4MD+elG+HDb83
	rnQIWr/aZZ2KnoErm9tAhfNsUamrW3rAIQCAl4N9wLXFhEJCxLJ2pjG1ryrlYyq/DQaytPv
	cb02ok8XKcQdYrxy/ge3xhD8gRfkCCWE9Bb3vfb5EV5+LvZ8O4SNLmwTWPD2CvhFu+fyMjD
	JooXZPDmdVwlWKMLbEGA3Ij6ebcIQjN8uM8bMI37sBdYQP5v6Yhww2xkaViuiJ6JUp3Lup9
	KrlC8BVkCQ8B7G2Rhn0P7RQW8wd4UDktXdYLw37ywUpzRlakWi0p9CwYDcKtxNhUznbNRNG
	Xs1+Rv9JBft5xnnuxojizQDeE/I2DG7jhcEeAQZb0uYCoHiGS08KcOSbRW+dgh2vesFY3Tt
	7XFTyRscVEZjMa5gYZBvKihse/v8kKqzc4IXJEiRj4M6B7BKIQcuH+7TQmO1BX6NExHHTWd
	tkanz+yrPe82F626s1Ekhe2KmbdyoTiWbHArnm/Kn42/OO0i3tAHmmZnggSoUGjxBUFpnza
	kCStqXXevY3VtszfiIxq13ievHiqgixWBkAx0Ki2uxagOOsieaW8e4kA/YzbhoXOWBbmERb
	ZGuQzWbVGXk3IJ8TQj/r5UYmxU6qCaJUAu07gURmnhabEIt6zMr7+Cjq0skEgH/01TVZqwh
	8lwAK4wVN7v3B3aHsyn+rdJsDvAnNC2AwSOnKKy+EHtxNv4gHdi/8KIBcHYoFRN6rg02ej9
	w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_004537_076851_BAF23CD7 
X-CRM114-Status: UNSURE (   9.82  )
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

Overview:
=========
The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().
    
Since kexec_load and kexec_file_load are not triggered simultaneously,
we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
    
Next, we need to do some things in this patchset:
    
1. rename kexec_file_dbg_print to kexec_dbg_print
2. Add KEXEC_DEBUG
3. Initialize kexec_dbg_print for kexec
4. Fix uninitialized struct kimage *image pointer 
5. Set the reset of kexec_dbg_print to kimage_free

Testing:
=========
I did testing on x86_64, arm64 and loongarch. On x86_64, the printed messages
look like below:

unset CONFIG_KEXEC_FILE:
[   81.502374] kexec: kexec_load: type:0, start:0x23fff7700 head:0x10a4b9002 flags:0x3e0010

set CONFIG_KEXEC_FILE
[   36.774228] kexec_file: kernel: 0000000066c386c8 kernel_size: 0xd78400
[   36.821814] kexec-bzImage64: Loaded purgatory at 0x23fffb000
[   36.821826] kexec-bzImage64: Loaded boot_param, command line and misc at 0x23fff9000 bufsz=0x12d0 memsz=0x2000
[   36.821829] kexec-bzImage64: Loaded 64bit kernel at 0x23d400000 bufsz=0xd73400 memsz=0x2ab7000
[   36.821918] kexec-bzImage64: Loaded initrd at 0x23bd0b000 bufsz=0x16f40a8 memsz=0x16f40a8
[   36.821920] kexec-bzImage64: Final command line is: root=/dev/mapper/test-root crashkernel=auto rd.lvm.lv=test/root
[   36.821925] kexec-bzImage64: E820 memmap:
[   36.821926] kexec-bzImage64: 0000000000000000-000000000009ffff (1)
[   36.821928] kexec-bzImage64: 0000000000100000-0000000000811fff (1)
[   36.821930] kexec-bzImage64: 0000000000812000-0000000000812fff (2)
[   36.821931] kexec-bzImage64: 0000000000813000-00000000bee38fff (1)
[   36.821933] kexec-bzImage64: 00000000bee39000-00000000beec2fff (2)
[   36.821934] kexec-bzImage64: 00000000beec3000-00000000bf8ecfff (1)
[   36.821935] kexec-bzImage64: 00000000bf8ed000-00000000bfb6cfff (2)
[   36.821936] kexec-bzImage64: 00000000bfb6d000-00000000bfb7efff (3)
[   36.821937] kexec-bzImage64: 00000000bfb7f000-00000000bfbfefff (4)
[   36.821938] kexec-bzImage64: 00000000bfbff000-00000000bff7bfff (1)
[   36.821939] kexec-bzImage64: 00000000bff7c000-00000000bfffffff (2)
[   36.821940] kexec-bzImage64: 00000000feffc000-00000000feffffff (2)
[   36.821941] kexec-bzImage64: 00000000ffc00000-00000000ffffffff (2)
[   36.821942] kexec-bzImage64: 0000000100000000-000000023fffffff (1)
[   36.872348] kexec_file: nr_segments = 4
[   36.872356] kexec_file: segment[0]: buf=0x000000005314ece7 bufsz=0x4000 mem=0x23fffb000 memsz=0x5000
[   36.872370] kexec_file: segment[1]: buf=0x000000006e59b143 bufsz=0x12d0 mem=0x23fff9000 memsz=0x2000
[   36.872374] kexec_file: segment[2]: buf=0x00000000eb7b1fc3 bufsz=0xd73400 mem=0x23d400000 memsz=0x2ab7000
[   36.882172] kexec_file: segment[3]: buf=0x000000006af76441 bufsz=0x16f40a8 mem=0x23bd0b000 memsz=0x16f5000
[   36.889113] kexec_file: kexec_file_load: type:0, start:0x23fffb150 head:0x101a2e002 flags:0x8

Changes in v3:
==========
- Rename kexec_core_dbg_print to kexec_dbg_print
- Remove unnecessary segments prints
- Remove patch "kexec_file: Fix the issue of mismatch between loop variable types"

Qiang Ma (3):
  kexec: Fix uninitialized struct kimage *image pointer
  kexec: add kexec flag to control debug printing
  kexec: print out debugging message if required for kexec_load

 include/linux/kexec.h      | 9 +++++----
 include/uapi/linux/kexec.h | 1 +
 kernel/kexec.c             | 8 +++++++-
 kernel/kexec_core.c        | 4 +++-
 kernel/kexec_file.c        | 4 +---
 5 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.20.1


