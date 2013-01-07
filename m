Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TsCsw-0003wV-Cp
 for kexec@lists.infradead.org; Mon, 07 Jan 2013 13:37:03 +0000
Date: Mon, 7 Jan 2013 07:39:35 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
Message-ID: <20130107133935.GA1207@sgi.com>
References: <E1TbGZV-0008DR-Tb@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1TbGZV-0008DR-Tb@eag09.americas.sgi.com>
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
To: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: lisa.mitchell@hp.com

An update on testing thise patches:

> This version of the patch improves the consolidation of the mem_map table
> that is passed to the kernel.  See make_kernel_mmap().
> Particularly the seemingly duplicate pfn ranges generated on an older
> (2.6.32-based, rhel6) kernel.


On a 2TB machine (idle) machine:
  the crash kernel ran successfully in 512M
  the scan for unnecessary pages takes about 40 seconds
  it was a single scan, not cyclic
  
On a 16TB machine (idle) machine:
  the crash kernel ran successfully in 512M
  there is a pause of about 4 minutes during makedumpfile initialization
  the scan for unnecessary pages takes about 4.8 minutes
  it was a single scan, not cyclic


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
