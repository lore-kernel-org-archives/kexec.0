Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L9pYj-0001bg-2C
	for kexec@lists.infradead.org; Mon, 08 Dec 2008 23:30:37 +0000
Subject: Re: kdump: quad core Opteron
From: Bob Montgomery <bob.montgomery@hp.com>
In-Reply-To: <200812082126.16680.chandru@in.ibm.com>
References: <48EB5B68.8010401@in.ibm.com> <20081007132401.GA4007@redhat.com>
	<1223395191.2215.179.camel@amd.troyhebe>
	<200812082126.16680.chandru@in.ibm.com>
Date: Mon, 08 Dec 2008 16:35:16 -0700
Message-Id: <1228779316.3428.367.camel@amd.troyhebe>
Mime-Version: 1.0
Reply-To: bob.montgomery@hp.com
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
To: Chandru <chandru@in.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 2008-12-08 at 15:56 +0000, Chandru wrote:

> Hi Bob,
> 
> This problem was recently reported on a LS42 blade and the patch given by you
> also resolved the issue here too.  However I made couple of changes to
> kexec-tools to ignore GART memory region and not have elf headers created to
> it.  This patch also seemed to work on a LS21.
> 
> Thanks,
> Chandru

Hi Chandru,

I tried your patch on kexec-tools, and I'm seeing a zero-length section
in /proc/vmcore (using readelf -e /proc/vmcore) right after the GART
hole:

/proc/iomem in the main kernel shows:
  01000000-08ffffff : Crash kernel 
  20000000-23ffffff : GART
cfe4e000-cfe55fff : ACPI Tables

And readelf -e /proc/vmcore in the kdump kernel shows:

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
...
  LOAD           0x000000000144d99c 0xffff810009000000 0x0000000009000000
                 0x0000000017000000 0x0000000017000000  RWE    0
  LOAD           0x000000001844d99c 0xffff810024000000 0x0000000024000000
                 0x00000000abe4e000 0x00000000abe4e000  RWE    0
  LOAD           0x00000000c429b99c 0xffff810024000000 0x0000000024000000
                 0x0000000000000000 0x0000000000000000  RWE    0
...

The first LOAD shown covers 09000000-20000000, the System RAM between
the Crash kernel and the GART.  
The next LOAD covers 24000000-cfe4e000, which is the System RAM between
the GART and the ACPI Tables.  So that all looks good.

Then the next LOAD is also at 24000000 with a 0 in the size fields.
I haven't had a chance to check the code yet.

Bob Montgomery



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
