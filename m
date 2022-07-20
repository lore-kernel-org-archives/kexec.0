Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4536FC433EF
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 11:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qQdgyReIUeHd3MIAWeRjSnVwKgZ123KsZdCVzaboknE=; b=s3VtcI8+jYEj7z
	QzVS5H9lmFLURyvY8AikTIT8EBdi98baO0tNrDY0OvKcruERseAO/tVdyLs7JTp54sLwo7u7Jg8GG
	Dg8xwTqJXNRihp6xPEtTqsfXEA5Bi5R1vwsbPDkm+s7TKGFZ2bmVB+zb8mPXLRnt7GUh07TOYxmeG
	2rm0fcvLgp8pljRXxSCbi6pzJwpy+dWCvOnbLxgYMAxyYzO+9s1vlLM0ssARCveuSeluv5U9Ex4LS
	iw5HgqsTNQ1zDmXa5YXUThzH0k/z+d/hq5Ybynu2voh0FzrU6FqT1bLFulx9T3d+1J7x+z13MHsTn
	AeQT5hsT/sv8f2rcm+JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE7Xy-004O2S-4g; Wed, 20 Jul 2022 11:07:18 +0000
Received: from mail-m972.mail.163.com ([123.126.97.2])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE7Xu-004NxN-L1
	for kexec@lists.infradead.org; Wed, 20 Jul 2022 11:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=89CUw
	D/ltIp7nzFeM1m56hj3ybYhAShEewrK3lMADUo=; b=JrKV/2LOI3sQYaLKf1d9Y
	PUUGruSx0cRDRyCNI9fif824zt4Dby9Bt9OS9GJyaGKQAUtT6uj7se8VDXLHLszk
	+Rg0/VC93hhDvZIzPonJMaEsCH49MItKXhh6YF09TuzVCmw4QwY7w+BuNTpVzmyF
	7GLU8iWOw4kykGr8OMEg38=
Received: from localhost.localdomain (unknown [112.97.48.93])
	by smtp2 (Coremail) with SMTP id GtxpCgAHkvTb4ddinkTCQA--.181S2;
	Wed, 20 Jul 2022 19:07:10 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] docs: admin-guide: ix typo in comment
Date: Wed, 20 Jul 2022 19:07:06 +0800
Message-Id: <20220720110706.16766-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: GtxpCgAHkvTb4ddinkTCQA--.181S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWUCr18CFykZr15XF4UXFb_yoWfXrcEka
	ykXF4kAa1xJ348tr4rJF90qFy2vw4akrWxuws7Jr42kayxA390kw1kJF9rAw1fGrs7uryr
	WFyfXryxJrnrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREb18tUUUUU==
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivx5EZFWB0iTLLQAAsF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_040715_058659_3C4344A4 
X-CRM114-Status: UNSURE (   8.94  )
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

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 8419019b6a88..6726f439958c 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -200,7 +200,7 @@ prb
 
 A pointer to the printk ringbuffer (struct printk_ringbuffer). This
 may be pointing to the static boot ringbuffer or the dynamically
-allocated ringbuffer, depending on when the the core dump occurred.
+allocated ringbuffer, depending on when the core dump occurred.
 Used by user-space tools to read the active kernel log buffer.
 
 printk_rb_static
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
