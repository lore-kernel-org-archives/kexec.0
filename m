Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c58TX-0002vA-2R
 for kexec@lists.infradead.org; Fri, 11 Nov 2016 09:50:24 +0000
Date: Fri, 11 Nov 2016 17:49:55 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 1/2] makedumpfile: Adapt code to get value of phys_base
Message-ID: <20161111094955.GB15325@x1>
References: <1478595319-9299-1-git-send-email-bhe@redhat.com>
 <1478595319-9299-2-git-send-email-bhe@redhat.com>
 <20161110063050.GE22737@x1>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7EACD@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E7EACD@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "panand@redhat.com" <panand@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On 11/11/16 at 08:12am, Atsushi Kumagai wrote:
> >Kernel code only exports virtual address of phys_base now and it's helpless
> >for Crash and Makedumpfile. Below patch which changes code to export value
> >of phys_base has been posted to upstream. So adapt code to get it.
> >
> >kexec: Change to export the value of phys_base instead of symbol address
> >marc.info/?l=linux-kernel&m=147856863629624&w=2
> >
> >Signed-off-by: Baoquan He <bhe@redhat.com>
> >---
> >v1->v2:
> >    Patch v1 is not compatible with the old kernel. Change code in
> >    get_phys_base_x86_64 and vtop4_x86_64 to avoid that according to
> >    Atsushi's suggestion.
> 
> Looks good to me, I'll merge this patch into v1.6.1.
> For 2/2, I'll revert 56649f7b6bfe7 with your patch's comment.

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
