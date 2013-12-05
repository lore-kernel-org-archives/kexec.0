Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vogwh-0006es-Hm
 for kexec@lists.infradead.org; Thu, 05 Dec 2013 21:58:56 +0000
Received: from g9t2301.houston.hp.com (g9t2301.houston.hp.com [16.216.185.78])
 by g4t0017.houston.hp.com (Postfix) with ESMTP id 51E083800C
 for <kexec@lists.infradead.org>; Thu,  5 Dec 2013 21:58:25 +0000 (UTC)
Received: from anatevka.fc.hp.com (anatevka.fc.hp.com [16.71.12.60])
 by g9t2301.houston.hp.com (Postfix) with ESMTP id 47CFB64
 for <kexec@lists.infradead.org>; Thu,  5 Dec 2013 21:58:25 +0000 (UTC)
Received: from anatevka.fc.hp.com (localhost [127.0.0.1])
 by anatevka.fc.hp.com (Postfix) with ESMTP id E497748115C
 for <kexec@lists.infradead.org>; Thu,  5 Dec 2013 14:58:24 -0700 (MST)
Received: (from hoemann@localhost)
 by anatevka.fc.hp.com (8.14.7/8.14.7/Submit) id rB5LwOJb029736
 for kexec@lists.infradead.org; Thu, 5 Dec 2013 14:58:24 -0700
Date: Thu, 5 Dec 2013 14:58:24 -0700
From: jerry.hoemann@hp.com
Subject: Re: [PATCH v9] x86, apic, kexec, Documentation: Add disable_cpu_apic
 kernel parameter
Message-ID: <20131205215824.GA29585@anatevka.fc.hp.com>
References: <529D34AA.1000809@jp.fujitsu.com>
 <20131203152536.GE4251@redhat.com>
 <20131205190949.GA23528@anatevka.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131205190949.GA23528@anatevka.fc.hp.com>
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
To: kexec <kexec@lists.infradead.org>



Sorry if you're getting multiple copies, but i have had problems with
my subscription to the kexec mailing list and am resending.



On Tue, Dec 03, 2013 at 10:25:36AM -0500, Vivek Goyal wrote:
>
> Hi Hatayama,
>
> We are almost there. A minor nit. Why have we specified KEXEC here. This
> parameter disabled_cpu_apicid does not seem to dependon CONFIG_KEXEC?
>
> Jerry, this patch looks good to me. Does it work on your system?
>
> Thanks
> Vivek


Vivek,  Hatayama,

I've back ported v9 of this patch to 2.6.32 and 3.0.80 based kernels to
test with existing distros.

I've tested on our smaller prototype server specifying nr_cpus=8/maxcpus=8
to the capture kernel.  One hundred iterations (echo c > /proc/sysrq-trigger)
varying target cpu and system load to each kernel.

The 2.6.32 based distro kernel showed the < 5% soft lockup
(still unresolved) during boot of capture kernel.  This is
something i've seen on all versions of the patch that i've tested.

The 3.0.80 based distro kernel has had zero failures.

I have not had a chance to test upstream kernels or on
our larger prototype configuration.

We still plan to test on our larger prototype.  Testing of
prior versions of the patch on the larger systems didn't show
problems w/ this functionality and I don't anticipate we'll
find anything this time either.

I am okay with this patch being accepted upstream and working
the intermittent 2.6.32 failures separately.


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
