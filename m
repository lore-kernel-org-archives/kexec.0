Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A255C3DA5D
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 21:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UurF9mLo9bfCaAHaCvUuvFmjdpbXwopyjb6FB+RtynI=; b=GIgQPKR2UVvmmF
	+Glf+zJFLHgcNAQ3qTA0Z0qcC/ArsGBtrUipqxxlPuJq3bx44PiD14mf8IpXxFrrgW6ivqPANl6WW
	RhF+fG0wNgVbqviDJGMQpU0n+N5Nlu7RzATZKfIgGObLef2DJGdi4b+jd1Df3vUtxZ/vWiUEc6h94
	w8nrScbqnxNkL9H9ahBGqqVUSZvXKYc5agfU9EsTxkncsJP2c2jwnfepsGbYSRU4y3ga1d9QGxdCT
	6bJSgsmXDsmxx2OcZoGhDtoqRHDvF6vYa1o1rYS/fB2iP3kSsTbxncW+4HRcPruj9yKdTCaN7RrDl
	un7S5gYSV6t/Tvyraz1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCGL-0000000EyvG-094x;
	Wed, 17 Jul 2024 21:32:37 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCGI-0000000EyuO-0fES
	for kexec@lists.infradead.org;
	Wed, 17 Jul 2024 21:32:35 +0000
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HEofNS002946;
	Wed, 17 Jul 2024 21:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pps0720; bh=808SU6qyaK/Um857JBYO8r
	S2Bl8LCNVBrZBok6IKwwE=; b=mDHLBAc0rPzJ0DNjqfFEzkKXPo4oM8PhTOFKQ1
	HuJUpQPfnyug8cPcDiqB3fj0HwIx+r3ujhrK2eLvGBgL8/FwVPkrlvbtSEzdmqut
	/IRFW+T8imeLqrJyeYRDer2YKF75NpOuspGovuiqtAIPnO7Ff+3mZ2K5SA3XtjAs
	XWwmX5GDnPW/zAyR5EBRQEj/fT3K761hZyDuPw0wVg2f6dIb6oJnFR2+VNUpBt7E
	R8fAko62JGJApVURJAeq9UQzajzdqT3eGWfjUWUOpA8NJjV68QmbLlOxIv0jWmln
	cOESQm/SrX8LMrNjgd66POhuHiphUlW4pqPwvuYZ1IF/tPXA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 40dwf02w6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 21:31:26 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id B9C1E80026E;
	Wed, 17 Jul 2024 21:31:24 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 71C0480FDCA;
	Wed, 17 Jul 2024 21:31:22 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 36CDD300BB4C9; Wed, 17 Jul 2024 16:31:21 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>,
        Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH v3 0/2] Resolve problems with kexec identity mapping
Date: Wed, 17 Jul 2024 16:31:19 -0500
Message-Id: <20240717213121.3064030-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Proofpoint-GUID: ho06VTQBQgjQyTsV5tShzxTP38dasqcr
X-Proofpoint-ORIG-GUID: ho06VTQBQgjQyTsV5tShzxTP38dasqcr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_16,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=893
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170162
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_143234_211034_9E83B6D6 
X-CRM114-Status: GOOD (  23.88  )
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

Creating kexec identity maps using only GB pages can include a lot of
extra address space past that requested, including areas marked
reserved by the BIOS, which on UV systems can cause system halts.

The previous attempt to fix this problem,

       7143c5f4cf20 ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")

caused a regression on a small number of AMD systems, and was later reverted.

The cause of this regression was that the EFI Config Table Array was
not explicitly included in the kexec identity map. While this array was
often included in the identity map by luck, when it was not, code that
checks whether the AMD SEV feature should be enabled takes a page
fault due to the array's address not being mapped.  This happens before
the new kernel is able to set up a page fault handler, so it is fatal.

The patch that was reverted greatly reduced the chance that the EFI
Config Table Array got mapped by luck, which is why this problem
appeared.  The kernel command line option "nogbpages" also causes the
problem to show, and was used for debugging and illustrative purposes.

The first patch in this series explicitly adds the EFI Config Table
array to the kexec identity map so this problem will not occur.

The second patch in the series re-instates the previously reverted
patch that reduces usage of gbpages in creating the identity map.

All three of the people who reported regression with my earlier patch
have retested with this patch series and found it to work where my
single patch previously did not.  With current kernels, all fail to
kexec when "nogbpages" is on the command line, but all succeed with
"nogbpages" after the series is applied.

Series version 3:
  * In patch 1, do not change name of map_efi_systab, and fix comment.

Series version 2:

  * Removed a patch (formerly #2) that also added the CC blob to the
    identity map, as this was proactive, but not proved necessary.

  * Rewrote this cover letter and patch commit messages to include
    discussion on previous version.

V1: https://lore.kernel.org/all/20240520183633.1457687-1-steve.wahl@hpe.com/

Steve Wahl (1):
  x86/mm/ident_map: Use gbpages only where full GB page should be
    mapped.

Tao Liu (1):
  x86/kexec: Add EFI config table identity mapping for kexec kernel

 arch/x86/kernel/machine_kexec_64.c | 27 +++++++++++++++++++++++++++
 arch/x86/mm/ident_map.c            | 23 ++++++++++++++++++-----
 2 files changed, 45 insertions(+), 5 deletions(-)

-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
