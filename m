Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9186CC47072
	for <kexec@archiver.kernel.org>; Wed, 27 Dec 2023 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D67xP64ZTtvMs5N2xR3n7rssVgdlebHQ3MlokfF8Kzs=; b=OJjW7wwqTjfZ+A
	8ZeY1ulYb83Q/3wbdPeoMEot5+oT2rvJlhKYRx5+PDpcNqn83CdqrcZkV195r+NzYwsptWg9D6WDf
	L5Cyd1LNNF7hiQ+tHuy+4S+qrAFpIUt+uZtYifniAdPYoklAmBAR0bW2hJ4Q0FnusLD3bT4yzSE2I
	86ekRbKS/3jlVkMIZG31VClqY+VUcyd76/KmuCrMjrvdzS1rXaaIv2BbaVvNWlMU+1F4qDH/h6jDg
	mvjhmnlhnNMm2tCA6bjaV8ilBnlqAISP02Bie4Ao53vXhqo1U5jWvkYbHB/yPj184py92wd3ps1b9
	4riLyg95TyCqhBOpBvUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJpt-00Dq2I-2E;
	Wed, 27 Dec 2023 02:39:57 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJpp-00Dq1i-1T
	for kexec@lists.infradead.org;
	Wed, 27 Dec 2023 02:39:54 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28c91894510so31668a91.1
        for <kexec@lists.infradead.org>; Tue, 26 Dec 2023 18:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703644791; x=1704249591; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SboSrGqWOteY4UZlaqkB5wcdrVV7EfEGe2NbvHZ/6A8=;
        b=SbEq6bvGkYfP4RT3A7Ad7VKlfh46ZVFKpGrBkbxvW2sfY41ND0g8R5XKWXEaFXKSp+
         TdSK83JSkZJru4ot/ymAUd1a1lappegzWd8DKnkq834UTAWbiMBf93wh7qFVMSlLKZQn
         8x9ivbRmOTxqTyiWDzGfUJWQW7m0nIblQqcClkn+DeZYZ4mSh3MWKq1AM+VXv14C/gTs
         Rw/ig3h+Q2yLrh5qagu4VlnYCqbA/ibEkj2r++A0kRWPlDM9D/hLkyj9UNV6yyE1Kp7B
         r7rshTfRbr0yH+JAnE0nlDximl/i+b8WURJOxBmxjSkP+IxoiEb+vOR2g1R9QHluNMzw
         ncVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703644791; x=1704249591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SboSrGqWOteY4UZlaqkB5wcdrVV7EfEGe2NbvHZ/6A8=;
        b=u6O5H9kFMSMBJzIsIz0D/RGWIxGjwdEd+HOYjPIA4rUwzwXEb/SzDck5yI+WFIAgzq
         CmTqn5rG67D3YcZk9nzYAR3Si45LD8oJR18EjhJBLgPrzHnVhF1J3BrKPGfboahbN0zB
         VMlRHcLXMnb3KnPhVLd0+/Xkh6xXSeK6qWSFBLiIHWGZcdijchtUcXf4Yf/yiU6XUKvG
         kEXc5noHIgDvpplI6VbfshA31GeMf8QZD2c8CmVfbuBZcX8Tzlp4QlpjECRNwAdev8Y5
         aATg8bOJq7XWsWMGhU9F9Sz7/3ljkYOCfzNkVajBHYCjLYdXEvfHTS8S9pKPoSp+LmCV
         Op+Q==
X-Gm-Message-State: AOJu0YxOHgL9dVX4oFk5B64NxXcfNDhwIepvtaYNwxwX3fofFTqeLiJa
	XhxdBDw4q/5Xw4JCcH1JbA==
X-Google-Smtp-Source: AGHT+IGIJgWT0l1nDA1jwD7Vix95y08PvJIxQUcIwxmsrqnGgX8x1c3u48LdYJvTfJlj/5kiAXGKFw==
X-Received: by 2002:a17:90b:3849:b0:28b:ef08:2673 with SMTP id nl9-20020a17090b384900b0028bef082673mr2177529pjb.64.1703644791505;
        Tue, 26 Dec 2023 18:39:51 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a134800b0028c387b2528sm6727454pjf.8.2023.12.26.18.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 18:39:51 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <piliu@redhat.com>,
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
Subject: [PATCHv10 0/3] enable nr_cpus for powerpc without re-ordering cpu number
Date: Wed, 27 Dec 2023 10:39:31 +0800
Message-Id: <20231227023934.12299-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_183953_498242_CA751573 
X-CRM114-Status: UNSURE (   8.24  )
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

From: Pingfan Liu <piliu@redhat.com>

This series addresses the nr_cpus issue for PowerPC without re-ordering
cpu number. To save the memory used by percpu area, it also limits the
possible cpu numbers by allowing hole in cpu_possible_mask.

Because the last cpu number will bigger than nr_cpu_ids in this way,
some pointer arrays indexed by cpu should be extended to hold the
pointer, e.g. paca_ptrs.

Please notice that this series still has some issue (some cpu can not be
brought up), but before I resolve it. Please share your thoughts about
it.

Thanks


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

Pingfan Liu (3):
  powerpc/kernel: Remove check on paca_ptrs_size
  powerpc/kernel: Extend arrays' size to make room for a hole in
    cpu_possible_mask
  powerpc/smp: Allow hole in paca_ptrs to accommodate boot_cpu

 arch/powerpc/include/asm/paca.h    |  2 ++
 arch/powerpc/include/asm/smp.h     |  1 +
 arch/powerpc/kernel/paca.c         | 24 +++++++-----------------
 arch/powerpc/kernel/prom.c         |  6 ++++++
 arch/powerpc/kernel/setup-common.c | 26 +++++++++++++++++++++-----
 arch/powerpc/kernel/smp.c          |  3 ++-
 6 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
