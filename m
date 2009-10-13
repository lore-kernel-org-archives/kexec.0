Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MxXDk-0007e1-V4
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 02:34:46 +0000
Message-ID: <4AD3D19F.7000508@mxs.nes.nec.co.jp>
Date: Tue, 13 Oct 2009 10:02:23 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile-1.3.4: Support kdump-compressed format for input
	file.
References: <4ACEA2A3.5090706@mxs.nes.nec.co.jp>
	<20091010.165135.12569232.caiqian@redhat.com>
In-Reply-To: <20091010.165135.12569232.caiqian@redhat.com>
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
To: CAI Qian <caiqian@redhat.com>
Cc: usui@mxm.nes.nec.co.jp, tindoh@redhat.com, kexec@lists.infradead.org, anderson@redhat.com


Hi CAI,

Thank you for testing and a good point.

CAI Qian wrote:
>> makedumpfile version 1.3.4 is released.
>> Your comments/patches are welcome.
>>
>> Changelog:
>>  o New feature
>>    - Support kdump-compressed format for input file. (by Takao Indoh)
>>       A new makedumpfile can read dumpfile which is kdump-compressed format
>>       instead of /proc/vmcore and re-filter it.
> 
> Does it need to specify either a vmlinux or vmcoreinfo file?

Yes, we need to do it for re-filtering now.
But it is not difficult to implement a feature that it is not
necessary to specify either a vmlinux or vmcoreinfo file for
re-filtering. I will try to implement the feature.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
