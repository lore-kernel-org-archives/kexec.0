Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khqlS-0007OM-0g
 for kexec@lists.infradead.org; Wed, 25 Nov 2020 09:07:03 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: RE: [PATCH] makedumpfile: printk: add support for lockless ringbuffer
In-Reply-To: <OSBPR01MB1991B98F9B72C74C33BAA950DDFB0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1991BDA9AB4100A661E53CF6DDE00@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87sg94zsva.fsf@jogness.linutronix.de>
 <OSBPR01MB199155FE684812D139FBD7F7DDFF0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87lfer82a4.fsf@jogness.linutronix.de>
 <OSBPR01MB1991B98F9B72C74C33BAA950DDFB0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Date: Wed, 25 Nov 2020 10:13:00 +0106
Message-ID: <87k0u94xfv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2020-11-24, HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=80=80=E4=B8=80=E4=BB=81=
)	<k-hagio-ab@nec.com> wrote:
>> After looking more closely, I see that your patch is still using the
>> old state flags. With the current version, there is now a value-based
>> state field.
>
> Thank you for pointing it out!  Could you submit a follow-up patch?

I have attached a follow-up patch. It is pretty much the exact same
patch as the one I sent for "crash".

John Ogness


--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment;
 filename=0001-printk-use-committed-finalized-state-values.patch

From 58396867cb3bfd1ca060cf5eb3a910d7f8c192c2 Mon Sep 17 00:00:00 2001
From: John Ogness <john.ogness@linutronix.de>
Date: Wed, 25 Nov 2020 10:10:31 +0106
Subject: [PATCH] printk: use committed/finalized state values

The ringbuffer entries use 2 state values (committed and finalized)
rather than a single flag to represent being available for reading.
Copy the definitions and state lookup function directly from the
kernel source and use the new states.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 printk.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/printk.c b/printk.c
index 8e00901..9cecbd1 100644
--- a/printk.c
+++ b/printk.c
@@ -1,12 +1,6 @@
 #include "makedumpfile.h"
 #include <ctype.h>
 
-#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
-#define DESC_COMMITTED_MASK	(1UL << (DESC_SV_BITS - 1))
-#define DESC_REUSE_MASK		(1UL << (DESC_SV_BITS - 2))
-#define DESC_FLAGS_MASK		(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
-#define DESC_ID_MASK		(~DESC_FLAGS_MASK)
-
 /* convenience struct for passing many values to helper functions */
 struct prb_map {
 	char		*prb;
@@ -21,12 +15,51 @@ struct prb_map {
 	char		*text_data;
 };
 
+/*
+ * desc_state and DESC_* definitions taken from kernel source:
+ *
+ * kernel/printk/printk_ringbuffer.h
+ */
+
+/* The possible responses of a descriptor state-query. */
+enum desc_state {
+	desc_miss	=  -1,	/* ID mismatch (pseudo state) */
+	desc_reserved	= 0x0,	/* reserved, in use by writer */
+	desc_committed	= 0x1,	/* committed by writer, could get reopened */
+	desc_finalized	= 0x2,	/* committed, no further modification allowed */
+	desc_reusable	= 0x3,	/* free, not yet used by any writer */
+};
+
+#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
+#define DESC_FLAGS_SHIFT	(DESC_SV_BITS - 2)
+#define DESC_FLAGS_MASK		(3UL << DESC_FLAGS_SHIFT)
+#define DESC_STATE(sv)		(3UL & (sv >> DESC_FLAGS_SHIFT))
+#define DESC_ID_MASK		(~DESC_FLAGS_MASK)
+#define DESC_ID(sv)		((sv) & DESC_ID_MASK)
+
+/*
+ * get_desc_state() taken from kernel source:
+ *
+ * kernel/printk/printk_ringbuffer.c
+ */
+
+/* Query the state of a descriptor. */
+static enum desc_state get_desc_state(unsigned long id,
+				      unsigned long state_val)
+{
+	if (id != DESC_ID(state_val))
+		return desc_miss;
+
+	return DESC_STATE(state_val);
+}
+
 static void
 dump_record(struct prb_map *m, unsigned long id)
 {
 	unsigned long long ts_nsec;
 	unsigned long state_var;
 	unsigned short text_len;
+	enum desc_state state;
 	unsigned long begin;
 	unsigned long next;
 	char buf[BUFSIZE];
@@ -45,7 +78,8 @@ dump_record(struct prb_map *m, unsigned long id)
 
 	/* skip non-committed record */
 	state_var = ULONG(desc + OFFSET(prb_desc.state_var) + OFFSET(atomic_long_t.counter));
-	if ((state_var & DESC_FLAGS_MASK) != DESC_COMMITTED_MASK)
+	state = get_desc_state(id, state_var);
+	if (state != desc_committed && state != desc_finalized)
 		return;
 
 	begin = ULONG(desc + OFFSET(prb_desc.text_blk_lpos) + OFFSET(prb_data_blk_lpos.begin)) %
-- 
2.20.1


--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--=-=-=--

