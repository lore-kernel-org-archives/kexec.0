Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aH6km-0001jd-0c
 for kexec@lists.infradead.org; Thu, 07 Jan 2016 09:21:09 +0000
Date: Thu, 7 Jan 2016 10:20:41 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
Message-ID: <20160107102041.1d99f70f@hananiah.suse.cz>
In-Reply-To: <568DF2C5.9080701@redhat.com>
References: <1452073845-1474-1-git-send-email-xlpang@redhat.com>
 <1452073845-1474-2-git-send-email-xlpang@redhat.com>
 <20160106170832.GB25832@dhcp-128-25.nay.redhat.com>
 <568DC9F0.8090609@redhat.com>
 <20160107023637.GA12526@dhcp-128-25.nay.redhat.com>
 <568DF2C5.9080701@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Minfei Huang <mhuang@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, 7 Jan 2016 13:08:21 +0800
Xunlei Pang <xlpang@redhat.com> wrote:

> On 01/07/2016 at 10:36 AM, Minfei Huang wrote:
> > On 01/07/16 at 10:14am, Xunlei Pang wrote:
> >>>> +static int
> >>>> +kexec_mark_range(unsigned long start, unsigned long end, bool protect)
> >>>> +{
> >>>> +	struct page *page;
> >>>> +	unsigned int nr_pages;
> >>>> +
> >>>> +	/* For physical range: [start, end] */
> >>>> +	if (!start || !end || start > end)
> >>>> +		return 0;
> >>> Hi, Xunlei.
> >>>
> >>>         if (start > end)
> >>>                 return 0;
> >> If both start and end are zero, we want to return directly, so the two
> >> more check doesn't hurt.
> > How about if the start is equal to 0, and end is larger than 0? It is
> > better to make code more robust, although it never happen in currect
> > kexec code.
> 
> Hmm, this will be better:
> 
> 	if (!end || start > end)
> 		return 0;
> 
> it handles the common case not using crash_low_res(start and end are 0).

Hm, if both start and end are 0, then what about using this condition:

 	if (start >= end)
 		return 0;

I think it's good enough, because if start is equal to end, then
there's nothing to protect anyway.

Regards,
Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
