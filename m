Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlWXC-00AX6E-HA
 for kexec@lists.infradead.org; Fri, 12 Nov 2021 13:24:03 +0000
Date: Fri, 12 Nov 2021 21:23:26 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
Message-ID: <20211112132326.GA16071@MiWiFi-R3L-srv>
References: <20211111191800.21281-1-david@redhat.com>
 <20211112070113.GA19016@MiWiFi-R3L-srv>
 <21bdcecd-127c-f70e-0c7d-cb1b97caecb0@redhat.com>
 <20211112090116.GC19016@MiWiFi-R3L-srv>
 <CADFyXm7uS3GN1AnF-iLpUZMFK=MwF3=NGwSZFqXPA+kK182-cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADFyXm7uS3GN1AnF-iLpUZMFK=MwF3=NGwSZFqXPA+kK182-cQ@mail.gmail.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 11/12/21 at 10:08am, David Hildenbrand wrote:
> > > "that allows supervisor mode programs to optionally set user-space
> > > memory mappings so that access to those mappings from supervisor mode
> > > will cause a trap. This makes it harder for malicious programs to
> > > "trick" the kernel into using instructions or data from a user-space
> > > program"
> >
> > OK, probably. I thought it's triggered in access_ok(), and tried to
> > figure out why. But seems we should do something to check this in
> > access_ok(), otherwise the logic of clear_user/_clear_user is not so
> > reasonable. Anyway, I have learned it, thanks a lot for digging it out.
> >
> > By the way, I can't open above wiki article, found below commit from
> > hpa. Maybe we can add some into log to tell this, not strong opinin,
> > leave it to you.
> 
> Yes, now that we know the root cause I'll add some more details to the
> patch description and resend -- thanks Baoquan!

Thanks for sending v2.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
