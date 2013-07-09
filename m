Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwaiL-0004SP-7J
 for kexec@lists.infradead.org; Tue, 09 Jul 2013 16:24:29 +0000
Date: Tue, 9 Jul 2013 11:24:03 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: makedumpfile 1.5.4, 734G kdump tests
Message-ID: <20130709162403.GA25441@sgi.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

I have run some tests with the latest makedumpfile and kexec and the
results (below) look very good to me.

This particular test machine has a megaraid root, which had been a problem
with previous kexec-tools (I did have to allocate a lot of low memory).

My 3.10 kernel does have Hatayama's vmcore mmap patches.

My only remaining concern for makedumpfile is the filtering of huge pages.
I believe that patch is in progress; but I don't see it in 1.5.4.

-Cliff


UV2000   memory: 734G
makedumpfile: makedumpfile-1.5.4
kexec:   git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
booted with   crashkernel=1G,high crashkernel=192M,low
non-cyclic mode

write to       option            init&scan sec.   copy sec.  dump size
-------------  -----------------           ----   ---------  ---------
megaraid disk  no compression                19          91      11.7G
megaraid disk  zlib compression              20         209       1.4G
megaraid disk  snappy compression            20          46       2.4G
megaraid disk  snappy compression no mmap    30          72       2.4G
/dev/null      no compression                19          28          -
/dev/null      zlib compression              19         206          -
/dev/null      snappy compression            19          41          -

Notes and observations
- Snappy compression is a big win over zlib compression; over 4 times faster
  with a cost of relatively little disk space.
- The vmcore mmap kernel patch cuts off about 1/3 of both page scan time and
  data copy time.
  I hope those patches reach Linus' tree shortly, as you expect.
- Data copy time is dominated by compression time; writing compressed data
  to /dev/null uses almost the same time as writing to disk.
  I hope your efforts to multi-thread the crash kernel go forward.

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
