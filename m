Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C735C0218D
	for <kexec@archiver.kernel.org>; Wed, 29 Jan 2025 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=65fOFW7iuu/x6870DaYNVuQjTdfmIQOdy5bDAd2uMoY=; b=pTCbyLY9LERgCX8AO7ZrzZ5Sbb
	ieO037gIEVUSu82A8ncI7PjFfyzYvj6jp88q6tWOyuEKIyUKkbOCiUcIJvODazxpTzlFBcJnS2NVi
	YqKBMeqfd8tLtFD440ftAP7f0LRwHIGO6J1aDWhm9TeiF79Kh7SneGaEXKwcAsAcsixmLVbSZm1q6
	J81HBYN7iYsa/CQbacTxLufJT9lY38FRdqW/LgprHO1Q41Ab2KhpaRRYwSTuYDVVG+1QNZCDgJUTW
	uYlv1H11iIPGQ6i+Z6+E7Ig+WbMqB/XfWE+B+yFN/t8yj2M0G1NtaQ45+glk0OWUVLC7NqEE+umQX
	kLg+Hz0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdGQL-00000007rTZ-16BS;
	Wed, 29 Jan 2025 22:20:41 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdGQJ-00000007rTB-0hBs
	for kexec@lists.infradead.org;
	Wed, 29 Jan 2025 22:20:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YjxS504L7zlgTWM;
	Wed, 29 Jan 2025 22:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1738189234; x=1740781235; bh=65fOFW7iuu/x6870DaYNVuQjTdfmIQOdy5b
	DAd2uMoY=; b=I/Wn83KtXStXdRySLbR3M0iO4MQAv+UJgJpHfZK2NjvstlxwVM2
	qyu3XYEG2qmrK3idEdQFdu4Zo/hs30W+9vAq1qmStdu/sjtK4tHv26CWi2aFO+7H
	gegs/v6EsDQ5YHObNpb8Pc3pQv83sqsHE4Nq2dJogoG4nts9G4MRB7SFVCR/DkKD
	xpsZ7sDQThAUV8xaFvhJIVFwHc/3HcvGH2/AMRuDHADvgBng8+2ZuiffzLRzpip5
	fAsl6WOVF65nb4wkg7oOlQOWcXExHtdHd/Ua3e5k4qRIpbw9QerbiXV0S/HY0bq2
	IUF1MUyY3PmEzR1vJitHX4Pp7JW36HQuWrg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pw0Ljsv_ouYw; Wed, 29 Jan 2025 22:20:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YjxS13lpGzlgTWG;
	Wed, 29 Jan 2025 22:20:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org,
	Bart Van Assche <bvanassche@acm.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] procfs: Fix a locking bug in a vmcore_add_device_dump() error path
Date: Wed, 29 Jan 2025 14:20:03 -0800
Message-ID: <20250129222003.1495713-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_142039_235666_4821653C 
X-CRM114-Status: GOOD (  11.59  )
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

Unlock vmcore_mutex when returning -EBUSY.

Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Fixes: 0f3b1c40c652 ("fs/proc/vmcore: disallow vmcore modifications while=
 the vmcore is open")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/proc/vmcore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index a00120a3c099..10d01eb09c43 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1524,7 +1524,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *da=
ta)
 		pr_warn_once("Unexpected adding of device dump\n");
 	if (vmcore_open) {
 		ret =3D -EBUSY;
-		goto out_err;
+		goto unlock;
 	}
=20
 	list_add_tail(&dump->list, &vmcoredd_list);
@@ -1532,6 +1532,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *da=
ta)
 	mutex_unlock(&vmcore_mutex);
 	return 0;
=20
+unlock:
+	mutex_unlock(&vmcore_mutex);
+
 out_err:
 	vfree(buf);
 	vfree(dump);

