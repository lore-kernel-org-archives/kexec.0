Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hbVrP-0004HU-4o
 for kexec@lists.infradead.org; Thu, 13 Jun 2019 19:58:12 +0000
Received: from mailgate02.nec.co.jp ([114.179.233.122])
 by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x5DJw6r6015503
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2019 04:58:06 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5DJw6c8005551
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2019 04:58:06 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
 by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x5DJw6OA027780
 for <kexec@lists.infradead.org>; Fri, 14 Jun 2019 04:58:06 +0900
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [ANNOUNCE] makedumpfile 1.6.6 preparation
Date: Thu, 13 Jun 2019 19:57:06 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03578556@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

I am planning to release makedumpfile v1.6.6 in the next two weeks.
It will support newer kernels up to v5.1.

If you have any patches that you would like included in v1.6.6,
please send them within one week.

For reference the patches since v1.6.5 are as follows:

8c21fc7e7c52 [PATCH] Support newer kernels up to v5.1
3222d4ad04c6 [PATCH] x86_64: fix get_kaslr_offset_x86_64() to return kaslr_offset correctly
d222b01e516b [PATCH] x86_64: Add support for AMD Secure Memory Encryption
1743c7370868 [PATCH] exclude pages that are logically offline
feee755900e0 [PATCH] ppc64: fix a typo for checking the file pointer for null
2f007b48c581 [PATCH v2] honor the CFLAGS from environment variables
b9da17259ef5 [PATCH] Some improvements of debugging messages
f349b51f6211 [PATCH] ppc64: increase MAX_PHYSMEM_BITS to 2PB

and "[PATCH] makedumpfile/arm64: fix get_kaslr_offset_arm64() to return
kaslr_offset correctly" I posted, if no objection to it.

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
