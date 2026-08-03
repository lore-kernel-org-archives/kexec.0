Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45648C55822
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Date:Cc:To:From:Subject:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0pg5vdKdmfDtSFhDDoMxYAKscw1ee4hFMSsX7J0wZec=; b=qa8xAX94RI9L+Axb2iGLs9g5JG
	2lQetAzKQ14NzAN2wsKVB0CwEo8tMelsHAs/hjJrRafA31WSBrXrdMI3rdd5wGCwOi0T/bWEh2HLT
	HYbqF5ntH3Z4wxFtHfo6UlZJfxxDcl/CuTQ5jWU4MfmVGa9YG7BB9oRSHiEqQbEqFcyTS7ekriD82
	Y5kZPgI05QRuL0+54X2w3mrXCEGx5H8HOYHoAw04Y7sgLnNwzAwIFtKA16T5mmRXWoE/ym5zo2xje
	PdZtROy8Z2xS2+8QPc9cd2LQumf1TaEFaQpqZDVPqSIEnnMK2YCcRvJhXyaYy0HZwCAv6A70jES9a
	qg6jPniA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqx9l-00000000Lbf-1qdu;
	Mon, 03 Aug 2026 18:12:57 +0000
Received: from mout-p-201.mailbox.org ([80.241.56.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqx9i-00000000LaQ-0It2
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 18:12:55 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDPss6bHyzMlDs;
	Mon, 03 Aug 2026 20:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785780769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pg5vdKdmfDtSFhDDoMxYAKscw1ee4hFMSsX7J0wZec=;
	b=Rm+q3L383W1g9P2AOgzUSwSzxKXWPKfqCXxqEjEr/y2YYkjEk0S0s1IqOBjZ/4R+MEe8w0
	7zYsU1k9+VtxeohRmKuIhldJ9MhrzntTY5IboEDpK1UX6hQRgv7PkIQxGqK3k5rsnZFDHz
	K/47sSwQzu9uAPNgOnbJIwv0cHJG1/ltY7AULrUb3LqwxikU8vekL57/1W0y/1cf6ju0ya
	Dja0iEuVuK+0npJXRU5KjukuZBYrQ0DqWAvetSqkGsc2Kh7r/a5y+DAj8RvQaGPdczyLfU
	SKQxXkhJ6qoKKz3V9b7gOrn7qmT+4RKRkPWV7U9Acukr/+4u4J7skXp2RUVfMw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LTcjog2d;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
Message-ID: <27a9ca7bf4d354e97b0865af8222490cf44f27e7.camel@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785780768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0pg5vdKdmfDtSFhDDoMxYAKscw1ee4hFMSsX7J0wZec=;
	b=LTcjog2dRCGv8Y6ISOAzFiEmNkpkIT+r51TILfDvsQB8SAxf/k680PC/I3WrmlsvZNK+nl
	CyesWmw1sNpDrGCB7SAaU5H0oTP6LK7SO2XXoRjxMPqjzGtKy1mHK89nYcTLy5Y5qCCVy1
	nQEpWImDlr8N5a1wd/RTilUghs/qBCNX20j6Lk7m8/Zkpf3ILhT57mNtTbWVGV3TtSa8DY
	n4OsNWW6EhAhDjLM49CYYz1WBFfsf3EpbdhofhfUo5+G9DsvwuXvR5o7C7XU75o/sEDjC3
	po6qjalBsiJh8pqh5HJd4OehK1curlnE9HUC0Aexu6svc6FFowwE95JsM8XIXQ==
Subject: [Build Errors] kho:
 =?UTF-8?Q?'=E2=80=98HPAGE=5FPMD=5FORDER=E2=80=99?= undeclared'
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: linux-next@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav	 <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
 Muchun Song	 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand	 <david@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jason Miu	 <jasonmiu@google.com>, Jork Loeser
 <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,  Manuel Ebner <manuelebner@mailbox.org>
Date: Mon, 03 Aug 2026 20:12:40 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: ay6khkkde3zkcycuyhmytefcoxfast4h
X-MBO-RS-ID: 427c8c8f1f2cc33b5c1
X-Rspamd-Queue-Id: 4hDPss6bHyzMlDs
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_111254_406596_80FA144A 
X-CRM114-Status: UNSURE (   4.95  )
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

Hi,

when building next-20260803 I get build errors, see below.
I assume it's one of the last 3 commits by Pratyush. Let me know
if you need more info.

Thanks
 Manuel


$make KCFLAGS=3D-Werror -j8 > make_output.txt
In file included from ./include/linux/nodemask.h:92,
                 from ./include/linux/numa.h:6,
                 from ./include/linux/cpumask.h:15,
                 from ./arch/x86/include/asm/paravirt.h:19,
                 from ./arch/x86/include/asm/irqflags.h:100,
                 from ./include/linux/irqflags.h:18,
                 from ./arch/x86/include/asm/special_insns.h:10,
                 from ./arch/x86/include/asm/io.h:45,
                 from ./include/linux/io.h:12,
                 from kernel/liveupdate/kho_block.c:23:
./include/linux/kexec_handover.h: In function =E2=80=98kho_scratch_migratet=
ype=E2=80=99:
./include/linux/pageblock-flags.h:66:53: error: =E2=80=98HPAGE_PMD_ORDER=E2=
=80=99 undeclared (first use in this function)
   66 | #define pageblock_order         MIN_T(unsigned int, HPAGE_PMD_ORDER=
, PAGE_BLOCK_MAX_ORDER)
      |                                                     ^~~~~~~~~~~~~~~
./include/linux/minmax.h:83:27: note: in definition of macro =E2=80=98__cmp=
=E2=80=99
   83 | #define __cmp(op, x, y) ((x) __cmp_op_##op (y) ? (x) : (y))
      |                           ^
./include/linux/pageblock-flags.h:66:33: note: in expansion of macro =E2=80=
=98MIN_T=E2=80=99
   66 | #define pageblock_order         MIN_T(unsigned int, HPAGE_PMD_ORDER=
, PAGE_BLOCK_MAX_ORDER)
      |                                 ^~~~~

And a couple more notes.

