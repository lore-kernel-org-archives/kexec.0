Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TxeGt-0000zZ-U3
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 13:52:17 +0000
Message-ID: <50FE9989.5070601@canonical.com>
Date: Tue, 22 Jan 2013 14:52:09 +0100
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: makedumpfile --dump-dmesg option broken on 3.5 kernels and later
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Kumagai-san,

Following a suggestion from Dave Anderson, I have tested the
makedumpfile --dump-dmesg option. After some research, I realized that
the option was no longer working on 3.5 kernel and later. Here is an
example of the result (on Ubuntu Quantal) :

# makedumpfile --dump-dmesg /proc/vmcore /tmp/dmesg
dump_dmesg: Can't find some symbols for log_buf.

makedumpfile Failed.

On 3.5 kernel and later, the log_end symbol no longer exists.

This is caused by the change from byte-buffer structure to
variable-length record buffer of the kernel log buffer introduced by
this commit :
	http://goo.gl/NCgLI

I am curious to know if you were aware of this change and if you had
done some work on modifying dump_dmesg() accordingly ? Just so I don't
go off and try to work on something that you have already solved.

Kind regards,

...Louis
-- 
Louis Bouchard
Backline Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
