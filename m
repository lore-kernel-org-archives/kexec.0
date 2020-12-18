Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps.thesusis.net ([34.202.238.73])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kqN5h-0005JF-30
 for kexec@lists.infradead.org; Fri, 18 Dec 2020 21:15:09 +0000
References: <87h7oudcbx.fsf@vps.thesusis.net>
 <CAHD1Q_zcruQ6KVHApvhb=0+mG0m80T+tmg1UzjQBki8j+aR51A@mail.gmail.com>
 <87czzcdtir.fsf@vps.thesusis.net>
 <CAHD1Q_z+WW36rfr1RAFYKjU5bocA90OonBmSKECRnpacvWyPmQ@mail.gmail.com>
 <873604p1i6.fsf@vps.thesusis.net>
From: Phillip Susi <phill@thesusis.net>
Subject: Re: kexec not working in xen domU?
Date: Fri, 18 Dec 2020 15:59:02 -0500
In-reply-to: <873604p1i6.fsf@vps.thesusis.net>
Message-ID: <877dpevmsl.fsf@vps.thesusis.net>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Cc: xen-devel@lists.xenproject.org, kexec mailing list <kexec@lists.infradead.org>


Phillip Susi writes:

> I tried with -s and it didn't help.  So far I tried it originally on my
> Ubuntu 20.04 amazon vps, then on my debian testing ( linux 5.9.0 ) on my
> local xen server.  I'll try building the latest upstream kernel and
> kexec tomorrow.

Built the latest kexec-tools and linux kernel from git today and get
the same results.  Is there a minimum version of xen required for this
to work?  I have no idea what Amazon is running but my server has 4.9.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
