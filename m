Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VrZzE-0000cN-M2
 for kexec@lists.infradead.org; Fri, 13 Dec 2013 21:09:29 +0000
Date: Fri, 13 Dec 2013 14:08:54 -0700
From: jerry.hoemann@hp.com
Subject: Re: [PATCH v10] x86, apic, kexec, Documentation: Add
 disable_cpu_apic kernel parameter
Message-ID: <20131213210854.GA31895@anatevka.fc.hp.com>
References: <529EE392.6060400@jp.fujitsu.com>
 <20131210144910.GC13909@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131210144910.GC13909@redhat.com>
Reply-To: jerry.hoemann@hp.com
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: hpa@linux.intel.com
Cc: Fengguang Wu <fengguang.wu@intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Jingbai Ma <jingbai.ma@hp.com>

On Tue, Dec 10, 2013 at 09:49:10AM -0500, Vivek Goyal wrote:
> On Wed, Dec 04, 2013 at 05:10:58PM +0900, HATAYAMA Daisuke wrote:
> > This patch set is to allow kdump 2nd kernel to wake up multiple CPUs,
> > a continueing work from:
> > 
> >   [PATCH v3 0/2] x86, apic, kdump: Disable BSP if boot cpu is AP
> >   https://lkml.org/lkml/2013/10/16/300.
> > 
> > At v4, basic design has changed. Now users need to figure out initial
> > APIC ID of BSP in the 1st kernel and configures kernel parameter for
> > the 2nd kernel manually using disable_cpu_apicid kernel parameter,
> > which is newly introduced by this patch set. This design is more
> > flexible than the previous version in that we no longer have to rely
> > on ACPI/MP table to get initial APIC ID of BSP.
> > 
> > Sorry, this patch set have not include in-source documentation
> > requested by Borislav Petkov yet, but I'll post it later separately,
> > which would be better to focus on documentation reviewing.
> 
> Hi hpa,
> 
> Can you please consider this patch for inclusion.
> 
> Thanks
> Vivek


  hpa,

  Yes,  please consider including this patch as it addresses
  some scaling issues we are having with kdump on our new
  systems.

  Thanks

  Jerry


-- 

----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer              Hewlett-Packard

3404 E Harmony Rd. MS 57                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-XXXX
                                                email:  jerry.hoemann@hp.com
----------------------------------------------------------------------------


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
