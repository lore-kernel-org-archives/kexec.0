Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TCA7a-0003W3-S8
 for kexec@lists.infradead.org; Thu, 13 Sep 2012 14:10:24 +0000
Date: Thu, 13 Sep 2012 10:10:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Query about cyclic buffer size
Message-ID: <20120913141018.GG4396@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>

Hi Atsushi-san,

How is size of cyclic buffer decided with 1.5.0? In practice I don't think
asking user for the size is a good idea as user does not know how much
memory will be left after kernel boot.

Will it make sense for makedumpfile to automatically determine the buffer
size based on amount of free memory available in the system. Something
like use 70-80% of free memory as cyclic buffer.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
