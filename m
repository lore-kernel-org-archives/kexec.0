Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZecNW-00053R-Ml
 for kexec@lists.infradead.org; Wed, 23 Sep 2015 05:14:03 +0000
Date: Wed, 23 Sep 2015 13:14:19 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] kexec: Add prefix "kexec" to output message
Message-ID: <20150923051419.GA21804@dhcp-128-25.nay.redhat.com>
References: <1442128512-32578-1-git-send-email-mnfhuang@gmail.com>
 <87fv2il0rq.fsf@x220.int.ebiederm.org>
 <20150914075056.GA13324@t440s.lenovo>
 <20150914084400.GA7953@localhost.localdomain>
 <20150915030804.GA7690@t440s.lenovo>
 <20150922160704.GA10225@dhcp-128-25.nay.redhat.com>
 <20150923013723.GA4394@dhcp-129-160.nay.redhat.com>
 <20150923024933.GB3166@dhcp-17-102.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150923024933.GB3166@dhcp-17-102.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Minfei Huang <mnfhuang@gmail.com>

On 09/23/15 at 10:49am, Baoquan He wrote:
> On 09/23/15 at 09:37am, Dave Young wrote:
> > > > Hi, Dave.
> > > > 
> > > > How about removing all of the prefix "crashkernel" in kexec_core. Thus
> > > > we can be consistent with the output message prefix "kexec".
> > > 
> > > Ping, any comment is appreciate and helpful.
> > 
> > Remove "crashkernel" sounds not a proper way, it indicates crashkernel parsing
> > messages. I have no idea what is the best way but below modification sounds better to me:
> > 
> > kexec_core.c:
> > 
> > #define pr_fmt(fmt)        "[kexec_core] " fmt
> > Also remove below prefix "Kexec:"
> > pr_warn("Kexec: Memory allocation for saving cpu register states failed\n"); 
> > 
> > kexec.c:
> > #define pr_fmt(fmt)        "[kexec] " fmt
> > 
> > kexec_file.c:
> > #define pr_fmt(fmt)        "[kexec_file] " fmt
> 
> This is weird, user really don't need to know each file. I saw you added
> a new file kexec_internal.h and all three files includes it. Why not doing
> it there to make it the same as before?

The output message format is incorrect, if other *.c (except for kexec*)
include the kexec_internal.h.

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

How about defining the format like above in each *.c?

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
