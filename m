Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CE9C07E9D
	for <kexec@archiver.kernel.org>; Thu, 29 Sep 2022 04:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GoQ1EBPeVwDBmzuax8S5PL8rmQMFmugOYfNM7z3Pzlo=; b=WAiuRJ25PW6qur
	/h7l38uFurj8zbwLO81MMdTc3/ligHwlGn9cCnm9p1T1cxzjDDa3lb7Vbu2kI7RdFqcEyufLOFaxu
	n891VbVhNI3m0yRoNqJpfAqcyUvU3cLuKQ9uEEOLpm2oYgbai+94U8pSDgssaLMlRVwU8qKu5GZZ4
	jcMPNI3E2fCQM2tgxA9bj3WxCW8BVeu6fY4rRXokQXLwVufHhMTRQgHXVs60X00MWdFiqcNsFKbi7
	tzy+LgoTnPXIl1t8V+jil8XsVORcs50wKuwumUFno6sXhEpZGmfqIr8kOxHwe3PlGUrTHedjrycNR
	SjHmKFArTKnTQvWlF5Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBI-0019uE-Kz; Thu, 29 Sep 2022 04:29:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBF-0019tU-PU
	for kexec@lists.infradead.org; Thu, 29 Sep 2022 04:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664425788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M1eGJAy9JUkESfaO/ZbKwDLtqZLkZ000Az8C4hJ30SA=;
	b=W26Uvkipjvor+94co9l3tIBRVMMm/0pWWPU4Vfn3zcXIQqMJLPk26PoRC907w2qspwwB9l
	UJ1J292NSR9HgD2OgMNHsLW8p7dyFLtKdOPXApIZft+D3jNoGfImibQ9pcTltF0Mdw4vB0
	bhNdEdKRxt/5q5d0PfJKlRwcVlIwxWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-JvxKXV_XOnaIq5hBsAQyEw-1; Thu, 29 Sep 2022 00:29:44 -0400
X-MC-Unique: JvxKXV_XOnaIq5hBsAQyEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C20F85A583;
	Thu, 29 Sep 2022 04:29:44 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-179.pek2.redhat.com [10.72.13.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63AF07AE5;
	Thu, 29 Sep 2022 04:29:39 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	ebiederm@xmission.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 0/4] Some minor cleanup patches resent
Date: Thu, 29 Sep 2022 12:29:32 +0800
Message-Id: <20220929042936.22012-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_212949_912327_619E7F8E 
X-CRM114-Status: UNSURE (   9.48  )
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

These three patches are reviewed and acked, are all trivial clean up
patches.

And for the patch "kexec: replace crash_mem_range with range", I got a
ibm-p9wr ppc64le system to test, it works well.

Hi Andrew,

Please help pick them into mm-nonmm-unstable branch.


Chen Lifu (1):
  ARM: kexec: Make machine_crash_nonpanic_core() static

Jianglei Nie (1):
  proc/vmcore: fix potential memory leak in vmcore_init()

Li Chen (1):
  kexec: replace crash_mem_range with range

ye xingchen (1):
  kexec: Remove the unneeded result variable

 arch/arm/kernel/machine_kexec.c   |  2 +-
 arch/powerpc/kexec/file_load_64.c |  2 +-
 arch/powerpc/kexec/ranges.c       |  8 ++++----
 fs/proc/vmcore.c                  |  1 +
 include/linux/kexec.h             |  7 ++-----
 kernel/kexec_core.c               | 10 ++--------
 kernel/kexec_file.c               |  2 +-
 7 files changed, 12 insertions(+), 20 deletions(-)

-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
