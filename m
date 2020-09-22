Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKlj3-0008DH-ME
 for kexec@lists.infradead.org; Tue, 22 Sep 2020 17:05:10 +0000
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kKlj1-0001L0-5s
 for kexec@lists.infradead.org; Tue, 22 Sep 2020 17:05:07 +0000
Received: by mail-ej1-f69.google.com with SMTP id hh10so6507202ejb.13
 for <kexec@lists.infradead.org>; Tue, 22 Sep 2020 10:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com> <20200922125809.66690d54@ibm>
 <7ee09899-6724-e932-f73d-d49da0fb4a9d@oracle.com>
In-Reply-To: <7ee09899-6724-e932-f73d-d49da0fb4a9d@oracle.com>
From: "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Date: Tue, 22 Sep 2020 14:04:30 -0300
Message-ID: <CAHD1Q_x8TQA7xMxbm0LaP-nBd0d++Ox7dQ9+2PsDfe3S+=nKHw@mail.gmail.com>
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
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
To: boris.ostrovsky@oracle.com
Cc: Baoquan He <bhe@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>, Dave Young <dyoung@redhat.com>

On Tue, Sep 22, 2020 at 11:53 AM <boris.ostrovsky@oracle.com> wrote:
>
>
> On 9/22/20 6:58 AM, Philipp Rudo wrote:
> >
> > AFAIK pstore requires UEFI to work. So what's the point to enable it on non-UEFI
> > systems?
>
>
> I don't think UEFI is required, ERST can specify its own backend. And that, in fact, can be quite useful in virtualization scenarios (especially in cases of direct boot, when there is no OVMF)
>
>
> -boris

There is ramoops backend too - I was able to collect a dmesg in a
cloud provider using that!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
