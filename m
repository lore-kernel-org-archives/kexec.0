Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fyD7J-0008Ua-IB
 for kexec@lists.infradead.org; Fri, 07 Sep 2018 09:31:59 +0000
Subject: Patch "Fix kexec forbidding kernels signed with keys in the secondary
 keyring to boot" has been added to the 4.18-stable tree
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Sep 2018 11:31:19 +0200
Message-ID: <153631267919813@kroah.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: dhowells@redhat.com, gregkh@linuxfoundation.org, kexec@lists.infradead.org, stable@kernel.org, torvalds@linux-foundation.org, yannik@sembritzki.me
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    Fix kexec forbidding kernels signed with keys in the secondary keyring to boot

to the 4.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     fix-kexec-forbidding-kernels-signed-with-keys-in-the-secondary-keyring-to-boot.patch
and it can be found in the queue-4.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From ea93102f32244e3f45c8b26260be77ed0cc1d16c Mon Sep 17 00:00:00 2001
From: Yannik Sembritzki <yannik@sembritzki.me>
Date: Thu, 16 Aug 2018 14:05:23 +0100
Subject: Fix kexec forbidding kernels signed with keys in the secondary keyring to boot

From: Yannik Sembritzki <yannik@sembritzki.me>

commit ea93102f32244e3f45c8b26260be77ed0cc1d16c upstream.

The split of .system_keyring into .builtin_trusted_keys and
.secondary_trusted_keys broke kexec, thereby preventing kernels signed by
keys which are now in the secondary keyring from being kexec'd.

Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
verify_pefile_signature().

Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kexec-bzimage64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loade
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	return verify_pefile_signature(kernel, kernel_len,
-				       NULL,
+				       VERIFY_USE_SECONDARY_KEYRING,
 				       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif


Patches currently in stable-queue which might be from yannik@sembritzki.me are

queue-4.18/replace-magic-for-trusting-the-secondary-keyring-with-define.patch
queue-4.18/fix-kexec-forbidding-kernels-signed-with-keys-in-the-secondary-keyring-to-boot.patch

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
