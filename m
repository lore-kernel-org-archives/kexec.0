Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIhPQ-0006ld-Qi
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 15:28:05 +0000
Date: Thu, 21 Mar 2013 11:27:51 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
Message-ID: <20130321152751.GK3934@redhat.com>
References: <8738vp75cy.fsf@xmission.com>
 <20130321.151428.393714972.d.hatayama@jp.fujitsu.com>
 <87ip4l1d1q.fsf@xmission.com>
 <20130321.154650.424925595.d.hatayama@jp.fujitsu.com>
 <87a9pxz0wv.fsf@xmission.com> <20130321152124.GJ3934@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130321152124.GJ3934@redhat.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

On Thu, Mar 21, 2013 at 11:21:24AM -0400, Vivek Goyal wrote:

[..]
> So if starting or end address of PT_LOAD header is not aligned, why
> not we simply allocate a page. Copy the relevant data from old memory,
> fill rest with zero. That way mmap and read view will be same. There
> will be no surprises w.r.t reading old kernel memory beyond what's 
> specified by the headers.

Copying from old memory might spring surprises w.r.t hw poisoned
pages. I guess we will have to disable MCE, read page, enable it
back or something like that to take care of these issues.

In the past we have recommended makedumpfile to be careful, look
at struct pages and make sure we are not reading poisoned pages.
But vmcore itself is reading old memory and can run into this
issue too.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
