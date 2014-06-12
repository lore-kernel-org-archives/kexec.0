Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-x22c.google.com ([2607:f8b0:400c:c03::22c])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuygP-0007X7-KL
 for kexec@lists.infradead.org; Thu, 12 Jun 2014 06:40:22 +0000
Received: by mail-vc0-f172.google.com with SMTP id hy10so357052vcb.17
 for <kexec@lists.infradead.org>; Wed, 11 Jun 2014 23:39:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53922FB8.6070408@linux.vnet.ibm.com>
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
 <1401833365.3247.36.camel@pasglop> <5391B413.100@linux.vnet.ibm.com>
 <53922FB8.6070408@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 12 Jun 2014 16:39:39 +1000
Message-ID: <CACPK8Xea+7rPHSCp51fVkX=GTmEwbV0T=JHDZ-XYt6RU96uyyg@mail.gmail.com>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
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
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, matt@ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com, ebiederm@xmission.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

Hi Srivatsa,

On Sat, Jun 7, 2014 at 7:16 AM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> And with the following hunk added (which I had forgotten earlier), it worked just
> fine on powernv :-)

How are the patches coming along?

I just hung a machine here while attempting to kexec. It appears to
have onlined all of the secondary threads, and then hung here:

kexec: Waking offline cpu 1.
kvm: enabling virtualization on CPU1
kexec: Waking offline cpu 2.
kvm: enabling virtualization on CPU2
kexec: Waking offline cpu 3.
kvm: enabling virtualization on CPU3
kexec: Waking offline cpu 5.
kvm: enabling virtualization on CPU5
[...]
kvm: enabling virtualization on CPU63
kexec: waiting for cpu 1 (physical 1) to enter OPAL
kexec: waiting for cpu 2 (physical 2) to enter OPAL
kexec: waiting for cpu 3 (physical 3) to enter OPAL

I'm running benh's next branch as of thismorning, and SMT was off.

Could you please post your latest patches a series? I will test them here.

Cheers,

Joel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
