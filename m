Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825F0C5AD55
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 14:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=2hiFBSdy7ThMtvj+ZlexYBwz4mqUTCW5FnQ3rSMFV4I=; b=r/ljpxYl/CIlvs36Th4dvOG7uJ
	yr/XYZFNWLYuykn02fy2fEe1fFY9OelLOuRkPF1/7wjBJiKFFAsrHn/+qx8O0SkFipdPnVXLVSH5e
	FEAyntTxaVdltbwRyN+miuV5TZh6RlYiv446EvxniVEDmvGvaHDDmNKGrq8wB5SmhKu7zQGWrLKsB
	udEJQ/Ouc3CdODUTTcmY6m+lE75JgsLQJMDyS5UhZ+U+WZXpXb5uGExo9z7osaVbSIO6pnyULtIBQ
	PyJ0k1PYrNkIhZpo2ZJc9URLMzrWVwKZtdhmKwYVndjCtBFislm5z6s9L5AlSsqW1NCxmpNDog0eO
	c8XPQHsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRD9-0000000C2xn-2U5Q;
	Mon, 10 Aug 2026 14:42:43 +0000
Received: from confino.investici.org ([2a11:7980:1::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRD6-0000000C2wS-1vrq
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 14:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786372956;
	bh=2hiFBSdy7ThMtvj+ZlexYBwz4mqUTCW5FnQ3rSMFV4I=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=mkwJrvOuE026sm3XI6fTVDkbFjBBTw4UCP6T8ekTZkarPrh4i2aFXJGgOSkQj6Y3y
	 7L1kdQLU1kGa++AD7LFxRUT4+kHX2upbvYBa4Hbic3hyBi/M+KuRL968YXI9KwBRXK
	 CVrZSHvI3j3LrQfpTbdQZDLVLASZzdWi7CDM2gcw=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hJct40J4Gz10tW;
	Mon, 10 Aug 2026 14:42:36 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hJct3484tz10ss;
	Mon, 10 Aug 2026 14:42:35 +0000 (UTC)
Date: Mon, 10 Aug 2026 15:42:37 +0100
From: Bradley Morgan <include@grrlz.net>
To: leitao@debian.org
CC: akpm@linux-foundation.org, baoquan.he@linux.dev, david@kernel.org,
 kas@kernel.org, kernel-team@meta.com, kexec@lists.infradead.org,
 liam@infradead.org, linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ljs@kernel.org, mhocko@suse.com, nao.horiguchi@gmail.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, riel@surriel.com,
 rmikey@meta.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5=5D_kexec=3A_keep_the_next?=
 =?US-ASCII?Q?_kernel_off_hardware-poisoned_pages?=
In-Reply-To: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
Message-ID: <59D6BB94-6379-46FA-9A54-C8CDE660CFF2@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_074240_933310_0A74BD53 
X-CRM114-Status: UNSURE (   2.65  )
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

hi, I feel this looks right to me.

Reviewed-by: Bradley Morgan <include@grrlz.net>


Thanks!

