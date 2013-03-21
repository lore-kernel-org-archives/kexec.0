Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIftH-0007ry-Bo
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 13:50:48 +0000
Date: Thu, 21 Mar 2013 09:50:28 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
Message-ID: <20130321135027.GB3934@redhat.com>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040228.15064.28019.stgit@localhost6.localdomain6>
 <877gl3koay.fsf@xmission.com> <20130320135716.GE17274@redhat.com>
 <87txo5bxk4.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87txo5bxk4.fsf@xmission.com>
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

On Wed, Mar 20, 2013 at 01:55:55PM -0700, Eric W. Biederman wrote:

[..]
> If core counts on the high end do more than double every 2 years we
> might have a problem.  Otherwise making everything mmapable seems easy
> and sound.

We already have mechanism to translate file offset into actual physical
address where data is. So if we can't allocate one contiguous chunk of
memory for notes, we should be able to break it down into multiple
page aligned areas and map offset into respective discontiguous areas
using vmcore_list.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
