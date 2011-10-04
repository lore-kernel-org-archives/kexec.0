Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAvad-0000wx-UP
	for kexec@lists.infradead.org; Tue, 04 Oct 2011 03:22:45 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id p943MckA005485
	for <kexec@lists.infradead.org>; Tue, 4 Oct 2011 08:52:38 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p943LLv64464866
	for <kexec@lists.infradead.org>; Tue, 4 Oct 2011 08:51:21 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p943LLMK024938
	for <kexec@lists.infradead.org>; Tue, 4 Oct 2011 08:51:21 +0530
Message-ID: <4E8A7BAF.9020908@in.ibm.com>
Date: Tue, 04 Oct 2011 08:51:19 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: powerpc: crash_dump: No backup region for PPC BookE
References: <20111003101746.30979.44424.stgit@suzukikp.in.ibm.com>
	<CAEsOVNefdrEgkSG9gO13kQW2akjYWX=Q6xEEkwxQ4Vv5ndfGKw@mail.gmail.com>
In-Reply-To: <CAEsOVNefdrEgkSG9gO13kQW2akjYWX=Q6xEEkwxQ4Vv5ndfGKw@mail.gmail.com>
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
To: McClintock Matthew-B29882 <B29882@freescale.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Simon Horman <horms@verge.net.au>, Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "M. Mohan Kumar" <mohan@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On 10/03/11 23:53, McClintock Matthew-B29882 wrote:
> On Mon, Oct 3, 2011 at 5:18 AM, Suzuki K. Poulose<suzuki@in.ibm.com>  wrote:
>> Disable backup regions for BookE in case of a CRASH Dump, as they can
>> be run from anywhere.
>>
>> The patch introduces --with-booke option to support the BookE.
>>
>> With the patch, we get :
>>
>> ## On a 256M machine:
>>
>> # busybox cat /proc/cmdline
>> init=/bin/init console=ttyS0,16550 crashkernel=128M@100M
>> # kexec -p root/vmlinux
>> usable memory rgns size:1 base:6400000 size:8000000
>> CRASH MEMORY RANGES
>> 0000000000000000-0000000006400000
>> 000000000e400000-0000000010000000
>> Command line after adding elfcorehdr:  elfcorehdr=112380K
>> Command line after adding elfcorehdr:  elfcorehdr=112380K savemaxmem=256M
>
> So there were two crash regions when we only needed the one specified
> on the command line?
>
Yes, and isn't that is expected ? The first kernel uses the memory region
(0-100M), (228M,256M). Where the 100-228M is reserved for crash kernel.

Thanks
Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
