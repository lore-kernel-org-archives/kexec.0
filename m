Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94D2C7618E
	for <kexec@archiver.kernel.org>; Sat, 22 Apr 2023 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2TpUjibifxKZTHkAZ/NGiTuhxAPSWXq8kiYcOiqNGSw=; b=MqRDK/70pE0KMv
	aogjQUngKHuxVBH4JSCwg/whfdFd5EEnX8/LZ6x3psQtYVG/QOV9qxaAYoboAB5e+F42cuA3SVpjg
	pWfa4Pm+PaBi0Gg25evzGKHd6asrma3EJNNrLFLbMRyG/P192NmLDclv1d+uU87Gy/UMJ/tz+Dy7+
	skqOLJXQxHOH/tIjde75i++TgpxUbsZKmi0P3KEC+LWlbXdfwo1v/z6MOFs2Lm6IwPROxqmLXwtA6
	Gc+qIgQyFVvGxkOnu4uz0c1eKa6EnsVn6m6G+Yh9CT+7k3HEEiUDVhcjCOZaIk2IPEH85fah5xQ8s
	Lf8lhcUDRpU8CkImORQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqA1v-00Cctd-0g;
	Sat, 22 Apr 2023 09:59:43 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqA1q-00CctE-34
	for kexec@lists.infradead.org;
	Sat, 22 Apr 2023 09:59:40 +0000
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MJV9S-1paq6L1EGu-00JsXO; Sat, 22
 Apr 2023 11:59:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>,
	Laurent Vivier <laurent@vivier.eu>,
	Jason@zx2c4.com
Subject: [PATCH] m68k: fix getrandom() use with uclibc
Date: Sat, 22 Apr 2023 11:59:04 +0200
Message-Id: <20230422095904.1303434-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:/L1g2saqdQvH+L/Q8jVRHyAoQHW8mPxIhzIruN7ZrnfWjaFud2V
 24MYfs6nImDnRPH3cyKjXVmdMrdNUb0IPTiN/7wam7eeXVL/uRdTTrygcZ4QWNu8fTbDoL0
 CTODjtMve1SB2RbUf24L3iWLHahm0ZySlKDUOg72qfOU0xNv0X+/t07IYtiR+HDkso1fGSk
 wS+dMfJ60h+wDgd9uSQ2A==
UI-OutboundReport: notjunk:1;M01:P0:ihsRs8XtlE4=;OV0z5MTLPx9BAVp++SEYsnyHZ/+
 +cSeZNRMrldh6MumRKun+bMNzNNrUF1l5WcEU5L7yuK8Ooa4nERKvWMIzrltI3StWgL9Ilcn6
 RmMU0mI9KicZ8WQO4Y1vWUuevrDqdbhdL1hDbICgNKYQ3sekSRuOh7ni3IasQcIf0jV7l7WyZ
 Dndj+NbBwuJgl5hLu9irT4vr019g9mCZvqcVVIbLGRnK/EnOV1KRFp6JX+vQRaXk7SGRPmye+
 LZCkz1UyM6UgyQSbiF2eauZGnsC4kuYmLV4Z8J9KtEHzDIUobyD9lAgcKTWgBVH3VZpl08Ctq
 Iblj+LgxzR3mtqmM9HA4hKteghCV5qXeunq4aNL/zoi6yX7gUoNvjoFeqKwW/Q6Jh+F4q0tCN
 /hJnkBe7H3aIxKZeVwhdnxRZHeSr4CnGW0bWqkDd3Vn/5Af87Ei7b5fx98WMaa3IKTBT8pXyk
 2XOgwsOCokozUKraFQtfMRw4NtKh0orknz7A6GAH9P7Kd6GJ2Jtt8oT16NoC0fPnJAsOfcLJA
 JTXGuOUedQAIQ6UvcBVAkX47dXd+gk30YQ7waWZvk7V7FX4LBweYJtFVsimcHIdBTfbnsqpSl
 nok1MG2Cw1EBLWLNr8jFKjKq8mnoQ1F03Dys1cDatg49A6h4sKAaSSjhQkaZt6NXJCFb86LnG
 f9iYjT7ltTRWhF+tW77ct3l8BfKFJ5j7ePatKB5aWw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230422_025939_301878_25198B37 
X-CRM114-Status: UNSURE (   8.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

With uclibc, getrandom() is only defined with _GNU_SOURCE, fix that:

kexec/arch/m68k/bootinfo.c: In function 'bootinfo_add_rng_seed':
kexec/arch/m68k/bootinfo.c:231:13: warning: implicit declaration of function 'getrandom'; did you mean 'srandom'? [-Wimplicit-function-declaration]
  231 |         if (getrandom(bi->rng_seed.data, RNG_SEED_LEN, GRND_NONBLOCK) != RNG_SEED_LEN) {
      |             ^~~~~~~~~
      |             srandom
kexec/arch/m68k/bootinfo.c:231:56: error: 'GRND_NONBLOCK' undeclared (first use in this function)
  231 |         if (getrandom(bi->rng_seed.data, RNG_SEED_LEN, GRND_NONBLOCK) != RNG_SEED_LEN) {
      |                                                        ^~~~~~~~~~~~~

Fixes:  b9de05184816 ("m68k: pass rng seed via BI_RNG_SEED")
Cc: Jason@zx2c4.com
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 kexec/arch/m68k/bootinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/m68k/bootinfo.c b/kexec/arch/m68k/bootinfo.c
index 086a34bdfdeb..5afd212d9d34 100644
--- a/kexec/arch/m68k/bootinfo.c
+++ b/kexec/arch/m68k/bootinfo.c
@@ -1,3 +1,4 @@
+#define _GNU_SOURCE
 
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
