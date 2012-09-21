Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TFC3Y-0001Op-Ac
 for kexec@lists.infradead.org; Fri, 21 Sep 2012 22:50:45 +0000
Message-ID: <1348267839.23545.2.camel@concerto.americas.hpqcorp.net>
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
From: Khalid Aziz <khalid.aziz@hp.com>
Date: Fri, 21 Sep 2012 16:50:39 -0600
In-Reply-To: <87mx0lxhfq.fsf@xmission.com>
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com> <504815EB.9000701@redhat.com>
 <5048E40E.7040003@hp.com> <5049B6AD.9000304@redhat.com>
 <1347028634.20255.79.camel@lyra> <20120913133827.GB4396@redhat.com>
 <5053945F.9060107@hp.com> <87mx0lxhfq.fsf@xmission.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>, horms@verge.net.au, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Thu, 2012-09-20 at 00:49 -0700, Eric W. Biederman wrote:
> Last I checked we still had that useless set_virtual_memory map call in
> the kernel when efi is detected and until that goes away I don't know
> that we can or should depend on any efi bits in the kernel on the kdump
> path.
> 
> Honestly I don't think we should make any EFI calls later than we make
> BIOS calls, certainly the kdump case proves it works.
> 
> Eric

I would agree for the most part about not making any EFI calls from the
kernel but there are couple of cases where we may have to rethink that.
One is accessing the hardware clock. On a pure EFI and legacy-free
machine, we will need to access hardware through EFI runtime services.
The other one being access to EFI variables. We can choose to not use
EFI variables but we might be giving up some useful functionality.

-- 
Khalid Aziz <khalid.aziz@hp.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
