Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKjGz-0006U8-Gi
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 05:51:46 +0000
Message-ID: <515288E9.2070707@hp.com>
Date: Wed, 27 Mar 2013 13:51:37 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: makedumpfile mmap() benchmark
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
In-Reply-To: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, "Mitchell, Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jingbai.ma@hp.com

Hi,

I have tested the makedumpfile mmap patch on a machine with 2TB memory, 
here is testing results:
Test environment:
Machine: HP ProLiant DL980 G7 with 2TB RAM.
CPU: Intel(R) Xeon(R) CPU E7- 2860  @ 2.27GHz (8 sockets, 10 cores)
(Only 1 cpu was enabled the 2nd kernel)
Kernel: 3.9.0-rc3+ with mmap kernel patch v3
vmcore size: 2.0TB
Dump file size: 3.6GB
makedumpfile mmap branch with parameters: -c --message-level 23 -d 31 
--map-size <map-size>
All measured time from debug message of makedumpfile.

As a comparison, I also have tested with original kernel and original 
makedumpfile 1.5.1 and 1.5.3.
I added all [Excluding unnecessary pages] and [Excluding free pages] 
time together as "Filter Pages", and [Copyying Data] as "Copy data" here.

makedumjpfile	Kernel	map-size (KB)	Filter pages (s)	Copy data (s)	Total (s)
1.5.1	 3.7.0-0.36.el7.x86_64	N/A	940.28	1269.25	2209.53
1.5.3	 3.7.0-0.36.el7.x86_64	N/A	380.09	992.77	1372.86
1.5.3	v3.9-rc3	N/A	197.77	892.27	1090.04
1.5.3+mmap	v3.9-rc3+mmap	0	164.87	606.06	770.93
1.5.3+mmap	v3.9-rc3+mmap	4	88.62	576.07	664.69
1.5.3+mmap	v3.9-rc3+mmap	1024	83.66	477.23	560.89
1.5.3+mmap	v3.9-rc3+mmap	2048	83.44	477.21	560.65
1.5.3+mmap	v3.9-rc3+mmap	10240	83.84	476.56	560.4


Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
