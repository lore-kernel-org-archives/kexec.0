Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LUgWC-00018M-5Z
	for kexec@lists.infradead.org; Wed, 04 Feb 2009 12:06:14 +0000
Date: Wed, 4 Feb 2009 07:05:49 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH]: add dmesg log symbols to /proc/vmcoreinfo lists
Message-ID: <20090204120549.GA2182@hmsreliant.think-freely.org>
References: <20090119212127.GA13157@hmsreliant.think-freely.org>
	<20090120141551.GA5125@redhat.com>
	<20090120150958.GB18207@hmsreliant.think-freely.org>
	<20090120152255.GB5125@redhat.com>
	<20090127001211.f847ea5a.akpm@linux-foundation.org>
	<20090128041109.GA4943@verge.net.au>
	<m1ljsnz1up.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1ljsnz1up.fsf@fess.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Eric Biederman <ebiederm@xmision.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Simon Horman <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

> 
> That aside we aren't currently exporting log_buf_len, so I don't
> think this code works actually works.
> 
> Neil can you add a comment in kernel/printk.c of the algorithm
> necessary for external tools to decode the ring buffer?
> 
> We need the comment because people working on kernel/printk.c
> need to know what is happening and without having to review lots
> of user space code, and we need the comment to verify that we
> are exporting the right things.
> 

Ok, as per Erics comment, I've written this.  It applies on top of whats already
in your tree Andrew.  It adds some comments on the function in question so that
anyone working on printk.c will know why we're exporting their symbols.  It also
modifies slightly the symbols we are exporting so that we can handle dmesg
buffers that are longer than the standard PAGE_SIZE configuration, and lets us
detect and handle buffer wraps.

Thanks!

printk.c |   12 +++++++++++-
1 file changed, 11 insertions(+), 1 deletion(-)

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

diff --git a/kernel/printk.c b/kernel/printk.c
index dd5cc7b..6a1163b 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -138,10 +138,20 @@ static int log_buf_len = __LOG_BUF_LEN;
 static unsigned logged_chars; /* Number of chars produced since last read+clear operation */
 
 #ifdef CONFIG_KEXEC
+/*
+ * This appends the listed symbols to /proc/vmcoreinfo
+ * /proc/vmcoreinfo is used by various utiilties, like
+ * crash and makedumpfile to obtain access to symbols that
+ * are otherwise very difficult to locate.  These symbols 
+ * are specifically used so that utilities 
+ * can access and extract the dmesg log from a vmcore file
+ * after a crash
+ */
 void log_buf_kexec_setup(void)
 {
 	VMCOREINFO_SYMBOL(log_buf);
-	VMCOREINFO_SYMBOL(log_end);
+	VMCOREINFO_SYMBOL(log_buf_len);
+	VMCOREINFO_SYMBOL(logged_chars)
 }
 #endif
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
