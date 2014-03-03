Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKYmw-00036A-U3
 for kexec@lists.infradead.org; Mon, 03 Mar 2014 19:44:36 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
 (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s23JiC6O000825
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 3 Mar 2014 14:44:13 -0500
Date: Mon, 3 Mar 2014 14:44:12 -0500
From: Marc Milgram <mmilgram@redhat.com>
Message-Id: <20140303194412.7864.20862.sendpatchset@dhcp-33-231.bos.redhat.com>
Subject: makedumpfile: optimize is_zero_page
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
To: kexec@lists.infradead.org
Cc: Marc Milgram <mmilgram@redhat.com>

There are local complaints that  filtering out only zero pages is slow.  I
found that is_zero_page was inefficient.  It checks if the page contains any
non-zero bytes - one byte at a time.

Improve performance by checking for non-zero data 64 bits at a time.  Also,
unroll the loop for additional performance.

Did testing in x86_64 mode on an Intel Xeon x5560 system with 18GB RAM.
Executed:
  time makedumpfile -d 1 /proc/vmcore <destination>

The amount of time taken in User space was reduced by 75%.  The total time to
dump memory was reduced by 28%.

is_zero_page 
Signed-off-by: Marc Milgram <mmilgram at redhat.com>
---
diff --git a/makedumpfile.h b/makedumpfile.h
index 3d270c6..0f211c4 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1634,10 +1634,27 @@ static inline int
 is_zero_page(unsigned char *buf, long page_size)
 {
 	size_t i;
+	unsigned long long *vect = (unsigned long long *) buf;
+	long page_len = page_size / (sizeof(unsigned long long));
 
-	for (i = 0; i < page_size; i++)
-		if (buf[i])
+	for (i = 0; i < page_len; i+=8) {
+		if (vect[i])
 			return FALSE;
+		if (vect[i+1])
+			return FALSE;
+		if (vect[i+2])
+			return FALSE;
+		if (vect[i+3])
+			return FALSE;
+		if (vect[i+4])
+			return FALSE;
+		if (vect[i+5])
+			return FALSE;
+		if (vect[i+6])
+			return FALSE;
+		if (vect[i+7])
+			return FALSE;
+	}
 	return TRUE;
 }
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
