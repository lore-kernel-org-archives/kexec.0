Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vy8lV-0008JN-Ll
 for kexec@lists.infradead.org; Tue, 31 Dec 2013 23:30:26 +0000
Subject: [PATCH 0/2] makedumpfile: for large memories
Message-Id: <E1Vy8l7-0004oL-7v@eag09.americas.sgi.com>
From: cpw <cpw@sgi.com>
Date: Tue, 31 Dec 2013 17:30:01 -0600
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
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

From: Cliff Wickman <cpw@sgi.com>

Gentlemen of kexec,

I have been working on enabling kdump on some very large systems, and
have found some solutions that I hope you will consider.

The first issue is to work within the restricted size of crashkernel memory
under 2.6.32-based kernels, such as sles11 and rhel6.

The second issue is to reduce the very large size of a dump of a big memory
system, even on an idle system.

These are my propositions:

Size of crashkernel memory
  1) raw i/o for writing the dump
  2) use root device for the bitmap file (not tmpfs)
  3) raw i/o for reading/writing the bitmaps
  
Size of dump (and hence the duration of dumping)
  4) exclude page structures for unused pages


1) Is quite easy.  The cache of pages needs to be aligned on a block
  boundary and written in block multiples, as required by O_DIRECT files.

  The use of raw i/o prevents the growing of the crash kernel's page
  cache.

2) Is also quite easy.  My patch finds the path to the crash
  kernel's root device by examining the dump pathname. Storing the bitmaps
  to a file is otherwise not conserving memory, as they are being written
  to tmpfs.

3) Raw i/o for the bitmaps, is accomplished by caching the
  bitmap file in a similar way to that of the dump file.

  I find that the use of direct i/o is not significantly slower than
  writing through the kernel's page cache.

4) The excluding of unused kernel page structures is very
  important for a large memory system.  The kernel otherwise includes
  3.67 million pages of page structures per TB of memory. By contrast
  the rest of the kernel is only about 1 million pages.

Test results are below, for systems of 1TB, 2TB, 8.8TB and 16TB.
(There are no 'old' numbers for 16TB as time and space requirements
 made those effectively useless.)

Run times were generally reduced 2-3x, and dump size reduced about 8x.

All timings were done using 512M of crashkernel memory.

   System memory size
   1TB                     unpatched    patched
     OS: rhel6.4 (does a free pages pass)
     page scan time           1.6min    1.6min
     dump copy time           2.4min     .4min
     total time               4.1min    2.0min
     dump size                 3014M      364M

     OS: rhel6.5
     page scan time            .6min     .6min
     dump copy time           2.3min     .5min
     total time               2.9min    1.1min
     dump size                 3011M      423M

     OS: sles11sp3 (3.0.93)
     page scan time            .5min     .5min
     dump copy time           2.3min     .5min
     total time               2.8min    1.0min
     dump size                 2950M      350M

   2TB
     OS: rhel6.5           (cyclicx3)
     page scan time           2.0min    1.8min
     dump copy time           8.0min    1.5min
     total time              10.0min    3.3min
     dump size                 6141M      835M

   8.8TB
     OS: rhel6.5           (cyclicx5)
     page scan time           6.6min    5.5min
     dump copy time          67.8min    6.2min
     total time              74.4min   11.7min
     dump size                 15.8G      2.7G

   16TB
     OS: rhel6.4
     page scan time                   125.3min
     dump copy time                    13.2min
     total time                       138.5min
     dump size                            4.0G

     OS: rhel6.5
     page scan time                    27.8min
     dump copy time                    13.3min
     total time                        41.1min
     dump size                            4.1G

Page scan time is greatly affected by whether or not the
kernel supports mmap of /proc/vmcore.

The choice of snappy vs. zlib compression becomes fairly irrelevant
when we can shrink the dump size dramatically.  The above
were done with snappy compression.

I am sending my 2 working patches.  
They are kludgy in the sense that they ignore all forms of
kdump except the creation of a disk dump, and all architectures
except x86_64.
But I think they are sufficient to demonstrate the sizable
time, crashkernel space and disk space savings that are possible.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
