Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6B1EE800C
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pmv+k7LS3nIUQSchAH3zTzonpVr0TdbEhrtOcZdNWM0=; b=uWJTP9JBFY4JEe
	LUQ9foqcT0PpwHmu5ruVNID783d75EjIrFTz1uLNI1k3ymHzNRa/Z0KYPd0uhSCTVuJsNIVIGq3be
	s87Ctfn5XGQB3UeKjOO0+WUOlnPW8FFZmS4vW6s50iRbw9MOGYjokUQ6xcG+SZNx/TgO7xHMnUevy
	Ko9vAhBEMjOJPLvTAmTvtRvEu67KVvm6PV72p/d8DZOLGHzsEQyRrIzW+NPI6CHVNglTkwMN8nomu
	u2PFSZ8MPwI2PIRDT9FLeSnAF6uIlU0oPZ09NWLo3/yBdmoyR3API4pXuH/mjwD5+bat8uiKbapAg
	eGFs2ad7bA21eC+DMUWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qecLD-00DuIK-0l;
	Fri, 08 Sep 2023 14:20:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qecL9-00DuHJ-3A
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 14:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694182799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TxX3RwZm8DvnVUsWP87/50R/IGSVy55DFt8/VVMyPyw=;
	b=MjVUPdFHkyZ+LOq+tN4rAB49GBQ487MSO00Lzurfwk7hHU1r0ezZv5jSgQfHSh8a0fVNhd
	mfnP1T2FVO4Z0/hKUjNbJgwa0+EaBD5fsNceZehugsZjZn1Xo1DxoU3Dr4JPNiBB0uq00A
	k8PudxQQkdTA2IjAIWXIQIlrW+yTUOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-j19lGPS5OQupQRvxOvyggw-1; Fri, 08 Sep 2023 10:19:56 -0400
X-MC-Unique: j19lGPS5OQupQRvxOvyggw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12EDC101A529;
	Fri,  8 Sep 2023 14:19:55 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B40852026D2B;
	Fri,  8 Sep 2023 14:19:50 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	kexec@lists.infradead.org
Subject: [PATCHv5 0/3] enable nr_cpus for powerpc
Date: Fri,  8 Sep 2023 22:19:38 +0800
Message-Id: <20230908141941.13660-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_072008_387975_E0C21724 
X-CRM114-Status: UNSURE (   8.63  )
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

It is a long time since my last v4 [1].

The code has undergone great changes. The paca[] array has been
reorganized and indexed by paca_ptrs[], which dramatically decreases the
memory consumption even if there are many unpresent cpus in the middle.

However, reordering the logical cpu numbers can further decrease the
size of paca_ptrs[] in the kdump case. So I keep [1/3], which
rotate-shifts the cpu's sequence number in the device tree to obtain the
logical cpu id.

Patch [2-3/3] make efforts to decrease the nr_cpus to be less than or
equal to two.

[1]: https://lore.kernel.org/linuxppc-dev/1520829790-14029-1-git-send-email-kernelfans@gmail.com/

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Wen Xiong <wenxiong@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org

Pingfan Liu (3):
  powerpc/setup: Loosen the mapping between cpu logical id and its seq
    in dt
  powerpc/setup: Handle the case when boot_cpuid greater than nr_cpus
  powerpc/setup: alloc extra paca_ptrs to hold boot_cpuid

 arch/powerpc/kernel/paca.c         |  10 +--
 arch/powerpc/kernel/prom.c         |  26 ++++---
 arch/powerpc/kernel/setup-common.c | 106 ++++++++++++++++++++++++-----
 3 files changed, 111 insertions(+), 31 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
