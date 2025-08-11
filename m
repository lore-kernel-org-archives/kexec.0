Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38F7CA0EC0
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/n8qeTi9a3W4STq8IZr8DxKUBCk9JyBjSgSQ35Nu4zE=; b=jjmJ9WvQlZWj7rZk1CVeya0Jf6
	suII8PEwaS9JOHZ9dmYyz2qDUOysHwInzNPQ3TYH+T3zL7I1vKMs9ne7oa8aaRcJGDdgAo1n593Xa
	IwZSBR1QvnjdmUBOATV/+pU3sp/Ji59NRXtsOQuTRH/pm0BGQ+GkSPk9DRXBU9SB6HvEg6Eo/HiBh
	kx9LNMnY4QQt7CMss+op3M7Yg+YQKS+0RBlQICZrD6KbvIPn2Lh95JdKSKYgBveGZH+k5agQayrUD
	S4IBxi8soVxxUsshFQAdUNQiwOlPZWqc29q3MnK3SzuWV78uS87+inPblyumbDAxGJMKmmwvS/LTn
	V195tjuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOHO-00000006usu-10Bq;
	Mon, 11 Aug 2025 08:53:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulNqQ-00000006qSD-1Uyl
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 08:25:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BB04861412;
	Mon, 11 Aug 2025 08:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E70C4CEED;
	Mon, 11 Aug 2025 08:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900725;
	bh=des5gSYvIeWFIzyviF7RIfsIRBzUROyPbzK9Qkkyq3c=;
	h=From:To:Cc:Subject:Date:From;
	b=SbFrEYmCbusOxHhswX9rm/y2f8AdNC8lOL9kP3zDmjaNi+5agTA2xAyM72DL53WKH
	 cj4bYvz87PtfgeyVmW0KDnbPJN+lCH8BCui77GbcJ21FdH7rP1DaHqmZuNEFuQDQRS
	 osrufcQ/DevLWz6blbySBuhwv67VpWIrBuH/mzILKrEqrDNRt047jJabg8rrN4a21k
	 AafiEr/hQXK/yFo+9A1o35POkuJTGuECzVCt6KrLvvrOL/ieEsE+YKTTmXJRdfrNF7
	 iTWETUxTLEoUKB2ilRlp0DGd3CZMEce8LgS4pKTYBS5YdGOot8b99ER0Mo763FBzZY
	 Qi8SodNQLMZ9A==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] kho: fixes and cleanups
Date: Mon, 11 Aug 2025 11:25:07 +0300
Message-ID: <20250811082510.4154080-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These are small KHO and KHO test fixes and cleanups

Mike Rapoport (Microsoft) (3):
  kho: allow scratch areas with zero size
  lib/test_kho: fixes for error handling
  selftest/kho: update generation of initrd

 kernel/kexec_handover.c               |  7 +++-
 lib/test_kho.c                        | 52 +++++++++++++++++----------
 tools/testing/selftests/kho/init.c    | 13 +++----
 tools/testing/selftests/kho/vmtest.sh | 28 ++++++++-------
 4 files changed, 58 insertions(+), 42 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.47.2


