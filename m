Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0kCa-0008MH-B0
	for kexec@lists.infradead.org; Mon, 26 May 2008 21:25:56 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7B7D145960
	for <kexec@lists.infradead.org>; Mon, 26 May 2008 23:25:54 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] EDD fix
Date: Mon, 26 May 2008 23:26:31 +0200
Message-Id: <1211837191-3850-1-git-send-email-bwalle@suse.de>
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
Cc: Bernhard Walle <bwalle@suse.de>

This patch fixes EDD support where the BIOS reports a length lower than the
actual length of raw_data in sysfs. That's no problem -- the check only
needs to catch the case where the sysfs file is *smaller* than the
BIOS reported length.

Also add a newline at the end of the error message.

The problem was introduced in 3bf0213789d56054f601c5a06372f78567aacdd9 by
myself, the initial EDD implementation.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/i386/x86-linux-setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 05a087e..cbb9d30 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -254,9 +254,9 @@ static int read_edd_raw_data(const char *dir, struct edd_info *edd_info)
 	len = ((uint16_t *)edd_info->edd_device_params)[0];
 	dbgprintf("EDD raw data has length %d\n", len);
 
-	if (read_chars != len) {
+	if (read_chars < len) {
 		fprintf(stderr, "BIOS reported EDD length of %hd but only "
-			"%d chars read.", len, (int)read_chars);
+			"%d chars read.\n", len, (int)read_chars);
 		return -1;
 	}
 
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
