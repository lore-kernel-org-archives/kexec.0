Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096FFC32796
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7tsuFE4qp3P4IKiShizQYtReL/63u75RJ440vcBdYKI=; b=xhdKbgffSlegM2
	v9hFQEEiWMLLBqdM23AQqXdW9G/hbSuNgyO0hJ1ReOiVFp5s9+bJ+NXGjRkvMmQ4GrDuD5VgN/4/E
	62fejXxXnkNnXsaQu6fKtUdMhyXDw5+QHgEWcOW9R3gG+R3ct12imJQinxRqjxxWaU1BH1Yv7LBoI
	lGXtH/vWaNOSMhCt2hwVhN+Kupm93yCCr0TDkg4SuWk2Xke7wEIYyVT4jLdZe5Yf05CoPsQ/Kp3hp
	nqx2uHRw1ufzob8+s+KalXMJmjlnVJhuwtZmLyIiPd+pi0FAwnXPxbCP2vgqZb3/Z+7vRtEb7z6wz
	Hm51YHh0Is/UjjwLXW2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQtHd-00EQgs-2J; Wed, 24 Aug 2022 16:31:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQtHa-00EQfb-7d
	for kexec@lists.infradead.org; Wed, 24 Aug 2022 16:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661358669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1Meo/JVVOcnrflu5rlIGOgtbrV+Zw+zKCUGgyNys75s=;
	b=UNouDKxvgsKjyV7fOvVhqlrHOogX9AQXGmRoxyWyIk+NFAUULoPRvazB6xBc0QUbMGQ91+
	w1/h8A1lpRrN4nSx4qnYdED3Lb3FT/MyokdY4TflPg+vKhgLG3O8gE+pG0+tRPXstQM+3L
	xRPVtkyDVdZqVpYK22+sotmyTCrj9JE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-1hJq29stMFOCbma2_vFXbA-1; Wed, 24 Aug 2022 12:31:06 -0400
X-MC-Unique: 1hJq29stMFOCbma2_vFXbA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17417185A7B2;
	Wed, 24 Aug 2022 16:31:06 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4C6492C3B;
	Wed, 24 Aug 2022 16:31:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH RFC 0/2] coding-style.rst: document BUG() and WARN() rules
Date: Wed, 24 Aug 2022 18:30:58 +0200
Message-Id: <20220824163100.224449-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_093110_375759_89E5A1C2 
X-CRM114-Status: GOOD (  17.29  )
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

As it seems to be rather unclear if/when to use BUG(), BUG_ON(),
VM_BUG_ON(), WARN_ON_ONCE(), ... let's try to document the result of a
recent discussion.

Details can be found in patch #1.

--------------------------------------------------------------------------

Here is some braindump after thinking about BUG_ON(), WARN_ON(), ... and
how it interacts with kdump.

I was wondering what the expectation on a system with armed kdump are,
for example, after we removed most BUG_ON() instances and replaced them
by WARN_ON_ONCE(). I would assume that we actually want to panic in some
cases to capture a proper system dump instead of continuing and eventually
ending up with a completely broken system where it's hard to extract any
useful debug information. We'd have to enable panic_on_warn. But we'd only
want to do that in case kdump is actually armed after boot.

So one idea would be to have some kind of "panic_on_warn_with_kdump" mode.
But then, we'd actually crash+kdump even on the most harmless WARN_ON()
conditions, because they all look alike. To compensate, we would need
some kind of "severity" levels of a warning -- at least some kind of
"this is harmless and we can easily recover, but please tell the
developers" vs. "this is real bad and unexpected, capture a dump
immediately instead of trying to recover and eventually failing miserably".

But then, maybe we really want something like BUG_ON() -- let's call it
CBUG_ON() for simplicity -- but be able to make it be usable in
conditionals (to implement recovery code if easily possible) and make the
runtime behavior configurable.

if (CBUG_ON(whatever))
	try_to_recover()

Whereby, for example, "panic_on_cbug" and "panic_on_cbug_with_kdump"
could control the runtime behavior.

But this is just a braindump and I assume people reading along have other,
better ideas. Especially, a better name for CBUG.


Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>

David Hildenbrand (2):
  coding-style.rst: document BUG() and WARN() rules ("do not crash the
    kernel")
  checkpatch: warn on usage of VM_BUG_ON() and friends

 Documentation/process/coding-style.rst | 27 ++++++++++++++++++++++++++
 scripts/checkpatch.pl                  |  6 +++---
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
