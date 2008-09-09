Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kd5hM-0007C7-Bi
	for kexec@lists.infradead.org; Tue, 09 Sep 2008 16:04:16 +0000
Message-ID: <48C69E4C.2020805@sgi.com>
Date: Tue, 09 Sep 2008 09:03:24 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: IA64: copying /proc/vmcore caused kernel MCA'ed
References: <48C56F55.5000503@sgi.com> <20080909101900.76f843ec@kepler.site>
In-Reply-To: <20080909101900.76f843ec@kepler.site>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

Bernhard Walle wrote:
> * Jay Lan <jlan@sgi.com> [2008-09-08]: 
> 
>> Any input helping me speed up debugging is appreciated.
> 
> I would start with comparing the ELF program headers of /proc/vmcore
> which you get with "readelf -l /proc/vmcore" in kdump environment and
> the /proc/iomem which kexec uses to set up the ELF core headers.
> 
> If both does contain the memory regions which should not be accessed,
> then it's a bug in the ressource assignment of the kernel, and
> if /proc/iomem does not, the kexec tool has a bug.

Hi Bernhard,

I talked to Jack Steiner about this problem. He said:
  The memory at 0xe000006000100000 is part of Altix "fetchop" space
  (AKA mspec). The memory supports only uncached attributes. A normal
  "cached" access may cause MCAs.

  The kernel should not be using this memory for anything. Only the
  fetchop driver is suppose to access this area.

  Note: /proc/iomem shows the memory as "System RAM" but that does NOT
  mean that is can be accessed w/o special code. See efi.c for the code
  that prints the iomem info. Maybe efi.c needs to be changed to show
  a different name for the fetchop memory so that kdump will work.

I still need to understand why it did not cause a problem before.

Thanks,
jay

> 
> 
> Bernhard
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
