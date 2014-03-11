Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNF7k-0008SR-9B
 for kexec@lists.infradead.org; Tue, 11 Mar 2014 05:21:09 +0000
Received: by mail-wi0-f170.google.com with SMTP id n15so328214wiw.1
 for <kexec@lists.infradead.org>; Mon, 10 Mar 2014 22:20:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140309070642.GA2525@needle>
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
 <20140305053617.GE26240@dhcp-17-89.nay.redhat.com>
 <20140306064756.GB16859@needle.mulix.org>
 <53181AC1.2020807@zytor.com>
 <20140306070047.GF16859@needle.mulix.org>
 <CAPoiz9yhAeoWDANus6=O_5AomKFEAzzR1pR4F0rN2HnDWwYAMg@mail.gmail.com>
 <20140309070642.GA2525@needle>
Date: Mon, 10 Mar 2014 22:20:45 -0700
Message-ID: <CAPoiz9xDUb1aoYMfj8jnQRTKo8GCH5PyfNjDd-04=AQXrQjBCA@mail.gmail.com>
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

On Sun, Mar 9, 2014 at 12:06 AM, Muli Ben-Yehuda <muli@cs.technion.ac.il> wrote:
> On Thu, Mar 06, 2014 at 07:46:44AM -0700, Jon Mason wrote:
>
>> > I don't know of anyone still using it, but it's not
>> > impossible. Calgary and CalIOC2 machines would now be ~5-8 years
>> > old.
>>
>> It is getting a bit crufty in arch/x86.  Would it be better to move
>> it to drivers/iommu?
>
> Not sure I see the potential benefit... I think for Calgary it's
> either leave it in arch/x86 or rip it out.

The intent is for it go where the other IOMMU drivers are, and gain
changes to the overall infrastructure as it evolves.  There has been a
decent amount of work going on in there  :)

Of course, someone would have to put the effort in and test it.

>
> Cheers,
> Muli

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
