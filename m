Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aeGbw-000327-7X
 for kexec@lists.infradead.org; Fri, 11 Mar 2016 06:31:44 +0000
Message-Id: <20160311062156.131015797@redhat.com>
Date: Fri, 11 Mar 2016 14:21:56 +0800
From: dyoung@redhat.com
Subject: [PATCH 0/2] min_t type casting bug fixes
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
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, d.hatayama@jp.fujitsu.com, bhe@redhat.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org, dyoung@redhat.com

Hi,

We found a min_t type casting issue in fs/proc/vmcore.c, it uses smaller
type in min_t so that during i386 PAE testing 64bit value was trucated
and then cause saving vmcore failure and BUG() for mmap case.

I introduced new macros min_lt and max_lt to select the larger data type
in x and y. Then use it in 2nd patch.

Any comments are appreciated.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
