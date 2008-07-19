Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ik-out-1112.google.com ([66.249.90.181])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KK9Vv-0006Pp-0y
	for kexec@lists.infradead.org; Sat, 19 Jul 2008 10:18:07 +0000
Received: by ik-out-1112.google.com with SMTP id c21so377284ika.2
	for <kexec@lists.infradead.org>; Sat, 19 Jul 2008 03:18:03 -0700 (PDT)
Date: Sat, 19 Jul 2008 11:16:35 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [Patch] kexec: remove redundant if-else
Message-ID: <20080719101635.GB3558@hack.netcabo.pt>
References: <20080718150410.GB26261@hack.voiplan.pt>
	<m1sku7j6qp.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1sku7j6qp.fsf@frodo.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Jul 18, 2008 at 01:07:58PM -0700, Eric W. Biederman wrote:
>WANG Cong <xiyou.wangcong@gmail.com> writes:
>
>> These if-else's can be removed.
>
>Why?  That appears to be pointless code style thrashing.


I don't think that is coding style fix. Because when we arrive the
'out' branch, 'result' is always properly set, thus checking it again
is useless for me. :-)

Thanks.

-- 
Hi, I'm a .signature virus, please copy/paste me to help me spread
all over the world.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
