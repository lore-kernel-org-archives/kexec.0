Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PGnh5-0002dw-82
	for kexec@lists.infradead.org; Fri, 12 Nov 2010 07:05:11 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAC751Jv013689
	for <kexec@lists.infradead.org>; Fri, 12 Nov 2010 18:05:01 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAC751RX2416880
	for <kexec@lists.infradead.org>; Fri, 12 Nov 2010 18:05:01 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAC7508K030116
	for <kexec@lists.infradead.org>; Fri, 12 Nov 2010 18:05:01 +1100
Message-ID: <4CDCE715.4050708@linux.vnet.ibm.com>
Date: Fri, 12 Nov 2010 12:34:53 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1] makedumpfile: s390x: Add support for s390x crashdump
	analysis
References: <20101111052840.14598.72719.stgit@mars.in.ibm.com>
	<20101112102856.a20dae40.oomichi@mxs.nes.nec.co.jp>
	<20101112113318.a69b0b57.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20101112113318.a69b0b57.oomichi@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Michael Holzheu <holzheu@de.ibm.com>, Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'ichi,

On 11/12/2010 08:03 AM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Fri, 12 Nov 2010 10:28:56 +0900
> "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:
>>
>> On Thu, 11 Nov 2010 11:04:17 +0530
>> Mahesh J Salgaonkar <mahesh@linux.vnet.in.ibm.com> wrote:
>>>
>>> This patch adds support for processing s390x kernel crashdumps.
>>>
>>> The changes have been tested on s390x system.
>>> The dump compression and filtering (for all dump levels 1,2,4,8,16 and 31)
>>> tests are succussfull.
>>
>> What version of linux kernel are the above tests on ?
>> I'd like to write the version on README file.
> 
> Also, please let me know the memory model (flatmem, discontigmem,
> or sparsemem) too.
> 
>   # make menuconfig
>   -> Processor type and features
>      -> Memory model
> 

I have tested this on RHEL6.0 GA kernel version 2.6.32-71.el6.s390x.

The memory model is 'Sparse Memory'

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
