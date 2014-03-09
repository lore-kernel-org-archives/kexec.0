Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WMXwQ-0005K9-9j
 for kexec@lists.infradead.org; Sun, 09 Mar 2014 07:14:34 +0000
Received: by mail-ea0-f177.google.com with SMTP id h10so3088050eak.8
 for <kexec@lists.infradead.org>; Sat, 08 Mar 2014 23:14:12 -0800 (PST)
Date: Sun, 9 Mar 2014 09:06:42 +0200
From: Muli Ben-Yehuda <muli@cs.technion.ac.il>
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
Message-ID: <20140309070642.GA2525@needle>
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
 <20140305053617.GE26240@dhcp-17-89.nay.redhat.com>
 <20140306064756.GB16859@needle.mulix.org>
 <53181AC1.2020807@zytor.com>
 <20140306070047.GF16859@needle.mulix.org>
 <CAPoiz9yhAeoWDANus6=O_5AomKFEAzzR1pR4F0rN2HnDWwYAMg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPoiz9yhAeoWDANus6=O_5AomKFEAzzR1pR4F0rN2HnDWwYAMg@mail.gmail.com>
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
To: Jon Mason <jdmason@kudzu.us>
Cc: discuss@x86-64.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, WANG Chao <chaowang@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Mar 06, 2014 at 07:46:44AM -0700, Jon Mason wrote:

> > I don't know of anyone still using it, but it's not
> > impossible. Calgary and CalIOC2 machines would now be ~5-8 years
> > old.
> 
> It is getting a bit crufty in arch/x86.  Would it be better to move
> it to drivers/iommu?

Not sure I see the potential benefit... I think for Calgary it's
either leave it in arch/x86 or rip it out.

Cheers,
Muli

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
