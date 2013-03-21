Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIgwC-0002IL-H9
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 14:57:52 +0000
Date: Thu, 21 Mar 2013 10:57:43 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
Message-ID: <20130321145743.GI3934@redhat.com>
References: <87txo5bxk4.fsf@xmission.com>
 <20130321.122501.82758179.d.hatayama@jp.fujitsu.com>
 <8738vp75cy.fsf@xmission.com>
 <20130321.151428.393714972.d.hatayama@jp.fujitsu.com>
 <87ip4l1d1q.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ip4l1d1q.fsf@xmission.com>
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

On Wed, Mar 20, 2013 at 11:29:05PM -0700, Eric W. Biederman wrote:

[..]
> Preserving the actual PT_LOAD segments p_paddr and p_memsz values is
> important. p_offset we can change as much as we want.  Which means there
> can be logical holes in the file between PT_LOAD segments, where we put
> the extra data needed to keep everything page aligned.

Agreed. If one modifies p_paddr then one will have to modify p->vaddr
too. And user space tools look at p->vaddr and where is the corresponding
physical address. Keeping p_vaddr and p_paddr intact makes sense.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
