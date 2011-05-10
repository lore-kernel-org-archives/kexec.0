Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJjSV-0000TU-5Z
	for kexec@lists.infradead.org; Tue, 10 May 2011 09:42:27 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QJjSS-0005wo-V8
	for kexec@lists.infradead.org; Tue, 10 May 2011 11:42:24 +0200
Received: from 60.247.97.98 ([60.247.97.98])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 11:42:24 +0200
Received: from xiyou.wangcong by 60.247.97.98 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 11:42:24 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: Kexec & Memory Zones question
Date: Tue, 10 May 2011 09:42:11 +0000 (UTC)
Message-ID: <iqb19j$e10$1@dough.gmane.org>
References: <BANLkTinOd+kmJKMdtW7saW0eWHN9xbO_3w@mail.gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Wed, 04 May 2011 11:35:46 -0700, Sujit V wrote:

> On our x86_64 NUMA hardware running linux 2.6.23 with two memory nodes
>  have the following zone layout
> DMA   0 - 16MB
> DMA32   16MB to 4GB
> NORMAL 4GB to 96GB
> 
> We had the crashkernel boot param as 128M@16M. I am using
> kexec-tools-2.0.0
> 
> We observed that the reserved crashkernel memory was getting used by the
> system.
> We found out by kdb  that around 17MB of physical memory the memory
> contents were changing which proved that the system was using the memory
> which is actually reserved for crash kernel. [ If I load crash kernel
> using kexec then the system would crash. The back trace was always in
> the megasas driver. ]
> 
> My Question is
> 1) Should the crashkernel memory be located past the DMA32 zone.?


Your DMA32 zone looks extremely large, probably due to you enabled NUMA? 
What does dmesg say if possible? Also, what is your kernel version?

> 
> I have tried the following
> (1) crashkernel=128M@4GB  ( So the memory reservation is past DMA32) In
> this scenario the kexec tools gave an error "Could not find a free area
> of memory of xyz bytes"
> 
> (2) I changed the max of DMA32 to 1GB
>      crashkernel=128M@1G
> Still kexec gave the same error "Could not find a free area of memory of
> xyz bytes"
> 
> Is there any specific restriction on where the crashkernel memory could
> be located.?

No, have you tried "crashkernel=128M@0"? Can that reserve the memory
successfully?

> 
> Is it ok to be in the DMA32 region OR it should be beyond the DMA32
> region.
> 


The reserve memory is unseen by the first kernel nor it should be used,
even if it is in DMA32 zone.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
