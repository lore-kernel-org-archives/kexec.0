Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vk1-xa4a.google.com ([2607:f8b0:4864:20::a4a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBqJd-0007jh-UC
 for kexec@lists.infradead.org; Thu, 04 Apr 2019 00:33:15 +0000
Received: by mail-vk1-xa4a.google.com with SMTP id f3so430779vkb.11
 for <kexec@lists.infradead.org>; Wed, 03 Apr 2019 17:33:13 -0700 (PDT)
Date: Wed,  3 Apr 2019 17:32:29 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
Subject: [PATCH V32 07/27] kexec_file: Restrict at runtime if the kernel is
 locked down
From: Matthew Garrett <matthewgarrett@google.com>
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
To: jmorris@namei.org
Cc: Jiri Bohac <jbohac@suse.cz>, linux-api@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>, dhowells@redhat.com, linux-security-module@vger.kernel.org, luto@kernel.org

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 67f3a866eabe..a1cc37c8b43b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		}
 
 		ret = 0;
+
+		if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.21.0.392.gf8f6787159e-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
