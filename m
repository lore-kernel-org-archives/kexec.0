Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5sHu-00028h-O1
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 01:36:55 +0000
Message-ID: <492E7E90.3080407@mxs.nes.nec.co.jp>
Date: Thu, 27 Nov 2008 20:03:44 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile-1.3.1: Support linux-2.6.27 and linux-2.6.28.
References: <492DF215.8050105@mxs.nes.nec.co.jp>
	<20081127102319.5f7f90a5@hale.suse.de>
In-Reply-To: <20081127102319.5f7f90a5@hale.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1402790117=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============1402790117==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-11-27 10:04]:
>> Changelog:
>>  o New feature
>>    - Support linux-2.6.26 sparsemem on i386.
> 
> BTW: Which option must be enabled for the kernel that this is
> 'sparsemem', i.e. that this support is needed?
> 
>   CONFIG_ARCH_SPARSEMEM_ENABLE=y
>   CONFIG_SPARSEMEM_MANUAL
>   CONFIG_SPARSEMEM_STATIC=y
>   CONFIG_SPARSEMEM_VMEMMAP_ENABLE

My kernel .config contains the following items, and I had tested
on the kernel.

CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set


Thanks
Ken'ichi Ohmichi


--===============1402790117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1402790117==--
