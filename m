Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-we0-f169.google.com ([74.125.82.169])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLZZo-0001tF-Cs
 for kexec@lists.infradead.org; Thu, 06 Mar 2014 14:47:14 +0000
Received: by mail-we0-f169.google.com with SMTP id w62so3248269wes.28
 for <kexec@lists.infradead.org>; Thu, 06 Mar 2014 06:46:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140306070047.GF16859@needle.mulix.org>
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
 <20140305053617.GE26240@dhcp-17-89.nay.redhat.com>
 <20140306064756.GB16859@needle.mulix.org>
 <53181AC1.2020807@zytor.com>
 <20140306070047.GF16859@needle.mulix.org>
Date: Thu, 6 Mar 2014 07:46:44 -0700
Message-ID: <CAPoiz9yhAeoWDANus6=O_5AomKFEAzzR1pR4F0rN2HnDWwYAMg@mail.gmail.com>
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
From: Jon Mason <jdmason@kudzu.us>
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
To: Muli Ben-Yehuda <muli@cs.technion.ac.il>
Cc: discuss@x86-64.org, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, WANG Chao <chaowang@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Mar 6, 2014 at 12:00 AM, Muli Ben-Yehuda <muli@cs.technion.ac.il> wrote:
> On Wed, Mar 05, 2014 at 10:50:41PM -0800, H. Peter Anvin wrote:
>
>> OK, second question... is it time to axe Calgary?
>
> I don't know of anyone still using it, but it's not
> impossible. Calgary and CalIOC2 machines would now be ~5-8 years old.

It is getting a bit crufty in arch/x86.  Would it be better to move it
to drivers/iommu?

>
> Cheers,
> Muli

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
