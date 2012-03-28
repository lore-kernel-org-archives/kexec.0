Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SD0Jj-00078U-Bi
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 21:22:08 +0000
Date: Wed, 28 Mar 2012 17:22:04 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: makedumpfile memory usage grows with system memory size
Message-ID: <20120328212204.GI18218@redhat.com>
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
To: oomichi@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Hello Ken'ichi-san,

I was talking to Vivek about kdump memory requirements and he mentioned
that they vary based on how much system memory is used.

I was interested in knowing why that was and again he mentioned that
makedumpfile needed lots of memory if it was running on a large machine
(for example 1TB of system memory).

Looking through the makedumpfile README and using what Vivek remembered of
makedumpfile, we gathered that as the number of pages grows, the more
makedumpfile has to temporarily store the information in memory.  The
possible reason was to calculate the size of the file before it was copied
to its final destination?

I was curious if that was true and if it was, would it be possible to only
process memory in chunks instead of all at once.

The idea is that a machine with 4Gigs of memory should consume the same
the amount of kdump runtime memory as a 1TB memory system.

Just trying to research ways to keep the memory requirements consistent
across all memory ranges.

Thanks,
Don


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
