Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2AFEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2fKbbItV/cG2bibwPuLvstxwaeRozFdt7J3w2QJtPc0=; b=0Kgh7m5O8ORIsh
	HHvZ9j9NZogkCr2ovIvsaIfv+l8/nQJP+yZhgAZYm6uFBAB4fjwH9WYFSqkAUCfRSatUHfLt/8Sez
	gxK9D/kZPuIbFSg/sKSPtbwgul/TCSAzo5LINtpm337jafpWwXhKxyzIeGVOyoOKrxyECYt1h/N6L
	bWbPO6nFDtw+CdATT9NuKm2OgAW8VNFG0TesZwpOZNbfaA9Lyhr8BkzTaycbCvBuXgU+YQdoCT0F1
	GQfK3AVtN/ZVdmKgtEikVGmLrHYGktF21QQWJn0SgiHdyMtQMVfiU0qT9k6uQuBMKA2lXpjCs0mY5
	K05Lem/pDUagrnyPNCrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfgox-000alQ-1S;
	Mon, 11 Sep 2023 13:19:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfgou-000akY-10
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 13:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694438350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=23bwaDVIUeu1xrOkLjrcpotMczUMf0CbTLoopyLaEdA=;
	b=Sn+QnYEa6g/wejjVptVB/861Uk9ov0+94kvwSgu0PCCZM64cGPtwy9iqC2iiGDuC8sE8iC
	zqGsFzm+xNwSqasykHgwijDo0Gs7p0Vn+vAPqYAJsYqG+MlYF65CexnJNodcw3rJtZ6ACd
	0BYBoT003h+z2aiJvxEjqcGKS3UU9XU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-6aQ1HiQLPTmuF6_IFR5hlw-1; Mon, 11 Sep 2023 09:19:05 -0400
X-MC-Unique: 6aQ1HiQLPTmuF6_IFR5hlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26680101A529;
	Mon, 11 Sep 2023 13:19:05 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (unknown [10.72.120.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE692156701;
	Mon, 11 Sep 2023 13:19:00 +0000 (UTC)
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
Subject: [PATCHv6 0/3] enable nr_cpus for powerpc
Date: Mon, 11 Sep 2023 21:18:52 +0800
Message-Id: <20230911131855.40738-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_061916_499409_F505BEDD 
X-CRM114-Status: UNSURE (   9.36  )
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

v5 -> v6:
  assign nr_cpu_ids by set_nr_cpu_ids() to tackle with the issue if nr_cpu_ids is
configured as a constant

Pingfan Liu (3):
  powerpc/setup: Loosen the mapping between cpu logical id and its seq
    in dt
  powerpc/setup: Handle the case when boot_cpuid greater than nr_cpus
  powerpc/setup: alloc extra paca_ptrs to hold boot_cpuid

 arch/powerpc/kernel/paca.c         |  10 +--
 arch/powerpc/kernel/prom.c         |  28 +++++---
 arch/powerpc/kernel/setup-common.c | 106 ++++++++++++++++++++++++-----
 3 files changed, 113 insertions(+), 31 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
