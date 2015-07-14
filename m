Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZF4fE-0000Ml-QB
 for kexec@lists.infradead.org; Tue, 14 Jul 2015 18:10:45 +0000
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 14 Jul 2015 19:10:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id DBC972190056
 for <kexec@lists.infradead.org>; Tue, 14 Jul 2015 19:09:55 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6EIAICK38207552
 for <kexec@lists.infradead.org>; Tue, 14 Jul 2015 18:10:18 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6F19nim023220
 for <kexec@lists.infradead.org>; Tue, 14 Jul 2015 19:09:50 -0600
Date: Tue, 14 Jul 2015 20:10:16 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] kexec: Make a pair of map and unmap reserved pages
 when kdump fails to start
Message-ID: <20150714201016.161e4f39@holzheu>
In-Reply-To: <20150714140920.GA10792@redhat.com>
References: <1436505137-4364-1-git-send-email-mnfhuang@gmail.com>
 <20150710105413.04e1db00@holzheu>
 <20150710090322.GA5138@dhcp-128-21.nay.redhat.com>
 <20150710111406.279dba14@holzheu>
 <20150714140920.GA10792@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>, schwidefsky@de.ibm.com, linux390@de.ibm.com, ebiederm@xmission.com

On Tue, 14 Jul 2015 10:09:20 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Jul 10, 2015 at 11:14:06AM +0200, Michael Holzheu wrote:
> 
> [..]
> > What about the following patch:
> > ---
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index 7a36fdc..7837c4e 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -1236,10 +1236,68 @@ int kexec_load_disabled;
> >  
> >  static DEFINE_MUTEX(kexec_mutex);
> >  
> > +static int __kexec_load(unsigned long entry, unsigned long nr_segments,
> 

[snip]

> > +
> > +failure_unmap_mem:
> 
> I don't like this tag "failure_unmap_mem". We are calling this both
> in success path as well as failure path. So why not simply call it "out".

Since the code is better readable now, I'm fine with "out" :-)

> 
> > +	if (flags & KEXEC_ON_CRASH)
> > +		crash_unmap_reserved_pages();
> > +	kimage_free(image);
> 
> Now kimage_free() is called with kexec_mutex held. Previously that was
> not the case. I hope that's not a problem.

Yes, I noticed that. But also in the original code there is already
one spot where kimage_free() is called under lock:

        /*
         * In case of crash, new kernel gets loaded in reserved region. It is
         * same memory where old crash kernel might be loaded. Free any
         * current crash dump kernel before we corrupt it.
         */
        if (flags & KEXEC_FILE_ON_CRASH)
                kimage_free(xchg(&kexec_crash_image, NULL));

Therefore I thought it should be ok.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
