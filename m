Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH] purgatory: Fix memcmp for src address increment
Date: Thu, 23 Apr 2015 08:34:17 +0530
Message-Id: <6cdeaea422f53a62d9c72dfb5848565697e27b08.1429758015.git.panand@redhat.com>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org

src addresses are not being incremented, so only first byte is compared
instead of first len bytes.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Acked-by: Geoff Levand <geoff@infradead.org>
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
