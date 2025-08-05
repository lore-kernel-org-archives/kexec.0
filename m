Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB06C87FD1
	for <kexec@archiver.kernel.org>; Tue,  5 Aug 2025 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YSXKdaD3IZAs8uieY7LPn8yhD3PkW5u9fBN/Is1bw+s=; b=SXcqA5SHMEdzGvFELZy7Ixcf9Y
	v1lm87O+molZ0uEDbb6Be2X+HHUZM3ezbcPwQVbgJHhg26yFBJCZAOiU07EqxVCnc52892RwP4WxC
	2WGjcqUub/glV31koQRIc6SskOZeCspIe24t7Aa/AM5pCOVjcaLclnwSDJLvd+fJfhSD0soDl8hV+
	Ksp0LlTkfHg42KRpneKG/cdTKSHB2G/21of5Fp5miPyURbu4WTYrsOmR53luf9eDdEdEBFipEoAwN
	fbZN1MPtid1E3spNQBK9+pngHJZS8Hj1qre5MaqVck0FlJGp+kKOI7GHwmke2tboNCyV6rTevrJ6Z
	jC+5f77A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujB8J-0000000Bszt-3rfy;
	Tue, 05 Aug 2025 06:26:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujB5S-0000000BsZR-1k09
	for kexec@lists.infradead.org;
	Tue, 05 Aug 2025 06:23:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754375028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YSXKdaD3IZAs8uieY7LPn8yhD3PkW5u9fBN/Is1bw+s=;
	b=D0h1v36EtZa4cj9I/ENQAT9QWZjWKH+awl+J5h+3hknM54CctSwUiaWV+D0mH4xqVoBbIX
	l9UcFA2D/Q5zTzIUKYrSmVVJt1br73J4CYV3CUi2eZVcrs+oCO4z4CTTkgVoA15FRHYqjN
	zWm83BAJ86r66F+KiBLOtPz1K1rhyDs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-L51CUMXUOgaWzMV0lMozWg-1; Tue,
 05 Aug 2025 02:23:44 -0400
X-MC-Unique: L51CUMXUOgaWzMV0lMozWg-1
X-Mimecast-MFC-AGG-ID: L51CUMXUOgaWzMV0lMozWg_1754375023
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D3CD180045C;
	Tue,  5 Aug 2025 06:23:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AF5F1956094;
	Tue,  5 Aug 2025 06:23:36 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/4] mm/kasan: make kasan=on|off work for all three modes
Date: Tue,  5 Aug 2025 14:23:29 +0800
Message-ID: <20250805062333.121553-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_232350_656276_4D0075D6 
X-CRM114-Status: GOOD (  12.03  )
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

Currently only hw_tags mode of kasan can be enabled or disabled with
kernel parameter kasan=on|off for built kernel. For kasan generic and
sw_tags mode, there's no way to disable them once kernel is built. 
This is not convenient sometime, e.g in system kdump is configured.
When the 1st kernel has KASAN enabled and crash triggered to switch to
kdump kernel, the generic or sw_tags mode will cost much extra memory
for kasan shadow while in fact it's meaningless to have kasan in kdump
kernel.

So this patchset moves the kasan=on|off out of hw_tags scope and into
common code to make it visible in generic and sw_tags mode too. Then we
can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
kasan.

Test:
=====
I only took test on x86_64 for generic mode, and on arm64 for
generic, sw_tags and hw_tags mode. All of them works well.

However when I tested sw_tags on a HPE apollo arm64 machine, it always
breaks kernel with a KASAN bug. Even w/o this patchset applied, the bug 
can always be seen too.

"BUG: KASAN: invalid-access in pcpu_alloc_noprof+0x42c/0x9a8"

I haven't got root cause of the bug, will report the bug later in
another thread.
====

Baoquan He (4):
  mm/kasan: add conditional checks in functions to return directly if
    kasan is disabled
  mm/kasan: move kasan= code to common place
  mm/kasan: don't initialize kasan if it's disabled
  mm/kasan: make kasan=on|off take effect for all three modes

 arch/arm/mm/kasan_init.c               |  6 +++++
 arch/arm64/mm/kasan_init.c             |  7 ++++++
 arch/loongarch/mm/kasan_init.c         |  5 ++++
 arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
 arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
 arch/riscv/mm/kasan_init.c             |  6 +++++
 arch/um/kernel/mem.c                   |  6 +++++
 arch/x86/mm/kasan_init_64.c            |  6 +++++
 arch/xtensa/mm/kasan_init.c            |  6 +++++
 include/linux/kasan-enabled.h          | 11 ++------
 mm/kasan/common.c                      | 27 ++++++++++++++++++++
 mm/kasan/generic.c                     | 20 +++++++++++++--
 mm/kasan/hw_tags.c                     | 35 ++------------------------
 mm/kasan/init.c                        |  6 +++++
 mm/kasan/quarantine.c                  |  3 +++
 mm/kasan/shadow.c                      | 23 ++++++++++++++++-
 mm/kasan/sw_tags.c                     |  9 +++++++
 18 files changed, 150 insertions(+), 46 deletions(-)

-- 
2.41.0


