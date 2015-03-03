Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YSivx-0008NY-Tl
 for kexec@lists.infradead.org; Tue, 03 Mar 2015 09:16:10 +0000
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 3 Mar 2015 09:15:47 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2DA3F17D8066
 for <kexec@lists.infradead.org>; Tue,  3 Mar 2015 09:16:04 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t239FjU97405976
 for <kexec@lists.infradead.org>; Tue, 3 Mar 2015 09:15:45 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t239FilA018724
 for <kexec@lists.infradead.org>; Tue, 3 Mar 2015 02:15:45 -0700
Date: Tue, 3 Mar 2015 10:15:43 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Use file offset in initialize_mmap()
Message-ID: <20150303101543.416b5cb4@holzheu>
In-Reply-To: <20150227131409.33dd14a4@hananiah.suse.cz>
References: <20150227131409.33dd14a4@hananiah.suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Jan Willeke <willeke@de.ibm.com>

Hello Petr,

Thanks for the fix!

Hard to believe that makedumpfile mmap mode on s390 has never worked.

On Fri, 27 Feb 2015 13:14:09 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> Hi all,
> 
> update_mmap_range() expects a file offset as its first argument, but
> initialize_mmap() passes a physical address. Since the first segment
> usually starts at physical addr 0 on S/390, but there is no segment 
> at file offset 0, update_mmap_range() fails, and makedumpfile falls
> back to read().

And for other architectures the wrong parameter was no problem?

> 
> @Michael: I wonder how you actually tested the kernel mmap patches;
> this bug has prevented mmap on all my s390 systems...

We tested /proc/vmcore mmap with our SCSI stand-alone dump (zfcpdump) and
with small test programs that used mmap.

I did a quick test with your patch and it looks like the mmap mode
on my s390 system is slower than the read mode:

# time ./makedumpfile -d 31 /proc/vmcore out
real    0m1.043s
user    0m0.187s
sys     0m0.433s

# time ./makedumpfile -d 31 /proc/vmcore out --non-mmap
real    0m0.767s
user    0m0.098s
sys     0m0.364s

We will have to look into this.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
