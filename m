Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7DFC4332F
	for <kexec@archiver.kernel.org>; Sat, 17 Dec 2022 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wHOxs/cJpGowU35tsFH02poprPtktYkkxyv+VhHOI4k=; b=j3wNoenh8aCHTb
	8zo38+63XS4TeD215kItZxyjwtBKO3PKgYBWJ4Ot1zNg7LrCaOWglyI3UV5a9AAJldzolEfEDtdB2
	pNxH174gQh8dN5j2hl+YYvDm+1V/gjaaN/ozyqlHsEJpTcnVZyvd44O3blfl3vh9/AXHS6KNePcJo
	5rSEFAUIszjvM7SuHQUTWcrFAQs5E/VzjpQnQZjnFBoyglUqJvEr4ynTNSZKECqAqROk15z07Geyi
	zYDVCYMEWBdVsxsS3HP7gwpi6STw10Hp6EUS/jrL+w2A1NaTh1m86DSr/RADdHo7XZB4GG7Fi5SNo
	NKzvyf8hJBmEMTZ2sQSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Z8w-00Aatd-OD; Sat, 17 Dec 2022 15:30:30 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6Z8s-00AarY-MS
	for kexec@lists.infradead.org; Sat, 17 Dec 2022 15:30:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 56D11B803F6;
	Sat, 17 Dec 2022 15:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A119C43392;
	Sat, 17 Dec 2022 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671291022;
	bh=J8PB7ageuGwzTFlKPjGTsoyLoPto2P7bxNGDSxJPy0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQa7xbe5Q6kM9ex0h5dasnxuijJnMIcBlbqMe4fy/8dNpYeXZAG+GTivLrvlfjuy+
	 j9LwxGCaWZ4a7fb7Rxc7/d6UEPlmkeUsTkqtkFcDP8Hx63Wo/0ld21sF10j26Iwweb
	 NEtXBYHE1xdBOEiK2vY5t3Jq88LpkEpH6RjW5u2DJY8MlUFWurRrI+tWm4mZo1Hf/X
	 o7E1PuH7aKiLX+/rjeNWZmN05pJAgFx2TWLh6FjDdlZAsGdsRISM+vOfw+p0s1OY0X
	 Ci6cPBBUKYV7PNTirzRB5TVk16QNTKWhUh6hCj3M074ktrDZ93yDh8oQvBKQcakJBZ
	 JCtY0fr+D7BuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianglei Nie <niejianglei2021@163.com>,
	Baoquan He <bhe@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Chen Lifu <chenlifu@huawei.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Li Chen <lchen@ambarella.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>,
	Petr Mladek <pmladek@suse.com>,
	Russell King <linux@armlinux.org.uk>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/8] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Sat, 17 Dec 2022 10:30:07 -0500
Message-Id: <20221217153012.99273-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221217153012.99273-1-sashal@kernel.org>
References: <20221217153012.99273-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221217_073027_082447_CFB4C08D 
X-CRM114-Status: GOOD (  12.91  )
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

From: Jianglei Nie <niejianglei2021@163.com>

[ Upstream commit 12b9d301ff73122aebd78548fa4c04ca69ed78fe ]

Patch series "Some minor cleanup patches resent".

The first three patches trivial clean up patches.

And for the patch "kexec: replace crash_mem_range with range", I got a
ibm-p9wr ppc64le system to test, it works well.

This patch (of 4):

elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
kzalloc().  If is_vmcore_usable() returns false, elfcorehdr_addr is a
predefined value.  If parse_crash_elf_headers() gets some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

Fix it by calling elfcorehdr_free() when parse_crash_elf_headers() fails.

Link: https://lkml.kernel.org/r/20220929042936.22012-1-bhe@redhat.com
Link: https://lkml.kernel.org/r/20220929042936.22012-2-bhe@redhat.com
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chen Lifu <chenlifu@huawei.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>
Cc: Li Chen <lchen@ambarella.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: ye xingchen <ye.xingchen@zte.com.cn>
Cc: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/vmcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f5dfedc01552..7f53c4d56e23 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1533,6 +1533,7 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
+		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
 	}
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
