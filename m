Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RNea9-0002kX-NH
 for kexec@lists.infradead.org; Tue, 08 Nov 2011 05:50:51 +0000
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 8 Nov 2011 05:48:53 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA85oab21810672
 for <kexec@lists.infradead.org>; Tue, 8 Nov 2011 16:50:36 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA85oZND006864
 for <kexec@lists.infradead.org>; Tue, 8 Nov 2011 16:50:35 +1100
Received: from mars.in.ibm.com ([9.124.35.152])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 pA85oXf4006807
 for <kexec@lists.infradead.org>; Tue, 8 Nov 2011 16:50:34 +1100
Message-ID: <4EB8C329.1010509@linux.vnet.ibm.com>
Date: Tue, 08 Nov 2011 11:20:33 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: ppc64 kexec -p failed
References: <4EB38EB1.5070904@redhat.com>
In-Reply-To: <4EB38EB1.5070904@redhat.com>
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
To: kexec@lists.infradead.org

On 11/04/2011 12:35 PM, Dave Young wrote:
> Hi,
> 
> When use crashkernel=128M@256M at a ppc64 machine, kexec -p vmlinuz
> failed with:
> Could not find a free area of memory of faa448 bytes...
> Could not find a free area of memory of 142721d bytes...
> 
> Is this a know issue or Is there limitation of the crashkernel base addr?

On Power, crashkernel base addr must fall inside RMO region. The is
because ppc64 kernel needs some of its memory in the RMO region. The
memory ranges below shows that the system has RMO region of size 128M,
Hence crashkernel base addr @64M should work just fine.

> 
> Detail info as below (define DEBUG when building):
> 
...
...
> 0000000000000000-0000000008000000 : 0
...
...

Thanks,
-Mahesh.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
