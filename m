Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB027C32793
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mFrVeiUqNFMgRfM9+V1HZFl8a7B2YNuHXwSxWMu8mWg=; b=X9jDIXJ1y7UGV5
	pLQ4IWNrkWpRsddxYC/5Ju9HWRN5A35HXBT4kEweycbNSGno2dxWLfYsIvh3yc9/CcEotoHDs6d/6
	C0ciFUAlJwIxV6nN7mDdS6WioLX2Atkkg+qKR0k8zNcFOhmKU0sum92mZaLLw8Zbb4pmGdhLqWjVL
	6PUhBOMHwnv4+JCDRTl5BCavIRYE7eTqCAQFA2aAkBSABbjiZ0+ielg2rxFKRHpsavqHnY044YItp
	8krwm++A80wDz+zd8uSFgRvdZszEsq+oDWfhpCD59+EHzDGbCX0HwOHvpxZY1nqE/QMqmYg9rUNGc
	hxXgB5c5H624s7zyU1nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq59-00D5rT-Qj; Wed, 24 Aug 2022 13:06:07 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPALC-00CnD4-LD
	for kexec@lists.infradead.org; Fri, 19 Aug 2022 22:19:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6/bnVK8C59Zdi0xRlMVaj0E9n3r0rDyiTtpOzSklScI=; b=YDFmAyxwqCNKkk/EO7h/cdG+Vb
	Bikhb+/65tLMaFYHZ5lUs066mD5fF2Jc5SsJXm9Jcw9L4T3OGqDryMv1WCbGTOtyOu5pHtabgOk3m
	WDNVbwsKhzb9co3ZkSrqKNoE4GMHNELEJ72Y2Xdlp548ephFdzxA2eaG+EfEiBboPp1hwXjOfhnIm
	Ahl/KUo4ULnE5OgnP6kDLFk3nbldsaQAj+5d4NvKCbr6MATTMnWNw1GJm3TS53LpgSUvtvhIESW6m
	MzVfyEK5JdHfZV43mQ+egvPqzyvlWsdJJRO0OGCY3bnthoW6eLVHJl82GiTM8iJPd5eeSV3riIZR/
	3PUd/dvA==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPAL4-00Cau4-La; Sat, 20 Aug 2022 00:19:40 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 02/11] notifier: Add panic notifiers info and purge trailing whitespaces
Date: Fri, 19 Aug 2022 19:17:22 -0300
Message-Id: <20220819221731.480795-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819221731.480795-1-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_151946_774564_5844FA82 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 24 Aug 2022 06:05:59 -0700
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
Cc: linux-hyperv@vger.kernel.org, halves@canonical.com, peterz@infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, dyoung@redhat.com, Valentin Schneider <valentin.schneider@arm.com>, vgoyal@redhat.com, Xiaoming Ni <nixiaoming@huawei.com>, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, Cong Wang <xiyou.wangcong@gmail.com>, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, Arjan van de Ven <arjan@linux.intel.com>, jgross@suse.com, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Although many notifiers are mentioned in the comments, the panic
notifiers infrastructure is not. Also, the file contains some
trailing whitespaces. Fix both issues here.

Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

---

V3:
- Added Baoquan review tag - thanks!

V2:
- No changes.


 include/linux/notifier.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index aef88c2d1173..d5b01f2e3fcc 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -208,12 +208,12 @@ static inline int notifier_to_errno(int ret)
 
 /*
  *	Declared notifiers so far. I can imagine quite a few more chains
- *	over time (eg laptop power reset chains, reboot chain (to clean 
+ *	over time (eg laptop power reset chains, reboot chain (to clean
  *	device units up), device [un]mount chain, module load/unload chain,
- *	low memory chain, screenblank chain (for plug in modular screenblankers) 
+ *	low memory chain, screenblank chain (for plug in modular screenblankers)
  *	VC switch chains (for loadable kernel svgalib VC switch helpers) etc...
  */
- 
+
 /* CPU notfiers are defined in include/linux/cpu.h. */
 
 /* netdevice notifiers are defined in include/linux/netdevice.h */
@@ -224,6 +224,8 @@ static inline int notifier_to_errno(int ret)
 
 /* Virtual Terminal events are defined in include/linux/vt.h. */
 
+/* Panic notifiers are defined in include/linux/panic_notifier.h. */
+
 #define NETLINK_URELEASE	0x0001	/* Unicast netlink socket released */
 
 /* Console keyboard events.
-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
