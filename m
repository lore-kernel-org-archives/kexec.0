Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3QLt-00074R-9U
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 13:17:51 +0000
Message-ID: <1389791824.17407.9.camel@x220>
Subject: [PATCH] kexec.h: stop exporting kexec_load() to userspace
From: Paul Bolle <pebolle@tiscali.nl>
Date: Wed, 15 Jan 2014 14:17:04 +0100
Mime-Version: 1.0
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Maximilian Attems <max@stro.at>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Since v3.5 kexec.h is exported to userspace. That includes its
declaration of kexec_load():
    extern int kexec_load(void *, size_t, struct kexec_segment *,
                   unsigned long int);

This declaration isn't very useful to userspace programs on itself. They
still have to define a matching function (which basically wraps the
kexec_load syscall). I'm not aware of programs or libraries that actually
do that.

It can be removed. The programs that actually use it, if there
are any, should then provide their own declaration to keep compiling.
Already compiled binaries will not be affected.

This gets rid of the headers_check warning that can be seen ever since
this header was exported:
    [...]/usr/include/linux/kexec.h:49: userspace cannot reference function or variable defined in the kernel

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
This declaration of kexec_load() was added to kexec.h in commit
29a5c67e7a ("kexec: export kexec.h to user space").

 include/uapi/linux/kexec.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 104838f..c7897b6 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -42,13 +42,6 @@ struct kexec_segment {
 	const void *mem;
 	size_t memsz;
 };
-
-/* Load a new kernel image as described by the kexec_segment array
- * consisting of passed number of segments at the entry-point address.
- * The flags allow different useage types.
- */
-extern int kexec_load(void *, size_t, struct kexec_segment *,
-		unsigned long int);
 #endif /* __KERNEL__ */
 
 #endif /* _UAPILINUX_KEXEC_H */
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
