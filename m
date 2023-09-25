Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C27CE7A89
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KwxG/JbPjNzG1DpU2EwIUkAjSTjscSE8LJbkXdDxLMg=; b=XFeiG1zCjeN/wO
	J3Fn2mA5zMS2ZyXN0O2dE1dz3gA0lwANbB3RQkOsY5G4wPrAt6QAGWAkZ7C9yjEHE9P159oFxd1d4
	T4dupafXJMcWr2OGOPMDL2sTszYBB8Vl3gP2vWtBTr0WdKEFv3AJ+H7JqTRDKN9x02e8B6dsfIepR
	dSIHm8RUCWzGkgv0EUwZH4G3sVeqPmJ9CUXV2Bwq1nWGPNcWGAnGAvXK+8cHTQmQFHEUYVCWT5kzW
	MWuQ8P0E8zSDTuG7HvXyZoeZTL4lz4LBYm7f91s3yOvCCVkcu/tfB8lzpbdsIm+u592Q+2wkvycIH
	5mX2hMDKiTaGyvKm19tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkgQ6-00DfKq-2V;
	Mon, 25 Sep 2023 07:54:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkgQ3-00DfK7-0p
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 07:54:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695628451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VkXHcWrt/ISGO01H27Y9nB2Iev3COcRqarEgCcDgrsw=;
	b=dyTN3cxSWVUlzeXfAKkoLEWkhenT1uU5OMYiWE039LAhmdtQo0ddeeWe7OO58kGbS0wkhN
	esl1y0sNV4FaRXf/OUBdzSEpACO8KMSTL6PF2KrpvImIZQf9Dtu/jGCTwvSe933xieC9MC
	ix3uUQ7yGdfY/T1ENuTkWmDWyJ9P/lw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-dJinBq2ZNQmARTZSIbeRAw-1; Mon, 25 Sep 2023 03:54:08 -0400
X-MC-Unique: dJinBq2ZNQmARTZSIbeRAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C497329A9D3D;
	Mon, 25 Sep 2023 07:54:07 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A214540C6E76;
	Mon, 25 Sep 2023 07:54:03 +0000 (UTC)
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
Subject: [PATCHv7 0/4] enable nr_cpus for powerpc
Date: Mon, 25 Sep 2023 15:53:44 +0800
Message-Id: <20230925075348.16654-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_005416_112923_AF298BBE 
X-CRM114-Status: UNSURE (   9.32  )
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

Since my last v4 [1], the code has undergone great changes. The paca[]
array has been reorganized and indexed by paca_ptrs[], which
dramatically decreases the memory consumption even if there are many
unpresent cpus in the middle.

However, reordering the logical cpu numbers can further decrease the
size of paca_ptrs[] in the kdump case. So I keep [2/4], which
rotate-shifts the cpu's sequence number in the device tree to obtain the
logical cpu id.

Patch [3-4/4] make efforts to decrease the nr_cpus to be less than or
equal to two.

[1]: https://lore.kernel.org/linuxppc-dev/1520829790-14029-1-git-send-email-kernelfans@gmail.com/
---
v6 -> v7
  Add [1/4], which fixes compilation error on PPC32

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@us.ibm.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org


Pingfan Liu (4):
  powerpc/setup : Enable boot_cpu_hwid for PPC32
  powerpc/setup: Loosen the mapping between cpu logical id and its seq
    in dt
  powerpc/setup: Handle the case when boot_cpuid greater than nr_cpus
  powerpc/setup: alloc extra paca_ptrs to hold boot_cpuid

 arch/powerpc/include/asm/smp.h     |   2 +-
 arch/powerpc/kernel/paca.c         |  10 +--
 arch/powerpc/kernel/prom.c         |  29 +++++---
 arch/powerpc/kernel/setup-common.c | 108 +++++++++++++++++++++++------
 4 files changed, 114 insertions(+), 35 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
