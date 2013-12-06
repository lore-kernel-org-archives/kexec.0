Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VoylD-00038J-IR
 for kexec@lists.infradead.org; Fri, 06 Dec 2013 17:00:16 +0000
Received: from g9t2301.houston.hp.com (g9t2301.houston.hp.com [16.216.185.78])
 by g4t0017.houston.hp.com (Postfix) with ESMTP id 0D26538007
 for <kexec@lists.infradead.org>; Fri,  6 Dec 2013 16:59:46 +0000 (UTC)
Subject: Re: [PATCH v9] x86, apic, kexec, Documentation: Add
 disable_cpu_apic kernel parameter
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <20131205215824.GA29585@anatevka.fc.hp.com>
References: <529D34AA.1000809@jp.fujitsu.com>
 <20131203152536.GE4251@redhat.com>
 <20131205190949.GA23528@anatevka.fc.hp.com>
 <20131205215824.GA29585@anatevka.fc.hp.com>
Date: Fri, 06 Dec 2013 05:34:59 -0700
Message-ID: <1386333299.17054.29.camel@lisamlinux.fc.hp.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Hoemann, Jerry" <jerry.hoemann@hp.com>
Cc: kexec <kexec@lists.infradead.org>

On Thu, 2013-12-05 at 21:58 +0000, Hoemann, Jerry wrote:
> 
> Sorry if you're getting multiple copies, but i have had problems with
> my subscription to the kexec mailing list and am resending.
> 
> 
> 
> On Tue, Dec 03, 2013 at 10:25:36AM -0500, Vivek Goyal wrote:
> >
> > Hi Hatayama,
> >
> > We are almost there. A minor nit. Why have we specified KEXEC here. This
> > parameter disabled_cpu_apicid does not seem to dependon CONFIG_KEXEC?
> >
> > Jerry, this patch looks good to me. Does it work on your system?
> >
> > Thanks
> > Vivek
> 
> 
> Vivek,  Hatayama,
> 
> I've back ported v9 of this patch to 2.6.32 and 3.0.80 based kernels to
> test with existing distros.
> 
> I've tested on our smaller prototype server specifying nr_cpus=8/maxcpus=8
> to the capture kernel.  One hundred iterations (echo c > /proc/sysrq-trigger)
> varying target cpu and system load to each kernel.
> 
> The 2.6.32 based distro kernel showed the < 5% soft lockup
> (still unresolved) during boot of capture kernel.  This is
> something i've seen on all versions of the patch that i've tested.
> 
> The 3.0.80 based distro kernel has had zero failures.
> 
> I have not had a chance to test upstream kernels or on
> our larger prototype configuration.
> 
> We still plan to test on our larger prototype.  Testing of
> prior versions of the patch on the larger systems didn't show
> problems w/ this functionality and I don't anticipate we'll
> find anything this time either.
> 
> I am okay with this patch being accepted upstream and working
> the intermittent 2.6.32 failures separately.
> 
> 
> Jerry
> 

Another update, I have tested our max cpu configuration prototype, with
a fairly large IO config with the backported 3.0.80 kernel Jerry
mentions above with the v9 patch backported, and this system got 7 out
of 7 successful dumps, with max_cpus=8, so far in testing. This system
has a a fairly large IO configuration too, such that intermittently
booting the crashkernel with 1 cpu  the crashkernel boot would hang due
to IRQ for system disk not getting assigned.   So this is early
indication that this patch is working well on larger IO configurations.

I plan to test with the 2.6.32 base with v9 patch over the weekend on
this large configuration.   The system takes much longer to dump than
the minimum config, so it is harder to build up as many iterations over
a short time, plus I have to share the system with others.  

Thanks,

Lisa Mitchell



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
