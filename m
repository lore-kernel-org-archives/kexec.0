Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RZFFA-0005da-SV
 for kexec@lists.infradead.org; Sat, 10 Dec 2011 05:13:05 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Sat, 10 Dec 2011 05:00:16 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBA4x2n13526846
 for <kexec@lists.infradead.org>; Sat, 10 Dec 2011 15:59:02 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBA52fdS006791
 for <kexec@lists.infradead.org>; Sat, 10 Dec 2011 16:02:41 +1100
Message-ID: <4EE2E7ED.6080202@linux.vnet.ibm.com>
Date: Sat, 10 Dec 2011 10:32:37 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v5 1/9] fadump: Add documentation for firmware-assisted
 dump.
References: <20111115151145.16533.16384.stgit@mars.in.ibm.com>
 <20111115151334.16533.5790.stgit@mars.in.ibm.com>
 <20111124223410.GB19828@bloggs.ozlabs.ibm.com>
In-Reply-To: <20111124223410.GB19828@bloggs.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Amerigo Wang <amwang@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>, Anton Blanchard <anton@samba.org>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On 11/25/2011 04:04 AM, Paul Mackerras wrote:
>> + /sys/kernel/debug/powerpc/fadump_region
>> +
>> +    This file shows the reserved memory regions if fadump is
>> +    enabled otherwise this file is empty. The output format
>> +    is:
>> +    <region>: [<start>-<end>] <reserved-size> bytes, Dumped: <dump-size>
>> +
>> +    e.g.
>> +    Contents when fadump is registered during first kernel
>> +
>> +    # cat /sys/kernel/debug/powerpc/fadump_region
>> +    CPU : [0x0000006ffb0000-0x0000006fff001f] 0x40020 bytes, Dumped: 0x0
>> +    HPTE: [0x0000006fff0020-0x0000006fff101f] 0x1000 bytes, Dumped: 0x0
>> +    DUMP: [0x0000006fff1020-0x0000007fff101f] 0x10000000 bytes, Dumped: 0x0
> 
> How come the HPTE region is only 0x1000 (4k) bytes?  The hashed page
> table (HPT) will be much bigger than this.  Is this our way of telling
> the hypervisor that we don't care about the HPT?  If so, is it
> possible to make this region 0 bytes instead of 0x1000?
> 

The firmware assisted dump registration fails with "Hardware
error (-1)" when called with HPTE dump section with size 0.

According to PAPR the size returned by ibm,configure-kernel-dump-sizes
node for HPTE dump section is a minimum size for HPTE dump section.

Though PAPR dose not mention this, but after sevaral trial and error, it
looks like the HPTE dump section is one of the mandatory
argument that needs to be passed (with non-zero size) while making
ibm,configure-kernel-dump rtas call.

Thanks,
-Mahesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
