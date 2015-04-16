Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yimxa-000836-6T
 for kexec@lists.infradead.org; Thu, 16 Apr 2015 16:48:14 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 1/6] purgatory: Fix memcmp for src address increment
Date: Thu, 16 Apr 2015 22:17:17 +0530
Message-Id: <6ac5de6bcd76b7a0790c3a403fa0c629c4a4eff8.1429201849.git.panand@redhat.com>
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
In-Reply-To: <cover.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.fedoraproject.org, kexec@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>

src addresses are not being incremented, so only first byte is compared
instead of first len bytes.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 purgatory/string.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/purgatory/string.c b/purgatory/string.c
index 4f35613ef751..f06c460b08f8 100644
--- a/purgatory/string.c
+++ b/purgatory/string.c
@@ -46,6 +46,8 @@ int memcmp(void *src1, void *src2, size_t len)
 		if (*s1 != *s2) {
 			return *s2 - *s1;
 		}
+		s1++;
+		s2++;
 	}
 	return 0;
 	
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
