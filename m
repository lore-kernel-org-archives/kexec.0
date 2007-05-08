Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-blu.bigfish.com ([65.55.251.10]
	helo=mail55-blu-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlDRG-0005Ys-RR
	for kexec@lists.infradead.org; Mon, 07 May 2007 20:20:24 -0400
Received: from mail55-blu (localhost.localdomain [127.0.0.1])
	by mail55-blu-R.bigfish.com (Postfix) with ESMTP id 7236E2382BB
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:03:03 +0000 (UTC)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail55-blu.bigfish.com (Postfix) with ESMTP id F08E91098065
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:03:02 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id l48031ih019509
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:03:02 GMT
Received: from USSDIXIM02.am.sony.com (ussdixim02.am.sony.com [43.130.140.34])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l48031tP019349
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:03:01 GMT
Message-ID: <463FBE34.7070504@am.sony.com>
Date: Mon, 07 May 2007 17:03:00 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 4/5] Add proper node alignment for the powerpc device-tree
	cmdline.
References: <20070507235727.631477448@am.sony.com>>
In-Reply-To: <20070507235727.631477448@am.sony.com>>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Geoff Levand <geoffrey.levand@am.sony.com>

Add proper node alignment for the powerpc device-tree cmdline.

Fixes the runtime error 'Invalid tag 3a scanning flattened device tree !'.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 kexec/arch/ppc64/fs2dt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- kexec-tools-hacked.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-hacked/kexec/arch/ppc64/fs2dt.c
@@ -283,6 +283,10 @@ static void putprops(char *fn, struct di
 			strcat(local_cmdline, " ");
 			cmd_len = strlen(local_cmdline);
 			cmd_len = cmd_len + 1;
+			if ((cmd_len >= 8) && ((unsigned long)dt & 0x4)) {
+				fprintf(stderr, "Aligning cmdline %p\n", dt);
+				dt++;
+			}
 			memcpy(dt, local_cmdline,cmd_len);
 			len = cmd_len;
 			*dt_len = cmd_len;

-- 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
