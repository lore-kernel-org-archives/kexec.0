Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E6C43458
	for <kexec@archiver.kernel.org>; Sat, 11 Jul 2026 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CSfqyZKLFQM4Wi3dU8k0/tyPS8lAXJVsZDngsM4+Hxs=; b=aZN9273OcuoTuD
	HBMrt/LCHF0M6QFHfvf74I7V1gVwiWo0ACUDsArdNSTAMO1hGs2hkWgK4fC54KLLSmTaf5ddX7V1Z
	cMqgy9GqNHBK1gp318BQut+T5Ji5MPM5GjnUrzQjju0p3hpEZ5B9guLXzufDVJRb7/ueDtbvFmePO
	4uKhiMjIQQ0NFsU/wPAvQkC5M1Rbp37eJ2Z91KQFUjJDHb+00kHm9a5Pyd5JysCDAFnfWm5bfia4u
	EXAslmOy6xpiChLjH6/oSeoNM6KZiWl5jHoxKh5O3w7xCYjKu+4QXINqJBOuRi4c/NjIpTpj0OxGa
	o8g/YUQKwJa+onD0HXxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUr-00000006358-1Zm7;
	Sat, 11 Jul 2026 00:23:09 +0000
Received: from confino.investici.org ([93.190.126.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUn-0000000631G-41rY
	for kexec@lists.infradead.org;
	Sat, 11 Jul 2026 00:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783729375;
	bh=CSfqyZKLFQM4Wi3dU8k0/tyPS8lAXJVsZDngsM4+Hxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsTLDd/KLNxd4MCJuEmR5cQaIzds1sUghMXGUfWuvXcP4q41Xl9ZS4QTFnX8ati2L
	 NSd2VRR9fEDPuGi7qIA6aMuTGZ1Nsxdu1J/8JKyw++IUwSgCmg+Ls8DNM90E9kI++B
	 lbARkp63V/UM36AVBZawsjSYiu6xU7VV8sEeePzg=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gxqCz2Hkhz114b;
	Sat, 11 Jul 2026 00:22:55 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gxqCy4tCjz113X;
	Sat, 11 Jul 2026 00:22:54 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [RFC PATCH 3/4] misc/pvpanic: notify the host on the pre kdump list
Date: Sat, 11 Jul 2026 00:22:52 +0000
Message-ID: <20260711002253.1115-4-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711002253.1115-1-include@grrlz.net>
References: <20260711002253.1115-1-include@grrlz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_172306_149776_37FD34BA 
X-CRM114-Status: GOOD (  10.15  )
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
Cc: pmladek@suse.com, include@grrlz.net, baoquan.he@linux.dev, arnd@arndb.de, corbet@lwn.net, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Writing the panic event to the pvpanic device is a self contained
upcall, and pvpanic_send_event() already takes pvpanic_lock with a
trylock, so the callback satisfies the contract as is.

The INT_MAX priority is kept so the host hears about the panic
before anything else on the list runs.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 drivers/misc/pvpanic/pvpanic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 17c0eb549463..c409968228e4 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -218,7 +218,7 @@ static int pvpanic_init(void)
 	INIT_LIST_HEAD(&pvpanic_list);
 	spin_lock_init(&pvpanic_lock);
 
-	atomic_notifier_chain_register(&panic_notifier_list, &pvpanic_panic_nb);
+	panic_notifier_register_pre_kdump(&pvpanic_panic_nb);
 
 	return 0;
 }
@@ -226,7 +226,6 @@ module_init(pvpanic_init);
 
 static void pvpanic_exit(void)
 {
-	atomic_notifier_chain_unregister(&panic_notifier_list, &pvpanic_panic_nb);
-
+	panic_notifier_unregister_pre_kdump(&pvpanic_panic_nb);
 }
 module_exit(pvpanic_exit);
-- 
2.53.0


