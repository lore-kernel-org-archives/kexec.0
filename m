Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXwSf-00071v-2P
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 11:11:45 +0000
Received: by rv-out-0708.google.com with SMTP id b17so1911060rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 04:11:44 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2008 20:11:56 +0900
Message-Id: <20080826111156.615.52141.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
Subject: [PATCH 01/06] sh: Add support for sh4al-dsp processors
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Add support for sh4al-dsp processors such as sh7722.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/kexec-sh.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/kexec/arch/sh/kexec-sh.c
+++ work/kexec/arch/sh/kexec-sh.c	2008-08-20 19:07:47.000000000 +0900
@@ -105,6 +105,7 @@ const struct arch_map_entry arches[] = {
 	{ "sh3", KEXEC_ARCH_DEFAULT },
 	{ "sh4", KEXEC_ARCH_DEFAULT },
 	{ "sh4a", KEXEC_ARCH_DEFAULT },
+	{ "sh4al-dsp", KEXEC_ARCH_DEFAULT },
 	{ 0 },
 };
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
