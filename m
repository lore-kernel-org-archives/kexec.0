Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EED5CD4F26
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Mime-Version:Date
	:Subject:In-Reply-To:From:Content-Type:Content-Transfer-Encoding:Message-Id:
	Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SK3vFTqQy3kkPGC8qGl4oYX8UeCavT8YGzJtI087N0I=; b=IeRAI+1Cg0qpEPde3N/oqQOXBf
	37cpzD2I9YwkTlUE/KzlQOukwSk/WEHFMOnrevfoe6pyFrihMc96Y9BzxZ67oOxn1cqiWKL8sfs2L
	9s2b6PrC6daASb3BNK3qetjgvOXhCMwzG1wfU4kyjHm/PPwo2orjCwgQM99sw7qY+P5MOmn1MPaEs
	fV7ZcHo4j/CKMN9PJtj1glnZrSIb1XZzHM0S3IHbLUAZm+7udm/Q2WvsxxMUR/oOc9HuSGs77pfno
	j4sOKFA0lVHMtaUXeJORGcISJodoK6h/x1F7yxfjG5KDLAP1Unfkk0MQKwcaOSBUBDW6BKvfFRsB5
	d45b0D+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMhRV-0000000FuJ8-00gS;
	Tue, 12 May 2026 07:22:13 +0000
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMhRS-0000000FuI6-2hJz
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 07:22:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778570521; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SK3vFTqQy3kkPGC8qGl4oYX8UeCavT8YGzJtI087N0I=;
 b=AR1ro+1MTYdxuPYfD8u0/E2h274yJBCQv6PM2b4aeHjsvIZPwt6ncwSM06Hgb1Cbh4Q21p
 LAQ8GAAyXbf5X4OSA9khuad4SRX6QWMr+og7SFq1FI90fhqujZWulGGOz0UOwprkzKtf4F
 0HgsT1DeAM/Xcs22vqCZ5y0ZkD2w0cVqn4wgZZbg9xw5jfXjRAUdBA+hSFjL/00+s8WXCy
 h3y8pxfk9/oStqMBEa6ELDrxnlfq5f2e2xJzXsY01BTtMF0OsAHUvPESapt7oJGtlVq60u
 BGOTCUWqB+e/sMod4vJ1BJTRqUaEUQYHq7KZYn0MGB2iNVbDNbjwrcAdVh8MUA==
To: <kexec@lists.infradead.org>
Cc: <k-hagio-ab@nec.com>, "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260512072142.58396-1-qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+26a02d516+a3d232+lists.infradead.org+qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>
In-Reply-To: <20260506115758.2497610-1-qirui.001@bytedance.com>
Subject: Re: [PATCH][makedumpfile] Fix riscv64 virtual-to-physical address translation
Date: Tue, 12 May 2026 15:21:42 +0800
Mime-Version: 1.0
References: <20260506115758.2497610-1-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.52.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_002210_757366_4838F1D9 
X-CRM114-Status: UNSURE (   2.56  )
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

Ping.

This patchset has been out for 6 days without feedback. Could anyone
please take a look?

Link: https://lists.infradead.org/pipermail/kexec/2026-May/036059.html

Thanks,
Rui Qi

