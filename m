Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <3d9d024551c3c0e560d77f81926cb5774dda7067.1386807069.git.geoff@infradead.org>
In-Reply-To: <cover.1386807069.git.geoff@infradead.org>
References: <cover.1386807069.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/4] kexec: Add IND_FLAGS macro
Date: Thu, 12 Dec 2013 00:18:56 +0000
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Eric Biederman <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>

Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
all the possible kexec IND_ kimage_entry indirection flags.

Having this macro allows for simplified code in the prosessing of the
kexec kimage_entry items.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 include/linux/kexec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index d78d28a..f755ec3 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -67,6 +67,7 @@ typedef unsigned long kimage_entry_t;
 #define IND_INDIRECTION  0x2
 #define IND_DONE         0x4
 #define IND_SOURCE       0x8
+#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
 
 struct kexec_segment {
 	void __user *buf;
-- 
1.8.1.2



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
