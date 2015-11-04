Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZtyWS-0007kP-5f
 for kexec@lists.infradead.org; Wed, 04 Nov 2015 13:54:46 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tA4DsMkR052307
 for <kexec@lists.infradead.org>; Wed, 4 Nov 2015 08:54:22 -0500
Date: Wed, 4 Nov 2015 08:54:22 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2105561780.4751780.1446645262529.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.1817.1446622935.1639.kexec@lists.infradead.org>
References: <mailman.1817.1446622935.1639.kexec@lists.infradead.org>
Subject: Re: [PATCH V7] makedumpfile: exclude page structures of non-dumped
 pages
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
To: kexec@lists.infradead.org



----- Original Message -----

> >On Wed, Oct 28, 2015 at 04:38:24AM +0000, Atsushi Kumagai wrote:
> >> Hello Cliff,
> >>
> >> >From: Cliff Wickman <cpw@sgi.com>
> >> >
> >> >Applies to the development branch as of 10/13/2015.
> >> >Incorporates review 10/22 by kumagai-atsushi.
> >> >Incorporates review 10/26 by kumagai-atsushi. (arch x86_64-only
> >> >implementation)
> >>
> >> Thanks for your great work.
> >> I don't want to delay v1.5.9 release anymore, I'll merge this patch
> >> into v1.6.0.
> >
> >Great!
> >Thanks for your long and patient help in defining the extent of this patch
> >and sanding off its rough edges.
> 
> BTW, I think you might be doing this, you should post a crash's patch to
> support DUMP_DH_EXCLUDED_VMEMMAP as Dave said, until this feature is
> released formally in v1.6.0.
> 
>   http://lists.infradead.org/pipermail/kexec/2015-October/014600.html
> 
> Thanks,
> Atsushi Kumagai

Hi Atsushi,

Since I didn't get a response to either of my posts re: the above, when
I saw the patch go into your devel branch, I went ahead and added a patch
for crash-7.1.4:

  https://github.com/crash-utility/crash/commit/7ce8469f8bf7e32017f8270ecd22469040817ba2

Thanks,
  Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
