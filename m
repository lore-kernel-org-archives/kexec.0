Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kx0Vs-0001s8-Dp
	for kexec@lists.infradead.org; Mon, 03 Nov 2008 14:34:40 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D6E2042A49
	for <kexec@lists.infradead.org>; Mon,  3 Nov 2008 15:34:36 +0100 (CET)
Message-ID: <490F0BFC.5070504@suse.de>
Date: Mon, 03 Nov 2008 15:34:36 +0100
From: Stefan Assmann <sassmann@suse.de>
MIME-Version: 1.0
Subject: [PATCH] make memcmp arguments const
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

In purgatory/string.c the definition of memcmp is
	int memcmp(void *src1, void *src2, size_t len)
man memcmp reveals
	int memcmp(const void *s1, const void *s2, size_t n)

Signed-off-by: Stefan Assmann <sassmann@suse.de>

---
 purgatory/string.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/purgatory/string.c
+++ b/purgatory/string.c
@@ -36,9 +36,9 @@ void* memcpy(void *dest, const void *src
 }


-int memcmp(void *src1, void *src2, size_t len)
+int memcmp(const void *src1, const void *src2, size_t len)
 {
-	unsigned char *s1, *s2;
+	const unsigned char *s1, *s2;
 	size_t i;
 	s1 = src1;
 	s2 = src2;
-- 
Stefan Assmann          | SUSE LINUX Products GmbH
Software Engineer       | Maxfeldstr. 5, D-90409 Nuernberg
Mail : sassmann@suse.de | GF: Markus Rex, HRB 16746 (AG Nuernberg)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
