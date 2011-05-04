Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pw0-f49.google.com ([209.85.160.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QHgvN-0005sj-RH
	for kexec@lists.infradead.org; Wed, 04 May 2011 18:35:50 +0000
Received: by pwi8 with SMTP id 8so749403pwi.36
	for <kexec@lists.infradead.org>; Wed, 04 May 2011 11:35:46 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 4 May 2011 11:35:46 -0700
Message-ID: <BANLkTinOd+kmJKMdtW7saW0eWHN9xbO_3w@mail.gmail.com>
Subject: Kexec & Memory Zones question
From: Sujit V <sujit.linux@gmail.com>
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

On our x86_64 NUMA hardware running linux 2.6.23 with two memory nodes
 have the following zone layout
DMA   0 - 16MB
DMA32   16MB to 4GB
NORMAL 4GB to 96GB

We had the crashkernel boot param as 128M@16M.
I am using kexec-tools-2.0.0

We observed that the reserved crashkernel memory was getting used by
the system.
We found out by kdb  that around 17MB of physical memory the memory
contents were changing which proved that the system was
using the memory which is actually reserved for crash kernel.
[ If I load crash kernel using kexec then the system would crash. The
back trace was always in the megasas driver. ]

My Question is
1) Should the crashkernel memory be located past the DMA32 zone.?

I have tried the following
(1) crashkernel=128M@4GB  ( So the memory reservation is past DMA32)
In this scenario the kexec tools gave an error "Could not find a free
area of memory of xyz bytes"

(2) I changed the max of DMA32 to 1GB
     crashkernel=128M@1G
Still kexec gave the same error "Could not find a free area of memory
of xyz bytes"

Is there any specific restriction on where the crashkernel memory
could be located.?

Is it ok to be in the DMA32 region OR it should be beyond the DMA32 region.

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
