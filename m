Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QKB2H-0000xi-KK
	for kexec@lists.infradead.org; Wed, 11 May 2011 15:09:14 +0000
Date: Wed, 11 May 2011 11:09:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kexec & Memory Zones question
Message-ID: <20110511150908.GG31633@redhat.com>
References: <BANLkTinOd+kmJKMdtW7saW0eWHN9xbO_3w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTinOd+kmJKMdtW7saW0eWHN9xbO_3w@mail.gmail.com>
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
To: Sujit V <sujit.linux@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, May 04, 2011 at 11:35:46AM -0700, Sujit V wrote:
> On our x86_64 NUMA hardware running linux 2.6.23 with two memory nodes
>  have the following zone layout
> DMA   0 - 16MB
> DMA32   16MB to 4GB
> NORMAL 4GB to 96GB
> 
> We had the crashkernel boot param as 128M@16M.
> I am using kexec-tools-2.0.0
> 
> We observed that the reserved crashkernel memory was getting used by
> the system.
> We found out by kdb  that around 17MB of physical memory the memory
> contents were changing which proved that the system was
> using the memory which is actually reserved for crash kernel.
> [ If I load crash kernel using kexec then the system would crash. The
> back trace was always in the megasas driver. ]

This is problematic. This memory has been reserved by kernel in early
boot and nobody else should be using this memory. This sounds like a
but somewhere.

> 
> My Question is
> 1) Should the crashkernel memory be located past the DMA32 zone.?
> 
> I have tried the following
> (1) crashkernel=128M@4GB  ( So the memory reservation is past DMA32)
> In this scenario the kexec tools gave an error "Could not find a free
> area of memory of xyz bytes"
> 
> (2) I changed the max of DMA32 to 1GB
>      crashkernel=128M@1G
> Still kexec gave the same error "Could not find a free area of memory
> of xyz bytes"

We have discussed this in the past and due to various reasons the max
amount of RAM you can boot your kernel from seems to be 896MB for
x86_64 and 512MB for 32bit. I shall have to open a previous thread
with hpa to get exact numbers. So loading kernel even higher is not
the solution.

We need to figure out who is using this memory and where is the bug
and fix it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
