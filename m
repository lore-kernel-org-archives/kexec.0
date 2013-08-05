Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6Ogv-0003Ed-U3
 for kexec@lists.infradead.org; Mon, 05 Aug 2013 17:35:35 +0000
Date: Mon, 5 Aug 2013 13:35:11 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] kexec: x86: struct x86_linux_param_header should be packed
Message-ID: <20130805173510.GD2274@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>

I think struct x86_linux_param_header should be packed. Strange that we
did not do it so far. 

Without packing struct size was 3824 (decimal) on my x86_64 machine. With
packing it is 3820. I think there was a padding of 4 bytes at the end. So
it should be harmless.

I tried to introduce more fields and that introduced padding in the
middle of structure and kexec stopped working and that's how I got to
know that bootparam is not packed.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/x86/x86-linux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: kexec-tools/include/x86/x86-linux.h
===================================================================
--- kexec-tools.orig/include/x86/x86-linux.h	2013-08-05 13:28:33.999338740 -0400
+++ kexec-tools/include/x86/x86-linux.h	2013-08-05 13:28:46.616475104 -0400
@@ -198,7 +198,7 @@ struct x86_linux_param_header {
 	struct 	edd_info eddbuf[EDDMAXNR];	/* 0xd00 */
 						/* 0xeec */
 #define COMMAND_LINE_SIZE 2048
-};
+} __attribute__ ((packed));
 
 struct x86_linux_faked_param_header {
 	struct x86_linux_param_header hdr;	/* 0x00 */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
