Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7CACDB474
	for <kexec@archiver.kernel.org>; Tue, 17 Oct 2023 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=avz2phECq5LPOFxrBUz+VBcf0Hu10vz9bCXvaVi+IR8=; b=LEpoAqKSyf9q+6
	sea5WYf3l1xKPvORbITiVSZIYVzVy9Jz89IyyRYAVmC9IC2V9nR1jxhd+QnPcpk2kTqlwgAHn/iyg
	CdVtsvEAi8jpHRfI7hEkacTHDkJCTU6vQb/B+sYsdWk3ZPs48P0LPhR+wZsFDnvsD91dREkHLBoQg
	yV3Os1K0fCdRmCBhj3gPkE6wCMnIrBeqcASepyuuEpqiLQyvInskFoTJVzWa+UBVvpBgRYE/UzbVu
	IFeprd5hsk6YOlNCHJyVHgDYd0UcGF3Y388HABfn93FNU77RW7zA72lwJpk4FJ2AObD/woli1fJaB
	RJeqNOTvHcvMgMMzebog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsZot-00B43I-2d;
	Tue, 17 Oct 2023 02:28:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsZoq-00B42x-0G
	for kexec@lists.infradead.org;
	Tue, 17 Oct 2023 02:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697509706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TgR+mAXMbi1ZPDCzaz8sBFm7f/fiuXUVrTub4khnewo=;
	b=HBprk8NQiCVVHmTfXN5XzzJxDMQ1WKVMlEqHvzj3F5QcQRIIcQcGhDCThp1x7PiLaN6Ed2
	ELXLMANg1bux8eM5rvBSwfDnWwy7iz1kM+hBbrcGoM0ic3a98Ke+NUdlo9uMcfz8W56gRF
	jWhAxcxMwx5Ydwn4hCk4JFqiYVQbi9k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-_-A2clm1O0-LnVxroWITvw-1; Mon, 16 Oct 2023 22:28:23 -0400
X-MC-Unique: _-A2clm1O0-LnVxroWITvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC4973C0E645;
	Tue, 17 Oct 2023 02:28:22 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE2621C060AE;
	Tue, 17 Oct 2023 02:28:14 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Wen Xiong <wenxiong@us.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	kexec@lists.infradead.org
Subject: [PATCHv9 0/2] enable nr_cpus for powerpc
Date: Tue, 17 Oct 2023 10:28:04 +0800
Message-Id: <20231017022806.4523-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_192828_215142_485CE276 
X-CRM114-Status: UNSURE (   8.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Pingfan Liu <kernelfans@gmail.com>


Since my last v4 [1], the code has undergone great changes. The paca[]
array has been reorganized and indexed by paca_ptrs[], which
dramatically decreases the memory consumption even if there are many
unpresent cpus in the middle.

However, reordering the logical cpu numbers can further decrease the
size of paca_ptrs[] in the kdump case. These two patches rotate-shifts
the cpu's sequence number in the device tree to obtain the logical cpu
id.


[1]: https://lore.kernel.org/linuxppc-dev/1520829790-14029-1-git-send-email-kernelfans@gmail.com/
---
v8 -> v9
  put aside [3-5/5] in v8 for the time being, which complicates the code.
  optimize out some unnecessary initialization according to Hari's
suggestion

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org

Pingfan Liu (2):
  powerpc/setup : Enable boot_cpu_hwid for PPC32
  powerpc/setup: Loosen the mapping between cpu logical id and its seq
    in dt

 arch/powerpc/include/asm/smp.h     |  2 +-
 arch/powerpc/kernel/prom.c         | 26 +++++----
 arch/powerpc/kernel/setup-common.c | 86 +++++++++++++++++++++++-------
 3 files changed, 83 insertions(+), 31 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
