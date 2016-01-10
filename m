Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aI4Si-0004iW-Po
 for kexec@lists.infradead.org; Sun, 10 Jan 2016 01:06:29 +0000
Date: Sun, 10 Jan 2016 09:08:51 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v3 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
Message-ID: <20160110010851.GA19773@dhcp-128-25.nay.redhat.com>
References: <1452220423-4733-1-git-send-email-xlpang@redhat.com>
 <1452220423-4733-2-git-send-email-xlpang@redhat.com>
 <20160108084741.GB6295@dhcp-128-25.nay.redhat.com>
 <568FB964.7030705@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <568FB964.7030705@redhat.com>
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
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/08/16 at 09:28pm, Xunlei Pang wrote:
> On 01/08/2016 at 04:47 PM, Minfei Huang wrote:
> > On 01/08/16 at 10:33am, Xunlei Pang wrote:
> >> +
> >> +static int
> >> +kexec_mark_range(unsigned long start, unsigned long end, bool protect)
> >> +{
> >> +	struct page *page;
> >> +	unsigned int nr_pages;
> >> +
> >> +	/* For physical range: [start, end] */
> >> +	if (!end || start > end)
> >> +		return 0;
> > This test !end is hard to be understood without the annotation. It is
> > better to add the comment about it.
> 
> !end is just for uninitialized crashk resource with a zero end member,
> maybe not so hard to understand :-)

Yes, The test !end may be simple, if someone knows the logic of kexec.
But it's hard to be understood, if there is only a glance from someone
without any annotation.

This test !end is related to the specific code flow, so it is better to
annotate it.

Thanks
Minfei

> 
> Regards,
> Xunlei
> 
> >
> > Otherwise it looks good for me.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
