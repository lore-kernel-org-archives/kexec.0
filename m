Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72912CC6B2A
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gq9Me0DpRMB/8hAjXFH9qO/hxN6qlQORSNAboh1nE1Q=; b=fD6PxzsVcMj7HGUaz9bco7Plt/
	0JEU6vx5Z5Qmk+DwocAeiDCrI4dYGFP4NLnX9aYA2zIp3G42iAtTmYN7KbmE0YLaei0wSEi4kuwuf
	BglEMRRgrcopzTZ4JAJ/VuQPoMgZKj8Fw+o961ZEJL//gWDx6fjGnB5GzqdBQv4RSqX40pQu/rBdn
	kmoTW6HxvH4bHNyb49PLHg7XLgEa1r/7iOGGCyBC1pRB3al6SUQC43z4JOSKAyp9vmONMkhAOMPuB
	l461hEkv+TyaAh3VSg2XytmuITsMdlkm1NMncW/e/ZO8B8mSCmBN4RoahkJz0qY84y617N4znhucG
	0yM1EPZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGvo7-0000000F9aY-0RTE;
	Wed, 14 Oct 2026 10:01:59 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGvnt-0000000F9X5-4Ba2
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 10:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gq
	9Me0DpRMB/8hAjXFH9qO/hxN6qlQORSNAboh1nE1Q=; b=juTtINBjinqvFI6EKd
	dt8OA/a8imzLq1g9iBhTpkgSeXT3WQdpHGhAHRXxKEV7WpblCa+VlbvjmDFGmaRZ
	jAfrI6X1gBzSFB8y6IiNsQFvE4d4gW3o9oeqYRwo1XQ9lq2cWPDdw846sVHGvjDq
	Nj6NHM8sifcOHDfKcT0v4GSeM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3_y3vUs9q6psGEw--.34516S2;
	Wed, 14 Oct 2026 18:01:21 +0800 (CST)
From: Haolong Wang <18766350203@163.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] mm/memfd_luo: preserve the sealed exec-bit state; reject kernel-private shmem files
Date: Wed, 14 Oct 2026 18:01:11 +0800
Message-ID: <20261014100111.79353-1-18766350203@163.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2vxzmrsgipn2.fsf@kernel.org>
References: <2vxzmrsgipn2.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_y3vUs9q6psGEw--.34516S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUO9N3UUUUU
X-Originating-IP: [2001:250:5828:4461:5d0:1f3:be4d:bdab]
X-CM-SenderInfo: jpryllawtvijiqt6il2tof0z/xtbC9RFfJ2rPUvEgDwAA31
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_030156_214436_DB930194 
X-CRM114-Status: UNSURE (   7.40  )
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

Hi Pratyush,

Understood, and sorry for the noise.  The Assisted-by: trailers are
accurate: I used an AI assistant to draft these patches, and the quality
problem is mine -- I did not review the output carefully enough.  I am
withdrawing the series and will not post another revision until I can explain
every line myself and have a much smaller patch with a clear use case.
Please disregard v1-v3.

Thanks for taking the time to say it plainly.

Haolong Wang


