Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CC9C00144
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 04:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KnpYiRcufTmyvpwEUmNZY/8ryQ5AJ8dZrx0i8S8zEy0=; b=yjVfIKvsJFduXw
	P1vKSrJcDZFvTdw0oEzNhP7/RLqlxZsSpijIwATrBtd6Kpj+YnNYaaguMj2PsttwnvD3It0AWRmmb
	arAPhVeoNJnq1fieowxa8nxruciBGsdwvp09btNp824vQEZvS3p4lT1b2o1MEHiZPlQLFibkoo44R
	vBZC+gRwY36cSrtCkSho4HfRnvCdjPKvCmpVVZLZrAI0TUtAD0nQg+2gIWaoeYkbBG/rFfccaalP1
	mReihYu4Ek2pl8kHlC9fdzMA4VMcjN7kI39sTIB3a8c22WhcGia3ofn+JLn48nwVBTUz4wkFmfqDI
	bD+4BOuXTw5FHPPEYI+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN5f-001jVn-9I; Mon, 01 Aug 2022 04:31:39 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN4z-001iuo-7h; Mon, 01 Aug 2022 04:31:01 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VL.thEh_1659328251;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VL.thEh_1659328251)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 12:30:52 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: crash-utility@redhat.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	hschauhan@nulltrace.org,
	huanyi.xj@alibaba-inc.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V2 8/9] RISCV64: Add 'mach' command support
Date: Mon,  1 Aug 2022 12:30:39 +0800
Message-Id: <20220801043040.2003264-9-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
References: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220731_213057_593120_353DCC71 
X-CRM114-Status: UNSURE (   8.46  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

With the patch we can get some basic machine state information,
crash> mach
                MACHINE TYPE: riscv64
                 MEMORY SIZE: 1 GB
                        CPUS: 1
             PROCESSOR SPEED: (unknown)
                          HZ: 250
                   PAGE SIZE: 4096
           KERNEL STACK SIZE: 16384

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 riscv64.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/riscv64.c b/riscv64.c
index 1506e05..dfb3950 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -115,10 +115,53 @@ static void riscv64_get_struct_page_size(struct machine_specific *ms)
 	free(string);
 }
 
+/*
+ * "mach" command output.
+ */
+static void
+riscv64_display_machine_stats(void)
+{
+	struct new_utsname *uts;
+	char buf[BUFSIZE];
+	ulong mhz;
+
+	uts = &kt->utsname;
+
+	fprintf(fp, "		MACHINE TYPE: %s\n", uts->machine);
+	fprintf(fp, "		 MEMORY SIZE: %s\n", get_memory_size(buf));
+	fprintf(fp, "			CPUS: %d\n", get_cpus_to_display());
+	fprintf(fp, "	     PROCESSOR SPEED: ");
+	if ((mhz = machdep->processor_speed()))
+		fprintf(fp, "%ld Mhz\n", mhz);
+	else
+		fprintf(fp, "(unknown)\n");
+	fprintf(fp, "			  HZ: %d\n", machdep->hz);
+	fprintf(fp, "		   PAGE SIZE: %d\n", PAGESIZE());
+	fprintf(fp, "	   KERNEL STACK SIZE: %ld\n", STACKSIZE());
+}
+
 static void
 riscv64_cmd_mach(void)
 {
-	/* TODO: */
+	int c;
+
+	while ((c = getopt(argcnt, args, "cmo")) != EOF) {
+		switch (c) {
+		case 'c':
+		case 'm':
+		case 'o':
+			option_not_supported(c);
+			break;
+		default:
+			argerrs++;
+			break;
+		}
+	}
+
+	if (argerrs)
+		cmd_usage(pc->curcmd, SYNOPSIS);
+
+	riscv64_display_machine_stats();
 }
 
 static int
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
