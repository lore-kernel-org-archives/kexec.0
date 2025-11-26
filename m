Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077FAD10395
	for <kexec@archiver.kernel.org>; Wed, 26 Nov 2025 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGNuORN0t3L6I+PuR7sub8AbC3vZBOSESWhy7WJ2t8U=; b=0AygjaRKkzahNezSjzqepS+wmw
	VpsE90mcqEDu2E2KEz/WUwdQPU9QOdsmsSSTtSfWBruMZGM1mSsZ/0aF7hBpoXBtEdE3US14nnm0x
	ivO5VECtwisWWnvmZo+GltY6sTryPtJLwwD0HQrxhfowP30QU+DL8Hw/i7sqR2XjV6hHKoNGzJjA9
	0gCyAUsWNQp/cGx7OWssnC1uFu74+0OvDUdhFAgvV7oFgWS3LVVhTG3dhIkvQYERPg9QrWDN1NZMb
	+5KWvvB9h78pHkiu0AW1pmnfoUuMJgtsUMpB9NlEOjBC+IINdp1IbiRX46InJGtvksBmKXXQm7XaJ
	b5V+/62g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBAg-0000000Edw4-23lm;
	Wed, 26 Nov 2025 08:46:42 +0000
Received: from smtpbg150.qq.com ([18.132.163.193])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOBAd-0000000EdtF-0mS6
	for kexec@lists.infradead.org;
	Wed, 26 Nov 2025 08:46:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764146759;
	bh=qGNuORN0t3L6I+PuR7sub8AbC3vZBOSESWhy7WJ2t8U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TqjHmuHApgPBK7SGiiaVQQJbevRmaqBwKlHrJSfMzvJEJvge8vxDUQu7AAH0c+fC2
	 vMaeVx6VHe8hYU7ofVKj3yK7JAHXObA07NO6KoJgMR6BYwUkqwkGkotEZ8MoiD03bU
	 J7wWPGEujuFWXBhsABVMq4uMSTmW+XioNQLxcSOM=
X-QQ-mid: zesmtpgz7t1764146739t764c441f
X-QQ-Originating-IP: Vr8J1j+CLmg91OoUs+VveyFmBNz+sNXr0fX3rVYxhaM=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 16:45:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2413188078539060852
EX-QQ-RecipientCnt: 6
From: Qiang Ma <maqianga@uniontech.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/3] kexec: print out debugging message if required for kexec_load
Date: Wed, 26 Nov 2025 16:44:27 +0800
Message-Id: <20251126084427.3222212-4-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251126084427.3222212-1-maqianga@uniontech.com>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NhUkPfKlCtQw9TcIzUupQSdZhEzk4ofBsDYkBhfqKN4NmwuIiAh4teii
	7IK2nUdopWwS/6SCcv28zK56PGMWbySdfo8ptoIbLno92phJBzKXNbwt3tBZV2k81aWK+XT
	WzuNbGGTph72ph8T8EwRM43Zfa5ZBv6Dey1A6Iw3qfSnZNZYEaBkKHG/BcgFm+D0aUhwXeI
	W2YU7eOKRDwQ7WMZQlmU1eOR6aWRwd4t9N5UBTyNyLftgTYFUNEwIJRazI2KyLG3fztaZNw
	+IbZ9uja9TpsKOOLLzf+SiHinHU0geqYRSmM05UKT/zhob1OLLerkSeMe8BMJVmiukZYsOF
	kuudNBhZwPwXYl7O8dI3QL+ZAvXThK5RMMoo7wCamvsZJWYsZYAoxokjPCjw0L9iI2/SBdn
	G75AA3qxq40cklSlcTSMWJHJtB1sdyvM/dRksZvpH30pano7/wB5104Qaauaxci+up4nTv5
	gkBtuEP2Wol10nZH8ZmqJymF17/5NiUYs8ZXrvRo1wX5uEINX6ubcDZV4lDCoUr37QCGZ2M
	oSaoUKahnnpOkelV/qbYmANyHe4bEju2YC24jzObLLcH46FS/Cov69N9wHbJb0x+GO4VLbX
	OcJtaIIxUomx+GwCjvo2HJwofeTkRPxbOOJ+ISIRUE7ZsClEhCPJXMorHaB3Vl9M52c6lRe
	U+v16PU7iIUNT5WjaIdhj1EBltYGl1w+InkZVh5f/CGjCd96weZXN4dVOCboXZahiy8HcxH
	clLK7CGYhHw167+3apusYSHmXIJnzPx92c1GB6vNLCwlQhzQJClztf3EcaaE0jQ+p3Mfy7R
	KrPt+hKEm2/xaCEviynMWxOCV8SihP43rVpnKeWuT7sikzhDKKWvWuwOyZb12U43QpYWhKG
	SR/IhN6pZKbw19g4t5Ctbc9eC6CCA/aqKLChG4qV3a30bfYmL5WKrR+mLoeUz2H1GrPYnsD
	v4BsIiEfLfYTizz23UGfp0qw3sj8TWusP+65NEWANFEn3rBDk9geDur9aSuF/L+HaFyEngM
	+cCDxQCfkHfGZS3LBeLh4TSoqNsIDNQExNwYiF4u5te+soMWCHE/owQKcgw5E3koitY2QRk
	g==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_004639_695946_3398BC33 
X-CRM114-Status: UNSURE (   9.60  )
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

The commit a85ee18c7900 ("kexec_file: print out debugging message
if required") has added general code printing in kexec_file_load(),
but not in kexec_load().

As a result, when using '-d' for the kexec_load interface,
print nothing in the kernel space.

And print out type/start/head of kimage and flags to help debug.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
---
 kernel/kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index f6c58c767eb0..37e4ac8af9f3 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -166,6 +166,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
+
 	/* Install the new kernel and uninstall the old */
 	image = xchg(dest_image, image);
 
-- 
2.20.1


