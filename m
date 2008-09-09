Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kd5rz-0003f2-2r
	for kexec@lists.infradead.org; Tue, 09 Sep 2008 16:15:11 +0000
Date: Tue, 9 Sep 2008 18:22:56 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: IA64: copying /proc/vmcore caused kernel MCA'ed
Message-ID: <20080909182256.5229dee0@kepler.site>
In-Reply-To: <48C69E4C.2020805@sgi.com>
References: <48C56F55.5000503@sgi.com> <20080909101900.76f843ec@kepler.site>
	<48C69E4C.2020805@sgi.com>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: jlan@sgi.com

* Jay Lan <jlan@sgi.com> [2008-09-09]: 
> 
> I talked to Jack Steiner about this problem. He said:
>   The memory at 0xe000006000100000 is part of Altix "fetchop" space
>   (AKA mspec). The memory supports only uncached attributes. A normal
>   "cached" access may cause MCAs.
> 
>   The kernel should not be using this memory for anything. Only the
>   fetchop driver is suppose to access this area.
> 
>   Note: /proc/iomem shows the memory as "System RAM" but that does NOT
>   mean that is can be accessed w/o special code. See efi.c for the
> code that prints the iomem info. Maybe efi.c needs to be changed to
> show a different name for the fetchop memory so that kdump will work.

If it's necessary to register that as "System RAM", then one could
register some special resource as child (like "Kernel text" is done)
and exclude that in kexec (like the reserved area is already excluded
when building the ELF core headers). I think that would be actually the
way to go here without breaking backward compatibility. Of course, you
need to update kexec-tools.


Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
