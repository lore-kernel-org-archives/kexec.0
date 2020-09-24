Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLGUX-0006ts-0W
 for kexec@lists.infradead.org; Thu, 24 Sep 2020 01:56:14 +0000
Subject: Re: [PATCH v2] docs: admin-guide: update kdump documentation due to
 change of crash URL
From: lijiang <lijiang@redhat.com>
References: <20200918080958.19841-1-lijiang@redhat.com>
Message-ID: <a088bff5-1174-25fa-ac26-6e46795f4085@redhat.com>
Date: Thu, 24 Sep 2020 09:56:02 +0800
MIME-Version: 1.0
In-Reply-To: <20200918080958.19841-1-lijiang@redhat.com>
Content-Language: en-US
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
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com, corbet@lwn.net

Since crash utility has been moved to github, the original URL is no
longer available. Let's update it accordingly.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 2da65fef2a1c..75a9dd98e76e 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -509,9 +509,12 @@ ELF32-format headers using the --elf32-core-headers kernel option on the
 dump kernel.
 
 You can also use the Crash utility to analyze dump files in Kdump
-format. Crash is available on Dave Anderson's site at the following URL:
+format. Crash is available at the following URL:
 
-   http://people.redhat.com/~anderson/
+   https://github.com/crash-utility/crash
+
+Crash document can be found at:
+   https://crash-utility.github.io/
 
 Trigger Kdump on WARN()
 =======================
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
