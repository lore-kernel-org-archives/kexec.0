Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FFDC6379F
	for <kexec@archiver.kernel.org>; Tue, 17 Jan 2023 03:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=px49JrRf5IHX+dr9udBWOrAfU7BLClKOTF3ii2p4IGQ=; b=3LH89CJ7CxwH7g
	WOVgmOY5Kq6yhGypGysDP3Za5/kovTy0pO+VGVvuTghn/zNGdwkKUxZXXI/z7GeZpJXXVFMzHNsAx
	6fR7c3PTmqlUtI7Wk6rz3mHk2BvY/8jbZTf/7ez/ZwmBehZsMGg40S0HXdhtHeOoB9VDmmuA7H4r0
	v4X2M9zY//fpaki0HDs+n4dGfBfdigjoLZITECy4XE8NfB7aNb+SwGlA17P7FLTT6S5nouicaVgz0
	66LflLW+NFlVKBnVBbOqKZDIhLd2N73oo3Lamezr8LmtbGDohjSSNOuE04rDnIJ6ZiPPoXrZSJ6jK
	TglKfr2YtGcnY51ki6ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHcyl-00CnuV-Ow; Tue, 17 Jan 2023 03:49:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHcyj-00Cnrn-DM
	for kexec@lists.infradead.org; Tue, 17 Jan 2023 03:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673927374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d6j1pwwcrVA2VMufpYBThaFRk5AuLZLztdhG3ETtdEQ=;
	b=A1pDL7CN0KnjNTcIMeWF1nL38uaufyJJW8q2uSvizgA2f+Zk6RshYtvmPXyNUodODH0MN0
	w9KN8MaQBTWgWROWdTqXaxaPs9mTRI9XQ7gnoZPNhfF+O+/aGLUQqW0oCIYuv1kqfUEoHw
	ajjhKWgraqnJyHF9E+204ON64ahlZng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-m9NhwEysOritgPQaMb4Hkg-1; Mon, 16 Jan 2023 22:49:30 -0500
X-MC-Unique: m9NhwEysOritgPQaMb4Hkg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D72FD185A794;
	Tue, 17 Jan 2023 03:49:29 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-12-229.pek2.redhat.com [10.72.12.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 336091415108;
	Tue, 17 Jan 2023 03:49:24 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	thunder.leizhen@huawei.com,
	John.p.donnelly@oracle.com,
	wangkefeng.wang@huawei.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
Date: Tue, 17 Jan 2023 11:49:19 +0800
Message-Id: <20230117034921.185150-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_194941_559106_81CC40C9 
X-CRM114-Status: GOOD (  11.32  )
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

After crashkernel=,high support was added, our QE engineer surprisingly
found the reserved crashkernel high region could cross the high low
memory boundary. E.g on system with 4G as boundary, the crashkernel high
region is [4G-64M, 4G+448M]. After investigation, I noticed on arm64,
the area near 4G is contiguous. Not like x86, its firmware occupies the
cpu address space below 4G. When memblock searches for available memory
region top down, it could find a region across 4G boundary. Finally, we
actually got two memory regions in low memory. This complicates the
crashkernel=,high behaviour, people will be confused by this.

In this patchset, simpliyfy the behaviour of crashkernel=,high. When
trying to reserve memory region for crashkernel high, we only search for
the region in high memory, e.g above 4G. If failed, try searching in low
memory. This makes sure the crashkernel high memory limited in high
memory, confusion is removed.

In patch 2, I add code comment above several crashkernel reservation
case to ease code reading. I put them in a separate patch 2 because I
want the code change in patch 1 to be straightforward and simpler for
reviewing.

Please help review and check if this is helpful and worth.

Baoquan He (2):
  arm64: kdump: simplify the reservation behaviour of crashkernel=,high
  arm64/kdump: add code comments for crashkernel reservation cases

 arch/arm64/mm/init.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
