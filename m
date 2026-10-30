Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51019606A329
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qfA+ufZT;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=PuWXMmG1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=k6t9eyb2E8jkIZBTmriw5WaYSUJLnvk+ry/+WUbhsWg=; b=qfA+ufZTiDItprmLPFdhMjmPwy
	GPi5s1kE0KF+KEr8Rx49yjbzEY4k6DYKlHkkHFDC+BWwE9ftBn3cgIRJLeb40zAE0mvcyYV+U5Ypp
	vKvBc2Gt1fUHhiyi0rjj8AjMFvlY7eDQkN3oX8ZJoSQFhT08NZIbSfKgEutCTqq3WvHCXbUFINUsB
	weZTbqbCK25qtGwixm9etvUOJ83d4RdijxESDjZu0ldCYYAWNckB0Y6Lw4g+Noih+ze2dppH959nO
	jw/HroZ6jDmpkxqI8KQokFcsdgisqfEIw1UUudmjE/359a9or5Ez/kjaVHaUyGVaSLl9LRDlffQf9
	8r+87VlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMczv-0000000AiKx-3xPF;
	Fri, 30 Oct 2026 03:09:43 +0000
Received: from m16.mail.126.com ([220.197.31.7])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMczt-0000000AiKY-0kKY
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 03:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=k6
	t9eyb2E8jkIZBTmriw5WaYSUJLnvk+ry/+WUbhsWg=; b=PuWXMmG1JDpzYKedlP
	Osf15RRJZmrcGyFGwOfpM9szQP1b3ULVBUHYU5kGPsfBySndyMo8RNfrPkgY+3sM
	KaD67UFKXw4dlq/VIJCiEQS9C71FEfnObwJOr/8Q+D4W1cwA/4Im4Jj82sdB7GKk
	aQQq7RllJGB5uVzXKOBe2Aew0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3915sCuRqXTr0Bw--.61347S2;
	Fri, 30 Oct 2026 11:09:33 +0800 (CST)
From: zhangzikang1992@126.com
To: kexec@lists.infradead.org
Cc: zhangzikang <zhangzikang@kylinos.cn>
Subject: [PATCH] kexec: fix stack buffer overflow in update_purgatory()
Date: Fri, 30 Oct 2026 11:09:18 +0800
Message-Id: <20261030030917.103293-1-zhangzikang1992@126.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3915sCuRqXTr0Bw--.61347S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWkJr4kJr1kWF13JFWrZrb_yoW8Crykpa
	9xKF1DKw4rA3WIkFn7tF4xZas8Zws5GrWrAFWj93y8Jr18CFy0qay2qa1qyF4jyrW3K347
	Wrn0qFZ3X3W8ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFsjUUUUUU=
X-CM-SenderInfo: x2kd0wp2lnt0jjrzmja6rslhhfrp/xtbBlg1xs2rkCm0tQQAA3c
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_200941_684720_C046481A 
X-CRM114-Status: UNSURE (   6.80  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.8 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: zhangzikang <zhangzikang@kylinos.cn>

Problem:
A stack buffer overflow exists in "update_purgatory()". The local array "sha256_region region[SHA256_REGIONS]" (size 16) is written during iteration over "info->nr_segments" without boundary checking for the write index "j".

"Add_degment_phys-virt()" only issues a warning when "nr_degments" exceeds "KEXEC_MAX_SGMENTS" (=16) and continues to append segments. Therefore, "update_purgation()" may be called, causing "nr_degments" to be much larger than "SHA256-REGIONS", resulting in "region [j]" being written outside of the 16 item stack array. This type of out of bounds write will damage the Canary stack and adjacent stack frames.

Impact:
Stack buffer overflow causing process crash (resulting in denial of service through Canary termination); The potential for controllable stack destruction depends on the content of the image.

Fix:
Before writing to "region[j]" in "update_purgatory()", add a bounds check on "j" to ensure that writing stops immediately when "j" reaches "SHA256_REGIONS", preventing out-of-bounds writes from corrupting adjacent global variables.

Signed-off-by: zhangzikang <zhangzikang@kylinos.cn>
---
 kexec/kexec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index c9e4bcb..732058e 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -728,6 +728,11 @@ static void update_purgatory(struct kexec_info *info)
 			sha256_update(&ctx, null_buf, bytes);
 			nullsz -= bytes;
 		}
+		if (j >= SHA256_REGIONS) {
+			fprintf(stderr, "Warning: SHA256 region limit reached. "
+				"Skipping remaining segments from checksum region list\n");
+			break;
+		}
 		region[j].start = (unsigned long) info->segment[i].mem;
 		region[j].len   = info->segment[i].memsz;
 		j++;
-- 
2.43.0


