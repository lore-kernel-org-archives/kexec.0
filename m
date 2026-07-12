Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0EDC43458
	for <kexec@archiver.kernel.org>; Sun, 12 Jul 2026 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=ZyUBwWtl42dThfa8ulAIiuiO/izeg++d6IRRmXHtIwA=; b=yoe93T3oJbXjVNCL4laSvBSo22
	LdR5JVLVqZPnJhESGuxosM0OWpYZ+MNoPzaPUHSoNEQMIOVbJnJkSeFDJriTLAfsVgQ6u4ouSahEp
	F3kfnrVapjRBtlfOwougY9MNk4RITTnlShyP7L7/sIrK3nonQsn0/it3WaTyGsHSNrsmpBBzRDU8L
	thn4XtaE5oPF2KCQyu6Ml/mnvHXcXF+wjWk3LfdC9JEROAs59pZSnkip0+piRKz9hNoOi51nrfe+X
	sGEkAeyEEY2kCRyVWy//HCc6VYQUs+Copmhx8zwxAYwDVdvve5eM9TorQQBassMiJof0qbfCoJQlD
	DtqUCg7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wistp-00000007QrL-3QfF;
	Sun, 12 Jul 2026 12:03:09 +0000
Received: from latitanza.investici.org ([2a12:4180:dc1:929::42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wistm-00000007Qps-3idi
	for kexec@lists.infradead.org;
	Sun, 12 Jul 2026 12:03:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783857773;
	bh=ZyUBwWtl42dThfa8ulAIiuiO/izeg++d6IRRmXHtIwA=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=SjNuVb3G7BfHpMPUHidibEhu0a5BPxxItmx/qX6mqkIiyhBc4BiMP/U2uhfiNhKxg
	 epemljzC59wPFvT1r/TCw22a4lDAUoKTRDLv8VXW/Qhvb/SyJ1rjJloTP498waCS8X
	 4GDLR37hOY/Ot5QJQRILcLw5Xr1poX52PvhmWkd0=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4gykj948pPzGpXq;
	Sun, 12 Jul 2026 12:02:53 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4gykj91xsHzGpXJ;
	Sun, 12 Jul 2026 12:02:53 +0000 (UTC)
Date: Sun, 12 Jul 2026 13:02:52 +0100
From: Bradley Morgan <include@grrlz.net>
To: baoquan.he@linux.dev
CC: akpm@linux-foundation.org, coxu@redhat.com, kexec@lists.infradead.org,
 lgs201920130244@gmail.com, linux-kernel@vger.kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, rppt@kernel.org,
 ruirui.yang@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_crash=5Fdump=3A_release_k?=
 =?US-ASCII?Q?eyring_reference_at_the_correct_time?=
In-Reply-To: <alOB02chtcQcG6lo@MiWiFi-R3L-srv>
Message-ID: <60D4A5AC-8B51-42B9-A605-835D253B3CCD@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_050307_363339_50A487A7 
X-CRM114-Status: UNSURE (   2.38  )
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

Nice! :)

Reviewed-by: Bradley Morgan <include@grrlz.net>

Thanks!

