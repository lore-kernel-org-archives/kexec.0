Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBEBD46BE6
	for <kexec@archiver.kernel.org>; Wed, 28 Jan 2026 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Cc:To:From:Subject:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MwsAKtB1TdslBChA/QaO2udawN6BW3NQscLnpI6z1uk=; b=rv0zHgFYPIL6BVPLGjgz/4zWhw
	e9LG2bCOMjlaGOYOZnZVtV/mjA8gTBwxsFX59E7qRM/6crEJcXjYsZ/cfiqQc/JcppI1EnWw/AjF1
	r1Rx4sH0gZqdCptv40k4W29kmjfYxVKYsIoTE27PzXyAycNCEOqLS8+fbAuunrrmpLH4PlA4h3/RE
	bdtTcmHMnZ15Caq9BQSWHxYZq3ZCJA1/YbqC2pcTDaztRPKzc/32Z8BLYtmovlnAk5cG4rnHcOLZG
	+zyAHCV3dXoywpkEJE9dyzepvTOiBEa0WwzcEcj5lcYoceGicR7d0jqBdubCTuQoHtEs/dr6c2hID
	lrDsAcpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl9YI-0000000GVoq-32xf;
	Wed, 28 Jan 2026 17:42:02 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl9YD-0000000GVoW-1gNB
	for kexec@lists.infradead.org;
	Wed, 28 Jan 2026 17:41:58 +0000
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80BCE20B7165;
	Wed, 28 Jan 2026 09:41:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80BCE20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769622116;
	bh=MwsAKtB1TdslBChA/QaO2udawN6BW3NQscLnpI6z1uk=;
	h=Subject:From:To:Cc:Date:From;
	b=J4DTxvm4kRrZgoQn30xmwcM1RG7SvmBji6ufucYKoNL/rQlySET+GZZORrK6foPw0
	 8aED/KJYFEw97QPvFdxQcisN8zfEie/lu5/mqEl8Anium4xSuQJUm5zuV0E1vnCEKb
	 31RxVY2zTKNw2heWXh54Cj4apQr5MJR1AJ7wSWmg=
Subject: [PATCH 0/2] kexec: Refuse kernel-unsafe Microsoft Hypervisor
 transitions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 28 Jan 2026 17:41:56 +0000
Message-ID: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_094157_487668_26F426DF 
X-CRM114-Status: UNSURE (   7.83  )
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

When Microsoft Hypervisor is active, the kernel may have memory “deposited”
to the hypervisor. Those pages are no longer safe for the kernel to touch,
and attempting to access them can trigger a GPF. The problem becomes acute
with kexec: the “deposited pages” state does not survive the transition,
and the next kernel has no reliable way to know which pages are still
owned/managed by the hypervisor.

Until there is a proper handoff mechanism to preserve that state across
kexec, the only safe behavior is to refuse kexec whenever there is shared
hypervisor state that cannot survive the transition—most notably deposited
pages, and also cases where VMs are still running.

This series adds the missing kexec integration point needed by MSHV: a
callback at the kexec “freeze” stage so the driver can make the transition
safe (or block it). With this hook, MSHV can refuse kexec while VMs are
running, attempt to withdraw deposited pages when possible (e.g. L1VH
host), and fail the transition if any pages remain deposited.

---

Stanislav Kinsburskii (2):
      kexec: Add permission notifier chain for kexec operations
      mshv: Add kexec blocking support


 drivers/hv/Makefile            |    1 +
 drivers/hv/hv_proc.c           |    4 ++
 drivers/hv/mshv_kexec.c        |   66 ++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h         |   14 ++++++++
 drivers/hv/mshv_root_hv_call.c |    2 +
 drivers/hv/mshv_root_main.c    |    7 ++++
 include/linux/kexec.h          |    6 ++++
 kernel/kexec_core.c            |   24 +++++++++++++++
 8 files changed, 124 insertions(+)
 create mode 100644 drivers/hv/mshv_kexec.c


