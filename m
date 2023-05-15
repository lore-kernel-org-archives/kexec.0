Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5218CC77B75
	for <kexec@archiver.kernel.org>; Mon, 15 May 2023 06:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CEJ+EK/OIj5LA0S+2wzsRqvrrKPk5a8XEZpnQqBA1sU=; b=ZX0pCFrkjUabRO
	+fGjDVex+/OVD/YcGqTfH6X1PR77e4mFEtHuggsdG6ZUUO1IRk3MnQ8pMwyoFSnX1SbVdDU+MoDnh
	1aGXSUs6WgJZoam0YLXx7c+IGnEGFn4C4C55yUnFfpeBTtR1TOiIt4p+9LTtNwePcpSFdUoBcHnEJ
	kMyRt6nvNxPZbJhwyyvBq8nn0TrPTI3YoxyR+8eUJOIR8MsRmIh4jNObNgt0uRGY7nd0OWGVXkF5B
	C1PD4l11ojQfffuLqmDoatxe1kydWcLyF/Y8+lSKFOL6HHR/Luj3X1493jV16fB0S8ghk8vXzOZqJ
	OIyHhlF2vA6UWIbZuwTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyRIl-0013CQ-2n;
	Mon, 15 May 2023 06:03:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyRIh-0013AL-1D
	for kexec@lists.infradead.org;
	Mon, 15 May 2023 06:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684130591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KwvjAcU6+K06SNPtN9LrkEogqw2dJLjTTDcGRcC1x2U=;
	b=QvT+ssF/XOzzIQ8oL+G05V8K9EftPCQkBGzmTReFJrv8dGtJ6f2AwYxRtaUj8yMi0BvfQi
	bci7fyphd2u3hFMmuCeOkXY0/P1F/+ebc7WkQRCCE45Xwxm3HbTvz6oMf3UYlVDhLDBFXT
	KMhY18MTHLBIKMVLt8rRMpQgvJXY8ds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-87bFa3QDMXu8R3FsN1FjeA-1; Mon, 15 May 2023 02:03:07 -0400
X-MC-Unique: 87bFa3QDMXu8R3FsN1FjeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6034885A5A3;
	Mon, 15 May 2023 06:03:06 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30514400F5A;
	Mon, 15 May 2023 06:03:01 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	horms@kernel.org,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date: Mon, 15 May 2023 14:02:57 +0800
Message-Id: <20230515060259.830662-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230514_230315_509757_9B7F97FD 
X-CRM114-Status: GOOD (  11.07  )
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

In v5 patch, Catalin helped review and acked the patch. However, an
uninitialized local varilable is warned out by static checker when Will
tried to merge the patch. And Will complained the code flow in
reserve_crashkernel() is hard to follow, required to refactor. While
when I tried to do the refactory, I feel it's not easy, the existing
several cases causes that.

To make the code easier understand, I try my best to compose a document
to introduce the background, concept and implementation strategies of 
crashkernel reservation. Hope it can help people to understand the code
flow a little more easily.

[PATCH v5] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
https://lore.kernel.org/all/20230407022419.19412-1-bhe@redhat.com/T/#u

v5->v6:
- Fix the warning reported by static checker about "uninitialized symbol
'search_base'".
- Add a document Documentation/arm64/kdump.rst to explain how to reserve
  crashkernel.

Baoquan He (2):
  arm64: kdump: simplify the reservation behaviour of crashkernel=,high
  Documentation: add kdump.rst to present crashkernel reservation on
    arm64

 Documentation/arm64/kdump.rst | 103 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c          |  44 +++++++++++----
 2 files changed, 137 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/arm64/kdump.rst

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
