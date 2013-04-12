Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UQXjd-0004z8-Ij
 for kexec@lists.infradead.org; Fri, 12 Apr 2013 06:45:23 +0000
Date: Fri, 12 Apr 2013 15:17:18 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 0/2] Fix the regression issue in makedumpfile-1.5.3.
Message-Id: <20130412151718.dc8eaa97cf73eddfea74edc0@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: ptesarik@suse.cz

Hello,

I found a regression issue in v1.5.3.
If you have already faced this issue, this patchset will help you.
At least, this issue may happen on IA64. Actually, I faced it
in my environment.


- DESCRIPTION

If reading the separated page on different PT_LOAD segments,
we have to read the page data from both segments.
And read_pfn() was introduced for such cases as described as below.

    /*
     * This function is specific for reading page.
     *
     * If reading the separated page on different PT_LOAD segments,
     * this function gets the page data from both segments. This is
     * worthy of ia64 /proc/vmcore. In ia64 /proc/vmcore, region 5
     * segment is overlapping to region 7 segment. The following is
     * example (page_size is 16KBytes):
     *
     *  region |       paddr        |       memsz
     * --------+--------------------+--------------------
     *     5   | 0x0000000004000000 | 0x0000000000638ce0
     *     7   | 0x0000000004000000 | 0x0000000000db3000
     *
     * In the above example, the last page of region 5 is 0x4638000
     * and the segment does not contain complete data of this page.
     * Then this function gets the data of 0x4638000 - 0x4638ce0
     * from region 5, and gets the remaining data from region 7.
     */
    int
    read_pfn(unsigned long long pfn, unsigned char *buf)
    {

But read_pfn() hasn't worked as expected since the caching feature
was introduced. 

The current call stack can be broken into as follows:

  read_pfn()
    readmem()
      readpage_elf()
        read(2)

If the target of read_pfn() is separated page, readmem() is called
twice as for the former part and later part of the page.
But readpage_elf() always try to read a whole page and cache it
without consideration for separated page. As the result, readmem()
can get the same invalid data in both readmem().

This patchset fix this issue by moving the logic for separated page
from read_pfn() to readpaeg_elf().
And this patchset includes the cleanup of scrubbing feature,
comments for it are welcome too.

----
Atsushi Kumagai (2):
      Move scrubbing process from reader to writer.
      Fix the issue which can happen around overlapping segments.

 makedumpfile.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------
 1 file changed, 64 insertions(+), 67 deletions(-)


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
