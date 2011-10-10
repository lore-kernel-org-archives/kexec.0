Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDCY5-0003X4-Sf
	for kexec@lists.infradead.org; Mon, 10 Oct 2011 09:53:31 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p9A9kS5L032417
	for <kexec@lists.infradead.org>; Mon, 10 Oct 2011 20:46:28 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p9A9rMFh2404378
	for <kexec@lists.infradead.org>; Mon, 10 Oct 2011 20:53:22 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p9A9rMu6027227
	for <kexec@lists.infradead.org>; Mon, 10 Oct 2011 20:53:22 +1100
Message-ID: <4E92C08F.4050908@in.ibm.com>
Date: Mon, 10 Oct 2011 15:23:19 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: powerpc: crash_dump: No backup region for PPC BookE
References: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "M. Mohan Kumar" <mohan@in.ibm.com>, "Suzuki K. Poulose" <suzuki@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On 10/03/11 15:48, Suzuki K. Poulose wrote:
> Disable backup regions for BookE in case of a CRASH Dump, as they can
> be run from anywhere.
>
> The patch introduces --with-booke option to support the BookE.
>
> With the patch, we get :
>
> ## On a 256M machine:
>
> # busybox cat /proc/cmdline
> init=/bin/init console=ttyS0,16550 crashkernel=128M@100M
> # kexec -p root/vmlinux
> usable memory rgns size:1 base:6400000 size:8000000
> CRASH MEMORY RANGES
> 0000000000000000-0000000006400000
> 000000000e400000-0000000010000000
> Command line after adding elfcorehdr:  elfcorehdr=112380K
> Command line after adding elfcorehdr:  elfcorehdr=112380K savemaxmem=256M
>
> Signed-off-by: Suzuki K. Poulose<suzuki@in.ibm.com>
Simon,

Could you please pick up the patch, if no one has any issues ?

Thanks

Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
