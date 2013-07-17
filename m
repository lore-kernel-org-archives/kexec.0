Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UzMdY-0002ap-99
 for kexec@lists.infradead.org; Wed, 17 Jul 2013 07:59:00 +0000
Message-ID: <51E64EA6.9040209@redhat.com>
Date: Wed, 17 Jul 2013 15:58:30 +0800
From: Baoquan <bhe@redhat.com>
MIME-Version: 1.0
Subject: makefumpfile tool to estimate vmcore file size
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Kexec-ml <kexec@lists.infradead.org>


Hi Atsushi,

Our customer want us to provide a tool to estimate the required dump
file size based on the current system memory footprint. The following is
detailed requirement I tried to conclude, what's your opinion?

In customer's place there are thousands of machines and they don't want
to budget for significant increases in storage if unnecessary. This
becomes particularly expensive with large memory (1tb+) systems booting
off san disk.

Customer would like to achieve this by below example:
##########################################################
#makedumpfile -d31 -c/-l/-p

TYPE			PAGES		INCLUDED

Zero Page		x		no
Cache Without Private	x           	no
Cache With Private	x		no
User Data		x		no
Free Page		x		no
Kernel Code		x		yes
Kernel Data		x		yes

Total Pages on system:			311000  (Just for example)
Total Pages included in kdump:		160000  (Just for example)
Estimated vmcore file size:		48000  (30% compression ratio)
##########################################################

By configured dump level, total pages included in kdump can be computed.
Then with option which specify a compression algorithm, an estimated
vmcore file size can be given. Though the estimated value is changed
dynamically with time, it does give user a valuable reference.

Thanks a lot
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
