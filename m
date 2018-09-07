Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fyO4H-00052j-0j
 for kexec@lists.infradead.org; Fri, 07 Sep 2018 21:13:30 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.18 025/145] Fix kexec forbidding kernels signed with keys in
 the secondary keyring to boot
Date: Fri,  7 Sep 2018 23:08:11 +0200
Message-Id: <20180907210905.703424333@linuxfoundation.org>
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
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
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Yannik Sembritzki <yannik@sembritzki.me>, keyrings@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
