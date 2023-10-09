Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D85E95A8E
	for <kexec@archiver.kernel.org>; Mon,  9 Oct 2023 11:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Et84k+ZaeOXZ2ebxo4daOLYjsR0jHbhQ321PEE/5xpc=; b=ELk3ftkppAoKiZ
	fXRJPLpaT5VBRi0MHk25ZguSRubCcMf5p6t6mDEQ7Ya9PXrpK9s7evGpTdMPCtg2Ix4vpOhd/aJUk
	hk/oHN6Lhvyhn7ADCYFSEj8gpmwpV+p95W+XNMSItpK/tjqAzMyyDn9yJCJvwB6790dKnSjMP0FH5
	Oegly1Q4GFuvrzyu3pPZcGevpmCDcAD13fHrfMu3r4ui/XWaCLVk8XM2so/tmj9zevsTYwnrDeGaI
	FNlQjQfYfzGYzDmEJXOuttPhZGf5qZxIMwLYjCzaFpMiZXVvDX0DyvchydCUeezXFWXOnVKN7V01I
	Y+L5fGmXwCZmJTi2dO0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpoTU-00ATBd-0N;
	Mon, 09 Oct 2023 11:31:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpoTQ-00AT8j-1A
	for kexec@lists.infradead.org;
	Mon, 09 Oct 2023 11:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696851052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AucLLdvUakuzR+OKAnMghovN188k9ydHfEOSC44ux8U=;
	b=Q17EC1eKnXQojhgcyt30NNeKuPlYi3WU0nub7ef40TU+Tz7eJnRCqDNeGYRB1I8hejrljl
	nYlSsq3wwE74OPz26vu6HnuEau6RnztKtwOtRkW9m/oTMYoCV4eJE+QKrUgjlEvhAul91Z
	Oj8hmIf3Nefm2mnXg5ymCZZ3NGsIRng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-RNfrfiIBOGC17ZfULLohZg-1; Mon, 09 Oct 2023 07:30:51 -0400
X-MC-Unique: RNfrfiIBOGC17ZfULLohZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6737F85A5BD;
	Mon,  9 Oct 2023 11:30:50 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 188092156711;
	Mon,  9 Oct 2023 11:30:45 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mahesh Salgaonkar <mahesh@us.ibm.com>,
	Wen Xiong <wenxiong@us.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	kexec@lists.infradead.org
Subject: [PATCHv8 0/5] enable nr_cpus for powerpc
Date: Mon,  9 Oct 2023 19:30:31 +0800
Message-Id: <20231009113036.45988-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_043056_496419_83A6BCEE 
X-CRM114-Status: GOOD (  10.13  )
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

Since my last v4 [1], the code has undergone great changes. The paca[]
array has been reorganized and indexed by paca_ptrs[], which
dramatically decreases the memory consumption even if there are many
unpresent cpus in the middle.

However, reordering the logical cpu numbers can further decrease the
size of paca_ptrs[] in the kdump case. So I keep [1-2/5], which
rotate-shifts the cpu's sequence number in the device tree to obtain the
logical cpu id.


Patch [3-5/5] make further efforts to decrease the nr_cpus to be less
than or equal to two.

[1]: https://lore.kernel.org/linuxppc-dev/1520829790-14029-1-git-send-email-kernelfans@gmail.com/
---
v7 -> v8
  Fix bug when turning on DEBUG macro
  Introducing [PATCHv7 4/5] powerpc/cpu: Skip impossible cpu during iteration on
a core, which avoid access to unpopulated pcpu data.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@us.ibm.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org


Pingfan Liu (5):
  powerpc/setup : Enable boot_cpu_hwid for PPC32
  powerpc/setup: Loosen the mapping between cpu logical id and its seq
    in dt
  powerpc/setup: Handle the case when boot_cpuid greater than nr_cpus
  powerpc/cpu: Skip impossible cpu during iteration on a core
  powerpc/setup: alloc extra paca_ptrs to hold boot_cpuid

 arch/powerpc/include/asm/cputhreads.h    |   6 ++
 arch/powerpc/include/asm/smp.h           |   2 +-
 arch/powerpc/kernel/paca.c               |  10 ++-
 arch/powerpc/kernel/prom.c               |  29 +++---
 arch/powerpc/kernel/setup-common.c       | 108 ++++++++++++++++++-----
 arch/powerpc/kernel/smp.c                |   2 +-
 arch/powerpc/kvm/book3s_hv.c             |   7 +-
 arch/powerpc/platforms/powernv/idle.c    |  32 +++----
 arch/powerpc/platforms/powernv/subcore.c |   5 +-
 9 files changed, 143 insertions(+), 58 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
