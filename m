Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH] bootstrap: Add program checks
Message-ID: <14c69313-ecb5-e7aa-bcb2-93846f2399b3@infradead.org>
Date: Sat, 4 Apr 2020 12:20:54 -0700
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Add a check for needed programs, print an error message
if not found.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 bootstrap | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bootstrap b/bootstrap
index fc9837d..9457a14 100755
--- a/bootstrap
+++ b/bootstrap
@@ -19,6 +19,20 @@
 ## @start 1
 #! /bin/sh
 
+progs="autoconf automake make"
+
+unset result
+for p in ${progs}; do
+	if ! command -v "${p}" > /dev/null; then
+		echo "Please install ${p}"
+		result=1
+	fi
+done
+
+if [ -n "${result}" ]; then
+	exit 1
+fi
+
 set -x
 aclocal -I config
 autoheader
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
