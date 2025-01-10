Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B96E77188
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HO4unJHe6xzhtTKuEPlnETcgcHtXTmE2TbUwW8QJ8fQ=; b=hmGBtiqXQSeIPkawwGaNKrApym
	2t9b1fCerSAomgqWxZzNXgOdbE9oYhcDUsPsnWh7dJ4XKZJK/iXThEtb2acGbeEd1n4sX24TOAGoT
	3dnAhrG42Ot/ivkL8HMt3kumTjR+la44fz9ki3dNtT+AC6y69tWt5AhPIH9BuJmWwJ3JEzdiLe4U7
	dfQ8g+Jf0Ecu+nXLfU/YWAvP7MZBgteMOx2Zp2FHr8Dx77TAE2DPEBIzkkeJqI09hOudD50+9Q/CA
	R/p6W55bIV8Y+l2xWBl6y8jYd3Z1vzC07VzkLQm3vsQqXy0okiNCmcfPVOFZ+xZ2mMlrlnVuA3/Gp
	23W7/Wbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHOC-0000000G7Z8-2RdS;
	Fri, 10 Jan 2025 15:57:36 +0000
Received: from shelob.surriel.com ([96.67.55.147])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWGwR-0000000Fvmo-0C2b
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 15:28:56 +0000
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tWGvy-0000000037I-38in;
	Fri, 10 Jan 2025 10:28:26 -0500
Date: Fri, 10 Jan 2025 10:28:21 -0500
From: Rik van Riel <riel@surriel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, kernel-team@meta.com, Breno
 =?UTF-8?B?TGVpdMOjbw==?= <leitao@debian.org>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc: fix softlockup in __read_vmcore (part 2)
Message-ID: <20250110102821.2a37581b@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_072855_088872_5750DF6B 
X-CRM114-Status: GOOD (  10.73  )
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

Since commit 5cbcb62dddf5 ("fs/proc: fix softlockup in __read_vmcore")
the number of softlockups in __read_vmcore at kdump time have gone
down, but they still happen sometimes.

In a memory constrained environment like the kdump image, a softlockup
is not just a harmless message, but it can interfere with things like
RCU freeing memory, causing the crashdump to get stuck.

The second loop in __read_vmcore has a lot more opportunities for
natural sleep points, like scheduling out while waiting for a data
write to happen, but apparently that is not always enough.

Add a cond_resched() to the second loop in __read_vmcore to
(hopefully) get rid of the softlockups.

Signed-off-by: Rik van Riel <riel@surriel.com>
Fixes: 5cbcb62dddf5 ("fs/proc: fix softlockup in __read_vmcore")
Reported-by: Breno Leitao <leitao@debian.org>
---
 fs/proc/vmcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3d8a82cee63e..658bf199d424 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -404,6 +404,8 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			if (!iov_iter_count(iter))
 				return acc;
 		}
+
+		cond_resched();
 	}
 
 	return acc;
-- 
2.47.1


